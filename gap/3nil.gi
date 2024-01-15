#############################################################################
##
##  3nil.gi                        Smallsemi - a GAP library of semigroups
##  Copyright (C) 2024                 Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

InstallGlobalFunction(Nr3NilpotentSemigroups, function(arg...)
    local size,   # input, order of semigroups
          type,   # optional input, type of semigroups
          types,  # list of valid second (optional) arguments
          i,      # loop counter
          smallc,

          nr3NilIso,
          # takes a positive integer <n> as input and returns the number of
          # 3-nilpotent semigroups with <n> elements up to isomorphism

          nr3NilSelfDual,
          # takes a positive integer <n> as input and returns the number of
          # self-dual 3-nilpotent semigroups with <n> elements

          nr3NilComm,
          # takes a positive integer <n> as input and returns the number of
          # commutative 3-nilpotent semigroups with <n> elements up to iso

          nr3NilAll,
          # takes a positive integer <n> as input and returns the number of
          # all different 3-nilpotent semigroups on a set with <n> elements

          nr3NilAllComm,
          # takes a positive integer <n> as input and returns the number of
          # all different, commutative 3-nilpotent semigroups on a set with
          # <n> elements

          sizeConjugacyClass,
          # returns for a partition <part> of <size> the number of permutations
          # in the symmetric group on <size> elements with disjoint cycle
          # notation given by <part> (corresponds to a conjugacy class)

          transformPart;
          # takes a partition as a list of summands and returns a vector with
          # the number of summands with value i in the i-th position

    ##################################################################
    ### local functions

    sizeConjugacyClass := function(partition)
      return Factorial(Sum(partition)) /
        Product(Collected(partition), pair -> Factorial(pair[2])
                                              * pair[1] ^ pair[2]);
    end;

    transformPart := function(part)
      local n, coll, i, jvec;

      n := Sum(part);
      jvec := [];
      coll := Collected(part);
      for i in [1 .. n] do
        if IsBound(coll[1]) and coll[1][1] = i then
          Add(jvec, coll[1][2]);
          Remove(coll, 1);
        else
          Add(jvec, 0);
        fi;
      od;
      return jvec;
    end;

    nr3NilIso := function(n)
      local NrIsomorphismClasses;

      NrIsomorphismClasses := function(n, m)
        local parts, nrs, Produkt;

        Produkt := function(p1, p2)
          local prod, i, j;

          prod := 1;

          for i in [1 .. Length(p1)] do
            # if exponent is 0, prod is multiplied by 1 => omit
            if p1[i] <> 0 then
              for j in [1 .. Length(p1)] do
                # if exponent is 0, prod is multiplied by 1 => omit
                if p1[j] <> 0 then
                  prod := prod * (1 + Sum(Filtered(DivisorsInt(Lcm(i, j)),
                                          x -> x <= Length(p2)), d -> d * p2[d]))
                                            ^ (p1[i] * p1[j] * Gcd(i, j));
                fi;
              od;
           fi;
         od;
         return prod;
       end;

       # only the zero semigroup in the case |B|=1
       if m = 1 then
         return 1;
       fi;

       # the elements in the Cartesian product are pairs of partitions
       # they stand for elements in a conjugacy class of S_{n-m} x S_{m-1}
       parts := Cartesian(Partitions(n - m), Partitions(m - 1));

       # pp is a partition pair
       nrs := List(parts,
              pp -> Produkt(transformPart(pp[1]),
              Concatenation(transformPart(pp[2]), [0])) *
              sizeConjugacyClass(pp[1]) * sizeConjugacyClass(pp[2]));
              return Sum(nrs) / (Factorial(n - m) * Factorial(m - 1));
      end;

      return Sum([2 .. n - 1],
                 m -> NrIsomorphismClasses(n, m) -
                 NrIsomorphismClasses(n - 1, m - 1));
    end;

    smallc := function(int, part)
      return 1 + Sum(Filtered(DivisorsInt(int),
                              x -> x <= Length(part)),
                     d -> d * part[d]);
    end;

    nr3NilSelfDual := function(n)
      local NrEquivalenceClasses;
      NrEquivalenceClasses := function(n, m)
        local parts, nrs, Produkt, Prod1, Prod2, Prod3, Prod4;

        Prod1 := function(p1, p2)
          local prod, i;
          prod := 1;
          for i in [1 .. Minimum(Int((Length(p1) + 1) / 2),
                                 Int((n + 1) / 2))] do
              # if exponent is 0, prod is multiplied by 1 => omit
            if p1[2 * i - 1] <> 0 then
              prod := prod *
                      (smallc(2 * i - 1, p2) *
                       smallc(4 * i - 2, p2) ^ (i - 1)) ^
                       (p1[2 * i - 1]);
            fi;
          od;
          return prod;
        end;

        Prod2 := function(p1, p2)
          local prod, i;
          prod := 1;
          for i in [1 .. Minimum(Int(Length(p1) / 4), Int(n / 4))] do
            # if exponent is 0, prod is multiplied by 1 => omit
            if p1[4 * i] <> 0 then
              prod := prod * smallc(4 * i, p2) ^ (4 * i * p1[4 * i]);
            fi;
          od;

          return prod;
        end;

        Prod3 := function(p1, p2)
          local prod, i;
          prod := 1;
          for i in [1 .. Minimum(Int((Length(p1) + 2) / 4), Int(n + 2 / 4))] do
            # if exponent is 0, prod is multiplied by 1 => omit
            if p1[4 * i - 2] <> 0 then
              prod := prod *
                      (smallc(2 * i - 1, p2) ^ 2
                       * smallc(4 * i - 2, p2) ^ (4 * i - 3)) ^
                       p1[4 * i - 2];
            fi;
          od;
          return prod;
        end;

        Prod4 := function(p1, p2)
          local prod, i, j;

          prod := 1;

          for i in [1 .. Length(p1)] do
            # if exponent is 0, prod is multiplied by 1 => omit
            if p1[i] <> 0 then
              prod := prod * smallc(Lcm(2, i), p2) ^
                      (i * Gcd(2, i) * (p1[i] ^ 2 - p1[i]) / 2);
              for j in [1 .. Minimum(Length(p1), i - 1)] do
                # if exponent is 0, prod is multiplied by 1 = > omit
                if p1[j] <> 0 then
                  prod := prod * smallc(Lcm(2, i, j), p2) ^
                          (p1[i] * p1[j] * 2 * i * j / Lcm(2, i, j));
                fi;
              od;
            fi;
          od;

          return prod;
        end;

        Produkt := {p1, p2} ->
            Prod1(p1, p2) * Prod2(p1, p2) * Prod3(p1, p2) * Prod4(p1, p2);

        # only the zero semigroup in the case |B|=1, counted half
        if m = 1 then
          return 1;
        fi;

        # the elements in the Cartesian product are pairs of partitions
        # they stand for elements in a conjugacy class of S_{n-m} x S_{m-1}
        parts := Cartesian(Partitions(n - m), Partitions(m - 1));

        # pp is a partition pair
        nrs := List(parts,
                    pp -> Produkt(transformPart(pp[1]),
                                  Concatenation(transformPart(pp[2]), [0])) *
                   sizeConjugacyClass(pp[1]) * sizeConjugacyClass(pp[2]));

        return Sum(nrs) / (Factorial(n - m) * Factorial(m - 1));
      end;

      return Sum([2 .. n - 1],
             m -> NrEquivalenceClasses(n, m) -
                  NrEquivalenceClasses(n - 1, m - 1));
    end;

    nr3NilComm := function(n)
      local NrIsomorphismClasses;

      NrIsomorphismClasses := function(n, m)
        local parts, nrs, Produkt, Produkt1, Produkt2, Produkt3;

        Produkt1 := function(p1, p2)
          local prod, i;

          prod := 1;

          for i in [1 .. Minimum(Int(Length(p1) / 2), Int(n / 2))] do
            # if exponent is 0, prod is multiplied by 1 = > omit
            if p1[2 * i] <> 0 then
                prod := prod *
                        (smallc(i, p2) * smallc(2 * i, p2) ^ i) ^ p1[2 * i];
            fi;
          od;

          return prod;
        end;

        Produkt2 := function(p1, p2)
          local prod, i;
          prod := 1;
          for i in [1 .. Minimum(Int((Length(p1) + 1) / 2), Int((n + 1) / 2))] do
            # if exponent is 0, prod is multiplied by 1 => omit
            if p1[2 * i - 1] <> 0 then
              prod := prod *
                      (smallc(2 * i - 1, p2)) ^ (i * p1[2 * i - 1]);
            fi;
          od;

          return prod;
        end;

        Produkt3 := function(p1, p2)
          local prod, i, j;
          prod := 1;
          for i in [1 .. Length(p1)] do
            # if exponent is 0, prod is multiplied by 1 => omit
            if p1[i] <> 0 then
              prod := prod * smallc(i, p2) ^ (i * (p1[i] ^ 2 - p1[i]) / 2);
              for j in [1 .. Minimum(Length(p1), i - 1)] do
                # if exponent is 0, prod is multiplied by 1 => omit
                if p1[j] <> 0 then
                  prod := prod * smallc(Lcm(i, j), p2) ^
                          (p1[i] * p1[j] * Gcd(i, j));
                fi;
              od;
            fi;
          od;

          return prod;
        end;

        Produkt := {p1, p2} ->
                   Produkt1(p1, p2) * Produkt2(p1, p2) * Produkt3(p1, p2);

        # only the zero semigroup in the case |B|=1
        if m = 1 then
            return 1;
        fi;

        # the elements in the Cartesian product are pairs of partitions
        # they stand for elements in a conjugacy class of S_{n-m} x S_{m-1}
        parts := Cartesian(Partitions(n - m), Partitions(m - 1));

        # pp is a partition pair
        nrs := List(parts,
                    pp -> Produkt(transformPart(pp[1]),
                                  Concatenation(transformPart(pp[2]), [0])) *
                    sizeConjugacyClass(pp[1]) * sizeConjugacyClass(pp[2]));

        return Sum(nrs) / (Factorial(n - m) * Factorial(m - 1));
      end;

      return Sum([2 .. n - 1],
             m -> NrIsomorphismClasses(n, m) -
                  NrIsomorphismClasses(n - 1, m - 1));
    end;

    nr3NilAll := function(n)
        return Sum([2 .. Int(n + 1 / 2 - RootInt(n - 1))],
                   k -> Binomial(n, k) * k
                        * Sum([0 .. k - 1],
                              i -> (- 1) ^ i * Binomial(k - 1, i)
                                   * (k - i) ^ ((n - k) ^ 2)));
    end;

    nr3NilAllComm := function(n)
        return Sum([1 .. Int(n + 3 / 2 - RootInt(2 * n))],
                   k -> Binomial(n, k) * k
                        * Sum([0 .. k - 1],
                               i -> (- 1) ^ i * Binomial(k - 1, i)
                                    * (k - i) ^ ((n - k) * (n - k + 1) / 2)));
    end;

    ##################################################################
    # MAIN FUNCTION
    ##################################################################

    types := ["UpToEquivalence", "UpToIsomorphism", "SelfDual", "Commutative",
              "Labelled", "Labelled-Commutative"];

    # check input
    if Length(arg) > 2 then
        Error("number of arguments must be two");
    elif not IsPosInt(arg[1]) then
        Error("first argument must be a positive integer");
    elif Length(arg) = 2 and not IsString(arg[2]) then
        Error("second argument must be a string");
    elif Length(arg) = 2 and not arg[2] in types then
        Error("invalid second argument, string must be in ", types);
    fi;

    # get input
    size := arg[1];
    if Length(arg) = 2 then
      type := arg[2];
    else
      type := types[1];
    fi;

    if type = types[1] then
      # up to equivalence
      return (nr3NilSelfDual(size) + nr3NilIso(size)) / 2;
    elif type = types[2] then
      # up to isomorphism
      return nr3NilIso(size);
    elif type = types[3] then
      # self dual semigroups
      return nr3NilSelfDual(size);
    elif type = types[4] then
      # commutative semigroups
      return nr3NilComm(size);
    elif type = types[5] then
      # labelled semigroups
      return nr3NilAll(size);
    else
      # labelled commutative semigroups
      return nr3NilAllComm(size);
    fi;
end);
