#############################################################################
#
# properties.gd                  Smallsemi - a GAP library of semigroups
# Copyright (C) 2008-2024            Andreas Distler & James D. Mitchell
#
# Licensing information can be found in the README file of this package.
#
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
# gap> s := SmallSemigroup(5,6);
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
# gap> s:=SmallSemigroup(8,10101);;
# gap> DiagonalOfMultiplicationTable(s);
# [ 1, 1, 1, 1, 1, 1, 1, 1 ]
# gap> s:=SmallSemigroup(7,10101);;
# gap> DiagonalOfMultiplicationTable(s);
# [ 1, 1, 1, 1, 1, 1, 1 ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareAttribute("DiagonalOfMultiplicationTable", IsSemigroup);

# <#GAPDoc Label="DisplaySmallSemigroup">
# <ManSection>
# <Func Name="DisplaySmallSemigroup" Arg="sgrp"/>
# <Description>
# displays all the information about the small semigroup <A>sgrp</A> that
# is stored in the library and its Green's classes and
# idempotents.
# <Example><![CDATA[
# gap> s:=SmallSemigroup(6, 3838);;
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
# gap> s:=SmallSemigroup(5,116);
# <small semigroup of size 5>
# gap> x:=Elements(s)[3];
# s3
# gap> IndexPeriod(x);
# [ 2, 1 ]
# gap> x^3=x^2;
# true
# gap> x^2=x^1;
# false
# gap> x^3=x^1;
# false
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
# </Description>
DeclareAttribute("IndexPeriod", IsSmallSemigroupElt);

# <#GAPDoc Label="IsFullTransformationSemigroupCopy">
# <ManSection>
# <Prop Name="IsFullTransformationSemigroupCopy" Arg="sgrp"/>
# <Description>
# returns <C>true</C> if the semigroup <A>sgrp</A> is isomorphic to a full
# transformation semigroup and <C>false</C> otherwise. <P/>
#
# The size of the full transformation semigroup on an <A>n</A> element set is
# <M>n^n</M> and so there are only two semigroup in the library that have this
# property.
# <Example><![CDATA[
# gap> s:=SmallSemigroup(1,1);
# <small semigroup of size 1>
# gap> IsFullTransformationSemigroupCopy(s);
# true
# gap> s:=OneSmallSemigroup(4, IsFullTransformationSemigroupCopy, true);
# <small semigroup of size 4>
# gap> IsFullTransformationSemigroupCopy(s);
# true
# gap> IdSmallSemigroup(s);
# [ 4, 96 ]
# gap> s:=OneSmallSemigroup(6, IsFullTransformationSemigroupCopy, true);
# fail
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareProperty("IsFullTransformationSemigroupCopy", IsSmallSemigroup);

DeclareSynonymAttr("Is1GeneratedSemigroup", IsMonogenicSemigroup);

# <#GAPDoc Label="IsMultSemigroupOfNearRing">
# <ManSection>
# <Prop Name="IsMultSemigroupOfNearRing" Arg="sgrp"/>
# <Description>
# returns <C>true</C> if <A>sgrp</A> is isomorphic (or anti-isomorphic?)
# to the multiplicative semigroup of a near-ring and <C>false</C> otherwise.
# <P/>
# Those semigroups in the library that have this property were identified
# using the <Package>Sonata</Package> package.
# <Example><![CDATA[
# gap> s:=OneSmallSemigroup(7, IsMultSemigroupOfNearRing, true);
# <small semigroup of size 7>
# gap> IdSmallSemigroup(s);
# [ 7, 1 ]
# gap> IsMultSemigroupOfNearRing(s);
# true
# gap> s:=SmallSemigroup(2,2);
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
# returns <C>true</C> if the least size of a generating set for the
# small semigroup <A>sgrp</A> is <A>n</A> and <C>false</C> otherwise.
# <Example><![CDATA[
# gap> s:=SmallSemigroup(7, 760041);
# <small semigroup of size 7>
# gap> IsNGeneratedSemigroup(s, 4);
# false
# gap> IsNGeneratedSemigroup(s, 3);
# true
# gap> MinimalGeneratingSet(s);
# [ s3, s5, s7 ]
# gap> s:=OneSmallSemigroup(4, x-> Length(MinimalGeneratingSet(x)), 4);
# <small semigroup of size 4>
# gap> IsNGeneratedSemigroup(s, 4);
# true
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareOperation("IsNGeneratedSemigroup", [IsSmallSemigroup, IsPosInt]);

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
# returns <C>true</C> if the small semigroup <A>sgrp</A> has <A>n</A> idempotents
# and <C>false</C> otherwise.
# <Example><![CDATA[
# gap> s:=SmallSemigroup(4, 75);;
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

DeclareProperty("Is1IdempotentSemigroup", IsSmallSemigroup);
DeclareProperty("Is2IdempotentSemigroup", IsSmallSemigroup);
DeclareProperty("Is3IdempotentSemigroup", IsSmallSemigroup);
DeclareProperty("Is4IdempotentSemigroup", IsSmallSemigroup);
DeclareProperty("Is5IdempotentSemigroup", IsSmallSemigroup);
DeclareProperty("Is6IdempotentSemigroup", IsSmallSemigroup);
DeclareProperty("Is7IdempotentSemigroup", IsSmallSemigroup);
DeclareProperty("Is8IdempotentSemigroup", IsSmallSemigroup);

# <#GAPDoc Label="IsSelfDualSemigroup">
# <ManSection>
# <Prop Name="IsSelfDualSemigroup" Arg="sgrp"/>
# <Description>
# returns <C>true</C> if the semigroup <A>sgrp</A> is self dual and
# <C>false</C> otherwise.
# <P/>
# A semigroup is <Emph>self dual</Emph> if it is isomorphic to its dual,
# that is, the semigroup <A>t</A> with multiplication <A>*</A> defined
# by <A>x*y=yx</A> where <A>yx</A> denotes the product in <A>sgrp</A>.
# <Example><![CDATA[
# gap> s:=SmallSemigroup(5,116);
# <small semigroup of size 5>
# gap> IsSelfDualSemigroup(s);
# false
# gap> s:=RandomSmallSemigroup(5, IsSelfDualSemigroup, true);
# <small semigroup of size 5>
# gap> IsSelfDualSemigroup(s);
# true
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareProperty("IsSelfDualSemigroup", IsSmallSemigroup);

# <#GAPDoc Label="IsSemigroupWithClosedIdempotents">
# <ManSection>
# <Prop Name="IsSemigroupWithClosedIdempotents" Arg="sgrp"/>
# <Description>
# returns <C>true</C> if the idempotent elements of the semigroup
#     <A>sgrp</A> form a subsemigroup and <C>false</C> otherwise.
##
# <Example><![CDATA[
# gap> s:=SmallSemigroup(5, 677);;
# gap> IsSemigroupWithClosedIdempotents(s);
# true
# gap> s:=SmallSemigroup(5, 659);;
# gap> IsSemigroupWithClosedIdempotents(s);
# true
# gap> s:=SmallSemigroup(5, 327);;
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
# returns <C>true</C> if the semigroup <A>sgrp</A> has a zero element
# and false otherwise.
# <P/>
#
# An element <M>z</M> is a <E>zero</E> if <M>z*x=x*z=z</M> for all
# <M>x</M> in the semigroup.
#
# <Example><![CDATA[
# gap> s:=SmallSemigroup(5,1);
# <small semigroup of size 5>
# gap> IsSemigroupWithZero(s);
# true
# gap> s:=SmallSemigroup(4,26);
# <small semigroup of size 4>
# gap> IsSemigroupWithZero(s);
# false
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>

DeclareProperty("IsSemigroupWithZero", IsSemigroup);

# <#GAPDoc Label="IsSingularSemigroupCopy">
# <ManSection>
# <Prop Name="IsSingularSemigroupCopy" Arg="sgrp"/>
# <Description>
# returns <C>true</C> if the semigroup <A>sgrp</A> is isomorphic to a
# semigroup of singular (i.e. non-invertible) mappings on a finite set
# and <C>false</C> otherwise.
# <P/>
# The size of this semigroup on an <M>n</M> element set is <M>n^n-n!</M>
# and so there is only one semigroup in the library that has this property.
# <Example><![CDATA[
# gap> s:=SmallSemigroup(1,1);
# <small semigroup of size 1>
# gap> IsSingularSemigroupCopy(s);
# false
# gap> s:=OneSmallSemigroup(2, IsSingularSemigroupCopy, true);
# <small semigroup of size 2>
# gap> IsSingularSemigroupCopy(s);
# true
# gap> IdSmallSemigroup(s);
# [ 2, 4 ]
# gap> s:=OneSmallSemigroup(4, IsSingularSemigroupCopy, true);
# fail
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>

DeclareProperty("IsSingularSemigroupCopy", IsSmallSemigroup);

# <#GAPDoc Label="MinimalGeneratingSet">
# <ManSection>
# <Attr Name="MinimalGeneratingSet" Arg="sgrp"/>
# <Description>
# returns a set of generators for <A>sgrp</A> with minimal size.
# <Example><![CDATA[
# gap> s:=SmallSemigroup(8, 1478885610);;
# gap> MinimalGeneratingSet(s);
# [ s4, s5, s6, s7, s8 ]
# gap> s:=SmallSemigroup(7, 673768);;
# gap> MinimalGeneratingSet(s);
# [ s4, s5, s6, s7 ]
# gap> s:=SmallSemigroup(4, 4);;
# gap> MinimalGeneratingSet(s);
# [ s2, s3, s4 ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
# MinimalGeneratingSet was only declared for IsGroup in GAP < 4.12. This
# declaration and comment can be removed if smallsemi ever requires GAP >= 4.12.
DeclareAttribute("MinimalGeneratingSet", IsSemigroup);

# <#GAPDoc Label="IsSemigroupWithoutClosedIdempotents">
# <ManSection>
# <Prop Name="IsSemigroupWithoutClosedIdempotents" Arg="sgrp"/>
# <Description>
# returns <C>true</C> if the idempotent elements of the semigroup
# <A>sgrp</A> do not form a subsemigroup, and <C>false</C> otherwise.
# <P/>
#
# The reason this function exists is that almost all semigroups in the
# library have the converse property and so it is more efficient to store
# the positions of those that do not in the <A>info<M>n</M>.g</A> files.
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
# <Example><![CDATA[
# MOREDATA2TO8[n].(name);
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareGlobalFunction("STORED_INFO");
