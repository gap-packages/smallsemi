#############################################################################
##
#W  testall.g                      Smallsemi - a GAP library of semigroups
#Y  Copyright (C) 2008-2014            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################

LoadPackage("smallsemi");
dirs := DirectoriesPackageLibrary( "smallsemi", "tst" );
TestDirectory(dirs, rec(exitGAP := true));
