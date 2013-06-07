#############################################################################
##
#W  PackageInfo.g                  Smallsemi - a GAP library of semigroups
#Y  Copyright (C) 2008-2013            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

##  <#GAPDoc Label="PKGVERSIONDATA">
##  <!ENTITY VERSION "0.6.7">
##  <!ENTITY ARCHIVENAME "smallsemi-0.6.7">
##  <#/GAPDoc>

SetPackageInfo( rec(
PackageName := "Smallsemi",
Subtitle := "A library of small semigroups",
Version := "0.6.7",
Revision := "",
Date := "07/06/2013",
ArchiveURL := 
  "http://tinyurl.com/jdmitchell/smallsemi/smallsemi-0.6.7",
ArchiveFormats := ".tar.gz",
Persons := [
  rec(LastName      := "Distler",
      FirstNames    := "Andreas",
      IsAuthor      := true,
      IsMaintainer  := true,
      Email         := "a.distler@tu-bs.de",
      PostalAddress := Concatenation( [
                       "AG Algebra und Diskrete Mathematik\n", 
                       "TU Braunschweig\n", "Rebenring 31 (A14)\n",
                       "38106 Braunschweig\n", "Germany"] ),
      Place         := "Braunschweig",
      Institution   := "Technische Universität Braunschweig"),
  rec( 
      LastName      := "Mitchell",
      FirstNames    := "James",
      IsAuthor      := true,
      IsMaintainer  := true,
      Email         := "jdm3@st-and.ac.uk",
      WWWHome       := "http://tinyurl.com/jdmitchell",
      PostalAddress := Concatenation( [
                       "Mathematical Institute\n", "North Haugh\n", 
                       "St Andrews\n", "Fife\n", "KY16 9SS\n", "Scotland"] ),
      Place         := "St Andrews",
      Institution   := "University of St Andrews"
  )
],
Status := "deposited",

README_URL := 
  "http://www-groups.mcs.st-andrews.ac.uk/~jamesm/smallsemi/README.txt",
PackageInfoURL := 
  "http://www-groups.mcs.st-andrews.ac.uk/~jamesm/smallsemi/PackageInfo.g",

AbstractHTML :=
  "The <Package>Smallsemi</Package> package is a data library of semigroups \
   of small size. It provides all semigroups with at most 8 elements as well \
   as various information about these objects.",

PackageWWWHome := "http://www-groups.mcs.st-and.ac.uk/~jamesm/smallsemi/",
               
PackageDoc := rec(
  BookName  := "Smallsemi",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",  
  SixFile   := "doc/manual.six",
  LongTitle := "a library of small semigroups",
  Autoload  := true
),

Dependencies := rec(
  GAP := ">=4.7",
  NeededOtherPackages := [],
  SuggestedOtherPackages := [["gapdoc",">=1.3"]],
  ExternalConditions := 
   ["gzip is needed in standard location if data files are used uncompressed"]),
AvailabilityTest := ReturnTrue,
BannerString := Concatenation( 
  ListWithIdenticalEntries(SizeScreen()[1]-3, '-'), "\n", ~.PackageName, 
  " -   ", ~.Subtitle, "\n", 
  "by ", ~.Persons[1].FirstNames, " ", ~.Persons[1].LastName,
  " & " , ~.Persons[2].FirstNames, " ", ~.Persons[2].LastName, "\n",
  "For contents, type: ?Smallsemi:\n" ,
  "Loading ", ~.PackageName, " ", ~.Version, " ...\n",
  ListWithIdenticalEntries(SizeScreen()[1]-3, '-'), "\n" ),
Autoload := false,
TestFile := "tst/testall.g",
Keywords := ["small semigroups", "data library", "multiplication tables"]
));

