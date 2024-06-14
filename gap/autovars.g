#############################################################################
##
##  autovars.g                     Smallsemi - a GAP library of semigroups
##  Copyright (C) 2008-2024            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# <#GAPDoc Label="MOREDATA2TO8">
# <ManSection>
# <Var Name="MOREDATA2TO8"/>
# <Description>
# contains the precomputed information stored in the files <C>infon.g</C>
# for <M>n</M> in <M>\{1,...,8\}</M> in a list where the <M>n</M>th entry
# is a record with components named after the function values they store.
# For example, to retrieve the stored value of the function
# <C>MinimalGeneratorsOfSemigroup</C> for a semigroup <C>S</C> of size
# <M>5</M> do
# <Log>
# MOREDATA2TO8[5].MinimalGeneratorsOfSemigroup[IdSmallSemigroup(S)[2]];
# </Log>
# </Description>
# </ManSection>
# <#/GAPDoc>
BindGlobal("MOREDATA2TO8", READ_MOREDATA2TO8());

# <#GAPDoc Label="PrecomputedSmallSemisInfo">
# <ManSection>
# <Var Name="PrecomputedSmallSemisInfo"/>
# <Description>
# the global variable <C>PrecomputedSmallSemisInfo</C> contains a list of all
# the names of precomputed properties stored in the library.  The <C>i</C>th
# element of the list contains the list of properties that have been
# precomputed for all semigroups in the library of order <C>i</C>.
# <Example><![CDATA[
# gap> PrecomputedSmallSemisInfo[3];
# [ "Is2GeneratedSemigroup", "Is3GeneratedSemigroup", "Is4GeneratedSemigroup",
#   "Is5GeneratedSemigroup", "Is6GeneratedSemigroup", "Is7GeneratedSemigroup",
#   "Is8GeneratedSemigroup", "IsBand", "IsCommutative",
#   "IsCompletelyRegularSemigroup", "IsFullTransformationSemigroupCopy",
#   "IsGroupAsSemigroup", "IsIdempotentGenerated", "IsInverseSemigroup",
#   "IsMonogenicSemigroup", "IsMonoidAsSemigroup", "IsMultSemigroupOfNearRing",
#   "IsMunnSemigroup", "IsRegularSemigroup", "IsSelfDualSemigroup",
#   "IsSemigroupWithoutClosedIdempotents", "IsSimpleSemigroup",
#   "IsSingularSemigroupCopy", "IsZeroSemigroup", "IsZeroSimpleSemigroup" ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
BindGlobal("PrecomputedSmallSemisInfo",
           List([1 .. 8],
                n -> AsSet(Concatenation(Filtered(RecNames(MOREDATA2TO8[n]),
                                                  x -> IsUpperAlphaChar(x[1])),
                                         ["IsBand"]))));
