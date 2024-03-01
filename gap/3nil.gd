#############################################################################
##
##  3nil.gd                        Smallsemi - a GAP library of semigroups
##  Copyright (C) 2024                 Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# <#GAPDoc Label="Nr3NilpotentSemigroups">
# <ManSection>
# <Func Name="Nr3NilpotentSemigroups" Arg="n[, type]"/>
# <Description>
# returns the number of 3-nilpotent semigroups on a set with <A>n</A>
# elements. If the optional argument <A>type</A> is given it must be one
# of <C>"UpToEquivalence", "UpToIsomorphism", "SelfDual", "Commutative",
# "Labelled", "Labelled-Commutative"</C>.
# The number will be returned for the respective type of semigroup.
# By default <A>type</A> is <C>"UpToEquivalence"</C>.
# <P/>
# The function implements the formulae calculating the number of
# 3-nilpotent semigroups developed in <Cite Key="Dis10"/>
# <Example><![CDATA[
# gap> Nr3NilpotentSemigroups(4);
# 8
# gap> Nr3NilpotentSemigroups(9, "UpToIsomorphism");
# 105931872028455
# gap> Nr3NilpotentSemigroups(9, "Labelled");
# 38430603831264883632
# gap> Nr3NilpotentSemigroups(16, "SelfDual");
# 4975000837941847814744710290469890455985530
# gap> Nr3NilpotentSemigroups(19, "Commutative");
# 12094270656160403920767935604624748908993169949317454767617795
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareGlobalFunction("Nr3NilpotentSemigroups");
