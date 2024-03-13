#############################################################################
##
#W  coclass.tst                    Smallsemi - a GAP library of semigroups
#Y  Copyright (C) 2008-2024            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

#ReadTest(Filename(DirectoriesPackageLibrary("smallsemi","tst"),"coclass.tst"));

gap> START_TEST("Smallsemi package: coclass.tst");
gap> LoadPackage("smallsemi", false);
true
gap> __InfoSmallsemiLevel := InfoLevel(InfoSmallsemi);;
gap> SetInfoLevel(InfoSmallsemi, 0);
gap> if IsBound(SEMIGROUPS) then SEMIGROUPS.StartTest(); fi;
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
gap> NilpotentSemigroupsByCoclass(2, 2);
[  ]
gap> NilpotentSemigroupsByCoclass(3, 1, 1);
[  ]
gap> NilpotentSemigroupsByCoclass(3, 1, 3);
[  ]

# coclass 0
# gap> NilpotentSemigroupsCoclass0(513);
# [ <fp semigroup on the generators [ s1 ]> ]
# gap> List([1..8],i-> NilpotentSemigroupsCoclass0(i));
# [ [ <fp semigroup on the generators [ s1 ]> ],
#   [ <fp semigroup on the generators [ s1 ]> ],
#   [ <fp semigroup on the generators [ s1 ]> ],
#   [ <fp semigroup on the generators [ s1 ]> ],
#   [ <fp semigroup on the generators [ s1 ]> ],
#   [ <fp semigroup on the generators [ s1 ]> ],
#   [ <fp semigroup on the generators [ s1 ]> ],
#   [ <fp semigroup on the generators [ s1 ]> ] ]
# gap> List(last, l-> IdSmallSemigroup(l[1]));
# [ [ 1, 1 ], [ 2, 1 ], [ 3, 4 ], [ 4, 11 ], [ 5, 194 ], [ 6, 2582 ],
#   [ 7, 527675 ], [ 8, 3637445 ] ]
# coclass 1
gap> NilpotentSemigroupsCoclass1(2);
[  ]
gap> NilpotentSemigroupsCoclass1(3);
[ <fp semigroup on the generators [ s1, s2 ]> ]
gap> NilpotentSemigroupsCoclass1(5);
[ <fp semigroup on the generators [ s1, s2 ]>,
  <fp semigroup on the generators [ s1, s2 ]>,
  <fp semigroup on the generators [ s1, s2 ]>,
  <fp semigroup on the generators [ s1, s2 ]>,
  <fp semigroup on the generators [ s1, s2 ]>,
  <fp semigroup on the generators [ s1, s2 ]>,
  <fp semigroup on the generators [ s1, s2 ]> ]
gap> List([1 .. 20], i -> Length(NilpotentSemigroupsCoclass1(i)));
[ 0, 0, 1, 8, 7, 9, 10, 12, 13, 15, 16, 18, 19, 21, 22, 24, 25, 27, 28, 30 ]

# coclass 2
gap> NilpotentSemigroupsCoclass2(3);
[  ]
gap> NilpotentSemigroupsCoclass2(4);
[ <fp semigroup on the generators [ s1, s2, s3 ]> ]

# coclass 2, rank 2
gap> NilpotentSemigroupsCoclass2Rank2(4);
[  ]
gap> NilpotentSemigroupsCoclass2Rank2(5);
[ <fp semigroup on the generators [ s1, s2 ]>,
  <fp semigroup on the generators [ s1, s2 ]>,
  <fp semigroup on the generators [ s1, s2 ]>,
  <fp semigroup on the generators [ s1, s2 ]>,
  <fp semigroup on the generators [ s1, s2 ]>,
  <fp semigroup on the generators [ s1, s2 ]>,
  <fp semigroup on the generators [ s1, s2 ]>,
  <fp semigroup on the generators [ s1, s2 ]>,
  <fp semigroup on the generators [ s1, s2 ]>,
  <fp semigroup on the generators [ s1, s2 ]>,
  <fp semigroup on the generators [ s1, s2 ]> ]
gap> List([1 .. 20], i -> Length(NilpotentSemigroupsCoclass2(i)));
[ 0, 0, 0, 1, 84, 142, 184, 218, 288, 328, 412, 460, 557, 612, 724, 785, 911,
  980, 1119, 1195 ]

# coclass 2, rank 3
gap> NilpotentSemigroupsCoclass2Rank3(3);
[  ]
gap> NilpotentSemigroupsCoclass2Rank3(4);
[ <fp semigroup on the generators [ s1, s2, s3 ]> ]

#
gap> SetInfoLevel(InfoSmallsemi, __InfoSmallsemiLevel);;
gap> if IsBound(SEMIGROUPS) then SEMIGROUPS.StopTest(); fi;
gap> STOP_TEST("Smallsemi package: coclass.tst", 1000);
