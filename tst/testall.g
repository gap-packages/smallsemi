#############################################################################
##
#W  testall.g                          smallsemi - a GAP library of semigroups
#Y  Copyright (C) 2009                 Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

## $Id: testall.g 260 2010-06-29 14:28:13Z jamesm $


#Read( Filename( DirectoriesPackageLibrary( "smallsemi", "tst" ),"testall.g" ));

LoadPackage( "smallsemi" );
ReadTest( Filename( DirectoriesPackageLibrary( "smallsemi", "tst" ), "small.tst" ));
ReadTest( Filename( DirectoriesPackageLibrary( "smallsemi", "tst" ), "properties.tst" ));
ReadTest( Filename( DirectoriesPackageLibrary( "smallsemi", "tst" ), "enums.tst" ));