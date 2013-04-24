#############################################################################
##
#W  testall.g                      Smallsemi - a GAP library of semigroups
#Y  Copyright (C) 2008-2013            Andreas Distler & James D. Mitchell
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
Test( Filename( DirectoriesPackageLibrary( "smallsemi", "tst" ), 
 "greensstar.tst" ));
