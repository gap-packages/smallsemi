#############################################################################
##
##  testall.g                      Smallsemi - a GAP library of semigroups
##  Copyright (C) 2008-2024            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################

LoadPackage("smallsemi");
SetInfoLevel(InfoSmallsemi, 0);
dirs := DirectoriesPackageLibrary("smallsemi", "tst");
TestDirectory(dirs, rec(exitGAP := true,
                        testOptions := rec(
                                       compareFunction := "uptowhitespace")));
