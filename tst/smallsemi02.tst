# Smallsemi, chapter 4
#
# DO NOT EDIT THIS FILE - EDIT EXAMPLES IN THE SOURCE INSTEAD!
#
# This file has been generated by AutoDoc. It contains examples extracted from
# the package documentation. Each example is preceded by a comment which gives
# the name of a GAPDoc XML file and a line range from which the example were
# taken. Note that the XML file in turn may have been generated by AutoDoc
# from some other input.
#
gap> START_TEST("smallsemi02.tst");

# doc/../gap/small.gd:205-212
gap> SmallSemigroup(8, 1353452);
<small semigroup of size 8>
gap> SmallSemigroupNC(5, 1);
<small semigroup of size 5>
gap> SmallSemigroupNC(5, 1) = SmallSemigroup(5, 1);
true

# doc/../gap/small.gd:108-116
gap> sgrp := RandomSmallSemigroup(5);
<small semigroup of size 5>
gap> IsSmallSemigroup(sgrp);
true
gap> sgrp := Semigroup(Transformation([1]));;
gap> IsSmallSemigroup(sgrp);
false

# doc/../gap/small.gd:85-91
gap> IsSmallSemigroupElt(Transformation([1]));
false
gap> sgrp := RandomSmallSemigroup(5);;
gap> IsSmallSemigroupElt(Random(sgrp));
true

# doc/../gap/small.gd:136-150
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

# doc/../gap/small.gd:176-181
gap> s := SemigroupByMultiplicationTableNC([[1, 2], [2, 1]]);
<semigroup of size 2, with 2 generators>
gap> IsSmallSemigroup(s);
false

# doc/../gap/small.gd:40-45
gap> sgrp := Semigroup(Transformation([1, 2, 2]),
>                      Transformation([1, 2, 3]));;
gap> IdSmallSemigroup(sgrp);
[ 2, 3 ]

# doc/../gap/small.gd:20-26
gap> sgrp := Semigroup(Transformation([1, 2, 2]),
>                      Transformation([1, 2, 3]));;
gap> EquivalenceSmallSemigroup(sgrp);
SemigroupHomomorphismByImages ( Monoid( [ Transformation( [ 1, 2, 2 ] )
 ] )-><small semigroup of size 2>)

# doc/../gap/properties.gd:20-25
gap> s := SmallSemigroup(5, 6);
<small semigroup of size 5>
gap> Annihilators(s);
[ s1, s2 ]

# doc/../gap/properties.gd:37-44
gap> s := SmallSemigroup(8, 10101);;
gap> DiagonalOfMultiplicationTable(s);
[ 1, 1, 1, 1, 1, 1, 1, 1 ]
gap> s := SmallSemigroup(7, 10101);;
gap> DiagonalOfMultiplicationTable(s);
[ 1, 1, 1, 1, 1, 1, 1 ]

# doc/../gap/properties.gd:57-86
gap> s := SmallSemigroup(6, 3838);;
gap> DisplaySmallSemigroup(s);
IsBand:                              false
IsBrandtSemigroup:                   false
IsCommutative:                       false
IsCompletelyRegularSemigroup:        false
IsFullTransformationSemigroupCopy:   false
IsGroupAsSemigroup:                  false
IsIdempotentGenerated:               false
IsInverseSemigroup:                  false
IsMonogenicSemigroup:                false
IsMonoidAsSemigroup:                 false
IsMultSemigroupOfNearRing:           false
IsOrthodoxSemigroup:                 false
IsRectangularBand:                   false
IsRegularSemigroup:                  false
IsSelfDualSemigroup:                 false
IsSemigroupWithClosedIdempotents:    true
IsSimpleSemigroup:                   false
IsSingularSemigroupCopy:             false
IsZeroSemigroup:                     false
IsZeroSimpleSemigroup:               false
MinimalGeneratingSet:                [ s3, s4, s5, s6 ]
Idempotents:                         [ s1, s5, s6 ]
GreensRClasses:                      [ {s1}, {s2}, {s3}, {s4}, {s5}, {s6} ]
GreensLClasses:                      [ {s1}, {s2}, {s3}, {s4}, {s6} ]
GreensHClasses:                      [ {s1}, {s2}, {s3}, {s4}, {s5}, {s6} ]
GreensDClasses:                      [ {s1}, {s2}, {s3}, {s4}, {s6} ]

# doc/../gap/properties.gd:98-111
gap> s := SmallSemigroup(5, 116);
<small semigroup of size 5>
gap> x := Elements(s)[3];
s3
gap> IndexPeriod(x);
[ 2, 1 ]
gap> x ^ 3 = x ^ 2;
true
gap> x ^ 2 = x ^ 1;
false
gap> x ^ 3 = x ^ 1;
false

# doc/../gap/properties.gd:127-137
gap> s := SmallSemigroup(5, 519);;
gap> IsBand(s);
false
gap> s := OneSmallSemigroup(5, IsBand, true);
<small semigroup of size 5>
gap> IsBand(s);
true
gap> IdSmallSemigroup(s);
[ 5, 1010 ]

# doc/../gap/properties.gd:151-161
gap> s := SmallSemigroup(5, 519);;
gap> IsBrandtSemigroup(s);
false
gap> s := OneSmallSemigroup(5, IsBrandtSemigroup, true);
<small semigroup of size 5>
gap> IsBrandtSemigroup(s);
true
gap> IdSmallSemigroup(s);
[ 5, 149 ]

# doc/../gap/properties.gd:177-196
gap> s := SmallSemigroup(5, 519);;
gap> IsBand(s);
false
gap> s := OneSmallSemigroup(5, IsBand, true);
<small semigroup of size 5>
gap> IsBand(s);
true
gap> IdSmallSemigroup(s);
[ 5, 1010 ]
gap> s := SmallSemigroup(5, 519);;
gap> IsCliffordSemigroup(s);
false
gap> s := OneSmallSemigroup(5, IsCliffordSemigroup, true);
<small semigroup of size 5>
gap> IsCliffordSemigroup(s);
true
gap> IdSmallSemigroup(s);
[ 5, 148 ]

# doc/../gap/properties.gd:211-229
gap> s := SmallSemigroup(6, 871);;
gap> IsCommutativeSemigroup(s);
false
gap> s := OneSmallSemigroup(5, IsCommutative, true);
<small semigroup of size 5>
gap> IsCommutativeSemigroup(s);
true
gap> IsCommutative(s);
true
gap> IdSmallSemigroup(s);
[ 5, 1 ]
gap> s := OneSmallSemigroup(5, IsCommutativeSemigroup, true);
<small semigroup of size 5>
gap> IsCommutativeSemigroup(s);
true
gap> IsCommutative(s);
true

# doc/../gap/properties.gd:242-253
gap> s := SmallSemigroup(6, 13131);
<small semigroup of size 6>
gap> IsCompletelyRegularSemigroup(s);
false
gap> s := OneSmallSemigroup(6, IsCompletelyRegularSemigroup, true);
<small semigroup of size 6>
gap> IsCompletelyRegularSemigroup(s);
true
gap> IdSmallSemigroup(s);
[ 6, 3164 ]

# doc/../gap/properties.gd:269-282
gap> s := SmallSemigroup(1, 1);
<small semigroup of size 1>
gap> IsFullTransformationSemigroupCopy(s);
true
gap> s := OneSmallSemigroup(4, IsFullTransformationSemigroupCopy, true);
<small semigroup of size 4>
gap> IsFullTransformationSemigroupCopy(s);
true
gap> IdSmallSemigroup(s);
[ 4, 96 ]
gap> s := OneSmallSemigroup(6, IsFullTransformationSemigroupCopy, true);
fail

# doc/../gap/properties.gd:296-304
gap> s := SmallSemigroup(7, 7);
<small semigroup of size 7>
gap> IsGroupAsSemigroup(s);
false
gap> s := SmallSemigroup(4, 37);;
gap> IsGroupAsSemigroup(s);
true

# doc/../gap/properties.gd:320-337
gap> s := SmallSemigroup(3, 13);
<small semigroup of size 3>
gap> IsIdempotentGenerated(s);
true
gap> s := OneSmallSemigroup(3, IsIdempotentGenerated, false);
<small semigroup of size 3>
gap> IsIdempotentGenerated(s);
false
gap> IdSmallSemigroup(s);
[ 3, 1 ]
gap> s := OneSmallSemigroup(4, IsIdempotentGenerated, true,
> IsSingularSemigroupCopy, true);
fail
gap> s := OneSmallSemigroup(2, IsIdempotentGenerated, true,
> IsSingularSemigroupCopy, true);
<small semigroup of size 2>

# doc/../gap/properties.gd:352-361
gap> s := OneSmallSemigroup(7, IsInverseSemigroup, true);
<small semigroup of size 7>
gap> IsInverseSemigroup(s);
true
gap> s := SmallSemigroup(7, 101324);
<small semigroup of size 7>
gap> IsInverseSemigroup(s);
false

# doc/../gap/properties.gd:375-384
gap> s := SmallSemigroup(5, 438);
<small semigroup of size 5>
gap> IsLeftZeroSemigroup(s);
false
gap> s := SmallSemigroup(5, 1141);
<small semigroup of size 5>
gap> IsLeftZeroSemigroup(s);
true

# doc/../gap/properties.gd:395-410
gap> s := RandomSmallSemigroup(7);
<small semigroup of size 7>
gap> IsMonogenicSemigroup(s);
false
gap> s := OneSmallSemigroup(7, IsMonogenicSemigroup, true);
<small semigroup of size 7>
gap> IsMonogenicSemigroup(s);
true
gap> MinimalGeneratingSet(s);
[ s7 ]
gap> s := SmallSemigroup(7, 406945);
<small semigroup of size 7>
gap> IsMonogenicSemigroup(s);
false

# doc/../gap/properties.gd:423-436
gap> s := SmallSemigroup(4, 126);
<small semigroup of size 4>
gap> IsMonoidAsSemigroup(s);
false
gap> s := OneSmallSemigroup(4, IsMonoidAsSemigroup, true);
<small semigroup of size 4>
gap> IsMonoidAsSemigroup(s);
true
gap> One(s);
s1
gap> IdSmallSemigroup(s);
[ 4, 7 ]

# doc/../gap/properties.gd:451-462
gap> s := OneSmallSemigroup(7, IsMultSemigroupOfNearRing, true);
<small semigroup of size 7>
gap> IdSmallSemigroup(s);
[ 7, 1 ]
gap> IsMultSemigroupOfNearRing(s);
true
gap> s := SmallSemigroup(2, 2);
<small semigroup of size 2>
gap> IsMultSemigroupOfNearRing(s);
false

# doc/../gap/properties.gd:476-489
gap> s := SmallSemigroup(7, 760041);
<small semigroup of size 7>
gap> IsNGeneratedSemigroup(s, 4);
false
gap> IsNGeneratedSemigroup(s, 3);
true
gap> MinimalGeneratingSet(s);
[ s3, s5, s7 ]
gap> s := OneSmallSemigroup(4, x -> Length(MinimalGeneratingSet(x)), 4);
<small semigroup of size 4>
gap> IsNGeneratedSemigroup(s, 4);
true

# doc/../gap/properties.gd:510-518
gap> s := SmallSemigroup(4, 75);;
gap> IsNIdempotentSemigroup(s, 1);
false
gap> IsNIdempotentSemigroup(s, 2);
false
gap> IsNIdempotentSemigroup(s, 3);
true

# doc/../gap/properties.gd:547-558
gap> s := SmallSemigroup(5, 116);
<small semigroup of size 5>
gap> IsNilpotentSemigroup(s);
false
gap> s := SmallSemigroup(7, 673768);;
gap> IsNilpotentSemigroup(s);
true
gap> s := SmallSemigroup(7, 657867);;
gap> IsNilpotent(s);
true

# doc/../gap/properties.gd:573-581
gap> s := SmallSemigroup(6, 15858);;
gap> IsSemigroupWithClosedIdempotents(s);
true
gap> IsRegularSemigroup(s);
true
gap> IsOrthodoxSemigroup(s);
true

# doc/../gap/properties.gd:595-602
gap> s := SmallSemigroup(5, 216);;
gap> IsRectangularBand(s);
false
gap> s := SmallSemigroup(6, 15854);;
gap> IsRectangularBand(s);
true

# doc/../gap/properties.gd:617-628
gap> s := SmallSemigroup(3, 10);;
gap> IsRegularSemigroup(s);
true
gap> s := SmallSemigroup(3, 1);;
gap> IsRegularSemigroup(s);
false
gap> s := OneSmallSemigroup(4, IsFullTransformationSemigroupCopy, true);
<small semigroup of size 4>
gap> IsRegularSemigroup(s);
true

# doc/../gap/properties.gd:643-648
gap> s := SmallSemigroup(5, 438);
<small semigroup of size 5>
gap> IsRightZeroSemigroup(s);
false

# doc/../gap/properties.gd:663-672
gap> s := SmallSemigroup(5, 116);
<small semigroup of size 5>
gap> IsSelfDualSemigroup(s);
false
gap> s := RandomSmallSemigroup(5, IsSelfDualSemigroup, true);
<small semigroup of size 5>
gap> IsSelfDualSemigroup(s);
true

# doc/../gap/properties.gd:685-695
gap> s := SmallSemigroup(5, 677);;
gap> IsSemigroupWithClosedIdempotents(s);
true
gap> s := SmallSemigroup(5, 659);;
gap> IsSemigroupWithClosedIdempotents(s);
true
gap> s := SmallSemigroup(5, 327);;
gap> IsSemigroupWithClosedIdempotents(s);
false

# doc/../gap/properties.gd:715-724
gap> s := SmallSemigroup(5, 1);
<small semigroup of size 5>
gap> IsSemigroupWithZero(s);
true
gap> s := SmallSemigroup(4, 26);
<small semigroup of size 4>
gap> IsSemigroupWithZero(s);
false

# doc/../gap/properties.gd:743-752
gap> s := SmallSemigroup(7, 835080);;
gap> IsSimpleSemigroup(s);
true
gap> IsCompletelySimpleSemigroup(s);
true
gap> s := SmallSemigroup(7, 208242);;
gap> IsSimpleSemigroup(s);
false

# doc/../gap/properties.gd:767-780
gap> s := SmallSemigroup(1, 1);
<small semigroup of size 1>
gap> IsSingularSemigroupCopy(s);
false
gap> s := OneSmallSemigroup(2, IsSingularSemigroupCopy, true);
<small semigroup of size 2>
gap> IsSingularSemigroupCopy(s);
true
gap> IdSmallSemigroup(s);
[ 2, 4 ]
gap> s := OneSmallSemigroup(4, IsSingularSemigroupCopy, true);
fail

# doc/../gap/properties.gd:797-808
gap> g := Group((1, 2), (3, 4));
Group([ (1,2), (3,4) ])
gap> IdSmallSemigroup(g);
[ 4, 7 ]
gap> s := Range(InjectionZeroMagma(g));
<Group([ (1,2), (3,4) ]) with 0 adjoined>
gap> IdSmallSemigroup(s);
[ 5, 149 ]
gap> IsZeroGroup(s);
true

# doc/../gap/properties.gd:823-836
gap> s := OneSmallSemigroup(5, IsZeroSemigroup, true);
<small semigroup of size 5>
gap> IsZeroSemigroup(s);
true
gap> IdSmallSemigroup(s);
[ 5, 1 ]
gap> s := OneSmallSemigroup(5, IsZeroSemigroup, false);
<small semigroup of size 5>
gap> IdSmallSemigroup(s);
[ 5, 2 ]
gap> IsZeroSemigroup(s);
false

# doc/../gap/properties.gd:839-846
gap> IsZeroSemigroup(SmallSemigroup(6, 1));
true
gap> IsZeroSemigroup(SmallSemigroup(7, 1));
true
gap> IsZeroSemigroup(SmallSemigroup(8, 1));
true

# doc/../gap/properties.gd:860-869
gap> s := SmallSemigroup(7, 519799);
<small semigroup of size 7>
gap> IsZeroSimpleSemigroup(s);
false
gap> s := RandomSmallSemigroup(7, IsZeroSimpleSemigroup, true);
<small semigroup of size 7>
gap> IsZeroSimpleSemigroup(s);
true

# doc/../gap/properties.gd:879-889
gap> s := SmallSemigroup(8, 1478885610);;
gap> MinimalGeneratingSet(s);
[ s4, s5, s6, s7, s8 ]
gap> s := SmallSemigroup(7, 673768);;
gap> MinimalGeneratingSet(s);
[ s4, s5, s6, s7 ]
gap> s := SmallSemigroup(4, 4);;
gap> MinimalGeneratingSet(s);
[ s2, s3, s4 ]

# doc/../gap/properties.gd:904-911
gap> s := SmallSemigroup(5, 1121);;
gap> NilpotencyDegree(s);
fail
gap> s := SmallSemigroup(7, 393450);;
gap> NilpotencyDegree(s);
3

# doc/../gap/properties.gd:914-921
gap> s := SmallSemigroup(8, 11433106 + 1231);;
gap> NilpotencyDegree(s);
3
gap> s := SmallSemigroup(8, NrSmallSemigroups(8));;
gap> NilpotencyDegree(s);
3

# doc/../gap/coclass.gd:19-32
gap> NilpotentSemigroupsByCoclass(5, 1);
[ <fp semigroup on the generators [ s1, s2 ]>,
  <fp semigroup on the generators [ s1, s2 ]>,
  <fp semigroup on the generators [ s1, s2 ]>,
  <fp semigroup on the generators [ s1, s2 ]>,
  <fp semigroup on the generators [ s1, s2 ]>,
  <fp semigroup on the generators [ s1, s2 ]>,
  <fp semigroup on the generators [ s1, s2 ]> ]
gap> NilpotentSemigroupsByCoclass(7, 0);
[ <fp semigroup on the generators [ s1 ]> ]
gap> NilpotentSemigroupsByCoclass(4, 2, 3);
[ <fp semigroup on the generators [ s1, s2, s3 ]> ]

# doc/../gap/greensstar.gd:167-175
gap> s := SmallSemigroup(7, 280142);
<small semigroup of size 7>
gap> elm := AsList(s)[5];;
gap> jclass := JStarClass(s, elm);
{s5}
gap> AsList(jclass);
[ s2, s3, s4, s5 ]

# doc/../gap/greensstar.gd:133-145
gap> s := SmallSemigroup(7, 280142);
<small semigroup of size 7>
gap> elm := AsList(s)[5];;
gap> hclass := HStarClass(s, elm);
{s5}
gap> AsList(LStarClass(hclass));
[ s5 ]
gap> AsList(RStarClass(hclass));
[ s2, s5 ]
gap> AsList(DStarClass(hclass));
[ s2, s3, s4, s5 ]

# doc/../gap/greensstar.gd:99-104
gap> s := SmallSemigroup(6, 54);
<small semigroup of size 6>
gap> JStarClasses(s);
[ {s1}, {s2}, {s4}, {s5}, {s6} ]

# doc/../gap/enums.gd:51-67
gap> AllSmallSemigroups(2);
[ <small semigroup of size 2>, <small semigroup of size 2>,
  <small semigroup of size 2>, <small semigroup of size 2> ]
gap> AllSmallSemigroups([2, 3], IsRegularSemigroup, true,
> x -> Length(GreensRClasses(x)), 1);
[ <small semigroup of size 2>, <small semigroup of size 3> ]
gap> enum := EnumeratorOfSmallSemigroups(8, IsInverseSemigroup, true,
> IsCommutativeSemigroup, true);;
gap> AllSmallSemigroups(enum, x -> Length(GreensRClasses(x)), 1);
[ <small semigroup of size 8>, <small semigroup of size 8>,
  <small semigroup of size 8> ]
gap> iter := IteratorOfSmallSemigroups(7, x -> Length(GreensRClasses(x)), 1);;
gap> AllSmallSemigroups(iter, IsCommutative, true,
> IsSimpleSemigroup, true);
[ <small semigroup of size 7> ]

# doc/../gap/enums.gd:111-127
gap> enum := EnumeratorOfSmallSemigroups(7);
<enumerator of semigroups of size 7>
gap> EnumeratorOfSmallSemigroups([2, 3], IsRegularSemigroup, true);
<enumerator of semigroups of sizes [ 2, 3 ]>
gap> enum := EnumeratorOfSmallSemigroups(8, IsInverseSemigroup, true,
> IsCommutativeSemigroup, true);
<enumerator of semigroups of size 8>
gap> EnumeratorOfSmallSemigroups(enum, IsCommutativeSemigroup, true,
> IsSimpleSemigroup, false);
<enumerator of semigroups of size 8>
gap> iter := IteratorOfSmallSemigroups(8);
<iterator of semigroups of size 8>
gap> EnumeratorOfSmallSemigroups(iter, IsCommutativeSemigroup, true,
> IsSimpleSemigroup, false);
<enumerator of semigroups of size 8>

# doc/../gap/enums.gd:161-168
gap> enum := EnumeratorOfSmallSemigroupsByIds([[7, 1], [6, 1], [5, 1]]);
<enumerator of semigroups of sizes [ 5, 6, 7 ]>
gap> enum := EnumeratorOfSmallSemigroupsByIds(7, [1 .. 1000]);
<enumerator of semigroups of size 7>
gap> enum := EnumeratorOfSmallSemigroupsByIds([2, 3], [[1 .. 2], [1 .. 10]]);
<enumerator of semigroups of sizes [ 2, 3 ]>

# doc/../gap/enums.gd:587-593
gap> enum := EnumeratorOfSmallSemigroups([2 .. 4], IsSimpleSemigroup, false,
> IsRegularSemigroup, true);;
gap> ArgumentsUsedToCreate(enum);
[ <Property "IsRegularSemigroup">, true, <Property "IsSimpleSemigroup">,
  false ]

# doc/../gap/enums.gd:225-234
gap> enum := EnumeratorOfSmallSemigroups(5,
> x -> Length(GreensRClasses(x)), 1);;
gap> IdsOfSmallSemigroups(enum, IsCommutativeSemigroup, true,
> IsSimpleSemigroup, false);
[  ]
gap> IdsOfSmallSemigroups([2, 3], IsRegularSemigroup, true);
[ [ 2, 2 ], [ 2, 3 ], [ 2, 4 ], [ 3, 10 ], [ 3, 11 ], [ 3, 12 ], [ 3, 13 ],
  [ 3, 14 ], [ 3, 15 ], [ 3, 16 ], [ 3, 17 ], [ 3, 18 ] ]

# doc/../gap/enums.gd:247-251
gap> enum := EnumeratorOfSmallSemigroupsByIds([[2, 1], [3, 1], [4, 1]]);;
gap> IsEnumeratorOfSmallSemigroups(enum);
true

# doc/../gap/enums.gd:267-274
gap> IsIdSmallSemigroup(8, 1);
true
gap> IsIdSmallSemigroup([1, 2]);
false
gap> IsIdSmallSemigroup([3, 18]);
true

# doc/../gap/enums.gd:286-290
gap> iter := IteratorOfSmallSemigroups(8);;
gap> IsIteratorOfSmallSemigroups(iter);
true

# doc/../gap/enums.gd:337-359
gap> iter := IteratorOfSmallSemigroups(8);
<iterator of semigroups of size 8>
gap> NextIterator(iter);
<small semigroup of size 8>
gap> IsDoneIterator(iter);
false
gap> iter := IteratorOfSmallSemigroups([2, 3], IsRegularSemigroup, true,
> x -> Length(Idempotents(x)) = 1, true);
<iterator of semigroups of sizes [ 2, 3 ]>
gap> NextIterator(iter);
<small semigroup of size 2>
gap> NextIterator(iter);
<small semigroup of size 3>
gap> NextIterator(iter);
fail
gap> enum := EnumeratorOfSmallSemigroups(5, x -> Length(Idempotents(x)) = 1,
> true);
<enumerator of semigroups of size 5>
gap> iter := IteratorOfSmallSemigroups(enum,
> x -> Length(GreensRClasses(x)) = 2, true);
<iterator of semigroups of size 5>

# doc/../gap/3nil.gd:24-35
gap> Nr3NilpotentSemigroups(4);
8
gap> Nr3NilpotentSemigroups(9, "UpToIsomorphism");
105931872028455
gap> Nr3NilpotentSemigroups(9, "Labelled");
38430603831264883632
gap> Nr3NilpotentSemigroups(16, "SelfDual");
4975000837941847814744710290469890455985530
gap> Nr3NilpotentSemigroups(19, "Commutative");
12094270656160403920767935604624748908993169949317454767617795

# doc/../gap/enums.gd:402-414
gap> List([1 .. 8], NrSmallSemigroups);
[ 1, 4, 18, 126, 1160, 15973, 836021, 1843120128 ]
gap> NrSmallSemigroups(8, IsCommutative, true, IsInverseSemigroup, true);
4443
gap> NrSmallSemigroups([1 .. 8], IsCliffordSemigroup, true);
5610
gap> NrSmallSemigroups(8, IsRegularSemigroup, true,
> IsCompletelyRegularSemigroup, false);
1164
gap> NrSmallSemigroups(5, NilpotencyDegree, 3);
84

# doc/../gap/enums.gd:457-466
gap> OneSmallSemigroup(8, IsCommutative, true, IsInverseSemigroup, true);
<small semigroup of size 8>
gap> OneSmallSemigroup([1 .. 8], IsCliffordSemigroup, true);
<small semigroup of size 1>
gap> iter := IteratorOfSmallSemigroups(8, IsCommutative, false);
<iterator of semigroups of size 8>
gap> OneSmallSemigroup(iter);
<small semigroup of size 8>

# doc/../gap/enums.gd:606-611
gap> enum := EnumeratorOfSmallSemigroups([2 .. 4], IsSimpleSemigroup, true);;
gap> PositionsOfSmallSemigroupsIn
> (enum);
[ [ 2, 4 ], [ 17, 18 ], [ 7, 37, 52, 122, 123 ] ]

# doc/../gap/enums.gd:492-505
gap> PositionsOfSmallSemigroups(3);
[ [ 1 .. 18 ] ]
gap> PositionsOfSmallSemigroups(3, IsRegularSemigroup, false);
[ [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ] ]
gap> enum := EnumeratorOfSmallSemigroups(3, IsRegularSemigroup, false);;
gap> PositionsOfSmallSemigroups(enum);
[ [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ] ]
gap> PositionsOfSmallSemigroups([1 .. 4], IsBand, true);
[ [ 1 ], [ 3, 4 ], [ 12 .. 17 ], [ 98 .. 123 ] ]
gap> PositionsOfSmallSemigroups(enum, Is1IdempotentSemigroup, true,
> Is2GeneratedSemigroup, true, IsCliffordSemigroup, false);
[ [ 1, 2 ] ]

# doc/../gap/autovars.g:37-48
gap> PrecomputedSmallSemisInfo[3];
[ "Is2GeneratedSemigroup", "Is3GeneratedSemigroup", "Is4GeneratedSemigroup",
  "Is5GeneratedSemigroup", "Is6GeneratedSemigroup", "Is7GeneratedSemigroup",
  "Is8GeneratedSemigroup", "IsBand", "IsCommutative",
  "IsCompletelyRegularSemigroup", "IsFullTransformationSemigroupCopy",
  "IsGroupAsSemigroup", "IsIdempotentGenerated", "IsInverseSemigroup",
  "IsMonogenicSemigroup", "IsMonoidAsSemigroup", "IsMultSemigroupOfNearRing",
  "IsMunnSemigroup", "IsRegularSemigroup", "IsSelfDualSemigroup",
  "IsSemigroupWithoutClosedIdempotents", "IsSimpleSemigroup",
  "IsSingularSemigroupCopy", "IsZeroSemigroup", "IsZeroSimpleSemigroup" ]

# doc/../gap/enums.gd:548-558
gap> RandomSmallSemigroup(8, IsCommutative, true,
> IsInverseSemigroup, true);
<small semigroup of size 8>
gap> RandomSmallSemigroup([1 .. 8], IsCliffordSemigroup, true);
<small semigroup of size 8>
gap> iter := IteratorOfSmallSemigroups([1 .. 7]);
<iterator of semigroups of sizes [ 1 .. 7 ]>
gap> RandomSmallSemigroup(iter);
<small semigroup of size 7>

# doc/../gap/enums.gd:571-576
gap> enum := EnumeratorOfSmallSemigroups([2 .. 4], IsSimpleSemigroup, false);
<enumerator of semigroups of sizes [ 2, 3, 4 ]>
gap> SizesOfSmallSemigroupsIn(enum);
[ 2, 3, 4 ]

# doc/../gap/enums.gd:629-635
gap> UpToIsomorphism([SmallSemigroup(5, 126), SmallSemigroup(6, 2)]);
[ <small semigroup of size 5>, <small semigroup of size 6> ]
gap> UpToIsomorphism([SmallSemigroup(5, 126), SmallSemigroup(5, 3)]);
[ <small semigroup of size 5>, <small semigroup of size 5>,
  <semigroup of size 5, with 5 generators> ]

#
gap> STOP_TEST("smallsemi02.tst", 1);
