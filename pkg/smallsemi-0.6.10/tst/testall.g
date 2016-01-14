#############################################################################
##
#W  testall.g                      Smallsemi - a GAP library of semigroups
#Y  Copyright (C) 2008-2014            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

#Read(Filename(DirectoriesPackageLibrary("smallsemi", "tst"), "testall.g"));

TestMyPackage := function( pkgname )
  local pkgdir, testfiles, testresult, ff, fn;
  LoadPackage(pkgname);
  pkgdir := DirectoriesPackageLibrary(pkgname, "tst");

  testfiles := ["small.tst", "properties.tst", "enums.tst",
                "greensstar.tst", "coclass.tst"];

  testresult := true;
  for ff in testfiles do
    fn := Filename(pkgdir, ff);
    Print("#I  Testing ", fn, "\n");
    if not Test(fn) then
      testresult:=false;
    fi;
  od;
  if testresult then
    Print("#I  No errors detected while testing package ", pkgname, "\n");
  else
    Print("#I  Errors detected while testing package ", pkgname, "\n");
  fi;
end;

# Set the name of the package here
TestMyPackage("smallsemi");
