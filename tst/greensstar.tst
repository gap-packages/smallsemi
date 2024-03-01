#############################################################################
##
#W  greensstar.tst                 Smallsemi - a GAP library of semigroups
#Y  Copyright (C) 2008-2024            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

#ReadTest(Filename(DirectoriesPackageLibrary("smallsemi","tst"),"greensstar.tst"));

gap> START_TEST("Smallsemi package: greensstar.tst");
gap> info := InfoLevel(InfoSmallsemi);;
gap> SetInfoLevel(InfoSmallsemi, 0);
gap> # playing around with the smallest J* <> D* example
gap> s := SmallSemigroup(8, 461);
<small semigroup of size 8>
gap> JStarClasses(s) = DStarClasses(s);
true
gap> s := SmallSemigroup(8, 471);
<small semigroup of size 8>
gap> JStarClasses(s) = DStarClasses(s);
false
gap> List(JStarClasses(s), DStarClasses);
[ [ {s1} ], [ {s2}, {s6} ], [ {s8} ] ]
gap> HStarClasses(s);
[ {s1}, {s2}, {s3}, {s4}, {s5}, {s6}, {s7}, {s8} ]
gap> cl := DStarClass(s, Elements(s)[3]);
{s3}
gap> IsStarClass(cl);
true
gap> s := SmallSemigroup(6, 54);
<small semigroup of size 6>
gap> JStarClasses(s);
[ {s1}, {s2}, {s4}, {s5}, {s6} ]
gap> elms := Elements(s);
[ s1, s2, s3, s4, s5, s6 ]
gap> List(elms, elm -> DStarClass(s, elm));
[ {s1}, {s2}, {s3}, {s4}, {s5}, {s6} ]
gap> List(last, CanonicalStarClass);
[ {s1}, {s2}, {s2}, {s4}, {s5}, {s6} ]
gap> s := SmallSemigroup(5, 1141);
<small semigroup of size 5>
gap> HStarClasses(s);
[ {s1}, {s2}, {s3}, {s4}, {s5} ]
gap> RStarClasses(s);
[ {s1}, {s2}, {s3}, {s4}, {s5} ]
gap> LStarClasses(s);
[ {s1} ]
gap> DStarClasses(s);
[ {s1} ]
gap> JStarClasses(s);
[ {s1} ]
gap> s := SmallSemigroup(7, 54234);
<small semigroup of size 7>
gap> JStarRelation(s) = HStarRelation(s);
true
gap> s := SmallSemigroup(7, 280142);
<small semigroup of size 7>
gap> elm := AsList(s)[5];;
gap> jclass := JStarClass(s, elm);
{s5}
gap> AsList(jclass);
[ s2, s3, s4, s5 ]
gap> hclass := HStarClass(s, elm);
{s5}
gap> AsList(LStarClass(hclass));
[ s5 ]
gap> AsList(RStarClass(hclass));
[ s2, s5 ]
gap> AsList(DStarClass(hclass));
[ s2, s3, s4, s5 ]
gap> # test internal representations of starred relations
gap> s := SmallSemigroup(3, 12);
<small semigroup of size 3>
gap> JStarClasses(s);
[ {s1}, {s2}, {s3} ]
gap> InternalRepStarRelation(JStarRelation(s));
[ [ 1 ], [ 2 ], [ 3 ] ]
gap> s := SmallSemigroup(4, 103);
<small semigroup of size 4>
gap> DStarClasses(s);
[ {s1}, {s2}, {s4} ]
gap> InternalRepStarRelation(DStarRelation(s));
[ [ 1, 3 ], [ 2 ], [ 4 ] ]
gap> s := SmallSemigroup(5, 907);
<small semigroup of size 5>
gap> RStarClasses(s);
[ {s1}, {s2}, {s3}, {s4}, {s5} ]
gap> InternalRepStarRelation(RStarRelation(s));
[ [ 1 ], [ 2 ], [ 3 ], [ 4 ], [ 5 ] ]
gap> s := SmallSemigroup(6, 6885);
<small semigroup of size 6>
gap> LStarClasses(s);
[ {s1}, {s2}, {s4}, {s5}, {s6} ]
gap> InternalRepStarRelation(LStarRelation(s));
[ [ 1, 3 ], [ 2 ], [ 4 ], [ 5 ], [ 6 ] ]
gap> s := SmallSemigroup(7, 346885);
<small semigroup of size 7>
gap> HStarClasses(s);
[ {s1}, {s2}, {s3}, {s4}, {s5}, {s6}, {s7} ]
gap> InternalRepStarRelation(HStarRelation(s));
[ [ 1 ], [ 2 ], [ 3 ], [ 4 ], [ 5 ], [ 6 ], [ 7 ] ]
gap> SetInfoLevel(InfoSmallsemi, info);
gap> STOP_TEST("Smallsemi package: greensstar.tst", 1000);
