#############################################################################
##
#W  properties.tst                 Smallsemi - a GAP library of semigroups
#Y  Copyright (C) 2008-2024            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

#ReadTest(Filename(DirectoriesPackageLibrary("smallsemi","tst"),"properties.tst"));
gap> START_TEST("Smallsemi package: properties.tst");
gap> if IsBound(SEMIGROUPS) then SEMIGROUPS.StartTest(); fi;
gap> info := InfoLevel(InfoSmallsemi);;
gap> SetInfoLevel(InfoSmallsemi, 0);
gap> s := SmallSemigroup(5, 6);
<small semigroup of size 5>
gap> Annihilators(s);
[ s1, s2 ]
gap> s := SmallSemigroup(6, 15001);
<small semigroup of size 6>
gap> Annihilators(s);
fail
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
gap> s := SmallSemigroup(8, 1478885610);;
gap> MinimalGeneratingSet(s);
[ s4, s5, s6, s7, s8 ]
gap> s := SmallSemigroup(7, 673768);;
gap> MinimalGeneratingSet(s);
[ s4, s5, s6, s7 ]
gap> s := SmallSemigroup(4, 4);;
gap> MinimalGeneratingSet(s);
[ s2, s3, s4 ]
gap> s := SmallSemigroup(4, 75);
<small semigroup of size 4>
gap> Is1IdempotentSemigroup(s);
false
gap> Is2IdempotentSemigroup(s);
false
gap> Is3IdempotentSemigroup(s);
true
gap> s := SmallSemigroup(8, 10101);;
gap> DiagonalOfMultiplicationTable(s);
[ 1, 1, 1, 1, 1, 1, 1, 1 ]
gap> s := SmallSemigroup(7, 10101);;
gap> DiagonalOfMultiplicationTable(s);
[ 1, 1, 1, 1, 1, 1, 1 ]
gap> s := SmallSemigroup(7, 366445);;
gap> NilpotencyDegree(s);
3
gap> s := SmallSemigroup(7, 518897);;
gap> NilpotencyDegree(s);
4
gap> s := SmallSemigroup(8, 11433105 + 1231);;
gap> NilpotencyDegree(s);
3
gap> s := SmallSemigroup(8, 2);;
gap> NilpotencyDegree(s);
4
gap> s := SmallSemigroup(5, 116);;
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
gap> IdSmallSemigroup(s);
[ 5, 1 ]
gap> s := SmallSemigroup(1, 1);
<small semigroup of size 1>
gap> IsFullTransformationSemigroupCopy(s);
true
gap> s := OneSmallSemigroup(4, IsFullTransformationSemigroupCopy, true);
<small semigroup of size 4>
gap> IsFullTransformationSemigroup(s);
false
gap> IsFullTransformationSemigroupCopy(s);
true
gap> IdSmallSemigroup(s);
[ 4, 96 ]
gap> s := OneSmallSemigroup(6, IsFullTransformationSemigroupCopy, true);
fail
gap> s := SmallSemigroup(7, 7);
<small semigroup of size 7>
gap> IsGroupAsSemigroup(s);
false
gap> s := SmallSemigroup(4, 37);;
gap> IsGroupAsSemigroup(s);
true
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
gap> s := OneSmallSemigroup(4, IsIdempotentGenerated, true, IsSingularSemigroupCopy, true);
fail
gap> s := OneSmallSemigroup(2, IsIdempotentGenerated, true, IsSingularSemigroupCopy, true);
<small semigroup of size 2>
gap> s := OneSmallSemigroup(7, IsInverseSemigroup, true);
<small semigroup of size 7>
gap> IsInverseSemigroup(s);
true
gap> s := SmallSemigroup(7, 101324);
<small semigroup of size 7>
gap> IsInverseSemigroup(s);
false
gap> s := SmallSemigroup(5, 438);
<small semigroup of size 5>
gap> IsLeftZeroSemigroup(s);
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
gap> s := OneSmallSemigroup(7, IsMultSemigroupOfNearRing, true);
<small semigroup of size 7>
gap> IdSmallSemigroup(s);
[ 7, 1 ]
gap> IsMultSemigroupOfNearRing(s);
true
gap> s := SmallSemigroup(2, 3);
<small semigroup of size 2>
gap> IsMultSemigroupOfNearRing(s);
true
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
gap> s := SmallSemigroup(7, 673768);;
gap> IsNilpotentSemigroup(s);
true
gap> s := SmallSemigroup(7, 657867);;
gap> IsNilpotentSemigroup(s);
true
gap> s := SmallSemigroup(6, 15858);;
gap> IsSemigroupWithClosedIdempotents(s);
true
gap> IsRegularSemigroup(s);
true
gap> IsOrthodoxSemigroup(s);
true
gap> s := SmallSemigroup(5, 327);
<small semigroup of size 5>
gap> IsSemigroupWithClosedIdempotents(s);
false
gap> s := SmallSemigroup(5, 677);;
gap> IsSemigroupWithClosedIdempotents(s);
true
gap> s := SmallSemigroup(5, 659);;
gap> IsSemigroupWithClosedIdempotents(s);
true
gap> s := SmallSemigroup(5, 216);;
gap> IsRectangularBand(s);
false
gap> s := SmallSemigroup(6, 15854);;
gap> IsRectangularBand(s);
true
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
gap> s := SmallSemigroup(5, 438);
<small semigroup of size 5>
gap> IsRightZeroSemigroup(s);
false
gap> s := SmallSemigroup(5, 1);
<small semigroup of size 5>
gap> IsSemigroupWithZero(s);
true
gap> s := SmallSemigroup(8, NrSmallSemigroups(8));
<small semigroup of size 8>
gap> IsSemigroupWithZero(s);
true
gap> IsSemigroupWithZero(SmallSemigroup([6, 1213]));
true
gap> s := RandomSmallSemigroup(3, IsNilpotentSemigroup, true);
<small semigroup of size 3>
gap> IsSemigroupWithZero(s);
true
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
gap> s := OneSmallSemigroup(6, IsSingularSemigroupCopy, true);
fail
gap> s := OneSmallSemigroup(4, IsSingularSemigroupCopy, true);
fail
gap> s := SmallSemigroup(5, 116);
<small semigroup of size 5>
gap> IsSelfDualSemigroup(s);
false
gap> s := SmallSemigroup(5, 880);
<small semigroup of size 5>
gap> IsSelfDualSemigroup(s);
true
gap> s := SmallSemigroup(7, 519799);;
gap> IsSimpleSemigroup(s);
false
gap> IsCompletelySimpleSemigroup(s);
false
gap> s := SmallSemigroup(7, 208242);;
gap> IsSimpleSemigroup(s);
false
gap> s := SmallSemigroup(7, 835080);;
gap> IsSimpleSemigroup(s);
true
gap> IsCompletelySimpleSemigroup(s);
true
gap> s := SmallSemigroup(7, 208242);;
gap> IsSimpleSemigroup(s);
false
gap> s := Group((1, 2), (3, 4));
Group([ (1,2), (3,4) ])
gap> IdSmallSemigroup(s);
[ 4, 7 ]
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
gap> s := OneSmallSemigroup(5, IsZeroSemigroup, true);;
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
gap> IsZeroSemigroup(SmallSemigroup(6, 1));
true
gap> IsZeroSemigroup(SmallSemigroup(7, 1));
true
gap> IsZeroSemigroup(SmallSemigroup(8, 1));
true
gap> s := SmallSemigroup(7, 519799);
<small semigroup of size 7>
gap> IsZeroSimpleSemigroup(s);
false
gap> s := RandomSmallSemigroup(7, IsZeroSimpleSemigroup, true);
<small semigroup of size 7>
gap> IsZeroSimpleSemigroup(s);
true
gap> s := SmallSemigroup(7, 393450);;
gap> IsNilpotentSemigroup(s);
true
gap> NilpotencyDegree(s);
3
gap> s := SmallSemigroup(1, 1);;
gap> NilpotencyDegree(s);
1
gap> enum := EnumeratorOfSmallSemigroups(4, IsRightZeroSemigroup, true);
<empty enumerator of semigroups>
gap> Length(last);
0
gap> s := RandomSmallSemigroup(4);;
gap> OneSmallSemigroup(4, IsRightZeroSemigroup, true);
fail
gap> RandomSmallSemigroup(4, IsRightZeroSemigroup, true);
fail
gap> OneSmallSemigroup(4, IsLeftZeroSemigroup, true);
<small semigroup of size 4>
gap> RandomSmallSemigroup(4, IsLeftZeroSemigroup, true);
<small semigroup of size 4>
gap> last = last2;
true
gap> a := Transformation([1, 2, 1, 2, 1]);;
gap> b := Transformation([3, 4, 3, 4, 4]);;
gap> s := Semigroup(a, b);;
gap> IdSmallSemigroup(s);
[ 4, 123 ]
gap> s := SmallSemigroup(4, 123);;
gap> IsRectangularBand(s);
true
gap> s := OneSmallSemigroup(7, IsRectangularBand, true);
<small semigroup of size 7>
gap> GreensDClasses(s);
[ <Green's D-class: s1> ]
gap> Elements(last[1]);
[ s1, s2, s3, s4, s5, s6, s7 ]
gap> GreensHClasses(s);
[ <Green's H-class: s1>, <Green's H-class: s2>, <Green's H-class: s3>,
  <Green's H-class: s4>, <Green's H-class: s5>, <Green's H-class: s6>,
  <Green's H-class: s7> ]
gap> List(last, Elements);
[ [ s1 ], [ s2 ], [ s3 ], [ s4 ], [ s5 ], [ s6 ], [ s7 ] ]
gap> s := OneSmallSemigroup(7, IsGroupAsSemigroup, true);
<small semigroup of size 7>
gap> h := GreensHClasses(s);
[ <Green's H-class: s1> ]
gap> Elements(h);
[ <Green's H-class: s1> ]
gap> Elements(last[1]);
[ s1, s2, s3, s4, s5, s6, s7 ]
gap> s := SmallSemigroup(5, 519);;
gap> IsBrandtSemigroup(s);
false
gap> s := OneSmallSemigroup(5, IsBrandtSemigroup, true);
<small semigroup of size 5>
gap> IsBrandtSemigroup(s);
true
gap> IdSmallSemigroup(s);
[ 5, 149 ]
gap> s := SmallSemigroup(5, 1141);
<small semigroup of size 5>
gap> IsLeftZeroSemigroup(s);
true
gap> SetInfoLevel(InfoSmallsemi, info);
gap> STOP_TEST("Smallsemi package: properties.tst", 10000);
