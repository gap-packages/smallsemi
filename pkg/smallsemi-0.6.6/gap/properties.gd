#############################################################################
##
#W  properties.gd                  Smallsemi - a GAP library of semigroups
#Y  Copyright (C) 2008-2012            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

## $Id$

###########################################################################
##
##  <#GAPDoc Label="Annihilators">
##  <ManSection>
##  <Attr Name="Annihilators" Arg="sgrp"/>
##  <Description>
##  returns the set of annihilators of <A>sgrp</A> if <A>sgrp</A> contains a
##  zero element and <C>fail</C> otherwise.<P/>
##
##  An element <M>x</M> in a semigroup with zero <M>z</M> is an 
##  <E>annihilator</E> if <M>xy=yx=z</M> for every element <M>y</M> in the 
##  semigroup.
##  <Example>
##  gap> s := SmallSemigroup(5,6);
##  <small semigroup of size 5>
##  gap> Annihilators(s);
##  [ s1, s2 ]
##  </Example> <!-- properties.tst --> 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareAttribute( "Annihilators", IsSemigroup );

###########################################################################
##
##  <#GAPDoc Label="DiagonalOfMultiplicationTable">
##  <ManSection>
##  <Attr Name="DiagonalOfMultiplicationTable" Arg="sgrp"/>
##  <Description>
##  returns the diagonal of the multiplication table of the semigroup
##  <A>sgrp</A>.
##  <Example>
##  gap> s:=SmallSemigroup(8,10101);;
##  #I  Smallsemi: loading data for semigroups of size 8.
##  gap> DiagonalOfMultiplicationTable(s);
##  [ 1, 1, 1, 1, 1, 1, 1, 1 ]
##  gap> s:=SmallSemigroup(7,10101);;
##  gap> DiagonalOfMultiplicationTable(s);
##  [ 1, 1, 1, 1, 1, 1, 1 ]
##  </Example> <!-- properties.tst --> 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareAttribute("DiagonalOfMultiplicationTable", IsSemigroup);

###########################################################################
##
##  <#GAPDoc Label="DisplaySmallSemigroup">
##  <ManSection>
##  <Func Name="DisplaySmallSemigroup" Arg="sgrp"/>
##  <Description>
##  displays all the information about the small semigroup <A>sgrp</A> that
##  is stored in the library and its Green's classes and
##  idempotents. 
##  <Example>
##  gap> s:=SmallSemigroup(6, 3838);;
##  gap> DisplaySmallSemigroup(s);
##  IsBand:                              false
##  IsBrandtSemigroup:                   false
##  IsCommutative:                       false
##  IsCompletelyRegularSemigroup:        false
##  IsFullTransformationSemigroupCopy:   false
##  IsGroupAsSemigroup:                  false
##  IsIdempotentGenerated:               false
##  IsInverseSemigroup:                  false
##  IsMonogenicSemigroup:                false
##  IsMonoidAsSemigroup:                 false
##  IsMultSemigroupOfNearRing:           false
##  IsOrthodoxSemigroup:                 false
##  IsRectangularBand:                   false
##  IsRegularSemigroup:                  false
##  IsSelfDualSemigroup:                 false
##  IsSemigroupWithClosedIdempotents:    true
##  IsSimpleSemigroup:                   false
##  IsSingularSemigroupCopy:             false
##  IsZeroSemigroup:                     false
##  IsZeroSimpleSemigroup:               false
##  MinimalGeneratingSet:                [ s3, s4, s5, s6 ]
##  Idempotents:                         [ s1, s5, s6 ]
##  GreensRClasses:                      [ {s1}, {s2}, {s3}, {s4}, {s5}, {s6} ]
##  GreensLClasses:                      [ {s1}, {s2}, {s3}, {s4}, {s6} ]
##  GreensHClasses:                      [ {s1}, {s2}, {s3}, {s4}, {s5}, {s6} ]
##  GreensDClasses:                      [ {s1}, {s2}, {s3}, {s4}, {s6} ]
##  </Example> <!-- properties.tst --> 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##

DeclareGlobalFunction("DisplaySmallSemigroup");

#############################################################################
##
##  <#GAPDoc Label="IndexPeriod">
##  <ManSection>
##  <Attr Name="IndexPeriod" Arg="x"/>
##  <Description>
##  returns the minimum numbers <A>m, r</A> such that <A>x^{m+r}=x^m</A>; known 
##  as the index and period of the small semigroup element <A>x</A>. 
##  <Example>
##gap&gt; s:=SmallSemigroup(5,116);
##&lt;small semigroup of size 5&gt;
##gap&gt; x:=Elements(s)[3];
##s3
##gap&gt; IndexPeriod(x);
##[ 2, 1 ]
##gap&gt; x^3=x^2;
##true
##gap&gt; x^2=x^1;
##false
##gap&gt; x^3=x^1;
##false
##  </Example><!-- properties.tst -->
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##  </Description>
##

DeclareAttribute("IndexPeriod", IsSmallSemigroupElt);

###########################################################################
##
##  <#GAPDoc Label="IsBand">
##  <ManSection>
##  <Prop Name="IsBand" Arg="sgrp"/>
##  <Description>
##  returns <C>true</C> if the small semigroup <A>sgrp</A> is a band and 
##  <C>false</C> otherwise.<P/>
##
##  A semigroup <A>sgrp</A> is a <E>band</E> if every element is an
##      idempotent, that is, <A>x^2=x</A> for all <A>x</A> in <A>sgrp</A>.
##  <Example>
##gap&gt; s:=SmallSemigroup(5,519);;
##gap&gt; IsBand(s);
##false
##gap&gt; s:=OneSmallSemigroup(5, IsBand, true);
##&lt;small semigroup of size 5&gt;
##gap&gt; IsBand(s);
##true
##gap&gt; IdSmallSemigroup(s);   
##[ 5, 1010 ]
##  </Example><!-- properties.tst -->
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareProperty("IsBand", IsSemigroup);

###########################################################################
##
##  <#GAPDoc Label="IsBrandtSemigroup">
##  <ManSection>
##  <Prop Name="IsBrandtSemigroup" Arg="sgrp"/>
##  <Description>
##  returns <C>true</C> if the small semigroup <A>sgrp</A> is a Brandt semigroup 
##  and <C>false</C> otherwise.<P/>
##
##  A finite semigroup <A>sgrp</A> is a <E>Brandt semigroup</E> if it is inverse 
##  and zero simple.
##  <Example>
##gap&gt; s:=SmallSemigroup(5,519);;
##gap&gt; IsBrandtSemigroup(s);
##false
##gap&gt; s:=OneSmallSemigroup(5, IsBrandtSemigroup, true);
##&lt;small semigroup of size 5&gt;
##gap&gt; IsBrandtSemigroup(s);
##true
##gap&gt; IdSmallSemigroup(s);   
##[ 5, 149 ]
##  </Example><!-- properties.tst -->
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareProperty("IsBrandtSemigroup", IsSemigroup);


###########################################################################
##
##  <#GAPDoc Label="IsCliffordSemigroup">
##  <ManSection>
##  <Prop Name="IsCliffordSemigroup" Arg="sgrp"/>
##  <Description>
##  returns <C>true</C> if the small semigroup <A>sgrp</A> is a Clifford 
##  semigroup and <C>false</C> otherwise.<P/>
##
##  A semigroup <A>sgrp</A> is a <E>Clifford semigroup</E> if it is a 
##  regular semigroup whose idempotents are central, that is, for all 
##  <A>e,x</A> in <A>sgrp</A> where <A>e^2=e</A> 
##  we have that <A>ex=xe</A>.
##  <Example>
##  gap> s:=SmallSemigroup(5,519);; 
##  gap> IsBand(s);
##  false
##  gap> s:=OneSmallSemigroup(5, IsBand, true);
##  &lt;small semigroup of size 5>
##  gap> IsBand(s);
##  true
##  gap> IdSmallSemigroup(s);   
##  [ 5, 1010 ]
##  gap> s:=SmallSemigroup(5,519);;
##  gap> IsCliffordSemigroup(s);
##  false
##  gap> s:=OneSmallSemigroup(5, IsCliffordSemigroup, true);
##  &lt;small semigroup of size 5>
##  gap> IsCliffordSemigroup(s);
##  true
##  gap> IdSmallSemigroup(s);
##  [ 5, 148 ]
##  </Example><!-- properties.tst -->
##  </Description>
##  </ManSection>
##  <#/GAPDoc> 

DeclareProperty("IsCliffordSemigroup", IsSemigroup);

###########################################################################
##
##  <#GAPDoc Label="IsCommutativeSemigroup">
##  <ManSection>
##  <Prop Name="IsCommutativeSemigroup" Arg="sgrp"/>
##  <Prop Name="IsCommutative" Arg="sgrp"/>
##  <Description>
##  return <C>true</C> if the small semigroup <A>sgrp</A> is commutative 
##  and <C>false</C> otherwise.<P/>
##
##  A semigroup <A>sgrp</A> is <E>commutative</E> if 
##  <A>xy=yx</A> for all <A>x,y</A> in <A>sgrp</A>.
##  <Example>
##gap&gt; s:=SmallSemigroup(6,871);;
##gap&gt; IsCommutativeSemigroup(s);
##false
##gap&gt; s:=OneSmallSemigroup(5, IsCommutative, true);
##&lt;small semigroup of size 5&gt;
##gap&gt; IsCommutativeSemigroup(s);
##true
##gap&gt; IsCommutative(s);         
##true
##gap&gt; IdSmallSemigroup(s);
##[ 5, 1 ]
##gap&gt; s:=OneSmallSemigroup(5, IsCommutativeSemigroup, true);
##&lt;small semigroup of size 5&gt;
##gap&gt; IsCommutativeSemigroup(s);
##true
##gap&gt; IsCommutative(s);
##true
##  </Example><!-- properties.tst -->
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareProperty("IsCommutativeSemigroup", IsSemigroup);

###########################################################################
##
##  <#GAPDoc Label="IsCompletelyRegularSemigroup">
##  <ManSection>
##  <Prop Name="IsCompletelyRegularSemigroup" Arg="sgrp"/>
##  <Description>
##  returns <C>true</C> if the semigroup <A>sgrp</A> is completely 
##  regular and <C>false</C> otherwise.<P/>
##  A semigroup is <E>completely regular</E> 
##  if every element is contained in a subgroup.
##  <Example>
##  gap&gt; s:=SmallSemigroup(6,13131);                           
##  &lt;small semigroup of size 6&gt;
##  gap&gt; IsCompletelyRegularSemigroup(s);
##  false
##  gap&gt; s:=OneSmallSemigroup(6, IsCompletelyRegularSemigroup, true); 
##  &lt;small semigroup of size 6&gt;
##  gap&gt; IsCompletelyRegularSemigroup(s);
##  true
##  gap&gt; IdSmallSemigroup(s);
##  [ 6, 3164 ]
##  </Example><!-- properties.tst -->
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareProperty("IsCompletelyRegularSemigroup", IsSemigroup);

###########################################################################
##
##  <#GAPDoc Label="IsFullTransformationSemigroupCopy">
##  <ManSection>
##  <Prop Name="IsFullTransformationSemigroupCopy" Arg="sgrp"/>
##  <Description>
##  returns <C>true</C> if the semigroup <A>sgrp</A> is isomorphic to a full
##  transformation 
##  semigroup and <C>false</C> otherwise. <P/>
##
##  The size of the full transformation semigroup on an <A>n</A> element set is 
##  <M>n^n</M> and so there are only two semigroup in the library that have this property. 
##  <Example>
##gap&gt; s:=SmallSemigroup(1,1);
##&lt;small semigroup of size 1&gt;
##gap&gt; IsFullTransformationSemigroupCopy(s);
##true
##gap&gt; s:=OneSmallSemigroup(4, IsFullTransformationSemigroupCopy, true);
##&lt;small semigroup of size 4&gt;
##gap&gt; IsFullTransformationSemigroupCopy(s);
##true
##gap&gt; IdSmallSemigroup(s);
##[ 4, 96 ]
##gap&gt; s:=OneSmallSemigroup(6, IsFullTransformationSemigroupCopy, true);
##fail
##  </Example><!-- properties.tst -->
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareProperty("IsFullTransformationSemigroupCopy", IsSmallSemigroup);


###########################################################################
##
##  <#GAPDoc Label="IsGroupAsSemigroup">
##  <ManSection>
##  <Prop Name="IsGroupAsSemigroup" Arg="sgrp"/>
##  <Description>
##  returns <C>true</C> if the semigroup <A>sgrp</A> is a group and 
##  <C>false</C> otherwise.
##  <Example>
##gap&gt; s:=SmallSemigroup(7,7);
##&lt;small semigroup of size 7&gt;
##gap&gt; IsGroupAsSemigroup(s);
##false
##gap&gt; s:=SmallSemigroup(4,37);;
##gap&gt; IsGroupAsSemigroup(s);
##true
##  </Example><!-- properties.tst -->
##  </Description>
##  </ManSection>
##  <#/GAPDoc> 

DeclareProperty("IsGroupAsSemigroup", IsSemigroup);

###########################################################################
##
##  <#GAPDoc Label="IsIdempotentGenerated">
##  <ManSection><Heading>IsIdempotentGenerated</Heading>
##  <Prop Name="IsIdempotentGenerated" Arg="sgrp"/>
##  <Prop Name="IsSemiband" Arg="sgrp"/>
##  <Description>
##  returns <C>true</C> if the semigroup <A>sgrp</A> is a 
##  semiband and <C>false</C> otherwise.<P/>
##
##  A semigroup <A>sgrp</A> is <E>idempotent generated</E> or equivalently a 
##  <E>semiband</E> if it is generated by its idempotent elements, i.e elements 
##  satisfying <A>x^2=x</A>.
##  <Example>
##  gap> s:=SmallSemigroup(3, 13);
##  &lt;small semigroup of size 3>
##  gap> IsIdempotentGenerated(s);
##  true
##  gap> s:=OneSmallSemigroup(3, IsIdempotentGenerated, false);
##  &lt;small semigroup of size 3>
##  gap> IsIdempotentGenerated(s);
##  false
##  gap> IdSmallSemigroup(s);
##  [ 3, 1 ]
##  gap> s:=OneSmallSemigroup(4, IsIdempotentGenerated, true, 
##  > IsSingularSemigroupCopy, true);
##  fail
##  gap> s:=OneSmallSemigroup(2, IsIdempotentGenerated, true, 
##  > IsSingularSemigroupCopy, true);
##  &lt;small semigroup of size 2>
##  </Example><!-- properties.tst -->
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

#if not IsBound(IsIdempotentGenerated) then 
  DeclareProperty("IsIdempotentGenerated", IsSemigroup);
#fi;

DeclareProperty("IsSemiband", IsSemigroup);

###########################################################################
##
##  <#GAPDoc Label="IsInverseSemigroup">
##  <ManSection>
##  <Prop Name="IsInverseSemigroup" Arg="sgrp"/>
##  <Description>
##  returns <C>true</C> if the semigroup <A>sgrp</A> is an inverse
##  semigroup and <C>false</C> otherwise.<P/>
##
##  A semigroup <A>sgrp</A> is an <E>inverse semigroup</E> if every element 
##  <A>x</A> in <A>sgrp</A> has a unique semigroup inverse, that is, a unique 
##  element <A>y</A> such that <A>xyx=x</A> and <A>yxy=y</A>.
##  <Example>
##gap&gt; s:=OneSmallSemigroup(7, IsInverseSemigroup, true);
##&lt;small semigroup of size 7&gt;
##gap&gt; IsInverseSemigroup(s);
##true
##gap&gt; s:=SmallSemigroup(7, 101324);
##&lt;small semigroup of size 7&gt;
##gap&gt; IsInverseSemigroup(s);
##false
##  </Example><!-- properties.tst -->
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

###########################################################################
##
##  <#GAPDoc Label="IsLeftZeroSemigroup">
##  <ManSection>
##  <Prop Name="IsLeftZeroSemigroup" Arg="sgrp"/>
##  <Description>
##  returns <C>true</C> if the semigroup <A>sgrp</A> is 
##  a left zero semigroup and <C>false</C> otherwise.<P/>
##
##  A semigroup <A>sgrp</A> is a <E>left zero semigroup</E> if <A>xy=x</A>
##      for all <A>x,y</A> in <A>sgrp</A>.
##  <Example>
##gap&gt; s:=SmallSemigroup(5, 438);
##&lt;small semigroup of size 5&gt;
##gap&gt; IsLeftZeroSemigroup(s);
##false
##gap&gt; s:=SmallSemigroup(5, 1141);
##&lt;small semigroup of size 5&gt;
##gap&gt; IsLeftZeroSemigroup(s);
##true
##  </Example> <!-- properties.tst -->
##  </Description>
##  </ManSection>
##  <#/GAPDoc> 

DeclareProperty("IsLeftZeroSemigroup", IsSemigroup);

###########################################################################
##
##  <#GAPDoc Label="IsMonogenicSemigroup">
##  <ManSection>
##  <Prop Name="IsMonogenicSemigroup" Arg="sgrp"/>
##  <Description>
##  returns <C>true</C> if the small semigroup <A>sgrp</A> is generated by a 
##  single element and <C>false</C> otherwise. 
##  <Example>
##gap&gt; s:=RandomSmallSemigroup(7);
##&lt;small semigroup of size 7&gt;
##gap&gt; IsMonogenicSemigroup(s);
##false
##gap&gt; s:=OneSmallSemigroup(7, IsMonogenicSemigroup, true);
##&lt;small semigroup of size 7&gt;
##gap&gt; IsMonogenicSemigroup(s);
##true
##gap&gt; MinimalGeneratingSet(s);
##[ s7 ]
##gap&gt; s:=SmallSemigroup( 7, 406945);
##&lt;small semigroup of size 7&gt;
##gap&gt; IsMonogenicSemigroup(s);
##false
##  </Example><!-- properties.tst -->
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareProperty("IsMonogenicSemigroup", IsSemigroup);
DeclareSynonymAttr("Is1GeneratedSemigroup", IsMonogenicSemigroup);

###########################################################################
##
##  <#GAPDoc Label="IsMonoidAsSemigroup">
##  <ManSection>
##  <Prop Name="IsMonoidAsSemigroup" Arg="sgrp"/>
##  <Description>
##  returns <C>true</C> if the semigroup <A>sgrp</A> is a monoid (i.e. has an
##  identity element) and <C>false</C> otherwise.
##  <Example>
##gap&gt; s:=SmallSemigroup(4, 126);
##&lt;small semigroup of size 4&gt;
##gap&gt; IsMonoidAsSemigroup(s);
##false
##gap&gt; s:=OneSmallSemigroup(4, IsMonoidAsSemigroup, true);
##&lt;small semigroup of size 4&gt;
##gap&gt; IsMonoidAsSemigroup(s);
##true
##gap&gt; One(s);
##s1
##gap&gt; IdSmallSemigroup(s);
##[ 4, 7 ]
##  </Example><!-- properties.tst -->
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty("IsMonoidAsSemigroup", IsSemigroup);

###########################################################################
##
##  <#GAPDoc Label="IsMultSemigroupOfNearRing">
##  <ManSection>
##  <Prop Name="IsMultSemigroupOfNearRing" Arg="sgrp"/>
##  <Description> 
##  returns <C>true</C> if <A>sgrp</A> is isomorphic (or anti-isomorphic?)
##  to the multiplicative semigroup of a near-ring and <C>false</C> otherwise.
##  <P/>
##  Those semigroups in the library that have this property were identified
##  using the <Package>Sonata</Package> package. 
##  <Example>
##  gap> s:=OneSmallSemigroup(7, IsMultSemigroupOfNearRing, true);
##  &lt;small semigroup of size 7&gt;
##  gap> IdSmallSemigroup(s);
##  [ 7, 1 ]
##  gap> IsMultSemigroupOfNearRing(s);
##  true
##  gap> s:=SmallSemigroup(2,2);
##  &lt;small semigroup of size 2>
##  gap> IsMultSemigroupOfNearRing(s);
##  false
##  </Example><!-- properties.tst -->
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
## JDM expand the example? is it isomorphic and anti-isomorphic or only 
## isomorphic?

DeclareProperty("IsMultSemigroupOfNearRing", IsSmallSemigroup);

###########################################################################
##
##  <#GAPDoc Label="IsNGeneratedSemigroup">
##  <ManSection>
##  <Oper Name="IsNGeneratedSemigroup" Arg="sgrp, n"/>
##  <Description>
##  returns <C>true</C> if the least size of a generating set for the 
##  small semigroup <A>sgrp</A> is <A>n</A> and <C>false</C> otherwise.
##  <Example>
##gap&gt; s:=SmallSemigroup(7, 760041);
##&lt;small semigroup of size 7&gt;
##gap&gt; IsNGeneratedSemigroup(s, 4);
##false
##gap&gt; IsNGeneratedSemigroup(s, 3);
##true
##gap&gt; MinimalGeneratingSet(s);
##[ s3, s5, s7 ]
##gap&gt; s:=OneSmallSemigroup(4, x-&gt; Length(MinimalGeneratingSet(x)), 4);
##&lt;small semigroup of size 4&gt;
##gap&gt; IsNGeneratedSemigroup(s, 4);
##true
##  </Example><!-- properties.tst -->
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareOperation("IsNGeneratedSemigroup", [IsSmallSemigroup, IsPosInt]);

DeclareProperty("Is2GeneratedSemigroup", IsSmallSemigroup);
DeclareProperty("Is3GeneratedSemigroup", IsSmallSemigroup);
DeclareProperty("Is4GeneratedSemigroup", IsSmallSemigroup);
DeclareProperty("Is5GeneratedSemigroup", IsSmallSemigroup);
DeclareProperty("Is6GeneratedSemigroup", IsSmallSemigroup);
DeclareProperty("Is7GeneratedSemigroup", IsSmallSemigroup);
DeclareProperty("Is8GeneratedSemigroup", IsSmallSemigroup);

###########################################################################
##
##  <#GAPDoc Label="IsNIdempotentSemigroup">
##  <ManSection>
##  <Oper Name="IsNIdempotentSemigroup" Arg="sgrp, n"/>
##  <Description> 
##  returns <C>true</C> if the small semigroup <A>sgrp</A> has <A>n</A> idempotents 
##  and <C>false</C> otherwise.  
##  <Example>
##gap&gt; s:=SmallSemigroup(4, 75);;
##gap&gt; IsNIdempotentSemigroup(s, 1);
##false
##gap&gt; IsNIdempotentSemigroup(s, 2);
##false
##gap&gt; IsNIdempotentSemigroup(s, 3);
##true
##  </Example><!-- properties.tst --> 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareOperation("IsNIdempotentSemigroup", [IsSmallSemigroup, IsPosInt]);

DeclareProperty("Is1IdempotentSemigroup", IsSmallSemigroup);
DeclareProperty("Is2IdempotentSemigroup", IsSmallSemigroup);
DeclareProperty("Is3IdempotentSemigroup", IsSmallSemigroup);
DeclareProperty("Is4IdempotentSemigroup", IsSmallSemigroup);
DeclareProperty("Is5IdempotentSemigroup", IsSmallSemigroup);
DeclareProperty("Is6IdempotentSemigroup", IsSmallSemigroup);
DeclareProperty("Is7IdempotentSemigroup", IsSmallSemigroup);
DeclareProperty("Is8IdempotentSemigroup", IsSmallSemigroup);

#############################################################################
##
##  <#GAPDoc Label="IsNilpotentSemigroup">
##  <ManSection><Heading>IsNilpotentSemigroup</Heading>
##  <Prop Name="IsNilpotentSemigroup" Arg="sgrp"/>
##  <Prop Name="IsNilpotent" Arg="sgrp"/>
##  <Description>
##  returns <C>true</C> if the small semigroup <A>sgrp</A> is nilpotent and
##  <C>false</C> otherwise.
##  <P/>
##
##  A semigroup is <Emph>nilpotent</Emph> if it has a zero element and
##  every element to some power equals this zero.
##
##  <Example>
##gap&gt; s:=SmallSemigroup(5,116);
##&lt;small semigroup of size 5&gt;
##gap&gt; IsNilpotentSemigroup(s);
##false
##gap&gt; s:=SmallSemigroup(7, 673768);;
##gap&gt; IsNilpotentSemigroup(s);
##true
##gap&gt; s:=SmallSemigroup(7, 657867);;
##gap&gt; IsNilpotent(s);
##true
##  </Example><!-- properties.tst -->
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareProperty("IsNilpotentSemigroup", IsSmallSemigroup);

###########################################################################
##
##  <#GAPDoc Label="IsOrthodoxSemigroup">
##  <ManSection>
##  <Prop Name="IsOrthodoxSemigroup" Arg="sgrp"/>
##  <Description>
##  returns <C>true</C> if the semigroup <A>sgrp</A> is orthodox and
##  <C>false</C> otherwise.
##  <P/>
##
##  A semigroup is <E>orthodox</E> if it is regular and its idempotents
##  form a subsemigroup.
##  <Example>
##  gap&gt; s:=SmallSemigroup(6, 15858);;
##  gap&gt; IsSemigroupWithClosedIdempotents(s);
##  true
##  gap&gt; IsRegularSemigroup(s);
##  true
##  gap&gt; IsOrthodoxSemigroup(s);
##  true
##  </Example><!-- properties.tst -->
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareProperty("IsOrthodoxSemigroup", IsSemigroup );

###########################################################################
##
##  <#GAPDoc Label="IsRectangularBand">
##  <ManSection>
##  <Prop Name="IsRectangularBand" Arg="sgrp"/>
##  <Description>
##  returns <C>true</C> if the small semigroup <A>sgrp</A> is a 
##  rectangular band and <C>false</C> otherwise.<P/>
##
##  A semigroup <A>sgrp</A> is a <E>rectangular band</E> if for all 
##  <A>x,y,z</A> in <A>sgrp</A> we have that <A>x^2=x</A> and <A>xyz=xz</A>.
##  <Example>
##  gap&gt; s:=SmallSemigroup(5, 216);;
##  gap&gt; IsRectangularBand(s);
##  false
##  gap&gt; s:=SmallSemigroup(6, 15854);;
##  gap&gt; IsRectangularBand(s);
##  true
##  </Example><!-- properties.tst -->
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareProperty("IsRectangularBand", IsSemigroup);

###########################################################################
##
##  <#GAPDoc Label="IsRegularSemigroup">
##  <ManSection>
##  <Prop Name="IsRegularSemigroup" Arg="sgrp"/>
##  <Description>
##  returns <C>true</C> if the small semigroup <A>sgrp</A> is a regular
##  semigroup and <C>false</C> otherwise. <P/>
##
##  A semigroup <A>sgrp</A> is <E>regular</E> if for all <A>x</A> in 
##  <A>sgrp</A> there exists <A>y</A> in <A>sgrp</A> such that <A>xyx=x</A>.
##
##  <Example>
##  gap&gt; s:=SmallSemigroup(3, 10);;
##  gap&gt; IsRegularSemigroup(s);
##  true
##  gap&gt; s:=SmallSemigroup(3, 1);;
##  gap&gt; IsRegularSemigroup(s);
##  false
##  gap&gt; s:=OneSmallSemigroup(4, IsFullTransformationSemigroupCopy, true); 
##  &lt;small semigroup of size 4&gt;
##  gap&gt; IsRegularSemigroup(s);
##  true
##  </Example><!-- properties.tst -->
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

###########################################################################
##
##  <#GAPDoc Label="IsRightZeroSemigroup">
##  <ManSection>
##  <Prop Name="IsRightZeroSemigroup" Arg="sgrp"/>
##  <Description>
##  returns <C>false</C> for any small semigroup <A>sgrp</A> since 
##  the library contains only left zero semigroups.
##  <P/>
##  A semigroup <A>sgrp</A> is a <E>right zero semigroup</E> if <A>xy=y</A> 
##  for all <A>x,y</A> in <A>sgrp</A>.
##
##  <Example>
##  gap> s:=SmallSemigroup(5, 438);
##  &lt;small semigroup of size 5>
##  gap> IsRightZeroSemigroup(s);
##  #I  Semigroups are stored up to isomorphism and anti-isomorphism in Smallsemi
##  #I  and there are only left zero semigroups in the library.
##  false
##  </Example> <!-- properties.tst -->
##  </Description>
##  </ManSection>
##  <#/GAPDoc> 

DeclareProperty("IsRightZeroSemigroup", IsSemigroup);

############################################################################
##
##  <#GAPDoc Label="IsSelfDualSemigroup">
##  <ManSection>
##  <Prop Name="IsSelfDualSemigroup" Arg="sgrp"/>
##  <Description>
##  returns <C>true</C> if the semigroup <A>sgrp</A> is self dual and
##  <C>false</C> otherwise.
##  <P/>
##  A semigroup is <Emph>self dual</Emph> if it is isomorphic to its dual,
##  that is, the semigroup <A>t</A> with multiplication <A>*</A> defined
##  by <A>x*y=yx</A> where <A>yx</A> denotes the product in <A>sgrp</A>.
##  <Example>
##  gap> s:=SmallSemigroup(5,116);
##  &lt;small semigroup of size 5>
##  gap> IsSelfDualSemigroup(s);
##  false
##  gap> s:=RandomSmallSemigroup(5, IsSelfDualSemigroup, true);
##  &lt;small semigroup of size 5>
##  gap> IsSelfDualSemigroup(s);
##  true
##  </Example><!-- properties.tst -->
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareProperty("IsSelfDualSemigroup", IsSmallSemigroup);

###########################################################################
##
##  <#GAPDoc Label="IsSemigroupWithClosedIdempotents">
##  <ManSection>
##  <Prop Name="IsSemigroupWithClosedIdempotents" Arg="sgrp"/>
##  <Description>
##  returns <C>true</C> if the idempotent elements of the semigroup
##      <A>sgrp</A> form a subsemigroup and <C>false</C> otherwise.
##
##  <Example>
##  gap&gt; s:=SmallSemigroup(5, 677);;
##  gap&gt; IsSemigroupWithClosedIdempotents(s);
##  true
##  gap&gt; s:=SmallSemigroup(5, 659);;
##  gap&gt; IsSemigroupWithClosedIdempotents(s);
##  true
##  gap&gt; s:=SmallSemigroup(5, 327);;
##  gap&gt; IsSemigroupWithClosedIdempotents(s);
##  false
##  </Example><!-- properties.tst -->
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareProperty("IsSemigroupWithClosedIdempotents", IsSmallSemigroup);

############################################################################
##  <#GAPDoc Label="IsSemigroupWithZero">
##  <ManSection>
##  <Prop Name="IsSemigroupWithZero" Arg="sgrp"/>
##  <Description>
##  returns <C>true</C> if the semigroup <A>sgrp</A> has a zero element
##  and false otherwise.
##  <P/>
##
##  An element <M>z</M> is a <E>zero</E> if <M>z*x=x*z=z</M> for all
##  <M>x</M> in the semigroup.
##
##  <Example>
##  gap&gt; s:=SmallSemigroup(5,1);
##  &lt;small semigroup of size 5&gt;
##  gap&gt; IsSemigroupWithZero(s);
##  true
##  gap&gt; s:=SmallSemigroup(4,26);
##  &lt;small semigroup of size 4&gt;
##  gap&gt; IsSemigroupWithZero(s);
##  false
##  </Example><!-- properties.tst -->
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareProperty("IsSemigroupWithZero", IsSemigroup);

###########################################################################
##
##  <#GAPDoc Label="IsSimpleSemigroup">
##  <ManSection><Heading>IsSimpleSemigroup</Heading>
##  <Prop Name="IsSimpleSemigroup" Arg="sgrp"/>
##  <Prop Name="IsCompletelySimpleSemigroup" Arg="sgrp"/>
##  <Description>
##    return <C>true</C> if the semigroup <A>sgrp</A> is simple or 
##    completely simple and <C>false</C> otherwise.
##    <P/>
##    A semigroup is <E>simple</E> if it has no proper 2-sided ideals. A
##    semigroup is <E>completely simple</E> if it is simple and possesses
##    minimal left and right ideals.
##    <P/>
##    A finite semigroup is simple if and only if it is completely simple. 
##  <Example>
##  gap> s:=SmallSemigroup(7, 835080);;
##  gap> IsSimpleSemigroup(s);
##  true
##  gap> IsCompletelySimpleSemigroup(s);
##  true
##  gap> s:=SmallSemigroup(7, 208242);;
##  gap> IsSimpleSemigroup(s);
##  false
##  </Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

# JDM the above seems more natural but has the disadvantage that 
# IsCompletelySimplesemigroup does not return a sensible value under
# NAME_FUNC. A more permanent solution would be to change the functions 
# in smallsemi to compare the actual functions themselves and not their names.

DeclareProperty("IsCompletelySimpleSemigroup", IsSemigroup);
InstallTrueMethod(IsCompletelySimpleSemigroup, IsFinite and IsSimpleSemigroup);

#JDM new for 0.7!

DeclareProperty("IsSemilatticeAsSemigroup", IsSemigroup);
InstallTrueMethod(IsSemilatticeAsSemigroup, IsCommutative and IsBand);

###########################################################################
##
##  <#GAPDoc Label="IsSingularSemigroupCopy">
##  <ManSection>
##  <Prop Name="IsSingularSemigroupCopy" Arg="sgrp"/>
##  <Description>
##    returns <C>true</C> if the semigroup <A>sgrp</A> is isomorphic to a
##    semigroup of singular (i.e. non-invertible) mappings on a finite set
##    and <C>false</C> otherwise.
##    <P/> 
##    The size of this semigroup on an <M>n</M> element set is <M>n^n-n!</M>
##    and so there is only one semigroup in the library that has this property.
##  <Example>
##  gap> s:=SmallSemigroup(1,1);
##  &lt;small semigroup of size 1>
##  gap> IsSingularSemigroupCopy(s);
##  false
##  gap> s:=OneSmallSemigroup(2, IsSingularSemigroupCopy, true);
##  &lt;small semigroup of size 2>
##  gap> IsSingularSemigroupCopy(s);
##  true
##  gap> IdSmallSemigroup(s);
##  [ 2, 4 ]
##  gap> s:=OneSmallSemigroup(4, IsSingularSemigroupCopy, true);
##  fail
##  </Example><!-- properties.tst -->
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareProperty("IsSingularSemigroupCopy", IsSmallSemigroup);

###########################################################################
##
##  <#GAPDoc Label="IsZeroGroup">
##  <ManSection>
##  <Prop Name="IsZeroGroup" Arg="sgrp"/>
##  <Description> 
##    returns <C>true</C> if the semigroup <A>sgrp</A> is a zero group
##    and <C>false</C> otherwise.
##    <P/>
##    The semigroup <A>sgrp</A>  is a <E>zero group</E> if there exists
##    an element <M>z</M> in <A>sgrp</A> such that <A>sgrp</A> without
##    <M>z</M> is a group and for all <M>x</M> in <M>sgrp</M> we have that
##    <M>xz=zx=z</M>.
##  <Example>
##  gap> g:=Group((1,2),(3,4)); 
##  Group([ (1,2), (3,4) ])
##  gap> IdSmallSemigroup(g); 
##  [ 4, 7 ]
##  gap> s := Range(InjectionZeroMagma(g));
##  &lt;monoid with 3 generators>
##  gap> IdSmallSemigroup(s);
##  [ 5, 149 ]
##  gap> IsZeroGroup(s);
##  true
##  </Example><!-- properties.tst -->
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

###########################################################################
##
##  <#GAPDoc Label="IsZeroSemigroup">
##  <ManSection>
##  <Prop Name="IsZeroSemigroup" Arg="sgrp"/>
##  <Description> 
##    returns <C>true</C> if the semigroup <A>sgrp</A> is a zero semigroup
##    and <C>false</C> otherwise.
##    <P/>
##    The semigroup <A>sgrp</A> is a <E>zero semigroup</E> if there exists an
##    element <M>z</M> in <A>sgrp</A> such that <M>xy=z</M> for all <M>x,y</M>
##    in <A>sgrp</A>.
##  <Example>
##  gap> s:=OneSmallSemigroup(5, IsZeroSemigroup, true);
##  &lt;small semigroup of size 5>
##  gap> IsZeroSemigroup(s);
##  true
##  gap> IdSmallSemigroup(s);
##  [ 5, 1 ]
##  gap> s:=OneSmallSemigroup(5, IsZeroSemigroup, false);
##  &lt;small semigroup of size 5>
##  gap> IdSmallSemigroup(s);
##  [ 5, 2 ]
##  gap> IsZeroSemigroup(s);
##  false
##  </Example>
##    Note that for each size the unique zero semigroup is always the first
##    semigroup of this size in the library.
##  <Example>
##  gap> IsZeroSemigroup(SmallSemigroup(6,1));
##  true
##  gap> IsZeroSemigroup(SmallSemigroup(7,1));
##  true
##  gap> IsZeroSemigroup(SmallSemigroup(8,1));
##  true
##  </Example><!-- properties.tst -->
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareProperty("IsZeroSemigroup", IsSemigroup);

###########################################################################
##
##  <#GAPDoc Label="IsZeroSimpleSemigroup">
##  <ManSection>
##  <Prop Name="IsZeroSimpleSemigroup" Arg="sgrp"/>
##  <Description> 
##  return <C>true</C> if the semigroup <A>sgrp</A> is zero simple
##       and <C>false</C> otherwise.<P/>
##
##  A semigroup <A>sgrp</A> is <E>zero simple</E> if the only 2-sided ideals 
##  are the zero <A>{0}</A> and <A>sgrp</A>. 
##  <Example>
##gap&gt; s:=SmallSemigroup(7, 519799);
##&lt;small semigroup of size 7&gt;
##gap&gt; IsZeroSimpleSemigroup(s);
##false
##gap&gt; s:=RandomSmallSemigroup(7, IsZeroSimpleSemigroup, true); 
##&lt;small semigroup of size 7&gt;
##gap&gt; IsZeroSimpleSemigroup(s);
##true
##  </Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>


###########################################################################
##
##  <#GAPDoc Label="MinimalGeneratingSet">
##  <ManSection>
##  <Attr Name="MinimalGeneratingSet" Arg="sgrp"/>
##  <Description> 
##    returns a set of generators for <A>sgrp</A> with minimal size.
##  <Example>
##  gap> s:=SmallSemigroup(8, 1478885610);;
##  #I  smallsemi: loading data for semigroups of size 8.
##  gap> MinimalGeneratingSet(s);
##  [ s4, s5, s6, s7, s8 ]
##  gap> s:=SmallSemigroup(7, 673768);;
##  gap> MinimalGeneratingSet(s);
##  [ s4, s5, s6, s7 ]
##  gap> s:=SmallSemigroup(4, 4);;
##  gap> MinimalGeneratingSet(s);
##  [ s2, s3, s4 ]
##  </Example> <!-- properties.tst --> 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareAttribute("MinimalGeneratingSet", IsSemigroup);

###########################################################################
##
##  <#GAPDoc Label="NilpotencyRank">
##  <ManSection>
##  <Attr Name="NilpotencyRank" Arg="sgrp"/>
##  <Description>
##    returns the least <M>n</M> such that every product of <M>n</M> elements
##    in the nilpotent semigroup <A>sgrp</A> equals the zero element and
##    returns <C>fail</C> if the semigroup <A>sgrp</A> is not nilpotent.
##  <Example>
##  gap> s := SmallSemigroup(5, 1121);;
##  gap> NilpotencyRank(s);
##  fail
##  gap> s := SmallSemigroup(7, 393450);;
##  gap> NilpotencyRank(s);
##  3
##  </Example> <!-- properties.tst --> 
##    Note that for size 8 a semigroup in the library with ID <M>(8,n)</M>
##    is nilpotent of rank 3 if and only if <M>n</M> is greater than 11433106.
##  <Example>
##  gap> s := SmallSemigroup(8, 11433106+1231);;
##  #I  Smallsemi: loading data for semigroups of size 8.
##  gap> NilpotencyRank(s);
##  3
##  gap> s := SmallSemigroup(8,NrSmallSemigroups(8));;
##  #I  Smallsemi: loading data for semigroups of size 8.
##  gap> NilpotencyRank(s);
##  3
##  </Example> <!-- properties.tst --> 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareAttribute("NilpotencyRank", IsSmallSemigroup);

#Internal Functions
###########################################################################
##  <#GAPDoc Label="IsSemigroupWithoutClosedIdempotents">
##  <ManSection>
##  <Prop Name="IsSemigroupWithoutClosedIdempotents" Arg="sgrp"/>
##  <Description>
##  returns <C>true</C> if the idempotent elements of the semigroup
##      <A>sgrp</A> do not form a subsemigroup, and <C>false</C> otherwise.
##      <P/>
##  The reason this function exists is that almost all semigroups in the
##      library have the converse property and so it is more efficient to store
##      the positions of those that do not in the <A>info<M>n</M>.g</A> files.
##      <P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareProperty("IsSemigroupWithoutClosedIdempotents", IsSmallSemigroup);

###########################################################################
##
##  <#GAPDoc Label="SMALLSEMI_ALWAYS_FALSE">
##  <ManSection>
##  <Var Name="SMALLSEMI_ALWAYS_FALSE"/>
##  <Description>
##  is a global variable whose value is a list of strings <A>str</A> of names of properties 
##  or attributes that are always <C>false</C> for a small semigroup. <P/>
##
##  For example, <Ref Prop="IsFullTransformationSemigroup" BookName="ref"/> is always <C>false</C>
##  for small semigroups but <Ref Prop="IsFullTransformationSemigroupCopy" BookName="smallsemi"/> 
##  can be <C>true</C>.
##  <Example>
##gap&gt; SMALLSEMI_ALWAYS_FALSE;
##[ "IsFullTransformationSemigroup", "IsSingularSemigroup" ]
##  </Example> <!-- no test -->
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareGlobalVariable("SMALLSEMI_ALWAYS_FALSE");

###########################################################################
##  <#GAPDoc Label="SMALLSEMI_EQUIV">
##  <ManSection>
##  <Var Name="SMALLSEMI_EQUIV"/>
##  <Description>
##  is a global variable whose value is a list of pairs <A>P</A> of functions 
##	and values where <A>P[1]</A>
##  is a property and value which is equivalent to the properties and values 
##  in <A>P[2]</A> for small semigroups. <P/>
##  For example, 
##  <Ref Prop="IsMonogenicSemigroup" BookName="smallsemi"/> implies 
##  <A>Is1GeneratedSemigroup</A> for all semigroups and is 
##  hence a synonym and the pair <A>[[IsMonogenicSemigroup, true], [Is1GeneratedSemigroup, true]]</A> does 
##  not need to be installed in <A>SMALLSEMI_EQUIV</A>. On the other hand, 
##  <Ref Prop="IsCompletelySimpleSemigroup" BookName="smallsemi"/> only holds for 
##  <Ref Prop="IsSimpleSemigroup" BookName="ref"/> and <Ref Prop="IsFinite" BookName="ref"/> and 
##  hence is not a synonym and the pairs 
##  <A>[ [IsCompletelySimpleSemigroup, true], [IsSimpleSemigroup, true]]</A> 
## and <A>[ [IsCompletelySimpleSemigroup, false], [IsSimpleSemigroup, false]]
## </A> 
## must be entered in 
## <A>SMALLSEMI_EQUIV</A>.  Note that <A>[[IsOrthodoxSemigroup, true], 
## [IsRegularSemigroup, true, IsSemigroupWithoutClosedIdempotents, false]]</A> 
## can be entered in <A>SMALLSEMI_EQUIV</A> but currently it is not possible to 
## have any pair in <A>SMALLSEMI_EQUIV</A> with first entry 
## <A>[IsOrthodoxSemigroup, false]</A>.<P/>
##
## Also note that if <A>P</A> is an entry in <A>SMALLSEMI_EQUIV</A>, then
## <A>P[1]</A> must have length 2. <P/> 
##
##  The reason for doing all of this is so that when 
##  <Ref Oper="EnumeratorOfSmallSemigroups" BookName="smallsemi"/> is called with argument 
##  <A>IsCompletelySimpleSemigroup</A> there is no component in the record in the info file with 
##  the name <A>"IsCompletelySimpleSemigroup"</A> and so this name is provided by 
##  <A>SMALLSEMI_EQUIV</A>. If two properties are synonymous, then <A>NAME_FUNC</A> has the same 
##  value for both and so it is only necessary to store a component with that one name and hence 
##  not necessary to put a pair in <A>SMALLSEMI_EQUIV</A>. <P/>
##  The name of the component in the info file should be in the second component of a pair in 
##  <A>SMALLSEMI_EQUIV</A>
##  <Example>
##gap&gt; SMALLSEMI_EQUIV;
## [ [ "IsCompletelySimpleSemigroup", "IsSimpleSemigroup" ], 
##  [ "IsCommutativeSemigroup", "IsCommutative" ], 
##  [ "IsNilpotent", "IsNilpotentSemigroup" ] ]
##  </Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareGlobalVariable("SMALLSEMI_EQUIV");

###########################################################################
##
##  <#GAPDoc Label="STORED_INFO">
##  <ManSection>
##  <Func Name="STORED_INFO" Arg="n, str"/>
##  <Description>
##  returns the value of the component of the record <C>MOREDATA2TO8[n]</C> with 
##  name the string <C>str</C>. This is equivalent to doing the following.
##  <Example>
##MOREDATA2TO8[n].(name);
##  </Example> <!-- no test --> 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareGlobalFunction("STORED_INFO");
