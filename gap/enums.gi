#############################################################################
##
##  enums.gi                       Smallsemi - a GAP library of semigroups
##  Copyright (C) 2008-2024            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

BindGlobal("SmallSemigroupEnumeratorFamily",
           NewFamily("SmallSemigroupEnumeratorFamily",
                     IsEnumeratorOfSmallSemigroups));

BindGlobal("SmallSemigroupIteratorFamily",
           NewFamily("SmallSemigroupIteratorFamily",
                     IsIteratorOfSmallSemigroups));

#############################################################################
# Internal stuff
#############################################################################

BindGlobal("SMALLSEMI_ValidateTypeArgs",
function(arg...)
  local x, i;

  if not IsOddInt(Length(arg)) then
    Error("there must be an odd number arguments");
  elif not ForAny([IsPosInt,
                   IsCyclotomicCollection,
                   IsEnumeratorOfSmallSemigroups,
                   IsIteratorOfSmallSemigroups], f -> f(arg[1])) then
    Error("the 1st argument must be a positive integer, cyclotomic collection, ",
          "enumerator, or iterator of small semigroups");
  fi;

  if IsPosInt(arg[1]) and arg[1] > 8 then
    Error("the 1st argument (a positive integer) must be at most 8, found ",
          arg[1]);
  elif IsCyclotomicCollection(arg[1]) then
    for i in [1 .. Length(arg[1])] do
      x := arg[1][i];
      if not IsPosInt(x) then
        Error("the 1st argument (a list) must consist of positive integers",
              ", found ", TNAM_OBJ(x), " in position ", i);
      elif x = 0 or x > 8 then
        Error("the 1st argument (a list) must consist of positive integers",
              " in the range [1, 8), found ", x);
      fi;
    od;
  fi;

  for i in [2, 4 .. Length(arg) - 1] do
    if not IsFunction(arg[i]) then
      Error("the argument in even positions must be functions, found ",
            TNAM_OBJ(arg[i]), " in position ", i);
    fi;
  od;
end);

# <A>arg</A> is assumed to satisfy SMALLSEMI_ValidateTypeArgs(arg)=true but
# this is not checked.
#
# <C>SMALLSEMI_NormalizeArgs</C> replaces every function <A>arg[2i]</A> by an
# equivalent function in <Ref Var="PrecomputedSmallSemisInfo"
# BookName="smallsemi"/> if it exists.
BindGlobal("SMALLSEMI_NormalizeArgs",
function(arg...)
  local func_val_pairs, pos, cmp, i;

  func_val_pairs := [];
  for i in [2, 4 .. Length(arg) - 1] do
    pos := PositionProperty(SMALLSEMI_EQUIV, x -> [arg[i], arg[i + 1]] = x[1]);
    if pos <> fail then
      Add(func_val_pairs, SMALLSEMI_EQUIV[pos][2]);
    elif not (arg[i] in SMALLSEMI_ALWAYS_FALSE and not arg[i + 1]) then
      Add(func_val_pairs, [arg[i], arg[i + 1]]);
    fi;
  od;

  cmp := function(x, y)
    if x[2] < y[2] then
      return true;
    elif x[2] = y[2] then
      return NameFunction(x[1]) < NameFunction(y[1]);
    fi;
  end;

  Sort(func_val_pairs, cmp);
  return Concatenation([arg[1]], Concatenation(func_val_pairs));
end);

# only allow precomputed, sorted, and converted functions as input
# Must declare this and not BindGlobal, since the function calls itself
DeclareGlobalFunction("SMALLSEMI_CanCreateEnumerator");
InstallGlobalFunction(SMALLSEMI_CanCreateEnumerator,
function(arg...)

  if IsEnumeratorOfSmallSemigroups(arg[1]) then
    return true;
  elif IsIteratorOfSmallSemigroups(arg[1]) then
    arg := Concatenation([SizesOfSmallSemigroupsIn(arg[1])],
                         arg{[2 .. Length(arg)]},
                         ArgumentsUsedToCreate(arg[1]));
    arg := CallFuncList(SMALLSEMI_NormalizeArgs, arg);
    return CallFuncList(SMALLSEMI_CanCreateEnumerator, arg);
  elif IsPosInt(arg[1]) then
    arg[1] := [arg[1]];
  fi;

  if Maximum(arg[1]) < 8 then
    return true;
  fi;

  if Length(arg) > 1 then
    # at least one precomputed value must be true
    return ForAny([2, 4 .. Length(arg) - 1],
                  i -> NameFunction(arg[i])
                       in PrecomputedSmallSemisInfo[8] and arg[i + 1]);
  fi;
  return GAPInfo.BytesPerVariable >= 8;
end);

BindGlobal("SMALLSEMI_ValidateEnumeratorArgs",
function(arg...)
  if not CallFuncList(SMALLSEMI_CanCreateEnumerator, arg) then
    Error("It is only possible to create an enumerator containing ",
          "semigroups of order 8 if it describes a subset of at ",
          "least one of the precomputed sets of values in the library.");
  fi;
end);

BindGlobal("SMALLSEMI_MakeEnumeratorNC",
function(sizes, positions, funcs)
  local sum, Lengths, record, enum, position;

  sum := 0;
  Lengths := [0];
  for position in positions do
    sum := sum + Length(position);
    Add(Lengths, sum);
  od;

  record := rec();

  record.Lengths := Lengths;

  record.ElementNumber := function(enum, pos)
    local i, S, funcs;
    i := PositionProperty(enum!.Lengths, x -> pos <= x);
    if i = fail then
      return fail;
    fi;
    i := i - 1;
    pos := pos - enum!.Lengths[i];
    S := SmallSemigroupNC(SizesOfSmallSemigroupsIn(enum)[i],
                          PositionsOfSmallSemigroupsIn(enum)[i][pos]);
    funcs := ArgumentsUsedToCreate(enum);
    for i in [1, 3 .. Length(funcs) - 1] do
      if IsAttribute(funcs[i]) or IsProperty(funcs[i]) then
        Setter(funcs[i])(S, funcs[i + 1]);
      fi;
    od;
    return S;
  end;

  record.NumberElement := function(enum, elm)
    local id, size, index;
    id    := IdSmallSemigroup(elm);
    size  := Position(SizesOfSmallSemigroupsIn(enum), id[1]);
    index := Position(PositionsOfSmallSemigroupsIn(enum), id[2]);
    return index + enum!.Lengths[size - 1];
  end;

  record.Length := enum -> enum!.Lengths[Length(enum!.Lengths)];

  record.PrintObj := function(enum)
    local sizes, msg;
    if IsEmpty(enum) then
      Print("<empty enumerator of semigroups>");
      return;
    fi;
    sizes := SizesOfSmallSemigroupsIn(enum);
    msg := "size";
    if Length(sizes) > 1 then
      Append(msg, "s");
    else
      sizes := sizes[1];
    fi;
    PrintFormatted("<enumerator of semigroups of {} {}>", msg, sizes);
  end;

  enum := EnumeratorByFunctions(SmallSemigroupEnumeratorFamily, record);

  SetPositionsOfSmallSemigroupsIn(enum, positions);
  SetSizesOfSmallSemigroupsIn(enum, sizes);
  SetArgumentsUsedToCreate(enum, funcs);
  return enum;
end);

########################################################################
# Functions with the same args as Enumerator/IteratorOfSmallSemigroups
########################################################################

InstallGlobalFunction(IdsOfSmallSemigroups,
function(arg...)
  local enum, size, pos;

  enum := CallFuncList(EnumeratorOfSmallSemigroups, arg);
  size := SizesOfSmallSemigroupsIn(enum);
  pos  := PositionsOfSmallSemigroupsIn(enum);

  return Concatenation(List([1 .. Length(size)],
                       x -> List(pos[x], y -> [size[x], y])));
end);

InstallGlobalFunction(AllSmallSemigroups,
function(arg...)
  return ConstantTimeAccessList(
           CallFuncList(EnumeratorOfSmallSemigroups, arg));
end);

InstallGlobalFunction(NrSmallSemigroups,
function(arg...)
  local numb, positions;

  if Length(arg) = 1 and IsPosInt(arg[1]) then
    numb := [1, 4, 18, 126, 1160, 15973, 836021, 1843120128];
    if arg[1] > 0 and arg[1] <= 8 then
      return numb[arg[1]];
    else
      Error("only semigroups of sizes from 1 to 8 are in the library");
    fi;
  fi;
  positions := CallFuncList(PositionsOfSmallSemigroups, arg);
  return Sum(List(positions, Length));
end);

InstallGlobalFunction(RandomSmallSemigroup,
function(arg...)
  local iter, i, j, s, t, enum;

  if Length(arg) = 1 and IsPosInt(arg[1]) then
    i := Random(RandomSource(IsMersenneTwister), 1, NrSmallSemigroups(arg[1]));
    return SmallSemigroupNC(arg[1], i);
  elif CallFuncList(SMALLSEMI_CanCreateEnumerator, arg) then
    enum := CallFuncList(EnumeratorOfSmallSemigroups, arg);
    if not IsEmpty(enum) then
      i := Random(RandomSource(IsMersenneTwister), 1, Length(enum));
      return enum[i];
    fi;
    return fail;
  fi;

  iter := CallFuncList(IteratorOfSmallSemigroups, arg);
  i := 0;
  j := Random(RandomSource(IsMersenneTwister), 1, 500);
  t := Runtime();

  if not IsDoneIterator(iter) then  # in case of the empty iterator
    repeat
      i := i + 1;
      s := NextIterator(iter);
    until IsDoneIterator(iter) or Runtime() - t > j;

    if IsDoneIterator(iter) and i > 1 then
      iter := IteratorOfSmallSemigroups(arg);
      for j in [1 .. RandomList([1 .. i - 1])] do
        s := NextIterator(iter);
      od;
    elif IsDoneIterator(iter) and i = 1 then  # iterators of length 1
      iter := IteratorOfSmallSemigroups(arg);
      s := NextIterator(iter);
    fi;
    return s;
  fi;
  return fail;
end);

InstallGlobalFunction(OneSmallSemigroup,
function(arg...)
  local iter;

  if Length(arg) = 1 then
    if IsEnumeratorOfSmallSemigroups(arg[1]) and IsEmpty(arg[1]) then
      return fail;
    elif IsIteratorOfSmallSemigroups(arg[1]) then
      iter := arg[1];
    else
      iter := CallFuncList(IteratorOfSmallSemigroups, arg);
    fi;
  else
    iter := CallFuncList(IteratorOfSmallSemigroups, arg);
  fi;

  # TODO not sure this makes sense in case arg[1] is the iterator
  if not IsDoneIterator(iter) then
    return NextIterator(CallFuncList(IteratorOfSmallSemigroups, arg));
  fi;
  return fail;
end);

########################################################################
# Related functionality
########################################################################

InstallGlobalFunction(IsIdSmallSemigroup,
function(arg...)
  local m, n, nr;

  if Length(arg) = 2 and IsPosInt(arg[1]) and IsPosInt(arg[2]) then
    m := arg[1];
    n := arg[2];
  elif Length(arg) = 1 and IsCyclotomicCollection(arg[1])
      and Length(arg[1]) = 2 then
    return IsIdSmallSemigroup(arg[1][1], arg[1][2]);
  else
    return false;
  fi;

  nr := NrSmallSemigroups(m);

  return 0 < m and m < 9 and 1 <= n and n <= nr;
end);

InstallMethod(UpToIsomorphism, "for a list of non-equivalent semigroups",
[IsList],  # TODO replace with something better?
function(list)
  local out, dual, equi, S;

  if not ForAll(list, IsSmallSemigroup) then
    Error("the argument must be a list of semigroups obtained from ",
          "the smallsemi library");
  fi;

  out := [];

  for S in list do
    Add(out, S);
    if not IsSelfDualSemigroup(S) then
      # creator for small semigroups cannot be used here as this would
      # result in an object with 'IsSmallSemi' being true but not in
      # the library
      dual := SemigroupByMultiplicationTableNC(
                  TransposedMat(MultiplicationTable(S)));
      equi := MappingByFunction(dual, S, x -> AsSSortedList(S)[x![1]]);
      SetRespectsMultiplication(equi, false);
      SetIsBijective(equi, true);
      SetEquivalenceSmallSemigroup(dual, equi);
      SetIdSmallSemigroup(dual, IdSmallSemigroup(S));
      Add(out, dual);
    fi;
  od;
  return out;
end);

InstallMethod(UpToIsomorphism, "for a small semigroup", [IsSmallSemigroup],
S -> UpToIsomorphism([S]));

########################################################################
# Positions
########################################################################

# This function does all of the work for enumerators, computes a list of
# lists of the positions the small semigroups that satisfy the
# arguments.

# TODO add a no-check version that doesn't validate the args etc
InstallGlobalFunction(PositionsOfSmallSemigroups,
function(arg...)
  local stored, sizes, prec, user, positions, i, enum, out, s, j;

  CallFuncList(SMALLSEMI_ValidateTypeArgs, arg);
  arg := CallFuncList(SMALLSEMI_NormalizeArgs, arg);
  CallFuncList(SMALLSEMI_ValidateEnumeratorArgs, arg);

  # a single stored value
  if IsPosInt(arg[1]) and Length(arg) = 3 and arg[3] = true then
    stored := STORED_INFO(arg[1], NameFunction(arg[2]));
    if stored <> fail then
      return [stored];
    fi;
  fi;

  # all semigroups not of order 8
  if Length(arg) = 1 then
    if IsPosInt(arg[1]) then
      return [[1 .. NrSmallSemigroups(arg[1])]];
    elif IsEnumeratorOfSmallSemigroups(arg[1]) then
      return PositionsOfSmallSemigroupsIn(arg[1]);
    fi;
  fi;

  # find sizes of semigroups
  # TODO set positions here too
  if IsPosInt(arg[1]) then
    sizes := [arg[1]];
  elif IsEnumeratorOfSmallSemigroups(arg[1])
      or IsIteratorOfSmallSemigroups(arg[1]) then
    sizes := SizesOfSmallSemigroupsIn(arg[1]);
    # TODO set arg as below here too
  elif IsCyclotomicCollection(arg[1]) and ForAll(arg[1], IsPosInt) then
    # TODO just use else here because type checked above
    sizes := arg[1];
  fi;

  prec := [arg[1]];
  user := [];

  if IsIteratorOfSmallSemigroups(arg[1]) then
      arg := Concatenation([SizesOfSmallSemigroupsIn(arg[1])],
                           arg{[2 .. Length(arg)]},
                           ArgumentsUsedToCreate(arg[1]));
      arg := CallFuncList(SMALLSEMI_NormalizeArgs, arg);
  fi;

  # split input into precomputed and user
  for i in [2, 4 .. Length(arg) - 1] do
    if NameFunction(arg[i]) in SMALLSEMI_ALWAYS_FALSE and arg[i + 1] then
      return [];
    elif ForAll(sizes,
                j -> NameFunction(arg[i]) in PrecomputedSmallSemisInfo[j]) then
      prec := Concatenation(prec, [arg[i], arg[i + 1]]);
    else  # user function
      user := Concatenation(user, [arg[i], arg[i + 1]]);
    fi;
  od;

  # initialize positions
  if IsEnumeratorOfSmallSemigroups(arg[1]) then
    positions := List(PositionsOfSmallSemigroupsIn(arg[1]), ShallowCopy);
  elif ForAny([3, 5 .. Length(prec)], i -> prec[i] = true) then
    i := First([3, 5 .. Length(prec)], i -> prec[i] = true);
    positions := List(sizes,
                      j -> ShallowCopy(
                        STORED_INFO(j, NameFunction(prec[i - 1]))));
  else
    positions := List(sizes, i -> [1 .. NrSmallSemigroups(i)]);
  fi;

  # find what function values are stored already
  for j in [1 .. Length(sizes)] do
    if Length(prec) > 1 then  # not just arg[1]
      i := 0;
      repeat
        i := i + 2;
        stored := STORED_INFO(sizes[j], NameFunction(prec[i]));
        if stored <> fail then
          if prec[i + 1] = true then
            IntersectSet(positions[j], stored);
          elif prec[i + 1] = false then
            SubtractSet(positions[j], stored);
          fi;
        fi;
      until i = Length(prec) - 1 or IsEmpty(positions[j]);
    fi;

    # compute the values of any remaining functions
    if not IsEmpty(user) and not IsEmpty(positions[j]) then
      i := -1;

      repeat
        enum := EnumeratorOfSmallSemigroupsByIds(sizes[j], positions[j]);
        i := i + 2;
        out := [];
        for s in [1 .. Length(enum)] do
          if InfoLevel(InfoSmallsemiEnums) = 4 then
            Print("  #I  at ", s, " of ", Length(enum), "\r");
          fi;
          s := enum[s];
          if user[i](s) = user[i + 1] then
            Add(out, IdSmallSemigroup(s)[2]);
          fi;
        od;
        IntersectSet(positions[j], out);
      until i = Length(user) - 1 or IsEmpty(positions[j]);
    fi;
  od;

  if InfoLevel(InfoSmallsemiEnums) = 4 then
    Print("\n");
  fi;

  return positions;
end);

########################################################################
# Enumerators
########################################################################

# TODO remove
InstallMethod(SizesOfSmallSemigroupsIn, "for an iterator",
[IsIteratorOfSmallSemigroups], it -> it!.sizes);

# TODO remove
InstallMethod(ArgumentsUsedToCreate, "for an iterator",
[IsIteratorOfSmallSemigroups], it -> it!.funcs);

InstallGlobalFunction(EnumeratorOfSmallSemigroups,
function(arg...)
  local sizes, positions, non_empty;

  CallFuncList(SMALLSEMI_ValidateTypeArgs, arg);

  if Length(arg) = 1 and IsEnumeratorOfSmallSemigroups(arg[1]) then
    # do nothing
    return arg[1];
  fi;

  if IsPosInt(arg[1]) then
    sizes := [arg[1]];
  elif IsEnumeratorOfSmallSemigroups(arg[1])
        or IsIteratorOfSmallSemigroups(arg[1]) then
    sizes := SizesOfSmallSemigroupsIn(arg[1]);
    Append(arg, ArgumentsUsedToCreate(arg[1]));
  else
    sizes := arg[1];
  fi;

  arg := CallFuncList(SMALLSEMI_NormalizeArgs, arg);
  CallFuncList(SMALLSEMI_ValidateEnumeratorArgs, arg);
  # TODO use PositionsOfSmallSemigroupsNC when available
  positions := CallFuncList(PositionsOfSmallSemigroups, arg);
  Assert(0, Length(positions) = Length(sizes));

  # some inherited sizes may now not occur, TODO still necessary?
  non_empty := Filtered([1 .. Length(positions)],
                        i -> not IsEmpty(positions[i]));

  sizes     := sizes{non_empty};
  positions := positions{non_empty};

  return SMALLSEMI_MakeEnumeratorNC(sizes, positions, arg{[2 .. Length(arg)]});
end);

# input ids, a list of ids, a pos. int. & list of positions, a list of pos.
# ints. and a list of positions of equal length

InstallMethod(EnumeratorOfSmallSemigroupsByIds,
"for a set of pos. ints. and list of sets of positions",
[IsCyclotomicCollection, IsCyclotomicCollColl],
function(sizes, positions)

  if not IsSet(sizes) then
    Info(InfoWarning,
         1,
         "the 1st argument (a cyclotomic coll.) must be a set!");
    return fail;
  elif not ForAll(sizes, x -> x > 0 and x < 9) then
    Info(InfoWarning,
         1,
         "the 1st argument (a set of integers) must be in the range [0, 9)!");
    return fail;
  elif Length(sizes) <> Length(positions) then
    Info(InfoWarning, 1, "the 1st and 2nd arguments must have equal length");
    return fail;
  elif not ForAll(positions, x -> ForAll(x, IsPosInt))
        or not ForAll(positions, IsSet) then
    Info(InfoWarning,
         1,
         "the 2nd argument must be a list of sets of positive integers");
    return fail;
  elif ForAny([1 .. Length(positions)],
              i -> Maximum(positions[i]) > NrSmallSemigroups(sizes[i])) then
    Info(InfoWarning,
         1,
         "all sets in 2nd argument must be in the range 1 to the number ",
         "of semigroups");
    return fail;
  fi;

  return EnumeratorOfSmallSemigroupsByIdsNC(sizes, positions);
end);

InstallMethod(EnumeratorOfSmallSemigroupsByIdsNC,
"for a set of pos. ints. and list of sets of positions",
[IsCyclotomicCollection, IsCyclotomicCollColl],
{sizes, positions} -> SMALLSEMI_MakeEnumeratorNC(sizes, positions, []));

InstallMethod(EnumeratorOfSmallSemigroupsByIds,
"for a pos. int. and set of positions", [IsPosInt, IsCyclotomicCollection],
{sizes, positions} -> EnumeratorOfSmallSemigroupsByIds([sizes], [positions]));

InstallMethod(EnumeratorOfSmallSemigroupsByIdsNC,
"for a pos. int. and set of positions", [IsPosInt, IsCyclotomicCollection],
{sizes, positions} -> EnumeratorOfSmallSemigroupsByIdsNC([sizes], [positions]));

InstallMethod(EnumeratorOfSmallSemigroupsByIds,
"for a list of smallsemi ids", [IsList],
function(ids)
  local sizes, positions, pos, i;

  ids := Set(ids);

  if not ForAll(ids, IsIdSmallSemigroup) then
    Info(InfoWarning, 1,
    "argument must be a list of ids of small semigroups");
    return fail;
  fi;

  sizes := [];
  positions := [];

  for i in ids do
    pos := PositionSet(sizes, i[1]);
    if pos = fail then
      AddSet(sizes, i[1]);
      positions[PositionSet(sizes, i[1])] := [i[2]];
    else
      AddSet(positions[pos], i[2]);
    fi;
  od;

  return EnumeratorOfSmallSemigroupsByIdsNC(sizes, positions);
end);

# TODO some arg checks here
InstallGlobalFunction(EnumeratorOfSmallSemigroupsByDiagonals,
function(diagonals)
    local sizes, ranges, diag, n, sizepos, diagpos, start, ende, i, offset, id;

    sizes := [];
    ranges := [];

    for diag in diagonals do
      n := Length(diag);
      sizepos := Position(sizes, n);
      diagpos := Position(MOREDATA2TO8[n].diags, diag);
      start := MOREDATA2TO8[n].endpositions[diagpos] + 1;
      ende := MOREDATA2TO8[n].endpositions[diagpos + 1];
      if sizepos = fail then
        Add(sizes, n);
        sizepos := Length(sizes);
        Add(ranges, [start .. ende]);
      else
        ranges[sizepos] := Union(ranges[sizepos], [start .. ende]);
      fi;
      offset := 11433106;
      if n = 8 then
        for i in [3 .. 8] do
          diagpos := Position(MOREDATA2TO8[n].3nildiags, diag{[i .. n]});
          if diagpos <> fail then
            start := MOREDATA2TO8[n].3nilendpositions[diagpos] + 1;
            ende := MOREDATA2TO8[n].3nilendpositions[diagpos + 1];
            id := start + offset;
            repeat
              Add(ranges[sizepos], id);
              id := id + 1;
            until id > ende + offset;
          fi;
        od;
      fi;
    od;
    return EnumeratorOfSmallSemigroupsByIds(sizes, ranges);
end);

########################################################################
# Iterators
########################################################################

# TODO remove
InstallGlobalFunction(EmptyIteratorOfSmallSemigroups,
function()
  local record, type;

  record                := rec();
  record.IsDoneIterator := ReturnTrue;
  record.NextIterator   := ReturnFail;
  record.PrintObj       := function(_)
    Print("<empty iterator of semigroups>");
  end;
  record.ShallowCopy := SHALLOWCOPYITERATORSMALLSEMI;
  record.at          := 0;
  record.max         := 0;
  record.enum        := [];
  record.user        := [];
  record.sizes       := [0];

  type := NewType(SmallSemigroupIteratorFamily,
                  IsIteratorOfSmallSemigroups and IsMutable);
  return Objectify(type, record);
end);

BindGlobal("PrintObj_IsIteratorOfSmallSemigroups",
function(iter)
  local sizes, msg;
  if SizesOfSmallSemigroupsIn(iter) = [0] then
    Print("<empty iterator of semigroups>");
    return;
  fi;
  sizes := SizesOfSmallSemigroupsIn(iter);
  msg := "size";
  if Length(sizes) > 1 then
    Append(msg, "s");
  else
    sizes := sizes[1];
  fi;
  PrintFormatted("<iterator of semigroups of {} {}>", msg, sizes);
end);

InstallGlobalFunction(IteratorOfSmallSemigroups,
function(arg...)
  local record, type, sizes, funcs, enum, user, max, i;

  CallFuncList(SMALLSEMI_ValidateTypeArgs, arg);

  if Length(arg) = 1 and IsPosInt(arg[1]) then
    # all semigroups
    record := rec();

    record.IsDoneIterator := iter -> iter!.next(iter, false) = fail;
    record.NextIterator := iter -> iter!.next(iter, true);
    record.PrintObj := PrintObj_IsIteratorOfSmallSemigroups;

    record.next := function(iter, advance)
      if iter!.at = iter!.max then
        return fail;
      elif advance then
        iter!.at := iter!.at + 1;
        return SmallSemigroupNC(arg[1], iter!.at);
      fi;
      return true;
    end;

    record.ShallowCopy := SHALLOWCOPYITERATORSMALLSEMI;
    record.at := 0;
    record.max := NrSmallSemigroups(arg[1]);
    record.enum := [];
    record.user := [];
    record.sizes := [arg[1]];
    record.funcs := [];

    type := NewType(SmallSemigroupIteratorFamily,
                    IsIteratorOfSmallSemigroups and IsMutable);
    return Objectify(type, record);
  fi;

  if IsPosInt(arg[1]) then
    sizes := [arg[1]];
    funcs := [];
  elif IsEnumeratorOfSmallSemigroups(arg[1]) then
    if IsEmpty(arg[1]) then
      return EmptyIteratorOfSmallSemigroups();
    fi;
    sizes := SizesOfSmallSemigroupsIn(arg[1]);
    funcs := ArgumentsUsedToCreate(arg[1]);
  elif IsIteratorOfSmallSemigroups(arg[1]) then
    sizes := SizesOfSmallSemigroupsIn(arg[1]);
    funcs := ArgumentsUsedToCreate(arg[1]);
  else
    # list of positive integers
    sizes := arg[1];
    funcs := [];
  fi;

  arg := CallFuncList(SMALLSEMI_NormalizeArgs, arg);

  enum := [arg[1]];
  user := [];

  for i in [2, 4 .. Length(arg) - 1] do
    if NameFunction(arg[i]) in SMALLSEMI_ALWAYS_FALSE and arg[i + 1] then
      return EmptyIteratorOfSmallSemigroups();
    elif ForAll(sizes,
                j -> NameFunction(arg[i]) in PrecomputedSmallSemisInfo[j]) then
      # precomputed function
      enum := Concatenation(enum, [arg[i], arg[i + 1]]);
    else
      # user function
      user := Concatenation(user, [arg[i], arg[i + 1]]);
    fi;
  od;

  if IsEnumeratorOfSmallSemigroups(arg[1]) and enum = [arg[1]] then
    enum := enum[1];
    max := Length(enum);
    if IsEmpty(enum) then
      return EmptyIteratorOfSmallSemigroups();
    fi;
  elif enum <> [arg[1]]
      and CallFuncList(SMALLSEMI_CanCreateEnumerator, enum) then
    enum := CallFuncList(EnumeratorOfSmallSemigroups, enum);
    max := Length(enum);
    if IsEmpty(enum) then
      return EmptyIteratorOfSmallSemigroups();
    fi;
  else
    enum := [];
    max := Sum(sizes, NrSmallSemigroups);
    user := arg{[2 .. Length(arg)]};
  fi;

  record := rec();

  record.IsDoneIterator := iter -> iter!.next(iter, IsDoneIterator) = fail;
  record.NextIterator := iter -> iter!.next(iter, NextIterator);
  record.PrintObj := PrintObj_IsIteratorOfSmallSemigroups;

  record.next := function(iter, called_by)
    local enum, user, s;

    if iter!.last_called = IsDoneIterator then
      iter!.last_called := called_by;
      return iter!.last_value;
    fi;

    if iter!.last_called = NextIterator then
      iter!.last_called := called_by;
      if iter!.at = iter!.max or iter!.last_value = fail then
        iter!.last_value := fail;
        return fail;
      fi;

      enum := iter!.enum;
      user := iter!.user;

      if not IsEmpty(enum) and Length(enum) <= iter!.at then
        iter!.last_value := fail;
        return fail;
      fi;

      repeat
        iter!.at := iter!.at + 1;
        if not IsEmpty(enum) then
          s := enum[iter!.at];
        else
          s := SmallSemigroupNC(iter!.at_size,
                                iter!.at -
                                Sum(Filtered(iter!.sizes,
                                             x -> x < iter!.at_size),
                                    NrSmallSemigroups));
        fi;

        if not IsEmpty(enum) then
          iter!.at_size := Size(s);
        elif Length(iter!.sizes) > 1
            and iter!.at < iter!.max
            and iter!.at - Sum(Filtered(iter!.sizes, x -> x < iter!.at_size),
                               NrSmallSemigroups) >=
              NrSmallSemigroups(iter!.at_size) then
          iter!.at_size := iter!.sizes[Position(iter!.sizes, iter!.at_size) + 1];
        fi;

        if IsEmpty(user) then
          iter!.last_value := s;
          return s;
        elif ForAll([1, 3 .. Length(user) - 1],
                    i -> user[i](s) = user[i + 1]) then
            iter!.last_value := s;
            return s;
          else
            iter!.last_value := fail;
          fi;
        until iter!.at = iter!.max;

        iter!.last_value := fail;
        return fail;
      fi;
    end;

    record.last_called := NextIterator;
    record.last_value := 0;
    record.ShallowCopy := SHALLOWCOPYITERATORSMALLSEMI;
    record.at := 0;
    record.max := max;
    record.enum := enum;
    record.user := user;
    record.sizes := sizes;
    record.at_size := sizes[1];
    record.funcs := Concatenation(funcs, arg{[2 .. Length(arg)]});

    type := NewType(SmallSemigroupIteratorFamily,
                    IsIteratorOfSmallSemigroups and IsMutable);
    return Objectify(type, record);
end);

########################################################################
# Internal Functions
########################################################################

InstallGlobalFunction(SHALLOWCOPYITERATORSMALLSEMI,
function(it)
  return rec(at := 0,
             max := it!.max,
             enum := it!.enum,
             user := it!.user,
             n := it!.n);
end);
