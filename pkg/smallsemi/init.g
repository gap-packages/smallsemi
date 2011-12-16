#############################################################################
##
#W  init.g                         smallsemi - a GAP library of semigroups
#Y  Copyright (C) 2008-2011            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##
## $Id$
##

ReadPkg("smallsemi/gap/small.gd");
ReadPkg("smallsemi/gap/properties.gd");
ReadPkg("smallsemi/gap/enums.gd");
ReadPkg("smallsemi/gap/utils.gd");

DeclareAutoreadableVariables( "smallsemi", "gap/autovars.g",
                              [ "MOREDATA2TO8",
                                "PrecomputedSmallSemisInfo",
                                "BLUEPRINT_MATS" ] );
