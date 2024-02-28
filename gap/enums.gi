#############################################################################
##
##  enums.gi                       Smallsemi - a GAP library of semigroups
##  Copyright (C) 2008-2024            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

#############################################################################
# Internal stuff
#############################################################################

# TODO remove
InstallGlobalFunction(SMALLSEMI_STRIP_ARG,
function(input)
  if IsList(input)
        and Length(input) = 1
        and not IsPosInt(input[1])
        and not IsEnumeratorOfSmallSemigroups(input[1])
        and not IsIteratorOfSmallSemigroups(input[1])
        and not (IsCyclotomicCollection(input[1])
                 and ForAll(input[1], IsPosInt)) then
    return input[1];
  fi;

  return input;
end);

BindGlobal("SMALLSEMI_FuncNameOrString",
function(x)
  if IsFunction(x) then
    return NAME_FUNC(x);
  else
    return x;
  fi;
end);

BindGlobal("SMALLSEMI_ValidateTypeArgs",
function(arg...)
  local x, i;

  arg := SMALLSEMI_STRIP_ARG(arg);

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

  arg := SMALLSEMI_STRIP_ARG(arg);

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
      return NAME_FUNC(x[1]) < NAME_FUNC(y[1]);
    fi;
  end;

  Sort(func_val_pairs, cmp);
  return Concatenation([arg[1]], Concatenation(func_val_pairs));
end);

# only allow precomputed, sorted, and converted functions as input
# Must declare this and not BindGlobal, since the function calls itself
DeclareGlobalFunction("SMALLSEMI_CanCreateEnumerator");
InstallGlobalFunction(SMALLSEMI_CanCreateEnumerator,
function(arg...)

  arg := SMALLSEMI_STRIP_ARG(arg);
  if IsEnumeratorOfSmallSemigroups(arg[1]) then
    return true;
  elif IsIteratorOfSmallSemigroups(arg[1]) then
    arg := Concatenation([SizesOfSmallSemisInIter(arg[1])],
                         arg{[2 .. Length(arg)]},
                         FuncsOfSmallSemisInIter(arg[1]));
    arg := SMALLSEMI_NormalizeArgs(arg);
    return SMALLSEMI_CanCreateEnumerator(arg);
  elif IsPosInt(arg[1]) then
    arg[1] := [arg[1]];
  fi;

  if Maximum(arg[1]) < 8 then
    return true;
  fi;

  if Length(arg) > 1 then
    # at least one precomputed value must be true
    return ForAny([2, 4 .. Length(arg) - 1],
                  i -> NAME_FUNC(arg[i])
                       in PrecomputedSmallSemisInfo[8] and arg[i + 1]);
  fi;
  return GAPInfo.BytesPerVariable >= 8;
end);

BindGlobal("SMALLSEMI_ValidateEnumeratorArgs",
function(arg...)
  arg := SMALLSEMI_STRIP_ARG(arg);
  if not SMALLSEMI_CanCreateEnumerator(arg) then
    Error("It is only possible to create an enumerator containing ",
          "semigroups of order 8 if it describes a subset of at ",
          "least one of the precomputed sets of values in the library.");
  fi;
end);

InstallGlobalFunction(NamesFuncsSmallSemisInEnum, enum -> enum!.names);
InstallGlobalFunction(PositionsOfSmallSemisInEnum, enum -> enum!.pos);
InstallGlobalFunction(FuncsOfSmallSemisInEnum, enum -> enum!.funcs);
InstallGlobalFunction(SizesOfSmallSemisInEnum, enum -> enum!.sizes);

InstallGlobalFunction(NamesFuncsSmallSemisInIter, iter -> iter!.names);
InstallGlobalFunction(FuncsOfSmallSemisInIter, iter -> iter!.funcs);
InstallGlobalFunction(SizesOfSmallSemisInIter, iter -> iter!.sizes);

InstallGlobalFunction(AllSmallSemigroups,
function(arg...)
  return ConstantTimeAccessList(
           CallFuncList(EnumeratorSortedOfSmallSemigroups, arg));
end);

InstallGlobalFunction(EnumeratorSortedOfSmallSemigroups,
function(arg...)
  return CallFuncList(EnumeratorOfSmallSemigroups, arg);
end);

# HERE

# TODO remove
InstallGlobalFunction(EmptyEnumeratorOfSmallSemigroups,
function()
  local record, fam, enum;

  record               := rec();
  record.ElementNumber := ReturnFail;
  record.NumberElement := ReturnFail;
  record.Length        := enum -> 0;
  record.PrintObj      := function(_)
    Print("<empty enumerator of semigroups>");
  end;
  record.pos   := [[]];
  record.sizes := [];

  fam  := CollectionsFamily(SmallSemigroupEltFamily);
  enum := EnumeratorByFunctions(Domain(fam, []), record);

  SetIsEnumeratorOfSmallSemigroups(enum, true);
  SetIsFinite(enum, true);

  return enum;
end);

# TODO remove
InstallGlobalFunction(EmptyIteratorOfSmallSemigroups,
function()
  local record, iter;

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

  iter := IteratorByFunctions(record);

  SetIsIteratorOfSmallSemigroups(iter, true);
  return iter;
end);

InstallGlobalFunction(EnumeratorOfSmallSemigroups,
function(arg...)

  arg := SMALLSEMI_STRIP_ARG(arg);
  SMALLSEMI_ValidateTypeArgs(arg);

  arg := SMALLSEMI_NormalizeArgs(arg);

  SMALLSEMI_ValidateEnumeratorArgs(arg);

  if Length(arg) = 1 and IsEnumeratorOfSmallSemigroups(arg[1]) then
    # do nothing
    return arg[1];
  elif IsIteratorOfSmallSemigroups(arg[1]) then
    Append(arg, FuncsOfSmallSemisInIter(arg[1]));
  elif IsEnumeratorOfSmallSemigroups(arg[1]) then
    Append(arg, FuncsOfSmallSemisInEnum(arg[1]));
  fi;

  return SMALLSEMI_CREATE_ENUM(arg[1],
                               PositionsOfSmallSemigroups(arg),
                               arg{[2 .. Length(arg)]});
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
function(sizes, positions)
  # TODO replace this with a call to SMALLSEMI_CREATE_ENUM
  local fam, tot, lens, record, enum, i;

  if ForAll(positions, IsEmpty) then
    return EmptyEnumeratorOfSmallSemigroups();
  fi;

  fam  := CollectionsFamily(SmallSemigroupEltFamily);
  tot  := 0;
  lens := [0];

  for i in positions do
    tot := tot + Length(i);
    Add(lens, tot);
  od;

  record := rec();

  record.ElementNumber := function(enum, pos)
    local i;
    if pos > Length(enum) then
      return fail;
    fi;
    i := PositionProperty(lens, x -> pos <= x) - 1;
    return SmallSemigroupNC(sizes[i], positions[i][pos - lens[i]]);
  end;

  record.NumberElement := function(_, elm)
    local id;
    id := IdSmallSemigroup(elm);
    return PositionSorted(positions[id[1]], id[2]);
  end;

  record.Length := enum -> tot;

  record.PrintObj := function(_)
    Print("<enumerator of semigroups of size");
    if Length(sizes) > 1 then
      Print("s ", sizes, ">");
    else
      Print(" ", sizes[1], ">");
    fi;
    return;
  end;

  record.pos := positions;
  record.sizes := sizes;
  record.names := ["enumerator by ids", sizes];
  record.funcs := [];

  enum := EnumeratorByFunctions(Domain(fam, []), record);
  SetIsEnumeratorOfSmallSemigroups(enum, true);
  SetIsFinite(enum, true);
  return enum;
end);

InstallMethod(EnumeratorOfSmallSemigroupsByIds,
"for a pos. int. and set of positions", [IsPosInt, IsCyclotomicCollection],
{sizes, positions} -> EnumeratorOfSmallSemigroupsByIds([sizes], [positions]));

InstallMethod(EnumeratorOfSmallSemigroupsByIdsNC,
"for a pos. int. and set of positions", [IsPosInt, IsCyclotomicCollection],
{sizes, positions} -> EnumeratorOfSmallSemigroupsByIdsNC([sizes], [positions]));

InstallMethod(EnumeratorOfSmallSemigroupsByIds,
"for a list of smallsemi ids", [IsList],
function(ids)
  local id1, id2, i, pos;

  ids := Set(ids);

  if not ForAll(ids, IsIdSmallSemigroup) then
    Info(InfoWarning, 1,
    "argument must be a list of ids of small semigroups");
    return fail;
  fi;

  id1 := [];
  id2 := [];

  for i in ids do
    pos := PositionSet(id1, i[1]);
    if pos = fail then
      AddSet(id1, i[1]);
      id2[PositionSet(id1, i[1])] := [i[2]];
    else
      AddSet(id2[pos], i[2]);
    fi;
  od;

  return EnumeratorOfSmallSemigroupsByIdsNC(id1, id2);
end);

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

InstallGlobalFunction(IdsOfSmallSemigroups,
function(arg...)
  local enum, size, pos;

  enum := EnumeratorOfSmallSemigroups(arg);
  size := SizesOfSmallSemisInEnum(enum);
  pos := PositionsOfSmallSemisInEnum(enum);

  return Concatenation(List([1 .. Length(size)],
                       x -> List(pos[x], y -> [size[x], y])));
end);

InstallMethod(IsEnumeratorOfSmallSemigroups, "for an object", [IsObject],
ReturnFalse);

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

InstallOtherMethod(IsIteratorOfSmallSemigroups, "for an object", [IsObject],
ReturnFalse);

BindGlobal("PrintObj_IsIteratorOfSmallSemigroups",
function(iter)
  if iter!.sizes = [0] then
    Print("<empty iterator of semigroups>");
  fi;
  Print("<iterator of semigroups of size");
  if Length(iter!.sizes) > 1 then
    Print("s ", iter!.sizes, ">");
  else
    Print(" ", iter!.sizes[1], ">");
  fi;
end);

InstallGlobalFunction(IteratorOfSmallSemigroups,
function(arg...)
  local record, iter, sizes, names, funcs, enum, user, max, i;

  arg := SMALLSEMI_STRIP_ARG(arg);
  SMALLSEMI_ValidateTypeArgs(arg);

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
    record.names := ["AllSmallSemigroups", arg[1]];

    iter := IteratorByFunctions(record);
    SetIsIteratorOfSmallSemigroups(iter, true);
    return iter;
  fi;

  if IsPosInt(arg[1]) then
    sizes := [arg[1]];
    names := [];
    funcs := [];
  elif IsEnumeratorOfSmallSemigroups(arg[1]) then
    if IsEmpty(arg[1]) then
      return EmptyIteratorOfSmallSemigroups();
    fi;
    sizes := SizesOfSmallSemisInEnum(arg[1]);
    names := NamesFuncsSmallSemisInEnum(arg[1]);
    funcs := FuncsOfSmallSemisInEnum(arg[1]);
  elif IsIteratorOfSmallSemigroups(arg[1]) then
    sizes := SizesOfSmallSemisInIter(arg[1]);
    names := NamesFuncsSmallSemisInIter(arg[1]);
    funcs := FuncsOfSmallSemisInIter(arg[1]);
  else
    # list of positive integers
    sizes := arg[1];
    names := [];
    funcs := [];
  fi;

  arg := SMALLSEMI_NormalizeArgs(arg);

  enum := [arg[1]];
  user := [];

  for i in [2, 4 .. Length(arg) - 1] do
    if NAME_FUNC(arg[i]) in SMALLSEMI_ALWAYS_FALSE and arg[i + 1] then
      return EmptyIteratorOfSmallSemigroups();
    elif ForAll(sizes,
                j -> NAME_FUNC(arg[i]) in PrecomputedSmallSemisInfo[j]) then
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
  elif enum <> [arg[1]] and SMALLSEMI_CanCreateEnumerator(enum) then
    enum := EnumeratorOfSmallSemigroups(enum);
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

    record.names := Concatenation(names,
                                  List(arg{[2 .. Length(arg)]},
                                       SMALLSEMI_FuncNameOrString));

    iter := IteratorByFunctions(record);
    SetIsIteratorOfSmallSemigroups(iter, true);
    return iter;
end);

InstallGlobalFunction(NrSmallSemigroups,
function(arg...)
  local numb;

  if Length(arg) = 1 and IsPosInt(arg[1]) then
    numb := [1, 4, 18, 126, 1160, 15973, 836021, 1843120128];
    if arg[1] > 0 and arg[1] <= 8 then
      return numb[arg[1]];
    else
      Error("only semigroups of sizes from 1 to 8 are in the library");
    fi;
  fi;
  return Sum(List(PositionsOfSmallSemigroups(arg), Length));
end);

InstallGlobalFunction(OneSmallSemigroup,
function(arg...)
  local iter;

  if Length(arg) = 1 then
    if IsEnumeratorOfSmallSemigroups(arg[1]) and IsEmpty(arg[1]) then
      return arg[1][1];
    elif IsIteratorOfSmallSemigroups(arg[1]) then
      iter := arg[1];
    else
      iter := IteratorOfSmallSemigroups(arg);
    fi;
  else
    iter := IteratorOfSmallSemigroups(arg);
  fi;

  if not IsDoneIterator(iter) then
    return NextIterator(IteratorOfSmallSemigroups(arg));
  fi;
  return fail;
end);

InstallGlobalFunction(PositionsOfSmallSemigroups,
function(arg...)
  local stored, sizes, enum, user, i, j, positions, out, enum2, s;

  arg := SMALLSEMI_STRIP_ARG(arg);
  SMALLSEMI_ValidateTypeArgs(arg);

  arg := SMALLSEMI_NormalizeArgs(arg);

  SMALLSEMI_ValidateEnumeratorArgs(arg);

  # a single stored value
  if IsPosInt(arg[1]) and Length(arg) = 3 and arg[3] = true then
    stored := STORED_INFO(arg[1], NAME_FUNC(arg[2]));
    if stored <> fail then
      return [stored];
    fi;
  fi;

  # all semigroups not of order 8
  if Length(arg) = 1 and IsPosInt(arg[1]) then
    return [[1 .. NrSmallSemigroups(arg[1])]];
  elif IsOddInt(Length(arg)) and (IsPosInt(arg[1])
        or IsEnumeratorOfSmallSemigroups(arg[1])
        or IsIteratorOfSmallSemigroups(arg[1])
        or (IsCyclotomicCollection(arg[1]) and ForAll(arg[1], IsPosInt))) then
    # for a list of functions and their values

    # find sizes of semigroups
    if IsPosInt(arg[1]) then
        sizes := [arg[1]];
    elif IsEnumeratorOfSmallSemigroups(arg[1]) then
        sizes := SizesOfSmallSemisInEnum(arg[1]);
    elif IsIteratorOfSmallSemigroups(arg[1]) then
        sizes := SizesOfSmallSemisInIter(arg[1]);
    elif IsCyclotomicCollection(arg[1]) and ForAll(arg[1], IsPosInt) then
        sizes := arg[1];
    fi;

    enum := [arg[1]];
    user := [];

    if IsIteratorOfSmallSemigroups(arg[1]) then
        arg := Concatenation([SizesOfSmallSemisInIter(arg[1])],
                             arg{[2 .. Length(arg)]},
                             FuncsOfSmallSemisInIter(arg[1]));
        arg := SMALLSEMI_NormalizeArgs(arg);
    fi;

    # split input into precomputed and user
    for i in [2, 4 .. Length(arg) - 1] do
      if NAME_FUNC(arg[i]) in SMALLSEMI_ALWAYS_FALSE and arg[i + 1] then
        return [];
      elif ForAll(sizes,
                  j -> NAME_FUNC(arg[i]) in PrecomputedSmallSemisInfo[j]) then
        enum := Concatenation(enum, [arg[i], arg[i + 1]]);
      else  # user function
        user := Concatenation(user, [arg[i], arg[i + 1]]);
      fi;
    od;

    # initialize positions
    if IsEnumeratorOfSmallSemigroups(arg[1]) then
        positions := List(PositionsOfSmallSemisInEnum(arg[1]), ShallowCopy);
    elif ForAny([3, 5 .. Length(enum)], i -> enum[i] = true) then
        i := First([3, 5 .. Length(enum)], i -> enum[i] = true);
        positions := List(sizes, j -> ShallowCopy(STORED_INFO(j,
          NAME_FUNC(enum[i - 1]))));
    else
        positions := List(sizes, i -> [1 .. NrSmallSemigroups(i)]);
    fi;

    # find what function values are stored already
    for j in [1 .. Length(sizes)] do
      if Length(enum) > 1 then  # not just arg[1]
        i := 0;
        repeat
          i := i + 2;
          stored := STORED_INFO(sizes[j], NAME_FUNC(enum[i]));
          if stored <> fail then
            if enum[i + 1] = true then
              IntersectSet(positions[j], stored);
            elif enum[i + 1] = false then
              SubtractSet(positions[j], stored);
            fi;
          fi;
        until i = Length(enum) - 1 or IsEmpty(positions[j]);
      fi;

      # compute the values of any remaining functions
      if not IsEmpty(user) and not IsEmpty(positions[j]) then
        i := -1;

        repeat
          enum2 := EnumeratorOfSmallSemigroupsByIds(sizes[j], positions[j]);
          i := i + 2;
          out := [];
          for s in [1 .. Length(enum2)] do
            if InfoLevel(InfoSmallsemiEnums) = 4 then
              Print("  #I  at ", s, " of ", Length(enum2), "\r");
            fi;
            s := enum2[s];
            if user[i](s) = user[i + 1] then
              Add(out, IdSmallSemigroup(s)[2]);
            fi;
          od;
          IntersectSet(positions[j], out);
        until i = Length(user) - 1 or IsEmpty(positions[j]);
      fi;
    od;
  fi;

  if InfoLevel(InfoSmallsemiEnums) = 4 then
    Print("\n");
  fi;

  return positions;
end);

InstallGlobalFunction(RandomSmallSemigroup,
function(arg...)
  local iter, i, j, s, t, enum;

  arg := SMALLSEMI_STRIP_ARG(arg);

  if Length(arg) = 1 and IsPosInt(arg[1]) then
    i := Random(RandomSource(IsMersenneTwister), 1, NrSmallSemigroups(arg[1]));
    return SmallSemigroupNC(arg[1], i);
  elif SMALLSEMI_CanCreateEnumerator(arg) then
    enum := EnumeratorOfSmallSemigroups(arg);
    if not IsEmpty(enum) then
      i := Random([1 .. Length(enum)]);
      return enum[i];
    fi;
    return fail;
  fi;
  iter := IteratorOfSmallSemigroups(arg);
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

InstallMethod(UpToIsomorphism, "for a list of non-equivalent semigroups",
[IsList],
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

BindGlobal("SMALLSEMI_ChainEnumeratorNC",
function(arg...)
  local tot, lens, fam, record, enum, i;

  arg := Filtered(arg, x -> not IsEmpty(x));
  if IsEmpty(arg) then
    # TODO just return empty list
    return EmptyEnumeratorOfSmallSemigroups();
  fi;

  tot := 0;
  lens := [0];
  for i in arg do
    tot := tot + Length(i);
    Add(lens, tot);
  od;

  fam := CollectionsFamily(FamilyObj(arg[1]));

  record := rec();

  record.tot := tot;
  record.lens := lens;

  record.ElementNumber := function(enum, pos)
    local i;
    i := PositionProperty(enum!.lens, x -> pos <= x) - 1;
    return arg[i][pos - enum!.lens[i]];
  end;

  record.NumberElement := function(enum, elm)
    local id, i;
    id := IdSmallSemigroup(elm);
    i := Position(enum!.sizes, id[2]);
    return Position(arg[i], elm) + tot[i - 1];
  end;

  record.Length := enum -> enum!.tot;

  record.PrintObj := function(enum)
    Print("<enumerator of semigroups of sizes ", enum!.sizes, ">");
    return;
  end;

  record.pos   := List(arg, x -> PositionsOfSmallSemisInEnum(x)[1]);
  record.sizes := List(arg, x -> SizesOfSmallSemisInEnum(x)[1]);
  # TODO this seems weird
  record.funcs := FuncsOfSmallSemisInEnum(arg[1]);
  record.names := List(record.funcs, SMALLSEMI_FuncNameOrString);

  enum := EnumeratorByFunctions(Domain(fam, []), record);
  SetIsEnumeratorOfSmallSemigroups(enum, true);
  SetIsFinite(enum, true);
  return enum;
end);

InstallGlobalFunction(SMALLSEMI_CREATE_ENUM,
function(source, position, names)
  local sizes, non_empty_sizes, fam, record, enum, enums, i;

  if ForAll(position, IsEmpty) then
    return EmptyEnumeratorOfSmallSemigroups();
  fi;

  if IsPosInt(source) then
    sizes := [source];
  elif IsEnumeratorOfSmallSemigroups(source) then
    sizes := SizesOfSmallSemisInEnum(source);
    names := Concatenation(FuncsOfSmallSemisInEnum(source), names);
  elif IsIteratorOfSmallSemigroups(source) then
    sizes := SizesOfSmallSemisInIter(source);
    names := Concatenation(FuncsOfSmallSemisInIter(source), names);
  elif IsCyclotomicCollection(source) and ForAll(source, IsPosInt) then
    sizes := source;
  fi;

  # some inherited sizes may now not occur
  non_empty_sizes := Filtered([1 .. Length(sizes)],
                              i -> not IsEmpty(position[i]));

  sizes := sizes{non_empty_sizes};
  position := position{non_empty_sizes};

  if Length(sizes) = 1 then  # one size
    fam := CollectionsFamily(SmallSemigroupEltFamily);

    record := rec();
    record.ElementNumber := function(_, pos)
      local s;
      s := SmallSemigroupNC(sizes[1], position[1][pos]);
      for i in [1, 3 .. Length(names) - 1] do
        if IsOperation(names[i]) then  # JDM ok?
          Setter(names[i])(s, names[i + 1]);
        fi;
      od;
      return s;
    end;

    record.NumberElement :=
        {enum, elm} -> PositionSorted(position[1], IdSmallSemigroup(elm)[2]);
    record.Length := enum -> Length(position[1]);

    record.PrintObj := function(enum)
      Print("<enumerator of semigroups of size ", enum!.sizes[1], ">");
    end;

    record.pos := position;
    record.sizes := sizes;
    record.funcs := names;
    record.names := List(names, SMALLSEMI_FuncNameOrString);

    enum := EnumeratorByFunctions(Domain(fam, []), record);

    SetIsEnumeratorOfSmallSemigroups(enum, true);
    SetIsFinite(enum, true);
    return enum;
  else
    # Range of sizes . . .
    enums := [];
    for i in [1 .. Length(sizes)] do
      enum := SMALLSEMI_CREATE_ENUM(sizes[i], [position[i]], names);
      Add(enums, enum);
    od;
    return CallFuncList(SMALLSEMI_ChainEnumeratorNC, enums);
  fi;
end);
