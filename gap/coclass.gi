#############################################################################
##
##  coclass.gi                     Smallsemi - a GAP library of semigroups
##  Copyright (C) 2008-2024            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################

InstallGlobalFunction(NilpotentSemigroupsByCoclass,
function(arg...)
  local n, d, r;
  # INPUT: order <n>, coclass <d> (and rank <r>)

  if Length(arg) < 2 or Length(arg) > 3 then
    Error("number of arguments must be 2 or 3");
  fi;

  n := arg[1];
  if not IsPosInt(n) then
    Error("the order <n> must be a positive integer");
  fi;

  d := arg[2];
  if not d in [0, 1, 2] then
    Error("admissible values for the coclass <d> are 0, 1 and 2");
  elif n <= d then
    Info(InfoSmallsemi, 1, "Order does not exceed coclass.");
    return [];
  fi;

  if Length(arg) = 3 then
    r := arg[3];
    if not r in [1, 2, 3] then
      Error("admissible values for the rank <r> are 1, 2 and 3");
    elif r = 1 and d <> 0 then
      Info(InfoSmallsemi, 1, "Nilpotent semigroups are 1-generated ",
      "if and only if they have coclass 0.");
      return [];
    elif d + 1 < r then
      Info(InfoSmallsemi, 1,
      "The rank <r> is larger than the coclass plus one, <d>+1.");
      return [];
    fi;
  fi;

  ### cases covered by current implementation
  if d = 0 then
    return NilpotentSemigroupsCoclass0(n);
  elif d = 1 then
    return NilpotentSemigroupsCoclass1(n);
  elif d = 2 then
    if Length(arg) = 2 then
      return NilpotentSemigroupsCoclass2(n);
    elif Length(arg) = 3 then
      if r = 2 then
        return NilpotentSemigroupsCoclass2Rank2(n);
      elif r = 3 then
        return NilpotentSemigroupsCoclass2Rank3(n);
      fi;
    fi;
  fi;
end);

##  returns a list with the presentation for the semigroup of order <n> and
##  coclass 0
InstallGlobalFunction(NilpotentSemigroupsCoclass0,
function(n)
  local f,  # free semigroup on one element
        x;  # generator of <f>

  # catch input error
  if not IsPosInt(n) then
    Error("the size <n> has to be a positive integer");
  fi;

  f := FreeSemigroup(1);
  x := GeneratorsOfSemigroup(f);

  return [f / [[x[1] ^ n, x[1] ^ (n + 1)]]];
end);

##  returns presentations for all semigroups of order <n> and coclass 1
##  up to equivalence
InstallGlobalFunction(NilpotentSemigroupsCoclass1,
function(n)
  local sgrps,  # list of all semigroups
        f,      # free semigroup on two elements
        x;      # generators of <f>

  # catch input error
  if not IsPosInt(n) then
      Error("the size <n> has to be a positive integer");
  fi;

  f := FreeSemigroup(2);
  x := GeneratorsOfSemigroup(f);

  # catch exceptional cases
  if n <= 2 then
      return [];

  elif n = 3 then                              # the zero semigroup
      return [f / [[x[1] ^ 2, x[1] ^ 3],       # u ^ 2 = u ^ 3
                   [x[1] ^ 2, x[2] ^ 2],       # u ^ 2 = v ^ 2
                   [x[1] ^ 2, x[1] * x[2]],    # u ^ 2 = uv
                   [x[1] ^ 2, x[2] * x[1]]]];  # u ^ 2 = vu
  fi;

  sgrps := NilpotentSemigroupsCoclassD_NC(n, 1);

  # additional semigroups since 3 - nilpotent
  if n = 4 then
      Add(sgrps, f / [[x[1] ^ 2, x[1] ^ 3],        # u ^ 2 = u ^ 3
                      [x[1] ^ 2, x[2] ^ 2],        # u ^ 2 = v ^ 2
                      [x[1] ^ 2, x[1] * x[2]],     # u ^ 2 = uv
                      [x[1] ^ 2, x[2] ^ 3]]);      # u ^ 2 = v ^ 3
      Add(sgrps, f / [[x[1] ^ 2, x[1] ^ 3],        # u ^ 2 = u ^ 3
                      [x[1] ^ 2, x[2] ^ 2],        # u ^ 2 = v ^ 2
                      [x[1] * x[2], x[2] * x[1]],  # uv = vu
                      [x[1] ^ 2, x[2] ^ 3]]);      # u ^ 2 = v ^ 3

  fi;

  return sgrps;
end);

##  returns presentations for all semigroups of order <n> and coclass 2
##  up to equivalence
InstallGlobalFunction(NilpotentSemigroupsCoclass2,
function(n)
    return Concatenation(NilpotentSemigroupsCoclass2Rank3(n),
                         NilpotentSemigroupsCoclass2Rank2(n));
end);

##  returns presentations for all semigroups up to equivalence of order <n>
##  and coclass <d> with <d>+1 generators and (at least?) <d> of those
##  generating a monogenic semigroup of coclass <d>
InstallGlobalFunction(NilpotentSemigroupsCoclassD_NC,
function(n, d)
    local sgrps,       # list of all semigroups
          f,           # free semigroup on two elements
          x,           # generators of <f>
          basrels,     # relations appearing for each semigroup
          rels,        # relations of a specific semigroup
          i, j, k, m;  # loop counter

    f := FreeSemigroup(d + 1);
    x := GeneratorsOfSemigroup(f);

    sgrps := EmptyPlist(5 * n + Int(n / 2) - 1);  # HOW MANY?

    basrels := [[x[1] ^ (n - d), x[1] ^ (n - d + 1)]];
    for i in [2 .. d] do
        Add(basrels, [x[1] ^ 2, x[i] ^ 2]);        # u_1 ^ 2 = u_i ^ 2
        Add(basrels, [x[1] ^ 2, x[1] * x[i]]);     # u_1 ^ 2 = u_1u_i
        Add(basrels, [x[1] ^ 2, x[i] * x[1]]);     # u_1 ^ 2 = u_iu_1
        for j in [i + 1 .. d] do
            Add(basrels, [x[1] ^ 2, x[i] * x[j]]);  # u_1 ^ 2 = u_iu_j
            Add(basrels, [x[1] ^ 2, x[j] * x[i]]);  # u_1 ^ 2 = u_ju_i
        od;
    od;

    #
    for k in [2 .. Int((n - d) / 2)] do
        rels := ShallowCopy(basrels);
        for i in [1 .. d] do
            Add(rels, [x[i] * x[d + 1], x[d + 1] * x[i]]);  # u_iv = vu_i
            Add(rels, [x[i] * x[d + 1], x[1] ^ k]);         # u_iv = u_1 ^ k
        od;
        Add(rels, [x[d + 1] ^ 2, x[1] ^ (2 * k - 2)]);  # v ^ 2 = u_1 ^ (2k - 2)
        Add(sgrps, f / rels);
    od;

    for k in [Int((n - d) / 2) + 1 .. n - d - 2] do

        rels := ShallowCopy(basrels);
        for i in [1 .. d] do
            Add(rels, [x[i] * x[d + 1], x[d + 1] * x[i]]);  # u_iv = vu_i
            Add(rels, [x[i] * x[d + 1], x[1] ^ k]);         # u_iv = u_1 ^ k
        od;
        Add(rels, [x[d + 1] ^ 2, x[1] ^ (n - d)]);  # v ^ 2 = u_1 ^ (n - d)
        Add(sgrps, f / rels);

        Remove(rels);
        # v ^ 2 = u_1 ^ (n - d - 1)
        Add(rels, [x[d + 1] ^ 2, x[1] ^ (n - d - 1)]);
        Add(sgrps, f / rels);

    od;

    # 0 <= j <= k <= m <= d
    for j in [0 .. d] do
      for k in [j .. d] do
        for m in [Int((d + k + 1) / 2) .. d] do

            rels := ShallowCopy(basrels);
            for i in [1 .. j] do
                Add(rels, [x[i] * x[d + 1], x[1] ^ (n - d - 1)]);
                Add(rels, [x[d + 1] * x[i], x[1] ^ (n - d - 1)]);
            od;
            for i in [j + 1 .. k] do
                Add(rels, [x[i] * x[d + 1], x[1] ^ (n - d)]);
                Add(rels, [x[d + 1] * x[i], x[1] ^ (n - d)]);
            od;
            for i in [k + 1 .. m] do
                Add(rels, [x[i] * x[d + 1], x[1] ^ (n - d)]);
                Add(rels, [x[d + 1] * x[i], x[1] ^ (n - d - 1)]);
            od;
            for i in [m + 1 .. d] do
                Add(rels, [x[i] * x[d + 1], x[1] ^ (n - d - 1)]);
                Add(rels, [x[d + 1] * x[i], x[1] ^ (n - d)]);
            od;
            Add(rels, [x[d + 1] ^ 2, x[1] ^ (n - d)]);  # v ^ 2 = u_1 ^ (n - d)
            Add(sgrps, f / rels);

            Remove(rels);
            # v ^ 2 = u_1 ^ (n - d - 1)
            Add(rels, [x[d + 1] ^ 2, x[1] ^ (n - d - 1)]);
            Add(sgrps, f / rels);

        od;
      od;
    od;

    return sgrps;
end);

##  returns presentations for all semigroups of order <n> and coclass <d>
##  with <d>+1 generators and <d> of those generating a monogenic semigroup
##  of coclass <d> up to equivalence

InstallGlobalFunction(NilpotentSemigroupsCoclassD,
function(n, d)
  if not IsPosInt(n) then
    Error("the size <n> has to be a positive integer");
  elif not IsPosInt(d) then
    Error("the coclass <d> has to be a positive integer");
    # catch restriction of coclass value < d > depending on order < n >
  elif n < 4 + d then
    Error("the difference of the order <n> and the coclass <d> ",
          " must be at least 4");
  fi;

  return NilpotentSemigroupsCoclassD_NC(n, d);
end);

##  obtain f.p.-presentation for a nilpotent semigroup of degree 3 from
##  the library
##  AD: WORKS ONLY FOR 3-GENERATED SEMIGROUPS OF ORDER 5 AT THE MOMENT

InstallGlobalFunction(IsomorphicFpSemigroup,
function(sgrp)
  local erz,    # minimal generating set of <sgrp>
        d,      # minimal number of generators of <sgrp>
        f,      # free semigroup on <d> generators
        x,      # generating set of <f>
        z,      # multiplicative zero of <sgrp>
        pairs,  # list of 2-tuples with entries in [1 .. <d>]
        pos,    # position of <p> in unmodified <pairs>
        p,      # a pair that corresponds to a non - zero product in <sgrp>
        rels,   # relations of output semigroup isomorphic to < sgrp >
        q;      # loop counter, element in modified < pairs >

  erz := MinimalGeneratingSet(sgrp);
  d   := Length(erz);

  f := FreeSemigroup(d);
  x := GeneratorsOfSemigroup(f);

  pairs := Reversed(Tuples([1 .. d], 2));

  z   := MultiplicativeZero(sgrp);
  pos := PositionProperty(pairs, p -> z <> erz[p[1]] * erz[p[2]]);
  p   := Remove(pairs, pos);

  rels := EmptyPlist(d ^ 2);
  Add(rels,
      [x[p[1]] * x[p[1]] * x[p[2]], x[p[1]] * x[p[1]] * x[p[1]] * x[p[2]]]);

  for q in pairs do
    if z = erz[q[1]] * erz[q[2]] then
      Add(rels, [x[p[1]] * x[p[1]] * x[p[2]], x[q[1]] * x[q[2]]]);
    else
      Add(rels, [x[p[1]] * x[p[2]], x[q[1]] * x[q[2]]]);
    fi;
  od;

  return f / rels;
end);

##  returns presentations for all semigroups of order <n> and coclass 2
##  which have a minimal generating set of size 3 up to equivalence
##
##  - implementing list from small coclass paper for n >= 6
##  - using the semigroups from the library for n = 5

InstallGlobalFunction(NilpotentSemigroupsCoclass2Rank3,
function(n)
  local sgrps,     # list of all semigroups
        f,         # free semigroup on two elements
        x,         # generators of <f>
        k, l,      # loop counters
        subsgrps,  # list of candidates for V and W
        v, w,      # loop counters
        V, W,      # subsemigroups of size n-1 and coclass 1
        Vgens,     # generators of the subsemigroup V
        Wgens,     # generators of the subsemigroup W
        Vrels,     # relations of the subsemigroup V
        Wrels,     # relations of the subsemigroup W
        rels;      # relations of a semigroup

  # catch input error
  if not IsPosInt(n) then
      Error("the size < n > has to be a positive integer");
  fi;

  f := FreeSemigroup(3);
  x := GeneratorsOfSemigroup(f);

  # catch exceptional cases
  if n <= 3 then
    return [];
  elif n = 4 then
    # the zero semigroup
    return [f / [[x[1] ^ 2, x[1] ^ 3],     # u ^ 2 = u ^ 3
                 [x[1] ^ 2, x[2] ^ 2],     # u ^ 2 = v ^ 2
                 [x[1] ^ 2, x[1] * x[2]],  # u ^ 2 = uv
                 [x[1] ^ 2, x[2] * x[1]],  # u ^ 2 = vu
                 [x[1] ^ 2, x[3] ^ 2],     # u ^ 2 = w ^ 2
                 [x[1] ^ 2, x[1] * x[3]],  # u ^ 2 = uw
                 [x[1] ^ 2, x[3] * x[1]],  # u ^ 2 = wu
                 [x[1] ^ 2, x[2] * x[3]],  # u ^ 2 = vw
                 [x[1] ^ 2, x[3] * x[2]],  # u ^ 2 = wv
                 [x[1] ^ 2, x[3] ^ 2]]];   # u ^ 2 = w ^ 2
  elif n = 5 then
    # just take the semigroups from the library
    return List(AllSmallSemigroups(5,
                                   Is3GeneratedSemigroup, true,
                                   NilpotencyDegree, 3),
                IsomorphicFpSemigroup);
  fi;

  if IsEvenInt(n) then
      sgrps := EmptyPlist((21 * n ^ 2 + 22 * n - 96) / 8);
  else
      sgrps := EmptyPlist((21 * n ^ 2 + 36 * n - 81) / 8);
  fi;

  sgrps := NilpotentSemigroupsCoclassD_NC(n, 2);

  # get semigroups of size n - 1 and coclass 1 .. .
  subsgrps := NilpotentSemigroupsCoclass1(n - 1);
  # .. . in which the two generators are not interchangeable
  Remove(subsgrps, 1);

  for v in [1 .. Length(subsgrps)] do
    V := subsgrps[v];

    # relations from V translated to new generators
    Vgens := FreeGeneratorsOfFpSemigroup(V);
    Vrels := List(RelationsOfFpSemigroup(V),
                   rel -> [MappedWord(rel[1], Vgens, x{[1, 2]}),
                           MappedWord(rel[2], Vgens, x{[1, 2]})]);
    # u * v = u ^ k
    k := ExtRepOfObj(Vrels[Length(Vrels) - 1][2])[2];

    for w in [1 .. Length(subsgrps)] do
      W := subsgrps[w];

      # relations from W translated to new generators
      Wgens := FreeGeneratorsOfFpSemigroup(W);
      Wrels := List(RelationsOfFpSemigroup(W),
                     rel -> [MappedWord(rel[1], Wgens, x{[1, 3]}),
                             MappedWord(rel[2], Wgens, x{[1, 3]})]);
      # first relation is already contained in <Vrels>
      Remove(Wrels, 1);
      # u * w = u ^ l
      l := ExtRepOfObj(Wrels[Length(Wrels) - 1][2])[2];

      rels := Concatenation(Vrels, Wrels);

      # Case 2.d
      if w >= v and IsCommutative(V) and IsCommutative(W) then
        if k + l <= n - 2 then
          # vw = wv
          Add(rels, [x[2] * x[3], x[3] * x[2]]);
          # vw = u ^ (k + l - 2)
          Add(rels, [x[2] * x[3], x[1] ^ (k + l - 2)]);
          Add(sgrps, f / rels);
        else
          # vw = u ^ (k + l - 2)
          Add(rels, [x[3] * x[2], x[1] ^ (n - 3)]);
          # vw = u ^ (k + l - 2)
          Add(rels, [x[2] * x[3], x[1] ^ (n - 3)]);
          Add(sgrps, f / rels);

          Remove(rels);

          # vw = u ^ (k + l - 2)
          Add(rels, [x[2] * x[3], x[1] ^ (n - 2)]);
          Add(sgrps, f / rels);

          Remove(rels);
          Remove(rels);

          # vw = u ^ (k + l - 2)
          Add(rels, [x[3] * x[2], x[1] ^ (n - 2)]);
          # vw = u ^ (k + l - 2)
          Add(rels, [x[2] * x[3], x[1] ^ (n - 2)]);
          Add(sgrps, f / rels);
        fi;
      elif not IsCommutative(V) and IsCommutative(W) then
        # se 2.b and part of Case 2.a
        Add(rels, [x[2] * x[3], x[1] ^ (n - 3)]);  # vw = u ^ (n - 3)
        Add(rels, [x[3] * x[2], x[1] ^ (n - 3)]);  # wv = u ^ (n - 3)
        Add(sgrps, f / rels);

        Remove(rels);
        Add(rels, [x[3] * x[2], x[1] ^ (n - 2)]);  # wv = u ^ (n - 2)
        Add(sgrps, f / rels);

        Remove(rels);
        Remove(rels);
        Add(rels, [x[2] * x[3], x[1] ^ (n - 2)]);  # vw = u ^ (n - 2)
        Add(rels, [x[3] * x[2], x[1] ^ (n - 2)]);  # wv = u ^ (n - 2)
        Add(sgrps, f / rels);

        Remove(rels);
        Add(rels, [x[3] * x[2], x[1] ^ (n - 3)]);  # wv = u ^ (n - 3)
        Add(sgrps, f / rels);

      elif v >= w and not IsCommutative(V) and not IsCommutative(W) then
        # Case 2.a
        Add(rels, [x[2] * x[3], x[1] ^ (n - 3)]);  # vw = u ^ (n - 3)
        Add(rels, [x[3] * x[2], x[1] ^ (n - 3)]);  # wv = u ^ (n - 3)
        Add(sgrps, f / rels);

        Remove(rels);
        Add(rels, [x[3] * x[2], x[1] ^ (n - 2)]);  # wv = u ^ (n - 2)
        Add(sgrps, f / rels);

        Remove(rels);
        Remove(rels);
        Add(rels, [x[2] * x[3], x[1] ^ (n - 2)]);  # vw = u ^ (n - 2)
        Add(rels, [x[3] * x[2], x[1] ^ (n - 2)]);  # wv = u ^ (n - 2)
        Add(sgrps, f / rels);

        Remove(rels);
        Add(rels, [x[3] * x[2], x[1] ^ (n - 3)]);  # wv = u ^ (n - 3)
        Add(sgrps, f / rels);

        if v = w then
            Remove(sgrps);
        fi;

        # take dual of W
        Wrels[Length(Wrels) - 2][2] := x[1] ^ (n - 3);
        Wrels[Length(Wrels) - 1][2] := x[1] ^ (n - 2);

        rels := Concatenation(Vrels, Wrels);

        Add(rels, [x[2] * x[3], x[1] ^ (n - 3)]);  # vw = u ^ (n - 3)
        Add(rels, [x[3] * x[2], x[1] ^ (n - 3)]);  # wv = u ^ (n - 3)
        Add(sgrps, f / rels);

        Remove(rels);
        Add(rels, [x[3] * x[2], x[1] ^ (n - 2)]);  # wv = u ^ (n - 2)
        Add(sgrps, f / rels);

        Remove(rels);
        Remove(rels);
        Add(rels, [x[2] * x[3], x[1] ^ (n - 2)]);  # vw = u ^ (n - 2)
        Add(rels, [x[3] * x[2], x[1] ^ (n - 2)]);  # wv = u ^ (n - 2)
        Add(sgrps, f / rels);

        Remove(rels);
        Add(rels, [x[3] * x[2], x[1] ^ (n - 3)]);  # wv = u ^ (n - 3)
        Add(sgrps, f / rels);
      fi;
    od;
  od;

  return sgrps;
end);

##  returns presentations for all semigroups of order <n> and coclass 2
##  which have a minimal generating set of size 2 up to equivalence
##
##  Implementing list from small coclass paper for n >= 7
InstallGlobalFunction(NilpotentSemigroupsCoclass2Rank2,
function(n)
  local sgrps,  # list of all semigroups
        f,      # free semigroup on two elements
        x,      # generators of <f>
        rels,   # relations of a semigroup
        k;      # loop counter

  if not IsPosInt(n) then
    Error("the size < n > has to be a positive integer");
  fi;

  # catch exceptional cases; for n > 4 see end of function
  if n <= 4 then
    return [];
  fi;

  f := FreeSemigroup(2);
  x := GeneratorsOfSemigroup(f);

  # might be 1 too big
  sgrps := EmptyPlist(5 * n + Int(n / 2) - Int(n / 3) - 1);

  # y = v^2 = uv = vu (third semigroup in Case 4, y = v^2)
  Add(sgrps, f / [[x[1] ^ (n - 1), x[1] ^ (n - 2)],  # u^(n - 2) = u ^ (n - 1)
                  [x[1] * x[2], x[2] * x[1]],        # uv = vu
                  [x[2] ^ 2, x[1] * x[2]],           # v ^ 2 = uv
                  [x[2] ^ 3, x[1] ^ (n - 3)]]);      # v ^ 3 = u ^ (n - 3)
  Add(sgrps, f / [[x[1] ^ (n - 1), x[1] ^ (n - 2)],  # u^(n - 2) = u ^ (n - 1)
                  [x[1] * x[2], x[2] * x[1]],        # uv = vu
                  [x[2] ^ 2, x[1] * x[2]],           # v ^ 2 = uv
                  [x[2] ^ 3, x[1] ^ (n - 2)]]);      # v ^ 3 = u ^ (n - 2)

  # y = uv = vu
  for k in [3, 4 .. Int((n - 1) / 2)] do
    # u ^ (n - 2) = u ^ (n - 1)
    Add(sgrps, f / [[x[1] ^ (n - 1), x[1] ^ (n - 2)],
                    [x[1] * x[2], x[2] * x[1]],        # uv = vu
                    [x[2] ^ 2, x[1] ^ (2 * k - 4)],    # v ^ 2 = u ^ (2k - 4)
                    [x[1] ^ 2 * x[2], x[1] ^ k]]);     # u ^ 2v = u ^ k
  od;
  for k in [n - Int(n / 2) .. n - 2] do
    Add(sgrps, f / [[x[1] ^ (n - 1), x[1] ^ (n - 2)],  # u^(n-2)=u^(n-1)
                    [x[1] * x[2], x[2] * x[1]],        # uv=vu
                    [x[2] ^ 2, x[1] ^ (n - 4)],        # v^2 =u^(n-4)
                    [x[1] ^ 2 * x[2], x[1] ^ k]]);     # u^2v=u^k
    Add(sgrps, f / [[x[1] ^ (n - 1), x[1] ^ (n - 2)],  # u^(n-2)=u^(n-1)
                    [x[1] * x[2], x[2] * x[1]],        # uv=vu
                    [x[2] ^ 2, x[1] ^ (n - 3)],        # v^2=u^(n-3)
                    [x[1] ^ 2 * x[2], x[1] ^ k]]);     # u^2v=u^k
    Add(sgrps, f / [[x[1] ^ (n - 1), x[1] ^ (n - 2)],  # u^(n-2)=u^(n - 1)
                    [x[1] * x[2], x[2] * x[1]],        # uv=vu
                    [x[2] ^ 2, x[1] ^ (n - 2)],        # v^2=u^(n-2)
                    [x[1] ^ 2 * x[2], x[1] ^ k]]);     # u^2v=u^k
  od;

  # y = uv = v ^ 2
  Add(sgrps, f / [[x[1] ^ (n - 1), x[1] ^ (n - 2)],      # u^(n-2)=u^(n-1)
                  [x[2] ^ 2, x[1] * x[2]],               # v^2=uv
                  [x[2] * x[1], x[1] ^ 2],               # vu=u^2
                  [x[1] * x[2] ^ 2, x[1] ^ 3]]);         # uv^2=u^3
  Add(sgrps, f / [[x[1] ^ (n - 1), x[1] ^ (n - 2)],      # u^(n-2)=u^(n-1)
                  [x[2] ^ 2, x[1] * x[2]],               # v^2=uv
                  [x[2] * x[1], x[1] ^ (n - 3)],         # vu=u^(n-3)
                  [x[1] * x[2] ^ 2, x[1] ^ (n - 2)]]);   # uv^2=u^(n-2)
  Add(sgrps, f / [[x[1] ^ (n - 1), x[1] ^ (n - 2)],      # u^(n-2)=u^(n-1)
                  [x[2] ^ 2, x[1] * x[2]],               # v^2=uv
                  [x[2] * x[1], x[1] ^ (n - 2)],         # vu=u^(n-2)
                  [x[1] * x[2] ^ 2, x[1] ^ (n - 2)]]);   # uv^2=u^(n-2)

  # y = v ^ 2
  for k in [2 .. n - 2] do
    Add(sgrps, f / [[x[1] ^ (n - 1), x[1] ^ (n - 2)],   # u^(n-2)=u^(n-1)
                    [x[1] * x[2], x[2] * x[1]],         # uv=vu
                    [x[1] * x[2], x[1] ^ k],            # uv=u^k
                    [x[2] ^ 3, x[1] ^ (3 * k - 3)]]);   # v^3=u^(3k-3)
  od;
  for k in [n - Int(2 * n / 3) .. n - 2] do
    Add(sgrps, f / [[x[1] ^ (n - 1), x[1] ^ (n - 2)],  # u^(n-2)=u^(n-1)
                    [x[1] * x[2], x[2] * x[1]],        # uv=vu
                    [x[1] * x[2], x[1] ^ k],           # uv=u^k
                    [x[2] ^ 3, x[1] ^ (n - 3)]]);      # v^3=u^(n-3)
  od;
  Add(sgrps, f / [[x[1] ^ (n - 1), x[1] ^ (n - 2)],  # u^(n-2)=u^(n-1)
                  [x[1] * x[2], x[1] ^ (n - 3)],     # uv=u^(n-3)
                  [x[2] * x[1], x[1] ^ (n - 2)],     # vu=u^(n-2)
                  [x[2] ^ 3, x[1] ^ (n - 3)]]);      # v^3=u^(n-3)
  Add(sgrps, f / [[x[1] ^ (n - 1), x[1] ^ (n - 2)],  # u^(n-2)=u^(n-1)
                  [x[1] * x[2], x[1] ^ (n - 3)],     # uv=u^(n-3)
                  [x[2] * x[1], x[1] ^ (n - 2)],     # vu=u^(n-2)
                  [x[2] ^ 3, x[1] ^ (n - 2)]]);      # v^3=u^(n-2)

  # y=vu
  for k in [2 .. n - Int((n + 1) / 2) - 1] do
    Add(sgrps, f / [[x[1] ^ (n - 1), x[1] ^ (n - 2)],      # u^(n-2)=u^(n-1)
                     [x[1] * x[2], x[1] ^ k],              # uv=u^k
                     [x[2] ^ 2, x[1] ^ (2 * k - 2)],       # v^2=u^(2k-2)
                     [x[2] * x[1] ^ 2, x[1] ^ (k + 1)]]);  # vu^2=u^(k+1)
  od;
  for k in [n - Int((n + 1) / 2) .. n - 2] do
    Add(sgrps, f / [[x[1] ^ (n - 1), x[1] ^ (n - 2)],      # u^(n-2)=u^(n-1)
                     [x[1] * x[2], x[1] ^ k],              # uv=u^k
                     [x[2] ^ 2, x[1] ^ (n - 2)],           # v^2=u^(n-2)
                     [x[2] * x[1] ^ 2, x[1] ^ (k + 1)]]);  # vu^2=u^(k+1)
    Add(sgrps, f / [[x[1] ^ (n - 1), x[1] ^ (n - 2)],      # u^(n-2)=u^(n-1)
                     [x[1] * x[2], x[1] ^ k],              # uv=u^k
                     [x[2] ^ 2, x[1] ^ (n - 3)],           # v^2=u^(n-3)
                     [x[2] * x[1] ^ 2, x[1] ^ (k + 1)]]);  # vu^2=u^(k+1)
  od;
  for k in [n - 3 .. n - 2] do
    Add(sgrps, f / [[x[1] ^ (n - 1), x[1] ^ (n - 2)],      # u^(n-2)=u^(n-1)
                     [x[1] * x[2], x[1] ^ (n - 4)],        # uv=u^(n-4)
                     [x[2] ^ 2, x[1] ^ k],                 # v^2=u^k
                     [x[2] * x[1] ^ 2, x[1] ^ (n - 2)]]);  # vu^2=u^(n-2)
    Add(sgrps, f / [[x[1] ^ (n - 1), x[1] ^ (n - 2)],      # u^(n-2)=u^(n-1)
                     [x[1] * x[2], x[1] ^ (n - 3)],        # uv=u^(n-3)
                     [x[2] ^ 2, x[1] ^ k],                 # v^2=u^k
                     [x[2] * x[1] ^ 2, x[1] ^ (n - 3)]]);  # vu^2=u^(n-3)
    Add(sgrps, f / [[x[1] ^ (n - 1), x[1] ^ (n - 2)],      # u^(n-2)=u^(n-1)
                    [x[1] * x[2], x[1] ^ (n - 2)],         # uv=u^(n-2)
                    [x[2] ^ 2, x[1] ^ k],                  # v^2=u^k
                    [x[2] * x[1] ^ 2, x[1] ^ (n - 3)]]);   # vu^2=u^(n-3)
  od;

  if n = 5 then
    sgrps := sgrps{[17, 15, 5, 18, 16, 4, 10, 8, 2, 6]};
    Add(sgrps, f / [[x[1] ^ 2, x[1] ^ 2 * x[2]],                # u^2=u^2v
                    [x[2] ^ 2, x[1] ^ 2 * x[2]],                # v^2=u^2v
                    [x[1] * x[2] * x[1], x[1] ^ 2 * x[2]],      # uvu=u^2v
                    [x[2] * x[1] * x[2], (x[1] * x[2]) ^ 2]]);  # vuv=(uv)^2
  fi;

  if n = 6 then
    sgrps := sgrps{[23, 21, 8, 30, 29, 5, 6, 20, 3, 24, 22, 7, 27, 26, 14,
                     11, 19, 2, 10, 13, 4, 17, 18, 16, 1, 9]};
    rels := [[x[1] ^ 2, x[1] ^ 3],                      # u^2=u^3
             [x[1] ^ 2, x[2] ^ 2],                      # u^2=v^2
             [x[1] ^ 2, x[1] * x[2] * x[1]],            # u^2=uvu
             [x[1] * x[2] * x[1], x[2] * x[1] * x[2]],  # uvu=vuv
             [x[1] ^ 2, x[2] ^ 3],                      # u^2=v^3
             [x[2] ^ 2, x[2] * x[1] * x[2]],            # v^2=vuv
             [x[1] ^ 2, x[2] * x[1]],                   # u^2=vu
             [x[2] * x[1], x[1] * x[2] ^ 2],            # vu=uv^2
             [x[2] ^ 2, x[1] * x[2] * x[1]],            # v^2=uvu
             [x[1] ^ 2, x[2] * x[1] * x[2]],            # u^2=vuv
             [x[2] ^ 2, x[2] * x[1]],                   # v^2=vu
             [x[1] * x[2], x[2] * x[1]],                # uv=vu
             [x[1] ^ 2 * x[2], x[1] ^ 2],               # u^2v=u^2
             [x[1] ^ 3, x[1] * x[2] * x[1]],            # u^3=uvu
             [x[1] ^ 3, x[2] ^ 3],                      # u^3=v^3
             [x[1] * x[2] ^ 2, x[1] ^ 2],               # uv^2=u^2
             [x[2] * x[1], x[2] * x[1] ^ 2],            # vu=vu^2
             [x[1] ^ 2 * x[2], x[1] ^ 3],               # u^2v=u^3
             [x[1] * x[2], x[1] ^ 2],                   # uv=u^2
             [x[2] * x[1] ^ 3, x[1] ^ 3]];              # vu^3=u^3

    Add(sgrps, f / rels{[1, 2, 3]});         # [6, 42]
    Add(sgrps, f / rels{[1, 2, 4]});         # [6, 141]
    Add(sgrps, f / rels{[3, 5, 6]});         # [6, 338]
    Add(sgrps, f / rels{[1, 5, 7]});         # [6, 413]
    Add(sgrps, f / rels{[1, 5, 8]});         # [6, 414]
    Add(sgrps, f / rels{[5, 9, 10]});        # [6, 481]
    Add(sgrps, f / rels{[1, 5, 11]});        # [6, 583]
    Add(sgrps, f / rels{[5, 6, 9]});         # [6, 659]
    Add(sgrps, f / rels{[1, 5, 12, 13]});    # [6, 880]
    Add(sgrps, f / rels{[2, 10, 14]});       # [6, 1485]
    Add(sgrps, f / rels{[2, 3, 10]});        # [6, 1865]
    Add(sgrps, f / rels{[15, 16, 17]});      # [6, 2416]
    Add(sgrps, f / rels{[7, 15, 16]});       # [6, 2417]
    Add(sgrps, f / rels{[11, 15, 16]});      # [6, 2494]
    Add(sgrps, f / rels{[12, 15, 16, 18]});  # [6, 2556]
    Add(sgrps, f / rels{[11, 19, 20]});      # [6, 2558]
    Add(sgrps, f / rels{[11, 12, 20]});      # [6, 2559]
  fi;
  return sgrps;
end);
