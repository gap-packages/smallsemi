#############################################################################
##
#W  init.g                         smallsemi - a GAP library of semigroups
#Y  Copyright (C) 2008-2010            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##
## $Id: init.g 237 2010-02-12 14:36:10Z andreas $
##
ReadPkg("smallsemi/gap/small.gd");
ReadPkg("smallsemi/gap/properties.gd");
ReadPkg("smallsemi/gap/enums.gd");

DeclareAutoreadableVariables( "smallsemi", "gap/autovars.g",
                              [ "MOREDATA2TO8",
                                "PrecomputedSmallSemisInfo",
                                "BLUEPRINT_MATS" ] );
