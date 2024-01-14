#############################################################################
##
##  greensstar.gd                  Smallsemi - a GAP library of semigroups
##  Copyright (C) 2008-2024            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# This file contains the declaration for Green's star relations of semigroups

# <#GAPDoc Label="IsStarRelation">
# <ManSection>
# <Prop Name="IsStarRelation" Arg='bin-relation'/>
# <Prop Name="IsRStarRelation" Arg='equiv-relation'/>
# <Prop Name="IsLStarRelation" Arg='equiv-relation'/>
# <Prop Name="IsJStarRelation" Arg='equiv-relation'/>
# <Prop Name="IsHStarRelation" Arg='equiv-relation'/>
# <Prop Name="IsDStarRelation" Arg='equiv-relation'/>
#
# <Description>
# These functions return <C>true</C> if the argument is the respective
# type of relation and <C>false</C> otherwise.
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareCategory("IsStarRelation", IsBinaryRelation);
DeclareCategory("IsRStarRelation", IsStarRelation);
DeclareCategory("IsLStarRelation", IsStarRelation);
DeclareCategory("IsJStarRelation", IsStarRelation);
DeclareCategory("IsHStarRelation", IsStarRelation);
DeclareCategory("IsDStarRelation", IsStarRelation);

DeclareProperty("IsFiniteSemigroupStarRelation", IsStarRelation);

# <#GAPDoc Label="RStarRelation">
# <ManSection>
# <Attr Name="RStarRelation" Arg='semigroup'/>
# <Attr Name="LStarRelation" Arg='semigroup'/>
# <Attr Name="JStarRelation" Arg='semigroup'/>
# <Attr Name="DStarRelation" Arg='semigroup'/>
# <Attr Name="HStarRelation" Arg='semigroup'/>
#
# <Description>
# The starred Green's relations (which are equivalence relations)
# are attributes of the semigroup <A>semigroup</A>.
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareAttribute("RStarRelation", IsSemigroup);
DeclareAttribute("LStarRelation", IsSemigroup);
DeclareAttribute("JStarRelation", IsSemigroup);
DeclareAttribute("DStarRelation", IsSemigroup);
DeclareAttribute("HStarRelation", IsSemigroup);

# <#GAPDoc Label="IsStarClass">
# <ManSection>
# <Prop Name="IsStarClass" Arg='equiv-class'/>
# <Prop Name="IsRStarClass" Arg='equiv-class'/>
# <Prop Name="IsLStarClass" Arg='equiv-class'/>
# <Prop Name="IsJStarClass" Arg='equiv-class'/>
# <Prop Name="IsHStarClass" Arg='equiv-class'/>
# <Prop Name="IsDStarClass" Arg='equiv-class'/>
#
# <Description>
# return <K>true</K> if the equivalence class <A>equiv-class</A> is
# a starred Green's class of any type, or of <M>R</M>, <M>L</M>, <M>J</M>,
# <M>H</M>, <M>D</M> type, respectively, or <K>false</K> otherwise.
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareProperty("IsStarClass", IsEquivalenceClass);
DeclareProperty("IsRStarClass", IsEquivalenceClass);
DeclareProperty("IsLStarClass", IsEquivalenceClass);
DeclareProperty("IsJStarClass", IsEquivalenceClass);
DeclareProperty("IsHStarClass", IsEquivalenceClass);
DeclareProperty("IsDStarClass", IsEquivalenceClass);

InstallTrueMethod(IsStarClass, IsRStarClass);
InstallTrueMethod(IsStarClass, IsLStarClass);
InstallTrueMethod(IsStarClass, IsJStarClass);
InstallTrueMethod(IsStarClass, IsHStarClass);
InstallTrueMethod(IsStarClass, IsDStarClass);

# <#GAPDoc Label="RStarClasses">
# <ManSection>
# <Attr Name="RStarClasses" Arg='semigroup'/>
# <Attr Name="LStarClasses" Arg='semigroup'/>
# <Attr Name="JStarClasses" Arg='semigroup'/>
# <Attr Name="DStarClasses" Arg='semigroup'/>
# <Attr Name="HStarClasses" Arg='semigroup'/>
#
# <Description>
# return the <M>R</M>, <M>L</M>, <M>J</M>, <M>H</M>, or <M>D</M> starred
# Green's classes, respectively for semigroup <A>semigroup</A>.
# <C>EquivalenceClasses</C> for a Green's relation lead to one of these
# functions.
# <Example><![CDATA[
# gap> s := SmallSemigroup(6, 54);
# <small semigroup of size 6>
# gap> JStarClasses(s);
# [ {s1}, {s2}, {s4}, {s5}, {s6} ]
# ]]></Example> <!-- greensstar.tst -->
# </Description>
# </ManSection>
# <#/GAPDoc>

DeclareGlobalFunction("LStarPartitionByMT");

DeclareAttribute("RStarClasses", IsSemigroup);
DeclareAttribute("LStarClasses", IsSemigroup);
DeclareAttribute("JStarClasses", IsSemigroup);
DeclareAttribute("DStarClasses", IsSemigroup);
DeclareAttribute("HStarClasses", IsSemigroup);

DeclareAttribute("HStarClasses", IsStarClass);
DeclareAttribute("RStarClasses", IsDStarClass);
DeclareAttribute("LStarClasses", IsDStarClass);

# <#GAPDoc Label="RStarClassAttribute">
# <ManSection>
# <Attr Name="RStarClass" Arg='C' Label="for a Green's *-class"/>
# <Attr Name="LStarClass" Arg='C' Label="for a Green's *-class"/>
# <Attr Name="DStarClass" Arg='C' Label="for a Green's *-class"/>
# <Attr Name="JStarClass" Arg='C' Label="for a Green's *-class"/>
#
# <Description>
# are attributes reflecting the natural ordering over the various starred
# Green's classes. They return the respective class in which the given
# class <M>C</M> is contained, where <M>C</M> must be a class from a
# strictly finer relation.
# <Example><![CDATA[
# gap> s := SmallSemigroup(7, 280142);
# <small semigroup of size 7>
# gap> elm := AsList(s)[5];;
# gap> hclass := HStarClass(s, elm);
# {s5}
# gap> AsList(LStarClass(hclass));
# [ s5 ]
# gap> AsList(RStarClass(hclass));
# [ s2, s5 ]
# gap> AsList(DStarClass(hclass));
# [ s2, s3, s4, s5 ]
# ]]></Example> <!-- greensstar.tst -->
# </Description>
# </ManSection>
# <#/GAPDoc>

DeclareAttribute("RStarClass", IsStarClass);
DeclareAttribute("LStarClass", IsStarClass);
DeclareAttribute("DStarClass", IsStarClass);
DeclareAttribute("JStarClass", IsStarClass);

# <#GAPDoc Label="RStarClassOperation">
# <ManSection>
# <Oper Name="RStarClass" Arg='S, a' Label='for a semigroup and element'/>
# <Oper Name="LStarClass" Arg='S, a' Label='for a semigroup and element'/>
# <Oper Name="DStarClass" Arg='S, a' Label='for a semigroup and element'/>
# <Oper Name="JStarClass" Arg='S, a' Label='for a semigroup and element'/>
# <Oper Name="HStarClass" Arg='S, a' Label='for a semigroup and element'/>
#
# <Description>
# Creates the <M>X*</M>-class of the element <A>a</A>
# in the semigroup <A>S</A> where <M>X</M> is one of
# <M>L</M>, <M>R</M>, <M>D</M>, <M>J</M>, or <M>H</M>.
# <Example><![CDATA[
# gap> s := SmallSemigroup(7, 280142);
# <small semigroup of size 7>
# gap> elm := AsList(s)[5];;
# gap> jclass := JStarClass(s, elm);
# {s5}
# gap> AsList(jclass);
# [ s2, s3, s4, s5 ]
# ]]></Example> <!-- greensstar.tst -->
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareOperation("HStarClass", [IsSemigroup, IsObject]);
DeclareOperation("RStarClass", [IsSemigroup, IsObject]);
DeclareOperation("LStarClass", [IsSemigroup, IsObject]);
DeclareOperation("DStarClass", [IsSemigroup, IsObject]);
DeclareOperation("JStarClass", [IsSemigroup, IsObject]);

DeclareAttribute("InternalRepStarRelation", IsStarRelation);
DeclareAttribute("CanonicalStarClass", IsStarClass);
