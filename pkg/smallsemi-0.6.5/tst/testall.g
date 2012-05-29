#############################################################################
##
#W  testall.g                      smallsemi - a GAP library of semigroups
#Y  Copyright (C) 2008-2012            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

#Read( Filename( DirectoriesPackageLibrary( "smallsemi", "tst" ),"testall.g" ));

LoadPackage( "smallsemi", false );
Test( Filename( DirectoriesPackageLibrary( "smallsemi", "tst" ), 
 "small.tst" ));
Test( Filename( DirectoriesPackageLibrary( "smallsemi", "tst" ), 
 "properties.tst" ));
Test( Filename( DirectoriesPackageLibrary( "smallsemi", "tst" ), 
 "enums.tst" ));
