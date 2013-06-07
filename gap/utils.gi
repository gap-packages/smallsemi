#############################################################################
##
#W  utils.gi                       Smallsemi - a GAP library of semigroups
#Y  Copyright (C) 2008-2013            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# new for 0.6.3! - SmallsemiMakeDoc - "for no argument"
#############################################################################

InstallGlobalFunction(SmallsemiMakeDoc, 
function()
  MakeGAPDocDoc(Concatenation(PackageInfo("smallsemi")[1]!.
   InstallationPath, "/doc"), "smallsemi.xml",
   [ "../PackageInfo.g", "data.xml", "examples.xml", "intro.xml",
     "../gap/enums.gd", "../gap/greensstar.gd", "../gap/properties.gd",
     "../gap/small.gd", "../gap/autovars.g"],
   "smallsemi");;
end);

# new for 0.6.3! - SmallsemiTestAll - "for no argument"
#############################################################################

InstallGlobalFunction(SmallsemiTestAll, 
function()
  Read(Filename(DirectoriesPackageLibrary("smallsemi","tst"),"testall.g"));;
end);

# new for 0.6.3! - SmallsemiTestManualExamples - "for no argument"
#############################################################################

InstallGlobalFunction(SmallsemiManualExamples, 
function()
  return ExtractExamples(DirectoriesPackageLibrary("smallsemi","doc"), 
  "smallsemi.xml",  [ "data.xml", "examples.xml", "intro.xml",
   "../gap/enums.gd", "../gap/greensstar.gd", "../gap/properties.gd",
   "../gap/small.gd", "../gap/autovars.g", "../PackageInfo.g" ], "Single");
end);

InstallGlobalFunction(SmallsemiTestManualExamples, 
function()
  SetInfoLevel(InfoWarning, 0);
  SetInfoLevel(InfoSmallsemi, 0); 
  RunExamples(SmallsemiManualExamples());
  return;
end);

#EOF
