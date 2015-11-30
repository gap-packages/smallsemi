#############################################################################
##
#W  utils.gi                       Smallsemi - a GAP library of semigroups
#Y  Copyright (C) 2008-2014            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

InstallGlobalFunction(SmallsemiMakeDoc,
function()
  MakeGAPDocDoc(Concatenation(PackageInfo("smallsemi")[1]!.
   InstallationPath, "/doc"), "smallsemi.xml",
   [ "../PackageInfo.g", "data.xml", "examples.xml", "intro.xml",
     "../gap/coclass.gd", "../gap/enums.gd", "../gap/greensstar.gd",
     "../gap/properties.gd", "../gap/small.gd", "../gap/autovars.g"],
   "smallsemi", "../../..");;
end);

InstallGlobalFunction(SmallsemiTestAll,
function()
  local record;
  record := rec();
  record.InfoWarningLevel := InfoLevel(InfoWarning);
  SetInfoLevel(InfoWarning, 0);
  Read(Filename(DirectoriesPackageLibrary("smallsemi","tst"),"testall.g"));;
  SetInfoLevel(InfoWarning, record.InfoWarningLevel);
  return;
end);

InstallGlobalFunction(SmallsemiManualExamples,
function()
  return ExtractExamples(DirectoriesPackageLibrary("smallsemi","doc"),
      "smallsemi.xml",  [ "data.xml", "examples.xml", "intro.xml",
      "../gap/coclass.gd", "../gap/enums.gd", "../gap/greensstar.gd",
      "../gap/properties.gd", "../gap/small.gd", "../gap/autovars.g",
      "../PackageInfo.g" ], "Single");
end);

InstallGlobalFunction(SmallsemiTestManualExamples,
function()
  local record;

  record := rec();
  record.InfoWarningLevel := InfoLevel(InfoWarning);
  record.InfoSmallsemiLevel := InfoLevel(InfoSmallsemi);

  SetInfoLevel(InfoWarning, 0);
  SetInfoLevel(InfoSmallsemi, 0);

  RunExamples(SmallsemiManualExamples());

  SetInfoLevel(InfoWarning, record.InfoWarningLevel);
  SetInfoLevel(InfoSmallsemi, record.InfoSmallsemiLevel);
  return;
end);
