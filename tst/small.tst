#############################################################################
##
#W  small.tst                       smallsemi - a GAP library of semigroups
#Y  Copyright (C) 2008-2024             Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# This file contains the tests for the file small.gi.


#ReadTest(Filename(DirectoriesPackageLibrary("smallsemi","tst"),"small.tst"));
gap> START_TEST("Smallsemi package: small.tst");
gap> LoadPackage("smallsemi", false);;
gap> if IsBound(SEMIGROUPS) then SEMIGROUPS.StartTest(); fi;
gap> cur := InfoLevel(InfoSmallsemi);;
gap> SetInfoLevel(InfoSmallsemi, 1);
gap> Info(InfoSmallsemi, 1, "This is a test for the info class.");
#I  This is a test for the info class.
gap> SetInfoLevel(InfoSmallsemi, 0);
gap> sgrp := SemigroupByMultiplicationTable([[1]]);;
gap> map := EquivalenceSmallSemigroup(sgrp);;
gap> Size(Range(map));
1
gap> grp := SmallGroup(7, 1);;
gap> map := EquivalenceSmallSemigroup(grp);
SemigroupHomomorphismByImages ( Group( [ f1 ] )-><small semigroup of size 7>)
gap> id := IdSmallSemigroup(Range(map));
[ 7, 836017 ]
gap> IsGroupAsSemigroup(SmallSemigroup(id));
true
gap> t1 := Transformation([2, 2, 1]);;
gap> t2 := Transformation([2, 1, 1]);;
gap> sgrp := SemigroupByGenerators([t1, t2]);
<transformation semigroup of degree 3 with 2 generators>
gap> map := EquivalenceSmallSemigroup(sgrp);
MappingByFunction( <transformation semigroup of size 6, degree 3 with 2
 generators>, <small semigroup of size 6>, function( x ) ... end )
gap> RespectsMultiplication(map);
false
gap> PreImage(map, MinimalGeneratingSet(Range(map)));
[ Transformation( [ 1, 1, 2 ] ), Transformation( [ 2, 1, 1 ] ) ]
gap> Idempotents(Range(map));
[ s1, s3, s5 ]
gap> sgrp := RandomSmallSemigroup(5);
<small semigroup of size 5>
gap> IsSmallSemigroup(sgrp);
true
gap> sgrp := Semigroup(Transformation([1]));;
gap> IsSmallSemigroup(sgrp);
false
gap> IsSmallSemigroupElt(Transformation([1]));
false
gap> sgrp := RandomSmallSemigroup(5);;
gap> IsSmallSemigroupElt(Random(sgrp));
true
gap> RecoverMultiplicationTable(5, 1000);
[ [ 1, 1, 1, 1, 1 ], [ 1, 1, 1, 1, 1 ], [ 1, 2, 3, 4, 5 ], [ 1, 2, 4, 5, 3 ],
  [ 1, 2, 5, 3, 4 ] ]
gap> SmallSemigroupCreator(last);
<small semigroup of size 5>
gap> s := SemigroupByMultiplicationTableNC([[1, 2], [2, 1]]);
<semigroup of size 2, with 2 generators>
gap> IsSmallSemigroup(s);
false
gap> RecoverMultiplicationTable(10, 2);
fail
gap> RecoverMultiplicationTable(1, 2);
fail
gap> RecoverMultiplicationTable(2, 1);
[ [ 1, 1 ], [ 1, 1 ] ]
gap> RecoverMultiplicationTable(8, 11111111);
[ [ 1, 1, 1, 1, 1, 1, 1, 1 ], [ 1, 1, 1, 1, 1, 1, 1, 3 ],
  [ 3, 3, 3, 3, 3, 3, 3, 3 ], [ 1, 1, 1, 4, 4, 4, 4, 1 ],
  [ 1, 2, 3, 4, 5, 6, 7, 1 ], [ 1, 2, 3, 4, 5, 6, 7, 1 ],
  [ 1, 2, 3, 4, 5, 6, 7, 1 ], [ 8, 8, 8, 8, 8, 8, 8, 8 ] ]
gap> RecoverMultiplicationTable(2, 11111111);
fail
gap> SmallSemigroup(8, 1353452);
<small semigroup of size 8>
gap> s := Semigroup(Transformation([1, 2, 2]), Transformation([1, 2, 3]));;
gap> IdSmallSemigroup(s);
[ 2, 3 ]
gap> map := EquivalenceSmallSemigroup(s);;
gap> IsBijective(map);
true
gap> s := SemigroupByMultiplicationTableNC([[1, 2], [1, 2]]);
<semigroup of size 2, with 2 generators>
gap> map := EquivalenceSmallSemigroup(s);
MappingByFunction( <semigroup of size 2, with 2 generators>
 , <small semigroup of size 2>, function( x ) ... end )
gap> RespectsMultiplication(map);
false
gap> SmallSemigroupEltFamily;;
gap> SmallSemigroupEltType;;
gap> SmallSemigroupType;;
gap> UnloadSmallsemiData(true);
gap> IsBound(DATA2TO7[1]);
false
gap> RecoverMultiplicationTable(2, 1);;
gap> DATA2TO7[1];
[ "0100", "0101", "0011" ]
gap> UnloadSmallsemiData(true);
gap> DATA2TO7;
[  ]
gap> DATA8;
[  ]
gap> Display(BLUEPRINT_MATS(3));
[ [  1,  1,  1,  1,  1,  1,  1,  1 ],
  [  1,  1,  1,  1,  1,  1,  1,  1 ],
  [  1,  1,  1,  1,  1,  1,  1,  1 ],
  [  1,  1,  1 ],
  [  1,  1,  1 ],
  [  1,  1,  1 ],
  [  1,  1,  1 ],
  [  1,  1,  1 ] ]
gap> 3NIL_DATA;
rec( diag := fail )
gap> SmallSemigroup(8, 11433105);;
gap> DATA8;
[ ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
  ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
  ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
  ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
  ,,,,,,,,,,,,,,
  [ "111", "222", "333", "444", "444", "333", "333", "111", "444", "000",
      "333", "333", "000", "000", "222", "444", "111", "000", "000", "111",
      "111", "333", "000", "111", "222", "222", "444", "444", "444", "333",
      "000", "222", "111", "222", "222", "444", "333", "000", "222", "111",
      "222", "222", "333", "000", "111", "444", "222", "222", "445", "333",
      "000", "111", "444", "222", "222", "455" ] ]
gap> SmallSemigroup(8, NrSmallSemigroups(8) - 2);;
gap> 3NIL_DATA;
rec( diag := [ 2, 3 ], next := 4, positions := [ 1, 3, 4, 7 ],
  strlist := [ "0013", "0313" ] )
gap> SmallSemigroupNC(5, 1);
<small semigroup of size 5>
gap> SmallSemigroupNC(5, 1) = SmallSemigroup(5, 1);
true

# Issue 2 (Github 2019)
gap> BruteForceIsoCheck := function(iso)
>   local x, y;
>   if not IsInjective(iso) or not IsSurjective(iso) then
>     return false;
>   fi;
>   for x in GeneratorsOfSemigroup(Source(iso)) do
>     for y in GeneratorsOfSemigroup(Source(iso)) do
>       if x ^ iso * y ^ iso <> (x * y) ^ iso then
>         return false;
>       fi;
>     od;
>   od;
>   return true;
> end;;
gap> BruteForceInverseCheck := function(map)
> local inv;
>   inv := InverseGeneralMapping(map);
>   return ForAll(Source(map), x -> x = (x ^ map) ^ inv)
>     and ForAll(Range(map), x -> x = (x ^ inv) ^ map);
> end;;
gap> S := SmallSemigroup(4, 18);
<small semigroup of size 4>
gap> map := IsomorphismTransformationSemigroup(S);
SemigroupHomomorphismByImages ( <small semigroup of size 4>->Semigroup(
[ Transformation( [ 1, 1, 1, 4, 2 ] ), Transformation( [ 1, 1, 1, 4, 3 ] ),
  Transformation( [ 1, 1, 1, 4, 4 ] ) ] ))
gap> BruteForceIsoCheck(map);
true
gap> BruteForceInverseCheck(map);
true

#
gap> SetInfoLevel(InfoSmallsemi, cur);
gap> if IsBound(SEMIGROUPS) then SEMIGROUPS.StopTest(); fi;
gap> STOP_TEST("Smallsemi package: small.tst", 10000);
