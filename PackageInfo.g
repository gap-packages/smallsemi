#############################################################################
##
#W  PackageInfo.g                  Smallsemi - a GAP library of semigroups
#Y  Copyright (C) 2008-2010            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##
##  $Id: PackageInfo.g 266 2010-07-06 11:19:28Z jamesm $
##

SetPackageInfo( rec(
PackageName := "Smallsemi",
Subtitle := "A library of small semigroups",
Version := "0.6.2",
Revision := "265",
Date := "06/07/2010",
ArchiveURL := 
  "http://www-groups.mcs.st-andrews.ac.uk/~jamesm/smallsemi/smallsemi0r6p2",
ArchiveFormats := ".tar.gz .tar.bz2",
Persons := [
  rec(LastName      := "Distler",
      FirstNames    := "Andreas",
      IsAuthor      := true,
      IsMaintainer  := true,
      Email         := "a.distler@tu-bs.de",
      PostalAddress := Concatenation( [
                       "CAUL\n", "Av. Prof. Gama Pinto, 2\n",
                       "1649-003 Lisboa\n", "Portugal"] ),
      Place         := "Lisboa",
      Institution   := "Centro de Álgebra da Universidade de Lisboa"),
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
  GAP := ">=4.4.10",
  NeededOtherPackages := [],
  SuggestedOtherPackages := [["gapdoc",">=1.1"]],
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

