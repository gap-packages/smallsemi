#############################################################################
##
#W  CHANGELOG                      Smallsemi - a GAP library of semigroups
#Y  Copyright (C) 2008-2025            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

===============
 Version 0.7.2  (25/02/25)
===============

- a minor release with some changes for compatibility with GAP.

===============
 Version 0.7.1  (27/08/24)
===============

- a minor release including some refactoring of the code, and some changes for
  compatibility with changes in GAP (from Max Horn in
  https://github.com/gap-packages/smallsemi/issues/40
  and
  https://github.com/gap-packages/smallsemi/issues/42).

===============
 Version 0.7.0  (20/05/24)
===============

- a minor release including some refactoring of the code related to enumerators
  and iterators, and including a bug fix related to the data files for order 8
  (see https://github.com/gap-packages/smallsemi/issues/34 for more details).

================
 Version 0.6.13  (28/02/22)
================

  - a minor release, containing various janitorial changes

================
 Version 0.6.12  (16/08/19)
================

  - a minor release, with a bug fixed in IsomorphismTransformationSemigroup,
    and various janitorial changes (e.g. http -> https, moved package website,
    improved viewing/printing for IsIteratorOfSmallSemigroups)

================
 Version 0.6.11  (26/04/17)
================

  - a minor release for compatibility with Semigroups 3.0.0, and to fix an
  incorrect method for `IsomorphismTransformationSemigroup`.

================
 Version 0.6.10  (13/01/16)
================

  - a minor release to update testall.g for travis

===============
 Version 0.6.9  (30/11/15)
===============

  - a minor release for compatibility with GAP 4.8

===============
 Version 0.6.8  (24/02/14)
===============

  - replaced NilpotencyRank by NilpotencyDegree
  - introduced functionality to obtain nilpotent semigroups of coclass 0, 1,
    and 2 as f.p. semigroups
  - further adjustments to GAP 4.7 and the new package Semigroups

===============
 Version 0.6.7  (07/06/13)
===============

  - a minor release fixing some bugs in the references in the documentation,
    and moving some declarations of properties and associated true methods to
    the GAP library to avoid clashes with the forthcoming Semigroups package.
  - Smallsemi now requires GAP 4.7

===============
 Version 0.6.6  (24/04/13)
===============

  - added starred Green's relations
  - fixed the swap of L- and R-classes
  - fixed bug in D-class computation when MinimalGeneratingSet is known

===============
 Version 0.6.5  (28/05/12)
===============

  - A (hopefully) final solution to the compatibility issues between Citrus and
    Smallsemi

===============
 Version 0.6.4  (10/10/11)
===============

  - made Smallsemi compatible with Citrus 0.2.

===============
 Version 0.6.3  (13/09/11)
===============

  - made Smallsemi compatible with GAP 4.5 and Citrus 0.1.

  - introduced SmallsemiMakeDoc, SmallsemiTestAll, SmallsemiTestManualExamples.

===============
 Version 0.6.2  (06/07/10)
===============

  - included an example in the manual which explains a workaround for a
    current performance issue of enumerators of semigroups of order 8
    suggested by Michal Stolorz.

  - minor changes relating to the compatibility of Smallsemi with the
    MONOID package and with some library functions.

===============
 Version 0.6.0  (12/02/10)
===============

  - added function 'Nr3NilpotentSemigroups'

  - reduced size of library by improving how position lists in the files
    'info<n>.g' are stored

  - stored position of self-dual semigroups of order 8

  - the property IsBrandtSemigroup introduced.

  - fixed several bugs relating to enumerators, iterators and
    Green's relations.

=============
 Version 0.5  (24/04/09)
=============

  - first stable version of the package

=============
 Version 0.1  (17/03/08)
=============

  - smallsemi extracted from Monoid package
