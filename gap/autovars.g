#############################################################################
##
#W  autovars.g                     Smallsemi - a GAP library of semigroups
#Y  Copyright (C) 2008-2012            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##


#####################

BindGlobal("MOREDATA2TO8", READ_MOREDATA2TO8( ) );

#####################

BindGlobal("BLUEPRINT_MATS", GENERATE_BLUEPRINT_MATS( ) );

###########################################################################
##
##  <#GAPDoc Label="PrecomputedSmallSemisInfo">
##  <ManSection>
##  <Var Name="PrecomputedSmallSemisInfo"/>
##  <Description>
##  the global variable <C>PrecomputedSmallSemisInfo</C> contains a list of all 
##  the names of precomputed properties stored in the library.  The <C>i</C>th 
##  element of the list contains the list of properties that have been 
##  precomputed for all semigroups in the library of order <C>i</C>. 
##  <Example><![CDATA[
##  gap> PrecomputedSmallSemisInfo[3];
##  [ "Is2GeneratedSemigroup", "Is3GeneratedSemigroup", "Is4GeneratedSemigroup", 
##    "Is5GeneratedSemigroup", "Is6GeneratedSemigroup", "Is7GeneratedSemigroup", 
##    "Is8GeneratedSemigroup", "IsBand", "IsCommutative", 
##    "IsCompletelyRegularSemigroup", "IsFullTransformationSemigroupCopy", 
##    "IsGroupAsSemigroup", "IsIdempotentGenerated", "IsInverseSemigroup", 
##    "IsMonogenicSemigroup", "IsMonoidAsSemigroup", "IsMultSemigroupOfNearRing", 
##    "IsMunnSemigroup", "IsRegularSemigroup", "IsSelfDualSemigroup", 
##    "IsSemigroupWithoutClosedIdempotents", "IsSimpleSemigroup", 
##    "IsSingularSemigroupCopy", "IsZeroSemigroup", "IsZeroSimpleSemigroup" ]
##  ]]></Example> <!-- no test --> 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

BindGlobal("PrecomputedSmallSemisInfo", 
           List([1..8], 
                n->AsSet(Concatenation(Filtered(RecNames(MOREDATA2TO8[n]), 
                                                x->IsUpperAlphaChar(x[1])),
                                       ["IsBand"]))));
