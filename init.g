#############################################################################
##
##  init.g                         Smallsemi - a GAP library of semigroups
##  Copyright (C) 2008-2024            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

ReadPackage("smallsemi", "gap/small.gd");
ReadPackage("smallsemi", "gap/properties.gd");
ReadPackage("smallsemi", "gap/enums.gd");
ReadPackage("smallsemi", "gap/utils.gd");
ReadPackage("smallsemi", "gap/greensstar.gd");
ReadPackage("smallsemi", "gap/coclass.gd");
ReadPackage("smallsemi", "gap/3nil.gd");

DeclareAutoreadableVariables("smallsemi", "gap/autovars.g",
                             ["MOREDATA2TO8",
                              "PrecomputedSmallSemisInfo"]);
