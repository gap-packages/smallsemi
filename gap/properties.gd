#############################################################################
##
##  properties.gd                  Smallsemi - a GAP library of semigroups
##  Copyright (C) 2008-2024            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################

# <#GAPDoc Label="Annihilators">
# <ManSection>
# <Attr Name="Annihilators" Arg="sgrp"/>
# <Description>
# returns the set of annihilators of <A>sgrp</A> if <A>sgrp</A> contains a
# zero element and <C>fail</C> otherwise.<P/>
#
# An element <M>x</M> in a semigroup with zero <M>z</M> is an
# <E>annihilator</E> if <M>xy=yx=z</M> for every element <M>y</M> in the
# semigroup.
# <Example><![CDATA[
# gap> s := SmallSemigroup(5, 6);
# <small semigroup of size 5>
# gap> Annihilators(s);
# [ s1, s2 ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareAttribute("Annihilators", IsSemigroup);

# <#GAPDoc Label="DiagonalOfMultiplicationTable">
# <ManSection>
# <Attr Name="DiagonalOfMultiplicationTable" Arg="sgrp"/>
# <Description>
# returns the diagonal of the multiplication table of the semigroup
# <A>sgrp</A>.
# <Example><![CDATA[
# gap> s := SmallSemigroup(8, 10101);;
# gap> DiagonalOfMultiplicationTable(s);
# [ 1, 1, 1, 1, 1, 1, 1, 1 ]
# gap> s := SmallSemigroup(7, 10101);;
# gap> DiagonalOfMultiplicationTable(s);
# [ 1, 1, 1, 1, 1, 1, 1 ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareAttribute("DiagonalOfMultiplicationTable", IsMagma);

# <#GAPDoc Label="DisplaySmallSemigroup">
# <ManSection>
# <Func Name="DisplaySmallSemigroup" Arg="sgrp"/>
# <Description>
# displays all the information about the small semigroup <A>sgrp</A> that
# is stored in the library and its Green's classes and
# idempotents.
# <Example><![CDATA[
# gap> s := SmallSemigroup(6, 3838);;
# gap> DisplaySmallSemigroup(s);
# IsBand:                              false
# IsBrandtSemigroup:                   false
# IsCommutative:                       false
# IsCompletelyRegularSemigroup:        false
# IsFullTransformationSemigroupCopy:   false
# IsGroupAsSemigroup:                  false
# IsIdempotentGenerated:               false
# IsInverseSemigroup:                  false
# IsMonogenicSemigroup:                false
# IsMonoidAsSemigroup:                 false
# IsMultSemigroupOfNearRing:           false
# IsOrthodoxSemigroup:                 false
# IsRectangularBand:                   false
# IsRegularSemigroup:                  false
# IsSelfDualSemigroup:                 false
# IsSemigroupWithClosedIdempotents:    true
# IsSimpleSemigroup:                   false
# IsSingularSemigroupCopy:             false
# IsZeroSemigroup:                     false
# IsZeroSimpleSemigroup:               false
# MinimalGeneratingSet:                [ s3, s4, s5, s6 ]
# Idempotents:                         [ s1, s5, s6 ]
# GreensRClasses:                      [ {s1}, {s2}, {s3}, {s4}, {s5}, {s6} ]
# GreensLClasses:                      [ {s1}, {s2}, {s3}, {s4}, {s6} ]
# GreensHClasses:                      [ {s1}, {s2}, {s3}, {s4}, {s5}, {s6} ]
# GreensDClasses:                      [ {s1}, {s2}, {s3}, {s4}, {s6} ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareGlobalFunction("DisplaySmallSemigroup");

# <#GAPDoc Label="IndexPeriod">
# <ManSection>
# <Attr Name="IndexPeriod" Arg="x"/>
# <Description>
# returns the minimum numbers <A>m, r</A> such that <A>x^{m+r}=x^m</A>; known
# as the index and period of the small semigroup element <A>x</A>.
# <Example><![CDATA[
# gap> s := SmallSemigroup(5, 116);
# <small semigroup of size 5>
# gap> x := Elements(s)[3];
# s3
# gap> IndexPeriod(x);
# [ 2, 1 ]
# gap> x ^ 3 = x ^ 2;
# true
# gap> x ^ 2 = x ^ 1;
# false
# gap> x ^ 3 = x ^ 1;
# false
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
# </Description>
DeclareAttribute("IndexPeriod", IsSmallSemigroupElt);

# <#GAPDoc Label="IsBand">
# <ManSection>
# <Prop Name="IsBand" Arg="sgrp"/>
# <Description>
# returns <K>true</K> if the small semigroup <A>sgrp</A> is a band and
# <K>false</K> otherwise.<P/>
#
# A semigroup <A>sgrp</A> is a <E>band</E> if every element is an idempotent,
# that is, <A>x^2=x</A> for all <A>x</A> in <A>sgrp</A>.
# <Example><![CDATA[
# gap> s := SmallSemigroup(5, 519);;
# gap> IsBand(s);
# false
# gap> s := OneSmallSemigroup(5, IsBand, true);
# <small semigroup of size 5>
# gap> IsBand(s);
# true
# gap> IdSmallSemigroup(s);
# [ 5, 1010 ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>

# <#GAPDoc Label="IsBrandtSemigroup">
# <ManSection>
# <Prop Name="IsBrandtSemigroup" Arg="sgrp"/>
# <Description>
# returns <K>true</K> if the small semigroup <A>sgrp</A> is a Brandt semigroup
# and <K>false</K> otherwise.<P/>
#
# A finite semigroup <A>sgrp</A> is a <E>Brandt semigroup</E> if it is inverse
# and zero simple.
# <Example><![CDATA[
# gap> s := SmallSemigroup(5, 519);;
# gap> IsBrandtSemigroup(s);
# false
# gap> s := OneSmallSemigroup(5, IsBrandtSemigroup, true);
# <small semigroup of size 5>
# gap> IsBrandtSemigroup(s);
# true
# gap> IdSmallSemigroup(s);
# [ 5, 149 ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>

# <#GAPDoc Label="IsCliffordSemigroup">
# <ManSection>
# <Prop Name="IsCliffordSemigroup" Arg="sgrp"/>
# <Description>
# returns <K>true</K> if the small semigroup <A>sgrp</A> is a Clifford
# semigroup and <K>false</K> otherwise.<P/>
#
# A semigroup <A>sgrp</A> is a <E>Clifford semigroup</E> if it is a
# regular semigroup whose idempotents are central, that is, for all
# <A>e,x</A> in <A>sgrp</A> where <A>e^2=e</A>
# we have that <A>ex=xe</A>.
# <Example><![CDATA[
# gap> s := SmallSemigroup(5, 519);;
# gap> IsBand(s);
# false
# gap> s := OneSmallSemigroup(5, IsBand, true);
# <small semigroup of size 5>
# gap> IsBand(s);
# true
# gap> IdSmallSemigroup(s);
# [ 5, 1010 ]
# gap> s := SmallSemigroup(5, 519);;
# gap> IsCliffordSemigroup(s);
# false
# gap> s := OneSmallSemigroup(5, IsCliffordSemigroup, true);
# <small semigroup of size 5>
# gap> IsCliffordSemigroup(s);
# true
# gap> IdSmallSemigroup(s);
# [ 5, 148 ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>

# <#GAPDoc Label="IsCommutativeSemigroup">
# <ManSection>
# <Prop Name="IsCommutativeSemigroup" Arg="sgrp"/>
# <Prop Name="IsCommutative" Arg="sgrp"/>
# <Description>
# return <K>true</K> if the small semigroup <A>sgrp</A> is commutative and
# <K>false</K> otherwise.<P/>
#
# A semigroup <A>sgrp</A> is <E>commutative</E> if <A>xy=yx</A> for all
# <A>x,y</A> in <A>sgrp</A>.
# <Example><![CDATA[
# gap> s := SmallSemigroup(6, 871);;
# gap> IsCommutativeSemigroup(s);
# false
# gap> s := OneSmallSemigroup(5, IsCommutative, true);
# <small semigroup of size 5>
# gap> IsCommutativeSemigroup(s);
# true
# gap> IsCommutative(s);
# true
# gap> IdSmallSemigroup(s);
# [ 5, 1 ]
# gap> s := OneSmallSemigroup(5, IsCommutativeSemigroup, true);
# <small semigroup of size 5>
# gap> IsCommutativeSemigroup(s);
# true
# gap> IsCommutative(s);
# true
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>

# <#GAPDoc Label="IsCompletelyRegularSemigroup">
# <ManSection>
# <Prop Name="IsCompletelyRegularSemigroup" Arg="sgrp"/>
# <Description>
# returns <K>true</K> if the semigroup <A>sgrp</A> is completely
# regular and <K>false</K> otherwise.<P/>
# A semigroup is <E>completely regular</E>
# if every element is contained in a subgroup.
# <Example><![CDATA[
# gap> s := SmallSemigroup(6, 13131);
# <small semigroup of size 6>
# gap> IsCompletelyRegularSemigroup(s);
# false
# gap> s := OneSmallSemigroup(6, IsCompletelyRegularSemigroup, true);
# <small semigroup of size 6>
# gap> IsCompletelyRegularSemigroup(s);
# true
# gap> IdSmallSemigroup(s);
# [ 6, 3164 ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>

# <#GAPDoc Label="IsFullTransformationSemigroupCopy">
# <ManSection>
# <Prop Name="IsFullTransformationSemigroupCopy" Arg="sgrp"/>
# <Description>
# returns <K>true</K> if the semigroup <A>sgrp</A> is isomorphic to a full
# transformation
# semigroup and <K>false</K> otherwise. <P/>
#
# The size of the full transformation semigroup on an <A>n</A> element set is
# <M>n^n</M> and so there are only two semigroup in the library that have this
# property.
# <Example><![CDATA[
# gap> s := SmallSemigroup(1, 1);
# <small semigroup of size 1>
# gap> IsFullTransformationSemigroupCopy(s);
# true
# gap> s := OneSmallSemigroup(4, IsFullTransformationSemigroupCopy, true);
# <small semigroup of size 4>
# gap> IsFullTransformationSemigroupCopy(s);
# true
# gap> IdSmallSemigroup(s);
# [ 4, 96 ]
# gap> s := OneSmallSemigroup(6, IsFullTransformationSemigroupCopy, true);
# fail
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareProperty("IsFullTransformationSemigroupCopy", IsSmallSemigroup);

# <#GAPDoc Label="IsGroupAsSemigroup">
# <ManSection>
# <Prop Name="IsGroupAsSemigroup" Arg="sgrp"/>
# <Description>
# returns <K>true</K> if the small semigroup <A>sgrp</A>
# is mathematically a group, and returns <K>false</K> otherwise.
# Note that no small semigroup can lie in the category
# <Ref Prop="IsGroup" BookName="ref"/>.
# <Example><![CDATA[
# gap> s := SmallSemigroup(7, 7);
# <small semigroup of size 7>
# gap> IsGroupAsSemigroup(s);
# false
# gap> s := SmallSemigroup(4, 37);;
# gap> IsGroupAsSemigroup(s);
# true
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>

# <#GAPDoc Label="IsIdempotentGenerated">
# <ManSection><Heading>IsIdempotentGenerated</Heading>
# <Prop Name="IsIdempotentGenerated" Arg="sgrp"/>
# <Prop Name="IsSemiband" Arg="sgrp"/>
# <Description>
# returns <K>true</K> if the semigroup <A>sgrp</A> is a
# semiband and <K>false</K> otherwise.<P/>
#
# A semigroup <A>sgrp</A> is <E>idempotent generated</E> or equivalently a
# <E>semiband</E> if it is generated by its idempotent elements, i.e elements
# satisfying <A>x^2=x</A>.
# <Example><![CDATA[
# gap> s := SmallSemigroup(3, 13);
# <small semigroup of size 3>
# gap> IsIdempotentGenerated(s);
# true
# gap> s := OneSmallSemigroup(3, IsIdempotentGenerated, false);
# <small semigroup of size 3>
# gap> IsIdempotentGenerated(s);
# false
# gap> IdSmallSemigroup(s);
# [ 3, 1 ]
# gap> s := OneSmallSemigroup(4, IsIdempotentGenerated, true,
# > IsSingularSemigroupCopy, true);
# fail
# gap> s := OneSmallSemigroup(2, IsIdempotentGenerated, true,
# > IsSingularSemigroupCopy, true);
# <small semigroup of size 2>
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>

# <#GAPDoc Label="IsInverseSemigroup">
# <ManSection>
# <Prop Name="IsInverseSemigroup" Arg="sgrp"/>
# <Description>
# returns <K>true</K> if the semigroup <A>sgrp</A> is an inverse
# semigroup and <K>false</K> otherwise.<P/>
#
# A semigroup <A>sgrp</A> is an <E>inverse semigroup</E> if every element
# <A>x</A> in <A>sgrp</A> has a unique semigroup inverse, that is, a unique
# element <A>y</A> such that <A>xyx=x</A> and <A>yxy=y</A>.
# <Example><![CDATA[
# gap> s := OneSmallSemigroup(7, IsInverseSemigroup, true);
# <small semigroup of size 7>
# gap> IsInverseSemigroup(s);
# true
# gap> s := SmallSemigroup(7, 101324);
# <small semigroup of size 7>
# gap> IsInverseSemigroup(s);
# false
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>

# <#GAPDoc Label="IsLeftZeroSemigroup">
# <ManSection>
# <Prop Name="IsLeftZeroSemigroup" Arg="sgrp"/>
# <Description>
# returns <K>true</K> if the semigroup <A>sgrp</A> is
# a left zero semigroup and <K>false</K> otherwise.<P/>
#
# A semigroup <A>sgrp</A> is a <E>left zero semigroup</E> if <A>xy=x</A>
#     for all <A>x,y</A> in <A>sgrp</A>.
# <Example><![CDATA[
# gap> s := SmallSemigroup(5, 438);
# <small semigroup of size 5>
# gap> IsLeftZeroSemigroup(s);
# false
# gap> s := SmallSemigroup(5, 1141);
# <small semigroup of size 5>
# gap> IsLeftZeroSemigroup(s);
# true
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>

# <#GAPDoc Label="IsMonogenicSemigroup">
# <ManSection>
# <Prop Name="IsMonogenicSemigroup" Arg="sgrp"/>
# <Description>
# returns <K>true</K> if the small semigroup <A>sgrp</A> is generated by a
# single element and <K>false</K> otherwise.
# <Example><![CDATA[
# gap> s := RandomSmallSemigroup(7);
# <small semigroup of size 7>
# gap> IsMonogenicSemigroup(s);
# false
# gap> s := OneSmallSemigroup(7, IsMonogenicSemigroup, true);
# <small semigroup of size 7>
# gap> IsMonogenicSemigroup(s);
# true
# gap> MinimalGeneratingSet(s);
# [ s7 ]
# gap> s := SmallSemigroup(7, 406945);
# <small semigroup of size 7>
# gap> IsMonogenicSemigroup(s);
# false
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>

DeclareSynonymAttr("Is1GeneratedSemigroup", IsMonogenicSemigroup);

# <#GAPDoc Label="IsMonoidAsSemigroup">
# <ManSection>
# <Prop Name="IsMonoidAsSemigroup" Arg="sgrp"/>
# <Description>
# returns <K>true</K> if the semigroup <A>sgrp</A> is a monoid (i.e. has an
# identity element) and <K>false</K> otherwise.
# <Example><![CDATA[
# gap> s := SmallSemigroup(4, 126);
# <small semigroup of size 4>
# gap> IsMonoidAsSemigroup(s);
# false
# gap> s := OneSmallSemigroup(4, IsMonoidAsSemigroup, true);
# <small semigroup of size 4>
# gap> IsMonoidAsSemigroup(s);
# true
# gap> One(s);
# s1
# gap> IdSmallSemigroup(s);
# [ 4, 7 ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
#

# <#GAPDoc Label="IsMultSemigroupOfNearRing">
# <ManSection>
# <Prop Name="IsMultSemigroupOfNearRing" Arg="sgrp"/>
# <Description>
# returns <K>true</K> if <A>sgrp</A> is isomorphic (or anti-isomorphic?)
# to the multiplicative semigroup of a near-ring and <K>false</K> otherwise.
# <P/>
# Those semigroups in the library that have this property were identified
# using the <Package>Sonata</Package> package.
# <Example><![CDATA[
# gap> s := OneSmallSemigroup(7, IsMultSemigroupOfNearRing, true);
# <small semigroup of size 7>
# gap> IdSmallSemigroup(s);
# [ 7, 1 ]
# gap> IsMultSemigroupOfNearRing(s);
# true
# gap> s := SmallSemigroup(2, 2);
# <small semigroup of size 2>
# gap> IsMultSemigroupOfNearRing(s);
# false
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
# JDM expand the example? is it isomorphic and anti-isomorphic or only
# isomorphic?
DeclareProperty("IsMultSemigroupOfNearRing", IsSmallSemigroup);

# <#GAPDoc Label="IsNGeneratedSemigroup">
# <ManSection>
# <Oper Name="IsNGeneratedSemigroup" Arg="sgrp, n"/>
# <Description>
# returns <K>true</K> if the least size of a generating set for the
# small semigroup <A>sgrp</A> is <A>n</A> and <K>false</K> otherwise.
# <Example><![CDATA[
# gap> s := SmallSemigroup(7, 760041);
# <small semigroup of size 7>
# gap> IsNGeneratedSemigroup(s, 4);
# false
# gap> IsNGeneratedSemigroup(s, 3);
# true
# gap> MinimalGeneratingSet(s);
# [ s3, s5, s7 ]
# gap> s := OneSmallSemigroup(4, x -> Length(MinimalGeneratingSet(x)), 4);
# <small semigroup of size 4>
# gap> IsNGeneratedSemigroup(s, 4);
# true
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>

DeclareOperation("IsNGeneratedSemigroup", [IsSmallSemigroup, IsPosInt]);
# TODO remove
DeclareProperty("Is2GeneratedSemigroup", IsSmallSemigroup);
DeclareProperty("Is3GeneratedSemigroup", IsSmallSemigroup);
DeclareProperty("Is4GeneratedSemigroup", IsSmallSemigroup);
DeclareProperty("Is5GeneratedSemigroup", IsSmallSemigroup);
DeclareProperty("Is6GeneratedSemigroup", IsSmallSemigroup);
DeclareProperty("Is7GeneratedSemigroup", IsSmallSemigroup);
DeclareProperty("Is8GeneratedSemigroup", IsSmallSemigroup);

# <#GAPDoc Label="IsNIdempotentSemigroup">
# <ManSection>
# <Oper Name="IsNIdempotentSemigroup" Arg="sgrp, n"/>
# <Description>
# returns <K>true</K> if the small semigroup <A>sgrp</A> has <A>n</A> idempotents
# and <K>false</K> otherwise.
# <Example><![CDATA[
# gap> s := SmallSemigroup(4, 75);;
# gap> IsNIdempotentSemigroup(s, 1);
# false
# gap> IsNIdempotentSemigroup(s, 2);
# false
# gap> IsNIdempotentSemigroup(s, 3);
# true
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>

DeclareOperation("IsNIdempotentSemigroup", [IsSmallSemigroup, IsPosInt]);

# TODO remove
DeclareProperty("Is1IdempotentSemigroup", IsSmallSemigroup);
DeclareProperty("Is2IdempotentSemigroup", IsSmallSemigroup);
DeclareProperty("Is3IdempotentSemigroup", IsSmallSemigroup);
DeclareProperty("Is4IdempotentSemigroup", IsSmallSemigroup);
DeclareProperty("Is5IdempotentSemigroup", IsSmallSemigroup);
DeclareProperty("Is6IdempotentSemigroup", IsSmallSemigroup);
DeclareProperty("Is7IdempotentSemigroup", IsSmallSemigroup);
DeclareProperty("Is8IdempotentSemigroup", IsSmallSemigroup);

# <#GAPDoc Label="IsNilpotentSemigroup">
# <ManSection><Heading>IsNilpotentSemigroup</Heading>
# <Prop Name="IsNilpotentSemigroup" Arg="sgrp"/>
# <Prop Name="IsNilpotent" Arg="sgrp"/>
# <Description>
# returns <K>true</K> if the small semigroup <A>sgrp</A> is nilpotent and
# <K>false</K> otherwise.
# <P/>
#
# A semigroup is <Emph>nilpotent</Emph> if it has a zero element and
# every element to some power equals this zero.
#
# <Example><![CDATA[
# gap> s := SmallSemigroup(5, 116);
# <small semigroup of size 5>
# gap> IsNilpotentSemigroup(s);
# false
# gap> s := SmallSemigroup(7, 673768);;
# gap> IsNilpotentSemigroup(s);
# true
# gap> s := SmallSemigroup(7, 657867);;
# gap> IsNilpotent(s);
# true
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>

# <#GAPDoc Label="IsOrthodoxSemigroup">
# <ManSection>
# <Prop Name="IsOrthodoxSemigroup" Arg="sgrp"/>
# <Description>
# returns <K>true</K> if the semigroup <A>sgrp</A> is orthodox and
# <K>false</K> otherwise.
# <P/>
#
# A semigroup is <E>orthodox</E> if it is regular and its idempotents
# form a subsemigroup.
# <Example><![CDATA[
# gap> s := SmallSemigroup(6, 15858);;
# gap> IsSemigroupWithClosedIdempotents(s);
# true
# gap> IsRegularSemigroup(s);
# true
# gap> IsOrthodoxSemigroup(s);
# true
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>

# <#GAPDoc Label="IsRectangularBand">
# <ManSection>
# <Prop Name="IsRectangularBand" Arg="sgrp"/>
# <Description>
# returns <K>true</K> if the small semigroup <A>sgrp</A> is a
# rectangular band and <K>false</K> otherwise.<P/>
#
# A semigroup <A>sgrp</A> is a <E>rectangular band</E> if for all
# <A>x,y,z</A> in <A>sgrp</A> we have that <A>x^2=x</A> and <A>xyz=xz</A>.
# <Example><![CDATA[
# gap> s := SmallSemigroup(5, 216);;
# gap> IsRectangularBand(s);
# false
# gap> s := SmallSemigroup(6, 15854);;
# gap> IsRectangularBand(s);
# true
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>

# <#GAPDoc Label="IsRegularSemigroup">
# <ManSection>
# <Prop Name="IsRegularSemigroup" Arg="sgrp"/>
# <Description>
# returns <K>true</K> if the small semigroup <A>sgrp</A> is a regular
# semigroup and <K>false</K> otherwise. <P/>
#
# A semigroup <A>sgrp</A> is <E>regular</E> if for all <A>x</A> in
# <A>sgrp</A> there exists <A>y</A> in <A>sgrp</A> such that <A>xyx=x</A>.
#
# <Example><![CDATA[
# gap> s := SmallSemigroup(3, 10);;
# gap> IsRegularSemigroup(s);
# true
# gap> s := SmallSemigroup(3, 1);;
# gap> IsRegularSemigroup(s);
# false
# gap> s := OneSmallSemigroup(4, IsFullTransformationSemigroupCopy, true);
# <small semigroup of size 4>
# gap> IsRegularSemigroup(s);
# true
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>

# <#GAPDoc Label="IsRightZeroSemigroup">
# <ManSection>
# <Prop Name="IsRightZeroSemigroup" Arg="sgrp"/>
# <Description>
# returns <K>false</K> for any small semigroup <A>sgrp</A> since
# the library contains only left zero semigroups.
# <P/>
# A semigroup <A>sgrp</A> is a <E>right zero semigroup</E> if <A>xy=y</A>
# for all <A>x,y</A> in <A>sgrp</A>.
#
# <Example><![CDATA[
# gap> s := SmallSemigroup(5, 438);
# <small semigroup of size 5>
# gap> IsRightZeroSemigroup(s);
# false
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>

# <#GAPDoc Label="IsSelfDualSemigroup">
# <ManSection>
# <Prop Name="IsSelfDualSemigroup" Arg="sgrp"/>
# <Description>
# returns <K>true</K> if the semigroup <A>sgrp</A> is self dual and
# <K>false</K> otherwise.
# <P/>
# A semigroup is <Emph>self dual</Emph> if it is isomorphic to its dual,
# that is, the semigroup <A>t</A> with multiplication <A>*</A> defined
# by <A>x*y=yx</A> where <A>yx</A> denotes the product in <A>sgrp</A>.
# <Example><![CDATA[
# gap> s := SmallSemigroup(5, 116);
# <small semigroup of size 5>
# gap> IsSelfDualSemigroup(s);
# false
# gap> s := RandomSmallSemigroup(5, IsSelfDualSemigroup, true);
# <small semigroup of size 5>
# gap> IsSelfDualSemigroup(s);
# true
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareProperty("IsSelfDualSemigroup", IsSemigroup);

# <#GAPDoc Label="IsSemigroupWithClosedIdempotents">
# <ManSection>
# <Prop Name="IsSemigroupWithClosedIdempotents" Arg="sgrp"/>
# <Description>
# returns <K>true</K> if the idempotent elements of the semigroup <A>sgrp</A>
# form a subsemigroup and <K>false</K> otherwise.
#
# <Example><![CDATA[
# gap> s := SmallSemigroup(5, 677);;
# gap> IsSemigroupWithClosedIdempotents(s);
# true
# gap> s := SmallSemigroup(5, 659);;
# gap> IsSemigroupWithClosedIdempotents(s);
# true
# gap> s := SmallSemigroup(5, 327);;
# gap> IsSemigroupWithClosedIdempotents(s);
# false
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>

if not IsBoundGlobal("IsSemigroupWithClosedIdempotents") then
  DeclareProperty("IsSemigroupWithClosedIdempotents", IsSemigroup);
fi;

# <#GAPDoc Label="IsSemigroupWithZero">
# <ManSection>
# <Prop Name="IsSemigroupWithZero" Arg="sgrp"/>
# <Description>
# returns <K>true</K> if the semigroup <A>sgrp</A> has a zero element
# and false otherwise.
# <P/>
#
# An element <M>z</M> is a <E>zero</E> if <M>z*x=x*z=z</M> for all
# <M>x</M> in the semigroup.
#
# <Example><![CDATA[
# gap> s := SmallSemigroup(5, 1);
# <small semigroup of size 5>
# gap> IsSemigroupWithZero(s);
# true
# gap> s := SmallSemigroup(4, 26);
# <small semigroup of size 4>
# gap> IsSemigroupWithZero(s);
# false
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareProperty("IsSemigroupWithZero", IsSemigroup);

# <#GAPDoc Label="IsSimpleSemigroup">
# <ManSection><Heading>IsSimpleSemigroup</Heading>
# <Prop Name="IsSimpleSemigroup" Arg="sgrp"/>
# <Prop Name="IsCompletelySimpleSemigroup" Arg="sgrp"/>
# <Description>
# return <K>true</K> if the semigroup <A>sgrp</A> is simple or
# completely simple and <K>false</K> otherwise.
# <P/>
# A semigroup is <E>simple</E> if it has no proper 2-sided ideals. A
# semigroup is <E>completely simple</E> if it is simple and possesses
# minimal left and right ideals.
# <P/>
# A finite semigroup is simple if and only if it is completely simple.
# <Example><![CDATA[
# gap> s := SmallSemigroup(7, 835080);;
# gap> IsSimpleSemigroup(s);
# true
# gap> IsCompletelySimpleSemigroup(s);
# true
# gap> s := SmallSemigroup(7, 208242);;
# gap> IsSimpleSemigroup(s);
# false
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>

# <#GAPDoc Label="IsSingularSemigroupCopy">
# <ManSection>
# <Prop Name="IsSingularSemigroupCopy" Arg="sgrp"/>
# <Description>
# returns <K>true</K> if the semigroup <A>sgrp</A> is isomorphic to a
# semigroup of singular (i.e. non-invertible) mappings on a finite set
# and <K>false</K> otherwise.
# <P/>
# The size of this semigroup on an <M>n</M> element set is <M>n^n-n!</M>
# and so there is only one semigroup in the library that has this property.
# <Example><![CDATA[
# gap> s := SmallSemigroup(1, 1);
# <small semigroup of size 1>
# gap> IsSingularSemigroupCopy(s);
# false
# gap> s := OneSmallSemigroup(2, IsSingularSemigroupCopy, true);
# <small semigroup of size 2>
# gap> IsSingularSemigroupCopy(s);
# true
# gap> IdSmallSemigroup(s);
# [ 2, 4 ]
# gap> s := OneSmallSemigroup(4, IsSingularSemigroupCopy, true);
# fail
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareProperty("IsSingularSemigroupCopy", IsSmallSemigroup);

# <#GAPDoc Label="IsZeroGroup">
# <ManSection>
# <Prop Name="IsZeroGroup" Arg="sgrp"/>
# <Description>
# returns <K>true</K> if the semigroup <A>sgrp</A> is a zero group
# and <K>false</K> otherwise.
# <P/>
# The semigroup <A>sgrp</A>  is a <E>zero group</E> if there exists
# an element <M>z</M> in <A>sgrp</A> such that <A>sgrp</A> without
# <M>z</M> is a group and for all <M>x</M> in <M>sgrp</M> we have that
# <M>xz=zx=z</M>.
# <Example><![CDATA[
# gap> g := Group((1, 2), (3, 4));
# Group([ (1,2), (3,4) ])
# gap> IdSmallSemigroup(g);
# [ 4, 7 ]
# gap> s := Range(InjectionZeroMagma(g));
# <Group([ (1,2), (3,4) ]) with 0 adjoined>
# gap> IdSmallSemigroup(s);
# [ 5, 149 ]
# gap> IsZeroGroup(s);
# true
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>

# <#GAPDoc Label="IsZeroSemigroup">
# <ManSection>
# <Prop Name="IsZeroSemigroup" Arg="sgrp"/>
# <Description>
# returns <K>true</K> if the semigroup <A>sgrp</A> is a zero semigroup
# and <K>false</K> otherwise.
# <P/>
# The semigroup <A>sgrp</A> is a <E>zero semigroup</E> if there exists an
# element <M>z</M> in <A>sgrp</A> such that <M>xy=z</M> for all <M>x,y</M>
# in <A>sgrp</A>.
# <Example><![CDATA[
# gap> s := OneSmallSemigroup(5, IsZeroSemigroup, true);
# <small semigroup of size 5>
# gap> IsZeroSemigroup(s);
# true
# gap> IdSmallSemigroup(s);
# [ 5, 1 ]
# gap> s := OneSmallSemigroup(5, IsZeroSemigroup, false);
# <small semigroup of size 5>
# gap> IdSmallSemigroup(s);
# [ 5, 2 ]
# gap> IsZeroSemigroup(s);
# false
# ]]></Example>
# Note that for each size the unique zero semigroup is always the first
# semigroup of this size in the library.
# <Example><![CDATA[
# gap> IsZeroSemigroup(SmallSemigroup(6, 1));
# true
# gap> IsZeroSemigroup(SmallSemigroup(7, 1));
# true
# gap> IsZeroSemigroup(SmallSemigroup(8, 1));
# true
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>

# <#GAPDoc Label="IsZeroSimpleSemigroup">
# <ManSection>
# <Prop Name="IsZeroSimpleSemigroup" Arg="sgrp"/>
# <Description>
# return <K>true</K> if the semigroup <A>sgrp</A> is zero simple
# and <K>false</K> otherwise.<P/>
#
# A semigroup <A>sgrp</A> is <E>zero simple</E> if the only 2-sided ideals
# are the zero <A>{0}</A> and <A>sgrp</A>.
# <Example><![CDATA[
# gap> s := SmallSemigroup(7, 519799);
# <small semigroup of size 7>
# gap> IsZeroSimpleSemigroup(s);
# false
# gap> s := RandomSmallSemigroup(7, IsZeroSimpleSemigroup, true);
# <small semigroup of size 7>
# gap> IsZeroSimpleSemigroup(s);
# true
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>

# <#GAPDoc Label="MinimalGeneratingSet">
# <ManSection>
# <Attr Name="MinimalGeneratingSet" Arg="sgrp"/>
# <Description>
# returns a set of generators for <A>sgrp</A> with minimal size.
# <Example><![CDATA[
# gap> s := SmallSemigroup(8, 1478885610);;
# gap> MinimalGeneratingSet(s);
# [ s4, s5, s6, s7, s8 ]
# gap> s := SmallSemigroup(7, 673768);;
# gap> MinimalGeneratingSet(s);
# [ s4, s5, s6, s7 ]
# gap> s := SmallSemigroup(4, 4);;
# gap> MinimalGeneratingSet(s);
# [ s2, s3, s4 ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
# MinimalGeneratingSet was only declared for IsGroup in GAP < 4.12. This
# declaration and comment can be removed if smallsemi ever requires GAP >= 4.12.
DeclareAttribute("MinimalGeneratingSet", IsSemigroup);

# <#GAPDoc Label="NilpotencyDegree">
# <ManSection>
# <Attr Name="NilpotencyDegree" Arg="sgrp"/>
# <Description>
# returns the least <M>n</M> such that every product of <M>n</M> elements
# in the nilpotent semigroup <A>sgrp</A> equals the zero element and
# returns <C>fail</C> if the semigroup <A>sgrp</A> is not nilpotent.
# <Example><![CDATA[
# gap> s := SmallSemigroup(5, 1121);;
# gap> NilpotencyDegree(s);
# fail
# gap> s := SmallSemigroup(7, 393450);;
# gap> NilpotencyDegree(s);
# 3
# ]]></Example>
# Note that for size 8 a semigroup in the library with ID <M>(8,n)</M> is
# nilpotent of degree 3 if and only if <M>n</M> is greater than 11433106.
# <Example><![CDATA[
# gap> s := SmallSemigroup(8, 11433106 + 1231);;
# gap> NilpotencyDegree(s);
# 3
# gap> s := SmallSemigroup(8, NrSmallSemigroups(8));;
# gap> NilpotencyDegree(s);
# 3
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>

# <#GAPDoc Label="IsSemigroupWithoutClosedIdempotents">
# <ManSection>
# <Prop Name="IsSemigroupWithoutClosedIdempotents" Arg="sgrp"/>
# <Description>
# returns <K>true</K> if the idempotent elements of the semigroup
# <A>sgrp</A> do not form a subsemigroup, and <K>false</K> otherwise.
# <P/>
# The reason this function exists is that almost all semigroups in the
# library have the converse property and so it is more efficient to store
# the positions of those that do not in the <A>info<M>n</M>.g</A> files.
# <P/>
# </Description>
# </ManSection>
# <#/GAPDoc>

DeclareProperty("IsSemigroupWithoutClosedIdempotents", IsSmallSemigroup);

# <#GAPDoc Label="STORED_INFO">
# <ManSection>
# <Func Name="STORED_INFO" Arg="n, str"/>
# <Description>
# returns the value of the component of the record <C>MOREDATA2TO8[n]</C> with
# name the string <C>str</C>. This is equivalent to doing the following.
# <Log><![CDATA[
# MOREDATA2TO8[n].(name);
# ]]></Log>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareGlobalFunction("STORED_INFO");

DeclareGlobalFunction("SMALLSEMI_TableToLiterals");
DeclareGlobalFunction("SMALLSEMI_OnLiterals");
