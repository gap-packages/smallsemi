#############################################################################
##
#W  init.g                         Smallsemi - a GAP library of semigroups
#Y  Copyright (C) 2008-2013            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

ReadPackage("smallsemi/gap/small.gd");
ReadPackage("smallsemi/gap/properties.gd");
ReadPackage("smallsemi/gap/enums.gd");
ReadPackage("smallsemi/gap/utils.gd");
ReadPackage("smallsemi/gap/greensstar.gd");

DeclareAutoreadableVariables( "smallsemi", "gap/autovars.g",
                              [ "MOREDATA2TO8",
                                "PrecomputedSmallSemisInfo",
                                "BLUEPRINT_MATS" ] );
