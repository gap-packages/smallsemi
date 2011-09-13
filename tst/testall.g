#############################################################################
##
#W  testall.g                      smallsemi - a GAP library of semigroups
#Y  Copyright (C) 2008-2011            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

## $Id$


#Read( Filename( DirectoriesPackageLibrary( "smallsemi", "tst" ),"testall.g" ));

LoadPackage( "smallsemi" );
ReadTest( Filename( DirectoriesPackageLibrary( "smallsemi", "tst" ), 
 "small.tst" ));
ReadTest( Filename( DirectoriesPackageLibrary( "smallsemi", "tst" ), 
 "properties.tst" ));
ReadTest( Filename( DirectoriesPackageLibrary( "smallsemi", "tst" ), 
 "enums.tst" ));
