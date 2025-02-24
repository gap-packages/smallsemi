#############################################################################
##
##  properties.gi                  Smallsemi - a GAP library of semigroups
##  Copyright (C) 2008-2024            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

##  The functions in this file are used to test whether a given
##  small semigroup has a given property.

InstallMethod(Annihilators, "for a small semigroup", [IsSmallSemigroup],
function(sg)
  local n,        # size of the <sg>
        mt,       # multiplication table of <sg>
        zero,     # index of the zero element in <sg>
        indices;  # indices of annihilators in <sg>

  # AD maybe this should run into an error or return the empty list?
  if not IsSemigroupWithZero(sg) then
    return fail;
  fi;

  n := Size(sg);
  mt := MultiplicationTable(sg);
  zero := MultiplicativeZero(sg)!.index;

  indices := Filtered([1 .. n], i -> Unique(mt{[1 .. n]}[i]) = [zero]
                                     and Unique(mt[i]) = [zero]);
  return Elements(sg){indices};
end);

InstallMethod(DiagonalOfMultiplicationTable, "for a semigroup",
[IsSemigroup and HasIsFinite and IsFinite],
x -> DiagonalOfMat(MultiplicationTable(x)));

InstallGlobalFunction(DisplaySmallSemigroup,
function(S)
  local id, info, out, max, eval, tab, pre;

  if not IsSmallSemigroup(S) then
    return fail;
  fi;

  id := IdSmallSemigroup(S);
  # collect function names for display
  info := Concatenation(PrecomputedSmallSemisInfo[id[1]],
                        ["IsSemigroupWithClosedIdempotents",
                         "IsMonogenicSemigroup",
                         "IsRectangularBand",
                         "IsOrthodoxSemigroup",
                         "IsBrandtSemigroup"]);

  # delete those that we do not want to display, sort alphabetically
  info := Difference(info, ["IsSemigroupWithoutClosedIdempotents",
                            "Is1GeneratedSemigroup",
                            "Is2GeneratedSemigroup",
                            "Is3GeneratedSemigroup",
                            "Is4GeneratedSemigroup",
                            "Is5GeneratedSemigroup",
                            "Is6GeneratedSemigroup",
                            "Is7GeneratedSemigroup",
                            "Is8GeneratedSemigroup"]);

  # glue things at the end of the display
  info := Concatenation(info, ["MinimalGeneratingSet", "Idempotents",
                               "GreensRClasses", "GreensLClasses",
                               "GreensHClasses", "GreensDClasses"]);

  out := [];
  max := Maximum(List(info, Length));

  for pre in info do
    eval := ValueGlobal(pre)(S);
    tab := Concatenation(List([1 .. (max - Length(pre)) + 3], x -> " "));
    Add(out, Concatenation(pre, ":", tab, String(eval), "\n"));
  od;

  Print(Concatenation(out));
end);

InstallMethod(Idempotents, "for a small semigroup", [IsSmallSemigroup],
S -> Filtered(S, IsIdempotent));

# TODO improve this method
InstallMethod(IndexPeriod, "for a small semigroup element",
[IsSmallSemigroupElt],
function(x)
  local i, y, m, powers;

  i := 1;
  y := x;
  powers := [y];

  repeat
    i := i + 1;
    y := y * x;
    Add(powers, y);
  until not IsDuplicateFreeList(powers);

  m := Position(powers, powers[i]);

  return [m, Length(powers) - m];
end);

InstallMethod(IsBand, "for a small semigroup",
[IsSmallSemigroup],
function(s)
  if HasIsCompletelyRegularSemigroup(s)
      and not IsCompletelyRegularSemigroup(s) then
    return false;
  fi;
  return DiagonalOfMat(s!.table) = [1 .. Size(s)];
end);

InstallMethod(IsBrandtSemigroup, "for a small semigroup",
[IsSmallSemigroup],
S -> IsInverseSemigroup(S) and IsZeroSimpleSemigroup(S));

InstallMethod(IsCliffordSemigroup, "for a small semigroup",
[IsSmallSemigroup],
function(S)
  if HasIsInverseSemigroup(S) and not IsInverseSemigroup(S) then
    return false;
  elif HasIsRegularSemigroup(S) and not IsRegularSemigroup(S) then
    return false;
  elif HasIsCompletelyRegularSemigroup(S)
      and not IsCompletelyRegularSemigroup(S) then
    return false;
  elif HasIsGroupAsSemigroup(S) and IsGroupAsSemigroup(S) then
    return true;
  fi;
  if ForAll(Idempotents(S), x -> x in Center(S)) then
    return IsRegularSemigroup(S);
  fi;
  return false;
end);

InstallMethod(IsCommutativeSemigroup, "for a small semigroup",
[IsSmallSemigroup], IsCommutative);

InstallMethod(IsCompletelySimpleSemigroup, "for a small semigroup",
[IsSmallSemigroup], IsSimpleSemigroup);

InstallMethod(IsSemiband, "for a small semigroup",
[IsSmallSemigroup], IsIdempotentGenerated);

InstallMethod(IsSemilattice, "for a small semigroup",
[IsSmallSemigroup], S -> IsCommutative(S) and IsBand(S));

InstallMethod(IsCompletelyRegularSemigroup, "for a small semigroup",
[IsSmallSemigroup],
function(S)

  if HasIsRegularSemigroup(S) and not IsRegularSemigroup(S) then
    return false;
  elif IsRegularSemigroup(S) then
    return Length(GreensHClasses(S)) = Length(Idempotents(S));
  fi;

  return false;
end);

InstallMethod(IsFullTransformationSemigroupCopy, "for a small semigroup",
[IsSmallSemigroup],
S -> IdSmallSemigroup(S) = [4, 96] or IdSmallSemigroup(S) = [1, 1]);

InstallMethod(IsGroupAsSemigroup, "for a small semigroup",  [IsSmallSemigroup],
function(S)
  local table;

  table := ShallowCopy(MultiplicationTable(S));
  if ForAny(table, x -> AsSet(x) <> [1 .. Size(S)])
      or ForAny(TransposedMat(table), x -> AsSet(x) <> [1 .. Size(S)]) then
    return false;
  fi;

  SetIsRegularSemigroup(S, true);
  SetIsSimpleSemigroup(S, true);
  SetIsCompletelyRegularSemigroup(S, true);
  SetIsCliffordSemigroup(S, true);
  if Size(S) > 1 then
    SetIsRectangularBand(S, false);
  else
    SetIsRectangularBand(S, true);
  fi;
  return true;
end);

InstallMethod(IsIdempotentGenerated, "for a small semigroup",
[IsSmallSemigroup],
function(S)
  if IsBand(S) then
    return true;
  elif IsNilpotentSemigroup(S) then
    # in a nilpotent semigroup zero does not generate the semigroup
    # (except if size is 1, but then it is already a band)
    return false;
  fi;

  return Size(Semigroup(Idempotents(S))) = Size(S);
end);

InstallMethod(IsInverseSemigroup, "for a small semigroup",
[IsSmallSemigroup],
function(S)
  local i, j, idem;

  if HasIsCliffordSemigroup(S) and IsCliffordSemigroup(S) then
    return true;
  elif IsRegularSemigroup(S) then
    idem := Idempotents(S);

    for i in [1 .. Length(idem)] do
      for j in [i + 1 .. Length(idem)] do
        if not idem[i] * idem[j] = idem[j] * idem[i] then
          return false;
        fi;
      od;
    od;
    return true;
  fi;

  return false;
end);

InstallMethod(IsLeftZeroSemigroup, "for a small semigroup",
[IsSmallSemigroup],
function(S)
  local table, i, j;

  table := MultiplicationTable(S);
  for i in [1 .. Size(S)] do
    for j in [1 .. Size(S)] do
      # for every entry test whether it equals its row index
      if table[i][j] <> i then
        return false;
      fi;
    od;
  od;

  return true;
end);

InstallMethod(IsMonoidAsSemigroup, "for a small semigroup",  [IsSmallSemigroup],
function(S)
  local table, id, pos;

  table := MultiplicationTable(S);
  id := IdSmallSemigroup(S);

  pos := Position(table, [1 .. id[1]]);

  if pos <> fail then
    return List(table, x -> x[pos]) = [1 .. id[1]];
  fi;

  return false;
end);

InstallMethod(IsMultSemigroupOfNearRing, "for a small semigroup",
[IsSmallSemigroup],
function(s)
  local id, vals;

  id := IdSmallSemigroup(s);
  vals := STORED_INFO(id[1], "IsMultSemigroupOfNearRing");

  return id[2] in vals;
end);

InstallMethod(IsNGeneratedSemigroup, "for a small semigroup and a pos. int",
[IsSmallSemigroup, IsPosInt],
function(S, n)
  local id, funcname, idlist, result, IsMGenerated, M;

  id := IdSmallSemigroup(S);

  if n > id[1] then
    return false;
  fi;

  funcname := Concatenation("Is", String(n), "GeneratedSemigroup");
  idlist := STORED_INFO(id[1], funcname);

  if idlist <> fail then
    result := id[2] in idlist;
  else
    result := Length(MinimalGeneratingSet(S)) = n;
  fi;

  if result then
    for M in [1 .. n - 1] do
      IsMGenerated := ValueGlobal(StringFormatted("Is{}GeneratedSemigroup", M));
      Setter(IsMGenerated)(S, false);
    od;
    for M in [n + 1 .. 8] do
      IsMGenerated := ValueGlobal(StringFormatted("Is{}GeneratedSemigroup", M));
      Setter(IsMGenerated)(S, false);
    od;
  fi;
  return result;
end);

BindGlobal("InstallIsNGenerated",
function(N)
  local IsNGenerated;
  IsNGenerated := ValueGlobal(StringFormatted("Is{}GeneratedSemigroup", N));
  InstallMethod(IsNGenerated, "for a small semigroup",
  [IsSmallSemigroup], S -> IsNGeneratedSemigroup(S, N));
end);

for N in [1 .. 8] do
  InstallIsNGenerated(N);
od;
MakeReadWriteGlobal("InstallIsNGenerated");
Unbind(InstallIsNGenerated);
Unbind(N);

# Is there really a point in having Is<n>IdempotentSemigroup functions
# if they don't do something more clever than calling Length(Idempotents)?
# (It's not needed for enumerator etc., is it?)
#
# Besides, storing of the values should probably behave in a different way.
# The values for Is<n>IdempotentSemigroup are at the moment not known after
# calling IsNIdempotentSemigroup (compare maybe MovedPoints vs. NrMovedPoints
# for Permutations).
InstallMethod(IsNIdempotentSemigroup, "for a small semigroup and a pos. int",
[IsSmallSemigroup, IsPosInt],
function(S, n)
  local result, IsMIdempotent, M;

  if n > Size(S) then
    return false;
  fi;

  result := (IsBand(S) and n = Size(S)) or Length(Idempotents(S)) = n;
  if result then
    for M in [1 .. n - 1] do
      IsMIdempotent :=
        ValueGlobal(StringFormatted("Is{}IdempotentSemigroup", M));
      Setter(IsMIdempotent)(S, false);
    od;
    for M in [n + 1 .. 8] do
      IsMIdempotent :=
        ValueGlobal(StringFormatted("Is{}IdempotentSemigroup", M));
      Setter(IsMIdempotent)(S, false);
    od;
  fi;

  return result;
end);

BindGlobal("InstallIsNIdempotent",
function(N)
  local IsNIdempotent;
  IsNIdempotent := ValueGlobal(StringFormatted("Is{}IdempotentSemigroup", N));
  InstallMethod(IsNIdempotent, "for a small semigroup",
  [IsSmallSemigroup], S -> IsNIdempotentSemigroup(S, N));
end);

for N in [1 .. 8] do
  InstallIsNIdempotent(N);
od;
MakeReadWriteGlobal("InstallIsNIdempotent");
Unbind(InstallIsNIdempotent);
Unbind(N);

InstallMethod(IsNilpotent, "for a small semigroup",  [IsSmallSemigroup],
IsNilpotentSemigroup);

InstallMethod(IsNilpotentSemigroup, "for a small semigroup", [IsSmallSemigroup],
function(S)
  return ForAll([2 .. Size(S)], i -> MultiplicationTable(S)[i][i] <> i)
      and IsSemigroupWithZero(S);
end);

InstallTrueMethod(IsOrthodoxSemigroup,
                  IsSemigroupWithClosedIdempotents and IsRegularSemigroup);

InstallMethod(IsOrthodoxSemigroup, "for a semigroup", [IsSemigroup],
S -> IsSemigroupWithClosedIdempotents(S) and IsRegularSemigroup(S));

InstallMethod(IsRectangularBand, "for a small semigroup",
[IsSmallSemigroup], S -> IsBand(S) and IsSimpleSemigroup(S));

InstallMethod(IsRegularSemigroup, "for a small semigroup", [IsSmallSemigroup],
function(S)
  if HasIsCompletelyRegularSemigroup(S) and IsCompletelyRegularSemigroup(S) then
    return true;
  elif HasIsGroupAsSemigroup(S) and IsGroupAsSemigroup(S) then
    return true;
  elif IsBand(S) then
    return true;
  fi;
  return ForAll(GreensRClasses(S), x -> ForAny(Idempotents(S), y -> y in x));
end);

# No semigroup in smallsemi is right zero, keep code for change of methods to
# be applicable to every semigroup with multiplication table.

InstallMethod(IsRightZeroSemigroup, "for a small semigroup",
[IsSmallSemigroup],
function(_)
  Info(InfoSmallsemi, 1, "Semigroups are stored up to isomorphism ",
       "and anti-isomorphism in Smallsemi");
  Info(InfoSmallsemi, 1,
       "and there are only left zero semigroups in the library.");
  return false;
end);

InstallMethod(IsSemigroupWithClosedIdempotents, "for a small semigroup",
[IsSmallSemigroup],
function(S)
  local table, idems, lookup, i, j;

  if HasIsBand(S) and IsBand(S) then
    return true;
  elif HasIsNilpotentSemigroup(S) and IsNilpotentSemigroup(S) then
    return true;
  fi;

  table  := MultiplicationTable(S);
  idems  := Filtered([1 .. Size(S)], i -> table[i][i] = i);
  lookup := BlistList([1 .. Size(S)], idems);

  # AD the following seems natural but slows down the computation by a factor
  # AD of 4. To have a separate call to 'Idempotents' if necessary seems the
  # AD better solution.
  # SetIdempotents(S, AsSSortedList(S){idems});

  for i in idems do
    for j in idems do
      if i <> j then
        if not lookup[table[i][j]] then
          return false;
        fi;
      fi;
    od;
  od;
  return true;
end);

InstallMethod(IsSemigroupWithoutClosedIdempotents, "for a small semigroup",
[IsSmallSemigroup], S -> not IsSemigroupWithClosedIdempotents(S));

InstallMethod(IsSemigroupWithZero, "for a small semigroup", [IsSmallSemigroup],
function(S)
  local i, hasleftzero;

  hasleftzero := false;
  # search for a left zero
  for i in [1 .. Size(S)] do
    if ForAll([1 .. Size(S)], j -> MultiplicationTable(S)[i][j] = i) then
      hasleftzero := true;
      break;
    fi;
  od;

  if hasleftzero then
    # test whether the left zero is as well a right zero
    return ForAll([1 .. Size(S)], j -> MultiplicationTable(S)[j][i] = i);
  fi;
  # there is no left zero
  return false;
end);

InstallGlobalFunction(SMALLSEMI_TableToLiterals,
function(table, n, NumLit)
  local i, j, literals, val;
  literals := [];
  for i in [1 .. n] do
    for j in [1 .. n] do
      val := table[i][j];
      Add(literals, NumLit([i, j, val], n));
    od;
  od;
  return literals;
end);

InstallGlobalFunction(SMALLSEMI_OnLiterals,
{n, LitNum, NumLit} -> function(ln, pi)
  local lit, imlit;
  lit := LitNum(ln, n);
  imlit := OnTuples(lit, pi);
  if (n + 1) ^ pi = n + 2 then
    imlit := Permuted(imlit, (1, 2));
  fi;
  return NumLit(imlit, n);
end);

InstallMethod(IsSelfDualSemigroup, "for a small semigroup",
[IsSmallSemigroup],
function(S)
  local orbit, NumLit, tbl2lits, onLiterals, n, LitNum, phi, literals, vals;

  LitNum := {ln, n} -> [QuoInt(ln - 1, n ^ 2) + 1,
                        QuoInt((ln - 1) mod n ^ 2, n) + 1,
                        (ln - 1) mod n + 1];

  NumLit := function(lit, n)
    local row, col, val;
    row := lit[1];
    col := lit[2];
    val := lit[3];
    return val + (row - 1) * n ^ 2 + (col - 1) * n;
  end;

  tbl2lits := {table, n} -> SMALLSEMI_TableToLiterals(table, n, NumLit);
  onLiterals := n -> SMALLSEMI_OnLiterals(n, LitNum, NumLit);

  n := Size(S);
  vals := STORED_INFO(n, "IsSelfDualSemigroup");
  if vals <> fail then
    return IdSmallSemigroup(S)[2] in vals;
  fi;

  if IsCommutativeSemigroup(S) then
    return true;
  fi;
  phi := ActionHomomorphism(SymmetricGroup(n), [1 .. n ^ 3], onLiterals(n));
  literals := tbl2lits(MultiplicationTable(S), n);
  orbit := Orbit(Image(phi, SymmetricGroup(n)), literals, OnSets);

  return tbl2lits(TransposedMat(MultiplicationTable(S)), n) in orbit;
end);

InstallMethod(IsSimpleSemigroup, "for a small semigroup", [IsSmallSemigroup],
function(S)

  if IsGroupAsSemigroup(S) then
    return true;
  elif HasIsCompletelyRegularSemigroup(S)
      and not IsCompletelyRegularSemigroup(S) then
    return false;
  fi;

  if Length(GreensDClasses(S)) = 1 then
    SetIsCompletelyRegularSemigroup(S, true);
    SetIsRegularSemigroup(S, true);
    return true;
  fi;

  return false;
end);

InstallMethod(IsSingularSemigroupCopy, "for a small semigroup",
[IsSmallSemigroup], S -> IdSmallSemigroup(S) = [2, 4]);

InstallMethod(IsZeroGroup, "for a small semigroup",  [IsSmallSemigroup],
function(S)
  local zero, elts;

  zero := MultiplicativeZero(S);
  if zero <> fail then
    elts := Difference(Elements(S), [zero]);
    return IsGroupAsSemigroup(SmallSemigroup(IdSmallSemigroup(Semigroup(elts))));
  fi;
  # TODO resolve the comments below
  # JDM the previous line is a good example of why IsomorphismSmallSemigroup is
  # required
  # AD shouldn't this rather be something like:
  # AD return fail <> AsGroup( elts );
  return false;
end);

InstallMethod(IsZeroSemigroup, "for a small semigroup",
[IsSmallSemigroup],
S -> Length(Unique(Flat(MultiplicationTable(S)))) = 1);

InstallMethod(IsZeroSimpleSemigroup, "for a small semigroup",
[IsSmallSemigroup],
function(S)
  local zero;
  if IsGroupAsSemigroup(S) then
    return false;
  elif HasIsCompletelyRegularSemigroup(S)
      and IsCompletelyRegularSemigroup(S) then
    return false;
  elif IsRegularSemigroup(S) then
    zero := MultiplicativeZero(S);
    if zero <> fail and Length(GreensDClasses(S)) = 2 then
      return true;
    fi;
  fi;
  return false;
end);

# split in two methods, second one for arbitrary semigroups
InstallMethod(MinimalGeneratingSet, "for a small semigroup", [IsSmallSemigroup],
function(S)
  local subsets, entries, gens, subset, k, generatedSubSG, mt, generated;

  generatedSubSG := function(indices)
    local new, old;
    new := indices;
    repeat
      old := new;
      new := Union(old, Unique(Flat(mt{old}{old})));
    until new = old;
    return new;
  end;

  mt := MultiplicationTable(S);

  # elements not in the mult. table have to be in every generating set
  entries := Unique(Flat(MultiplicationTable(S)));
  gens := Difference([1 .. Size(S)], entries);

  # for nilpotent semigroups the non - entries are a generating set
  if IsNilpotentSemigroup(S) then
    return AsSSortedList(S){gens};
  fi;

  if not IsEmpty(gens) then
    generated := generatedSubSG(gens);
    entries := Difference(entries, generated);
  fi;

  # try inductively adding sets of size k to get generating set
  for k in [Maximum(0, 1 - Length(gens)) .. Length(entries)] do
    # subsets of elements not generated by < gens >
    subsets := Combinations(entries, k);
    for subset in subsets do
      if Length(generatedSubSG(Concatenation(gens, subset))) = Size(S) then
        return  AsSSortedList(S){Concatenation(gens, subset)};
      fi;
    od;
  od;
end);

InstallMethod(NilpotencyDegree, "for a small semigroup", [IsSmallSemigroup],
function(S)
  local elms, rank, gens, gen, elm, elmslist;

  if not IsNilpotentSemigroup(S) then
    Info(InfoSmallsemi, 2,
    "Only nilpotent semigroups have a nilpotency degree.");
    return fail;
  elif Size(S) = 1 then
    # special case trivial semigroup
    return 1;
  elif Size(S) = 8 and IdSmallSemigroup(S)[2] > 11433106 then
    # special treatment for 3-nilpotent semigroups of size 8
    return 3;
  fi;

  # the generators of a nilpotent semigroup are precisely the elements
  # which do not appear in the multiplication table
  gens := Difference([1 .. Size(S)], Unique(Flat(MultiplicationTable(S))));
  elms := gens;
  rank := 1;

  # for a 'small semigroup' 1 is the zero
  while [1] <> elms do
    rank := rank + 1;
    # max. 6 generators (for zero semigroup of size 7)
    elmslist := EmptyPlist(36);
    # repeatedly calculate {gens} ^ (rank)
    for gen in gens do
      for elm in elms do
        Add(elmslist, MultiplicationTable(S)[gen][elm]);
      od;
    od;
    elms := Unique(elmslist);
  od;

  return rank;
end);

# the following are special methods for library functions - no doc

InstallMethod(GreensRClasses, "for a small semigroup", [IsSmallSemigroup],
function(S)
  local table, class, elms, out, i;

  # the left Cayley graph
  table := MultiplicationTable(S);
  class := STRONGLY_CONNECTED_COMPONENTS_DIGRAPH(table);
  elms  := Elements(S);
  elms  := AsSet(List(class, x -> AsSet(elms{x})));
  out   := [];
  for i in [1 .. Length(elms)] do
    out[i] := GreensRClassOfElement(S, elms[i][1]);
    SetAsSSortedList(out[i], elms[i]);
  od;
  return out;
end);

InstallMethod(GreensLClasses, "for a small semigroup", [IsSmallSemigroup],
function(S)
  local table, class, elms, out, i;

  # the left Cayley graph
  table := TransposedMat(MultiplicationTable(S));
  class := STRONGLY_CONNECTED_COMPONENTS_DIGRAPH(table);
  elms  := Elements(S);
  elms  := AsSet(List(class, x -> AsSet(elms{x})));
  out   := [];
  for i in [1 .. Length(elms)] do
    out[i] := GreensRClassOfElement(S, elms[i][1]);
    SetAsSSortedList(out[i], elms[i]);
  od;
  return out;
end);

# TODO replace this with the method in the Semigroups package
InstallMethod(GreensHClasses, "for a small semigroup",
[IsSmallSemigroup],
function(S)
  local r, l, H, c, i, h;

  r := GreensRClasses(S);
  l := GreensLClasses(S);

  if Length(r) = Size(S) then
    SetGreensDClasses(S, List(l, x ->
    GreensDClassOfElement(S, Representative(x))));

    for i in [1 .. Length(GreensLClasses(S))] do
      SetAsSSortedList(GreensDClasses(S)[i], Elements(GreensLClasses(S)[i]));
    od;

    SetGreensHClasses(S, List(r, x ->
    GreensHClassOfElement(S, Representative(x))));

    for c in GreensHClasses(S) do
      SetAsSSortedList(c, [Representative(c)]);
    od;

    return GreensHClasses(S);
  elif Length(l) = Size(S) then
    SetGreensDClasses(S, List(r, x ->
    GreensDClassOfElement(S, Representative(x))));

    for i in [1 .. Length(GreensRClasses(S))] do
      SetAsSSortedList(GreensDClasses(S)[i], Elements(GreensRClasses(S)[i]));
    od;

    SetGreensHClasses(S, List(l, x ->
    GreensHClassOfElement(S, Representative(x))));

    for c in GreensHClasses(S) do
      SetAsSSortedList(c, [Representative(c)]);
    od;

    return GreensHClasses(S);
  fi;

  r := List(r, x -> List(Elements(x), y -> y!.index));
  l := List(l, x -> List(Elements(x), y -> y!.index));

  H := [];

  repeat
    c := r[1];
    i := 0;
    repeat
      i := i + 1;
      if not IsEmpty(l[i]) then
        h := Intersection(c, l[i]);
        if not IsEmpty(h) then
          Add(H, h);
          SubtractSet(l[i], h);
          SubtractSet(c, h);
        fi;
      fi;
    until IsEmpty(c);
    SubtractSet(r, [c]);
  until IsEmpty(r);

  SetGreensHClasses(S,
                    List(H, x -> GreensHClassOfElement(S, Elements(S)[x[1]])));

  for i in [1 .. Length(H)] do
    SetAsSSortedList(GreensHClasses(S)[i], Elements(S){H[i]});
  od;

  return GreensHClasses(S);
end);

InstallMethod(GreensDClasses, "for a small semigroup",
[IsSmallSemigroup],
function(S)
  local R, L, D, elts, C, i;

  R := TransposedMat(MultiplicationTable(S));
  L := MultiplicationTable(S);

  # union of the two graphs
  D := List([1 .. Size(S)], i -> Union(R[i], L[i]));
  D := STRONGLY_CONNECTED_COMPONENTS_DIGRAPH(D);
  elts := AsSSortedList(S);
  elts := AsSet(List(D, x -> AsSet(elts{x})));
  C := [];
  for i in [1 .. Length(elts)] do
    C[i] := GreensDClassOfElement(S, elts[i][1]);
    SetAsSSortedList(C[i], elts[i]);
  od;

  return C;
end);

InstallMethod(String, "for Green's classes of a semigroup", [IsGreensClass],
C -> Concatenation("{", String(Representative(C)), "}"));

###########################################################################
# Internal functions - documented in the dev manual
###########################################################################

InstallGlobalFunction(STORED_INFO, function(n, name)
  local i;

  if name in RecNames(MOREDATA2TO8[n]) then
    return MOREDATA2TO8[n].(name);
  elif name = "IsBand" then
    i := Position(MOREDATA2TO8[n].diags, [1 .. n]);
    return [MOREDATA2TO8[n].endpositions[i] + 1 ..
            MOREDATA2TO8[n].endpositions[i + 1]];
  fi;
  return fail;
end);

# This is the same as using DeclareSynonymAttr(SMALLSEMI_EQUIV[1],
# SMALLSEMI_EQUIV[2]) but where SMALLSEMI_EQUIV[2] is not a property of
# semigroups alone or is not true for all semigroups. For example,
# IsMonogenicSemigroup implies Is1GeneratedSemigroup for all semigroups, and is
# hence a synonym. On the other hand, IsCompletelySimpleSemigroup only holds
# for IsSimpleSemigroup and IsFinite, and IsCommutativeSemigroup only holds for
# IsCommutative and IsSemigroup.

# <#GAPDoc Label="SMALLSEMI_ALWAYS_FALSE">
# <ManSection>
# <Var Name="SMALLSEMI_ALWAYS_FALSE"/>
# <Description>
# is a global variable whose value is a list of strings <A>str</A> of names of
# properties or attributes that are always <C>false</C> for a small semigroup.
# <P/>
#
# For example, <Ref Prop="IsFullTransformationSemigroup" BookName="ref"/> is
# always <C>false</C> for small semigroups but <Ref
# Prop="IsFullTransformationSemigroupCopy" BookName="smallsemi"/>
# can be <C>true</C>.
# <Example><![CDATA[
# gap> SMALLSEMI_ALWAYS_FALSE;
# [ "IsFullTransformationSemigroup", "IsSingularSemigroup" ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>

if IsBound(IsSingularSemigroup) then
  BindGlobal("SMALLSEMI_ALWAYS_FALSE",
             [IsFullTransformationSemigroup, IsSingularSemigroup]);
else
  BindGlobal("SMALLSEMI_ALWAYS_FALSE",
             [IsFullTransformationSemigroup]);
fi;

# the entries in the variable SMALLSEMI_EQUIV should be sorted according to
# SMALLSEMI_SORT_ARG_NC, i.e. the ones with true as argument come first and
# then are sorted alphabetically. Currently, the first component of every
# instance in SMALLSEMI_EQUIV should have length two!

# <#GAPDoc Label="SMALLSEMI_EQUIV">
# <ManSection>
# <Var Name="SMALLSEMI_EQUIV"/>
# <Description>
# is a global variable whose value is a list of pairs <A>P</A> of functions and
# values where <A>P[1]</A> is a property and value which is equivalent to the
# properties and values in <A>P[2]</A> for small semigroups. <P/>
#
# For example, <Ref Prop="IsMonogenicSemigroup" BookName="smallsemi"/> implies
# <A>Is1GeneratedSemigroup</A> for all semigroups and is hence a synonym and
# the pair <A>[[IsMonogenicSemigroup, true], [Is1GeneratedSemigroup, true]]</A>
# does not need to be installed in <A>SMALLSEMI_EQUIV</A>. On the other hand,
# <Ref Prop="IsCompletelySimpleSemigroup" BookName="smallsemi"/> only holds for
# <Ref Prop="IsSimpleSemigroup" BookName="ref"/> and <Ref Prop="IsFinite"
# BookName="ref"/> and hence is not a synonym and the pairs <A>[
# [IsCompletelySimpleSemigroup, true], [IsSimpleSemigroup, true]]</A> and <A>[
# [IsCompletelySimpleSemigroup, false], [IsSimpleSemigroup, false]]</A>
# must be entered in <A>SMALLSEMI_EQUIV</A>.  Note that
# <A>[[IsOrthodoxSemigroup, true], [IsRegularSemigroup, true,
# IsSemigroupWithoutClosedIdempotents, false]]</A> can be entered in
# <A>SMALLSEMI_EQUIV</A> but currently it is not possible to have any pair in
# <A>SMALLSEMI_EQUIV</A> with first entry <A>[IsOrthodoxSemigroup,
# false]</A>.<P/>
#
# Also note that if <A>P</A> is an entry in <A>SMALLSEMI_EQUIV</A>, then
# <A>P[1]</A> must have length 2. <P/>
#
# The reason for doing all of this is so that when <Ref
# Oper="EnumeratorOfSmallSemigroups" BookName="smallsemi"/> is called with
# argument <A>IsCompletelySimpleSemigroup</A> there is no component in the
# record in the info file with the name <A>"IsCompletelySimpleSemigroup"</A>
# and so this name is provided by <A>SMALLSEMI_EQUIV</A>. If two properties are
# synonymous, then <A>NAME_FUNC</A> has the same value for both and so it is
# only necessary to store a component with that one name and hence not
# necessary to put a pair in <A>SMALLSEMI_EQUIV</A>. <P/> The name of the
# component in the info file should be in the second component of a pair in
# <A>SMALLSEMI_EQUIV</A>
# <Example><![CDATA[
# gap> SMALLSEMI_EQUIV;
# [ [ "IsCompletelySimpleSemigroup", "IsSimpleSemigroup" ],
# [ "IsCommutativeSemigroup", "IsCommutative" ],
# [ "IsNilpotent", "IsNilpotentSemigroup" ] ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>

BindGlobal("SMALLSEMI_EQUIV", [
[[IsCliffordSemigroup, true],
[IsCompletelyRegularSemigroup, true, IsInverseSemigroup, true]],

[[IsCompletelySimpleSemigroup, true], [IsSimpleSemigroup, true]],

[[IsCompletelySimpleSemigroup, false], [IsSimpleSemigroup, false]],

[[IsCommutativeSemigroup, true], [IsCommutative, true]],

[[IsCommutativeSemigroup, false], [IsCommutative, false]],

[[IsNilpotent, true], [IsNilpotentSemigroup, true]],

[[IsNilpotent, false], [IsNilpotentSemigroup, false]],

[[IsSemigroupWithClosedIdempotents, false],
[IsSemigroupWithoutClosedIdempotents, true]],

[[IsSemigroupWithClosedIdempotents, true],
[IsSemigroupWithoutClosedIdempotents, false]],

[[IsSemilattice, true],
[IsBand, true, IsCommutative, true]],

[[IsRectangularBand, true], [IsBand, true, IsSimpleSemigroup, true]],

[[IsOrthodoxSemigroup, true],
[IsRegularSemigroup, true, IsSemigroupWithoutClosedIdempotents, false]],

[[IsBrandtSemigroup, true], [IsInverseSemigroup, true,
 IsZeroSimpleSemigroup, true]],
]);
