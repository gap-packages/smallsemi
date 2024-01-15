#############################################################################
##
##  coclass.gd                     Smallsemi - a GAP library of semigroups
##  Copyright (C) 2008-2024            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################

# <#GAPDoc Label="NilpotentSemigroupsByCoclass">
# <ManSection>
# <Func Name="NilpotentSemigroupsByCoclass" Arg="n, d[, r]"/>
# <Description>
# returns for a positive integer <A>n</A> and an integer <A>d</A> with value
# 0, 1, or 2 a list of nilpotent semigroups of order <A>n</A> and coclass
# <A>d</A> up to (anti-)isomorphism. If the optional third argument <A>r</A>
# is given then only semigroups of rank <A>r</A> are returned. The semigroups
# in the list are given by finite presentations.
# <Example><![CDATA[
# gap> NilpotentSemigroupsByCoclass(5, 1);
# [ <fp semigroup on the generators [ s1, s2 ]>,
#   <fp semigroup on the generators [ s1, s2 ]>,
#   <fp semigroup on the generators [ s1, s2 ]>,
#   <fp semigroup on the generators [ s1, s2 ]>,
#   <fp semigroup on the generators [ s1, s2 ]>,
#   <fp semigroup on the generators [ s1, s2 ]>,
#   <fp semigroup on the generators [ s1, s2 ]> ]
# gap> NilpotentSemigroupsByCoclass(7, 0);
# [ <fp semigroup on the generators [ s1 ]> ]
# gap> NilpotentSemigroupsByCoclass(4, 2, 3);
# [ <fp semigroup on the generators [ s1, s2, s3 ]> ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareGlobalFunction("NilpotentSemigroupsByCoclass");

#  <#GAPDoc Label="NilpotentSemigroupsCoclass0">
#  <ManSection>
#  <Func Name="NilpotentSemigroupsCoclass0" Arg="n"/>
#  <Description>
#  returns for a positive integer <A>n</A> a list of length one containing
#  a finitely presented semigroup of coclass 0, that is a nilpotent,
#  monogenic semigroup, of order <A>n</A>.
#  <Example><![CDATA[
#  gap> NilpotentSemigroupsCoclass0(513);
#  [ <fp semigroup on the generators [ s1 ]> ]
#  ]]></Example>
#  </Description>
#  </ManSection>
#  <#/GAPDoc>
DeclareGlobalFunction("NilpotentSemigroupsCoclass0");

# <#GAPDoc Label="NilpotentSemigroupsCoclass1">
# <ManSection>
# <Func Name="NilpotentSemigroupsCoclass1" Arg="n"/>
# <Description>
# returns for a positive integer <A>n</A> a list of nilpotent semigroups of
# coclass 1 up to (anti-)isomorphism as finitely presented semigroups.
# <Example><![CDATA[
# gap> NilpotentSemigroupsCoclass1(2);
# [  ]
# gap> NilpotentSemigroupsCoclass1(3);
# [ <fp semigroup on the generators [ s1, s2 ]> ]
# gap> NilpotentSemigroupsCoclass1(5);
# [ <fp semigroup on the generators [ s1, s2 ]>,
#   <fp semigroup on the generators [ s1, s2 ]>,
#   <fp semigroup on the generators [ s1, s2 ]>,
#   <fp semigroup on the generators [ s1, s2 ]>,
#   <fp semigroup on the generators [ s1, s2 ]>,
#   <fp semigroup on the generators [ s1, s2 ]>,
#   <fp semigroup on the generators [ s1, s2 ]> ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareGlobalFunction("NilpotentSemigroupsCoclass1");

# <#GAPDoc Label="NilpotentSemigroupsCoclass2">
# <ManSection>
# <Func Name="NilpotentSemigroupsCoclass2" Arg="n"/>
# <Description>
# returns for a positive integer <A>n</A> a list of nilpotent semigroups o
# coclass 2 up to (anti-)isomorphism as finitely presented semigroups.
# <Example><![CDATA[
# gap> NilpotentSemigroupsCoclass2(3);
# [  ]
# gap> NilpotentSemigroupsCoclass2(4);
# [ <fp semigroup on the generators [ s1, s2, s3 ]> ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareGlobalFunction("NilpotentSemigroupsCoclass2");
DeclareGlobalFunction("IsomorphicFpSemigroup");

# <#GAPDoc Label="NilpotentSemigroupsCoclass2Rank2">
# <ManSection>
# <Func Name="NilpotentSemigroupsCoclass2Rank2" Arg="n"/>
# <Description>
# returns for a positive integer <A>n</A> a list of nilpotent 2-generated
# semigroups of coclass 2 up to (anti-)isomorphism as finitely presented
# semigroups.
# <Example><![CDATA[
# gap> NilpotentSemigroupsCoclass2Rank2(4);
# [  ]
# gap> NilpotentSemigroupsCoclass2Rank2(5);
# [ <fp semigroup on the generators [ s1, s2 ]>,
#   <fp semigroup on the generators [ s1, s2 ]>,
#   <fp semigroup on the generators [ s1, s2 ]>,
#   <fp semigroup on the generators [ s1, s2 ]>,
#   <fp semigroup on the generators [ s1, s2 ]>,
#   <fp semigroup on the generators [ s1, s2 ]>,
#   <fp semigroup on the generators [ s1, s2 ]>,
#   <fp semigroup on the generators [ s1, s2 ]>,
#   <fp semigroup on the generators [ s1, s2 ]>,
#   <fp semigroup on the generators [ s1, s2 ]>,
#   <fp semigroup on the generators [ s1, s2 ]> ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareGlobalFunction("NilpotentSemigroupsCoclass2Rank2");

# <#GAPDoc Label="NilpotentSemigroupsCoclass2Rank3">
# <ManSection>
# <Func Name="NilpotentSemigroupsCoclass2Rank3" Arg="n"/>
# <Description>
# returns for a positive integer <A>n</A> a list of nilpotent 3-generated
# semigroups of coclass 2 up to (anti-)isomorphism as finitely presented
# semigroups.
# <Example><![CDATA[
# gap> NilpotentSemigroupsCoclass2Rank3(3);
# [  ]
# gap> NilpotentSemigroupsCoclass2Rank3(4);
# [ <fp semigroup on the generators [ s1, s2, s3 ]> ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareGlobalFunction("NilpotentSemigroupsCoclass2Rank3");
DeclareGlobalFunction("NilpotentSemigroupsCoclassD_NC");
DeclareGlobalFunction("NilpotentSemigroupsCoclassD");
