#############################################################################
##
#W  enums.tst                        smallsemi - a GAP library of semigroups
#Y  Copyright (C) 2008-2024              Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

#ReadTest(Filename(DirectoriesPackageLibrary("smallsemi","tst"),"enums.tst"));
gap> START_TEST("Smallsemi package: enums.tst");
gap> cur := [InfoLevel(InfoSmallsemi), InfoLevel(InfoWarning)];;
gap> SetInfoLevel(InfoSmallsemi, 0); SetInfoLevel(InfoWarning, 0);
gap> ## old checks
gap> NrSmallSemigroups(5, DiagonalOfMultiplicationTable, [1, 1, 1, 1, 2],
> IsCommutative, true);
17
gap> NrSmallSemigroups(5, DiagonalOfMultiplicationTable, [1, 1, 1, 1, 3],
> IsCommutative, true);
0
gap> NrSmallSemigroups(5, DiagonalOfMultiplicationTable, [1, 1, 1, 1, 2],
> IsCommutative, false);
23
gap> NrSmallSemigroups(5, DiagonalOfMultiplicationTable, [1, 1, 1, 1, 3],
> IsCommutative, false);
0
gap> NrSmallSemigroups(5, DiagonalOfMultiplicationTable, [1, 1, 1, 1, 5],
> IsCommutative, false);
55
gap> NrSmallSemigroups(5, DiagonalOfMultiplicationTable, [1, 1, 1, 1, 2]);
40
gap> NrSmallSemigroups(5, DiagonalOfMultiplicationTable, [1, 1, 1, 1, 3]);
0
gap> diags := Set(List(AllSmallSemigroups(2), DiagonalOfMultiplicationTable));
[ [ 1, 1 ], [ 1, 2 ] ]
gap> List(diags, x -> NrSmallSemigroups(2, DiagonalOfMultiplicationTable, x,
> IsCommutative, true));
[ 2, 1 ]
gap> List(diags, x -> NrSmallSemigroups(2, DiagonalOfMultiplicationTable, x,
> IsCommutative, false));
[ 0, 1 ]
gap> NrSmallSemigroups(2, IsCommutative, true);
3
gap> NrSmallSemigroups(2);
4
gap> diags := Set(List(AllSmallSemigroups(3), DiagonalOfMultiplicationTable));;
gap> List(diags, x -> NrSmallSemigroups(3, DiagonalOfMultiplicationTable, x,
> IsCommutative, true));
[ 3, 1, 5, 2, 1 ]
gap> List(diags, x -> NrSmallSemigroups(3, DiagonalOfMultiplicationTable, x,
> IsCommutative, false));
[ 0, 0, 2, 4, 0 ]
gap> Sum(last2); Sum(last2);
12
6
gap> NrSmallSemigroups(3);
18
gap> diags := Set(List(AllSmallSemigroups(4), DiagonalOfMultiplicationTable));;
gap> List(diags, x -> NrSmallSemigroups(4, DiagonalOfMultiplicationTable, x,
> IsCommutative, true));
[ 6, 5, 11, 3, 3, 7, 14, 1, 5, 2, 1 ]
gap> List(diags, x -> NrSmallSemigroups(4, DiagonalOfMultiplicationTable, x,
> IsCommutative, false));
[ 1, 1, 9, 1, 1, 4, 30, 0, 21, 0, 0 ]
gap> Sum(last2); Sum(last2);
58
68
gap> NrSmallSemigroups(4);
126
gap> diags := Set(List(AllSmallSemigroups(5), DiagonalOfMultiplicationTable));;
gap> List(diags, x -> NrSmallSemigroups(5, DiagonalOfMultiplicationTable, x,
> IsCommutative, true));
[ 13, 17, 28, 15, 4, 1, 19, 31, 38, 1, 5, 9, 8, 9, 1, 41, 49, 8, 1, 15, 5, 3,
  1, 1, 1, 1 ]
gap> List(diags, x -> NrSmallSemigroups(5, DiagonalOfMultiplicationTable, x,
> IsCommutative, false));
[ 13, 23, 55, 22, 3, 0, 14, 27, 152, 0, 9, 7, 4, 12, 0, 91, 277, 2, 0, 120,
  3, 1, 0, 0, 0, 0 ]
gap> Sum(last2); Sum(last2);
325
835
gap> NrSmallSemigroups(5);
1160
gap> OneSmallSemigroup(5, DiagonalOfMultiplicationTable, [1, 1, 1, 1, 2]);
<small semigroup of size 5>
gap> GeneratorsOfSemigroup(last);
[ s1, s2, s3, s4, s5 ]
gap> s := RandomSmallSemigroup(5, DiagonalOfMultiplicationTable, [1, 1, 1, 1, 2],
> IsCommutative, true);;
gap> IsSmallSemigroup(s);
true
gap> HasMultiplicationTable(s);
true
gap> enum := EnumeratorOfSmallSemigroups(7);
<enumerator of semigroups of size 7>
gap> Length(enum);
836021
gap> s := enum[500000];
<small semigroup of size 7>
gap> MultiplicationTable(s);
[ [ 1, 1, 1, 1, 1, 1, 1 ], [ 1, 1, 1, 1, 1, 1, 1 ], [ 1, 1, 1, 1, 1, 1, 1 ],
  [ 1, 1, 1, 1, 2, 2, 2 ], [ 1, 1, 1, 3, 2, 3, 1 ], [ 1, 1, 1, 3, 3, 2, 3 ],
  [ 1, 1, 1, 2, 1, 3, 3 ] ]
gap> IsCommutativeSemigroup(s);
false
gap> IsRegularSemigroup(s);
false
gap> GreensRClasses(s);;
gap> GreensDClasses(s);;
gap> MultiplicationTable(s);
[ [ 1, 1, 1, 1, 1, 1, 1 ], [ 1, 1, 1, 1, 1, 1, 1 ], [ 1, 1, 1, 1, 1, 1, 1 ],
  [ 1, 1, 1, 1, 2, 2, 2 ], [ 1, 1, 1, 3, 2, 3, 1 ], [ 1, 1, 1, 3, 3, 2, 3 ],
  [ 1, 1, 1, 2, 1, 3, 3 ] ]
gap> enum := EnumeratorOfSmallSemigroups(6, IsRegularSemigroup, true);
<enumerator of semigroups of size 6>
gap> Length(enum);
1352
gap> s := enum[999];
<small semigroup of size 6>
gap> IsCompletelyRegularSemigroup(s);
true
gap> IsCliffordSemigroup(s);
false
gap> enum := EnumeratorOfSmallSemigroups(7, IsCliffordSemigroup, true);
<enumerator of semigroups of size 7>
gap> Length(last);
879
gap> s := enum[441];
<small semigroup of size 7>
gap> s := enum[1];
<small semigroup of size 7>
gap> AllSmallSemigroups(2);
[ <small semigroup of size 2>, <small semigroup of size 2>,
  <small semigroup of size 2>, <small semigroup of size 2> ]
gap> AllSmallSemigroups([2, 3]);
[ <small semigroup of size 2>, <small semigroup of size 2>,
  <small semigroup of size 2>, <small semigroup of size 2>,
  <small semigroup of size 3>, <small semigroup of size 3>,
  <small semigroup of size 3>, <small semigroup of size 3>,
  <small semigroup of size 3>, <small semigroup of size 3>,
  <small semigroup of size 3>, <small semigroup of size 3>,
  <small semigroup of size 3>, <small semigroup of size 3>,
  <small semigroup of size 3>, <small semigroup of size 3>,
  <small semigroup of size 3>, <small semigroup of size 3>,
  <small semigroup of size 3>, <small semigroup of size 3>,
  <small semigroup of size 3>, <small semigroup of size 3> ]
gap> AllSmallSemigroups([2, 3], IsRegularSemigroup, true);
[ <small semigroup of size 2>, <small semigroup of size 2>,
  <small semigroup of size 2>, <small semigroup of size 3>,
  <small semigroup of size 3>, <small semigroup of size 3>,
  <small semigroup of size 3>, <small semigroup of size 3>,
  <small semigroup of size 3>, <small semigroup of size 3>,
  <small semigroup of size 3>, <small semigroup of size 3> ]
gap> AllSmallSemigroups([2, 3], IsRegularSemigroup, true,
> x -> Length(GreensLClasses(x)), 1);
[ <small semigroup of size 2>, <small semigroup of size 2>,
  <small semigroup of size 3>, <small semigroup of size 3> ]
gap> enum := EnumeratorOfSmallSemigroups([3, 4]);
<enumerator of semigroups of sizes [ 3, 4 ]>
gap> IdSmallSemigroup(enum[2]);
[ 3, 2 ]
gap> IdSmallSemigroup(enum[19]);
[ 4, 1 ]
gap> IdSmallSemigroup(enum[100]);
[ 4, 82 ]
gap> enum := EnumeratorOfSmallSemigroups(8, IsInverseSemigroup, true,
> IsCommutativeSemigroup, true);
<enumerator of semigroups of size 8>
gap> Length(enum);
4443
gap> AllSmallSemigroups(enum, x -> Length(GreensRClasses(x)), 1);
[ <small semigroup of size 8>, <small semigroup of size 8>,
  <small semigroup of size 8> ]
gap> iter := IteratorOfSmallSemigroups(7, x -> Length(GreensRClasses(x)), 1);
<iterator of semigroups of size 7>
gap> AllSmallSemigroups(iter, IsCommutative, true, IsSimpleSemigroup, true);
[ <small semigroup of size 7> ]
gap> iter := IteratorOfSmallSemigroups(5, x -> Length(GreensDClasses(x)), 1);
<iterator of semigroups of size 5>
gap> AllSmallSemigroups(iter);
[ <small semigroup of size 5>, <small semigroup of size 5> ]
gap> AllSmallSemigroups(iter) = AllSmallSemigroups(5, IsSimpleSemigroup, true);
true
gap> semis := AllSmallSemigroups([2, 4], IsCommutativeSemigroup,
> false, x -> MultiplicativeZero(x) = fail,
> false, IsCliffordSemigroup, false, IsRegularSemigroup, true);
[ <small semigroup of size 4>, <small semigroup of size 4>,
  <small semigroup of size 4>, <small semigroup of size 4>,
  <small semigroup of size 4> ]
gap> ForAll(semis, x -> not IsCommutativeSemigroup(x));
true
gap> ForAll(semis, IsRegularSemigroup);
true
gap> ForAll(semis, x -> not IsCliffordSemigroup(x));
true
gap> ForAll(semis, x -> MultiplicativeZero(x) <> fail);
true
gap> EnumeratorOfSmallSemigroups(8, IsSimpleSemigroup, true);
<enumerator of semigroups of size 8>
gap> ForAll(last, IsSimpleSemigroup);
true
gap> ForAll(last2, IsCompletelySimpleSemigroup);
true
gap> s := RandomSmallSemigroup(8, IsSimpleSemigroup, true);
<small semigroup of size 8>
gap> IsSimpleSemigroup(s);
true
gap> IsCompletelySimpleSemigroup(s);
true
gap> s := RandomSmallSemigroup(8, IsSimpleSemigroup, true);
<small semigroup of size 8>
gap> IsSimpleSemigroup(s);
true
gap> IsCompletelySimpleSemigroup(s);
true
gap> s := OneSmallSemigroup(6, IsRectangularBand, true);
<small semigroup of size 6>
gap> IsRectangularBand(s);
true
gap> enum := EnumeratorOfSmallSemigroups(6, IsCommutative, false);
<enumerator of semigroups of size 6>
gap> enum := EnumeratorOfSmallSemigroups(enum, DiagonalOfMultiplicationTable,
> [1, 3, 2, 4, 4, 4]);
<empty enumerator of semigroups>
gap> OneSmallSemigroup(enum, IsCompletelyRegularSemigroup, false);
fail
gap> s := OneSmallSemigroup(6, IsFullTransformationSemigroup, true);
fail
gap> s := OneSmallSemigroup(6, IsFullTransformationSemigroupCopy, true);
fail
gap> s := OneSmallSemigroup(4, IsRightZeroSemigroup, true);
fail
gap> s := OneSmallSemigroup(4, IsLeftZeroSemigroup, true);
<small semigroup of size 4>
gap> s := RandomSmallSemigroup([1 .. 7]);;
gap> s1 := OneSmallSemigroup(5, IsSemigroupWithClosedIdempotents, false);
<small semigroup of size 5>
gap> s2 := OneSmallSemigroup(5, IsSemigroupWithoutClosedIdempotents, true);
<small semigroup of size 5>
gap> s1 = s2;
true
gap> s := RandomSmallSemigroup(8, IsSimpleSemigroup, true);
<small semigroup of size 8>
gap> s := OneSmallSemigroup(6, IsRectangularBand, true);
<small semigroup of size 6>
gap> enum := EnumeratorOfSmallSemigroups(6, IsCommutative, false);
<enumerator of semigroups of size 6>
gap> OneSmallSemigroup(enum, IsCompletelyRegularSemigroup, false);
<small semigroup of size 6>
gap> enum := EnumeratorOfSmallSemigroups(6, IsSimpleSemigroup, true);
<enumerator of semigroups of size 6>
gap> ForAll(enum, IsSimpleSemigroup);
true
gap> enum := EnumeratorOfSmallSemigroups(7);
<enumerator of semigroups of size 7>
gap> EnumeratorOfSmallSemigroups(2);
<enumerator of semigroups of size 2>
gap> EnumeratorOfSmallSemigroups([2, 3]);
<enumerator of semigroups of sizes [ 2, 3 ]>
gap> EnumeratorOfSmallSemigroups([2, 3], IsRegularSemigroup, true);
<enumerator of semigroups of sizes [ 2, 3 ]>
gap> EnumeratorOfSmallSemigroups([2, 3], IsRegularSemigroup, true, x ->
> Length(GreensRClasses(x)), 1);
<enumerator of semigroups of sizes [ 2, 3 ]>
gap> enum := EnumeratorOfSmallSemigroups(8, IsInverseSemigroup, true,
> IsCommutativeSemigroup, true);
<enumerator of semigroups of size 8>
gap> enum := EnumeratorOfSmallSemigroups(5, x -> Length(GreensLClasses(x)), 1);
<enumerator of semigroups of size 5>
gap> Length(enum);
2
gap> EnumeratorOfSmallSemigroups(enum, IsCommutativeSemigroup, true,
> IsSimpleSemigroup, false);
<empty enumerator of semigroups>
gap> iter := IteratorOfSmallSemigroups(8);
<iterator of semigroups of size 8>
gap> EnumeratorOfSmallSemigroups(iter, IsCommutativeSemigroup, true,
> IsSimpleSemigroup, false);
<enumerator of semigroups of size 8>
gap> enum := EnumeratorOfSmallSemigroups(5, x -> Length(GreensRClasses(x)), 1);
<enumerator of semigroups of size 5>
gap> IdsOfSmallSemigroups(enum, IsCommutativeSemigroup, true,
> IsSimpleSemigroup, false);
[  ]
gap> iter := IteratorOfSmallSemigroups(4);;
gap> IdsOfSmallSemigroups(iter, IsCommutativeSemigroup, true);
[ [ 4, 1 ], [ 4, 3 ], [ 4, 4 ], [ 4, 5 ], [ 4, 6 ], [ 4, 7 ], [ 4, 8 ],
  [ 4, 10 ], [ 4, 11 ], [ 4, 12 ], [ 4, 13 ], [ 4, 14 ], [ 4, 19 ],
  [ 4, 22 ], [ 4, 24 ], [ 4, 25 ], [ 4, 26 ], [ 4, 28 ], [ 4, 29 ],
  [ 4, 30 ], [ 4, 32 ], [ 4, 33 ], [ 4, 34 ], [ 4, 36 ], [ 4, 37 ],
  [ 4, 38 ], [ 4, 40 ], [ 4, 41 ], [ 4, 42 ], [ 4, 43 ], [ 4, 47 ],
  [ 4, 48 ], [ 4, 49 ], [ 4, 50 ], [ 4, 51 ], [ 4, 53 ], [ 4, 56 ],
  [ 4, 67 ], [ 4, 68 ], [ 4, 78 ], [ 4, 80 ], [ 4, 83 ], [ 4, 84 ],
  [ 4, 86 ], [ 4, 88 ], [ 4, 89 ], [ 4, 91 ], [ 4, 92 ], [ 4, 94 ],
  [ 4, 97 ], [ 4, 98 ], [ 4, 100 ], [ 4, 105 ], [ 4, 112 ], [ 4, 114 ],
  [ 4, 124 ], [ 4, 125 ], [ 4, 126 ] ]
gap> IdsOfSmallSemigroups(2);
[ [ 2, 1 ], [ 2, 2 ], [ 2, 3 ], [ 2, 4 ] ]
gap> IdsOfSmallSemigroups([2, 3]);
[ [ 2, 1 ], [ 2, 2 ], [ 2, 3 ], [ 2, 4 ], [ 3, 1 ], [ 3, 2 ], [ 3, 3 ],
  [ 3, 4 ], [ 3, 5 ], [ 3, 6 ], [ 3, 7 ], [ 3, 8 ], [ 3, 9 ], [ 3, 10 ],
  [ 3, 11 ], [ 3, 12 ], [ 3, 13 ], [ 3, 14 ], [ 3, 15 ], [ 3, 16 ],
  [ 3, 17 ], [ 3, 18 ] ]
gap> IdsOfSmallSemigroups([2, 3], IsRegularSemigroup, true);
[ [ 2, 2 ], [ 2, 3 ], [ 2, 4 ], [ 3, 10 ], [ 3, 11 ], [ 3, 12 ], [ 3, 13 ],
  [ 3, 14 ], [ 3, 15 ], [ 3, 16 ], [ 3, 17 ], [ 3, 18 ] ]
gap> IdsOfSmallSemigroups([2, 3], IsRegularSemigroup, true, x ->
> Length(GreensLClasses(x)), 1);
[ [ 2, 2 ], [ 2, 4 ], [ 3, 17 ], [ 3, 18 ] ]
gap> enum := EnumeratorOfSmallSemigroupsByIds([[7, 1], [6, 1], [5, 1]]);
<enumerator of semigroups of sizes [ 5, 6, 7 ]>
gap> enum[1];
<small semigroup of size 5>
gap> enum[2];
<small semigroup of size 6>
gap> enum[3];
<small semigroup of size 7>
gap> enum[4];
fail
gap> Length(enum);
3
gap> List(enum, IdSmallSemigroup);
[ [ 5, 1 ], [ 6, 1 ], [ 7, 1 ] ]
gap> PositionsOfSmallSemigroupsIn(enum);
[ [ 1 ], [ 1 ], [ 1 ] ]
gap> ids := [[5, 7], [5, 4], [5, 8]];
[ [ 5, 7 ], [ 5, 4 ], [ 5, 8 ] ]
gap> enum := EnumeratorOfSmallSemigroupsByIds(ids);
<enumerator of semigroups of size 5>
gap> IdSmallSemigroup(enum[1]);
[ 5, 4 ]
gap> IdSmallSemigroup(enum[2]);
[ 5, 7 ]
gap> IdSmallSemigroup(enum[3]);
[ 5, 8 ]
gap> enum := EnumeratorOfSmallSemigroupsByIds(7, [1 .. 1000]);
<enumerator of semigroups of size 7>
gap> Length(enum);
1000
gap> enum := EnumeratorOfSmallSemigroupsByIds([2, 3], [[1 .. 1000], [1 .. 10]]);
fail
gap> enum := EnumeratorOfSmallSemigroupsByIds([2, 3], [[1 .. 10], [1 .. 10]]);
fail
gap> enum := EnumeratorOfSmallSemigroupsByIds([2, 3], [[1 .. 2], [1 .. 10]]);
<enumerator of semigroups of sizes [ 2, 3 ]>
gap> enum := EnumeratorOfSmallSemigroupsByIds([[2, 1], [3, 1], [4, 1]]);
<enumerator of semigroups of sizes [ 2, 3, 4 ]>
gap> IsEnumeratorOfSmallSemigroups(enum);
true
gap> enum := EnumeratorOfSmallSemigroups(4);
<enumerator of semigroups of size 4>
gap> IsEnumeratorOfSmallSemigroups(enum);
true
gap> IsIdSmallSemigroup([7, 1]);
true
gap> IsIdSmallSemigroup([8, 1]);
true
gap> IsIdSmallSemigroup([1, 2]);
false
gap> IsIdSmallSemigroup([3, 20]);
false
gap> IsIdSmallSemigroup([3, 18]);
true
gap> IsIdSmallSemigroup(3, 18);
true
gap> IsIdSmallSemigroup(3, 20);
false
gap> IsIdSmallSemigroup(3, 20, 1021);
false
gap> IsIdSmallSemigroup([3, 20, "t"]);
false
gap> iter := IteratorOfSmallSemigroups(8);
<iterator of semigroups of size 8>
gap> IsIteratorOfSmallSemigroups(iter);
true
gap> iter := EmptyIteratorOfSmallSemigroups();
<empty iterator of semigroups>
gap> IsIteratorOfSmallSemigroups(iter);
true
gap> iter := IteratorOfSmallSemigroups(8);
<iterator of semigroups of size 8>
gap> iter := IteratorOfSmallSemigroups([8]);
<iterator of semigroups of size 8>
gap> NextIterator(iter);
<small semigroup of size 8>
gap> IsDoneIterator(iter);
false
gap> IteratorOfSmallSemigroups([2, 3], IsRegularSemigroup, true);
<iterator of semigroups of sizes [ 2, 3 ]>
gap> iter := IteratorOfSmallSemigroups([2, 3], IsRegularSemigroup, true,
> x -> Length(Idempotents(x)) = 1, true);
<iterator of semigroups of sizes [ 2, 3 ]>
gap> NextIterator(iter);
<small semigroup of size 2>
gap> NextIterator(iter);
<small semigroup of size 3>
gap> NextIterator(iter);
fail
gap> enum := EnumeratorOfSmallSemigroups(5, x -> Length(Idempotents(x)) = 1, true);
<enumerator of semigroups of size 5>
gap> iter := IteratorOfSmallSemigroups(enum, x -> Length(GreensRClasses(x)) = 2, true);
<iterator of semigroups of size 5>
gap> NextIterator(iter);
<small semigroup of size 5>
gap> NextIterator(iter);
<small semigroup of size 5>
gap> NextIterator(iter);
<small semigroup of size 5>
gap> iter := IteratorOfSmallSemigroups(8);
<iterator of semigroups of size 8>
gap> IteratorOfSmallSemigroups(iter);
<iterator of semigroups of size 8>
gap> IteratorOfSmallSemigroups(iter, IsInverseSemigroup, true,
> x -> Length(Idempotents(x)) = 1, true, x -> Length(GreensRClasses(x)) = 2, true);
<iterator of semigroups of size 8>
gap> NextIterator(iter);
<small semigroup of size 8>
gap> NextIterator(iter);
<small semigroup of size 8>
gap> List([1 .. 8], NrSmallSemigroups);
[ 1, 4, 18, 126, 1160, 15973, 836021, 1843120128 ]
gap> NrSmallSemigroups(8, IsCommutative, true, IsInverseSemigroup, true);
4443
gap> NrSmallSemigroups([1 .. 8], IsCliffordSemigroup, true);
5610
gap> NrSmallSemigroups([2 .. 8], IsCliffordSemigroup, true);
5609
gap> NrSmallSemigroups(8, IsRegularSemigroup, true,
> IsCompletelyRegularSemigroup, false);
1164
gap> NrSmallSemigroups(5, NilpotencyDegree, 3);
84
gap> OneSmallSemigroup(8, IsCommutative, true, IsInverseSemigroup, true);
<small semigroup of size 8>
gap> OneSmallSemigroup([1 .. 8], IsCliffordSemigroup, true);
<small semigroup of size 1>
gap> OneSmallSemigroup(8, IsRegularSemigroup, true,
> IsCompletelyRegularSemigroup, false);
<small semigroup of size 8>
gap> OneSmallSemigroup(6, NilpotencyDegree, 3);
<small semigroup of size 6>
gap> iter := IteratorOfSmallSemigroups([1 .. 8]);
<iterator of semigroups of sizes [ 1 .. 8 ]>
gap> OneSmallSemigroup(iter);
<small semigroup of size 1>
gap> iter := IteratorOfSmallSemigroups(8, IsCommutative, false);
<iterator of semigroups of size 8>
gap> OneSmallSemigroup(iter);
<small semigroup of size 8>
gap> OneSmallSemigroup(iter, IsRegularSemigroup, true);
<small semigroup of size 8>
gap> enum := EnumeratorOfSmallSemigroups([3 .. 5], IsSimpleSemigroup, false);
<enumerator of semigroups of sizes [ 3, 4, 5 ]>
gap> PositionsOfSmallSemigroups(enum, Is1IdempotentSemigroup, true,
> Is2GeneratedSemigroup, true, IsCliffordSemigroup, false);
[ [ 1, 2 ], [ 2, 3, 5, 6, 8, 9, 10, 12, 34, 35, 36, 97 ],
  [ 5, 20, 21, 22, 23, 26, 29, 32, 35, 54, 55, 56, 60, 61, 62, 63, 64, 65,
      152, 156, 159, 177, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190,
      191, 192, 193, 540, 1009, 1157, 1158 ] ]
gap> enum := EnumeratorOfSmallSemigroups([2 .. 4], IsSimpleSemigroup, false,
> IsRegularSemigroup, true);
<enumerator of semigroups of sizes [ 2, 3, 4 ]>
gap> PositionsOfSmallSemigroupsIn(enum);
[ [ 3 ], [ 10, 11, 12, 13, 14, 15, 16 ],
  [ 50, 51, 88, 89, 90, 91, 92, 93, 94, 95, 96, 98, 99, 100, 101, 102, 103,
      104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117,
      118, 119, 120, 121, 124, 125 ] ]
gap> PositionsOfSmallSemigroupsIn(enum);
[ [ 3 ], [ 10, 11, 12, 13, 14, 15, 16 ],
  [ 50, 51, 88, 89, 90, 91, 92, 93, 94, 95, 96, 98, 99, 100, 101, 102, 103,
      104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117,
      118, 119, 120, 121, 124, 125 ] ]
gap> enum := EnumeratorOfSmallSemigroups([2 .. 4], IsSimpleSemigroup, false,
> IsRegularSemigroup, true);
<enumerator of semigroups of sizes [ 2, 3, 4 ]>
gap> ArgumentsUsedToCreate(enum);
[ <Property "IsRegularSemigroup">, true, <Property "IsSimpleSemigroup">,
  false ]
gap> iter := IteratorOfSmallSemigroups([2 .. 4], IsSimpleSemigroup, false,
> IsRegularSemigroup, true);
<iterator of semigroups of sizes [ 2 .. 4 ]>
gap> ArgumentsUsedToCreate(iter);
[ <Property "IsRegularSemigroup">, true, <Property "IsSimpleSemigroup">,
  false ]
gap> RandomSmallSemigroup(8, IsCommutative, true, IsInverseSemigroup, true);
<small semigroup of size 8>
gap> RandomSmallSemigroup([1 .. 8], IsCliffordSemigroup, true);;
gap> RandomSmallSemigroup(8, IsRegularSemigroup, true,
> IsCompletelyRegularSemigroup, false);
<small semigroup of size 8>
gap> RandomSmallSemigroup(6, NilpotencyDegree, 3);
<small semigroup of size 6>
gap> RandomSmallSemigroup(5, NilpotencyDegree, 6);
fail
gap> iter := IteratorOfSmallSemigroups([1 .. 7]);
<iterator of semigroups of sizes [ 1 .. 7 ]>
gap> RandomSmallSemigroup(iter);;
gap> iter := IteratorOfSmallSemigroups(7, IsCommutative, false);
<iterator of semigroups of size 7>
gap>  RandomSmallSemigroup(iter);
<small semigroup of size 7>
gap> RandomSmallSemigroup(iter, IsRegularSemigroup, true);
<small semigroup of size 7>
gap> enum := EnumeratorOfSmallSemigroups([2 .. 4], IsSimpleSemigroup, false);
<enumerator of semigroups of sizes [ 2, 3, 4 ]>
gap> SizesOfSmallSemigroupsIn(enum);
[ 2, 3, 4 ]
gap> iter := IteratorOfSmallSemigroups(7, IsCommutative, false);
<iterator of semigroups of size 7>
gap> SizesOfSmallSemigroupsIn(iter);
[ 7 ]
gap> SMALLSEMI_NormalizeArgs(5, IsCommutativeSemigroup, true);
[ 5, <Property "IsCommutative">, true ]
gap> SMALLSEMI_NormalizeArgs(5, IsSemigroupWithClosedIdempotents, false);
[ 5, <Property "IsSemigroupWithoutClosedIdempotents">, true ]
gap> SMALLSEMI_NormalizeArgs(5, IsCommutative, true);
[ 5, <Property "IsCommutative">, true ]
gap> iter := IteratorOfSmallSemigroups(4, NilpotencyDegree, fail);
<iterator of semigroups of size 4>
gap> IsDoneIterator(iter); NextIterator(iter);
false
<small semigroup of size 4>
gap> IsDoneIterator(iter); NextIterator(iter);
false
<small semigroup of size 4>
gap> for i in iter do
> od;
gap>  IsDoneIterator(iter); NextIterator(iter);
true
fail
gap> iter := IteratorOfSmallSemigroups(4, NilpotencyDegree, 2);
<iterator of semigroups of size 4>
gap> IsDoneIterator(iter); NextIterator(iter);
false
<small semigroup of size 4>
gap> IsDoneIterator(iter); NextIterator(iter);
true
fail
gap> iter := IteratorOfSmallSemigroups(4, IsZeroSemigroup, true);
<iterator of semigroups of size 4>
gap> IsDoneIterator(iter); NextIterator(iter);
false
<small semigroup of size 4>
gap> IsDoneIterator(iter); NextIterator(iter);
true
fail
gap> iter := IteratorOfSmallSemigroups(4, NilpotencyDegree, 5);
<iterator of semigroups of size 4>
gap> IsDoneIterator(iter);
true
gap> NextIterator(iter);
fail
gap> iter := IteratorOfSmallSemigroups(4, NilpotencyDegree, 5);
<iterator of semigroups of size 4>
gap> NextIterator(iter);
fail
gap> IsDoneIterator(iter);
true
gap> Nr3NilpotentSemigroups(4);
8
gap> Nr3NilpotentSemigroups(9, "UpToIsomorphism");
105931872028455
gap> Nr3NilpotentSemigroups(16, "SelfDual");
4975000837941847814744710290469890455985530
gap> Nr3NilpotentSemigroups(19, "Commutative");
12094270656160403920767935604624748908993169949317454767617795
gap> SetInfoLevel(InfoSmallsemi, cur[1]); SetInfoLevel(InfoWarning, cur[2]);
gap> Unbind(cur);
gap> STOP_TEST("Smallsemi package: enums.tst", 10000);
