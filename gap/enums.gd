#############################################################################
##
##  enums.gd                       Smallsemi - a GAP library of semigroups
##  Copyright (C) 2008-2024            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# TODO remove
DeclareGlobalFunction("EmptyIteratorOfSmallSemigroups");

# <#GAPDoc Label="AllSmallSemigroups">
# <ManSection>
# <Func Name="AllSmallSemigroups" Arg="arg"/>
# <Description>
# the number of argument of this function should be odd. The first argument
# <C>arg[1]</C> should be a positive integer, an enumerator of small semigroups
# with <Ref Func="IsEnumeratorOfSmallSemigroups"/>, or an iterator of small
# semigroup with <Ref Func="IsIteratorOfSmallSemigroups"/>.
# <P/>
#
# The even arguments <C>arg[2i]</C>, if present, should be functions, and the
# odd arguments <C>arg[2i+1]</C> should be a value that the preceding function
# can have.  For example, a typical input might be <C>3, IsRegularSemigroup,
# true</C>.  The functions <C>arg[2i]</C> can be user defined or existing &GAP;
# functions.
# <P/>
#
# Please see Section <Ref Sect="enums"/> or Chapter <Ref Chap="examples"/> for
# more details.
# <P/>
#
# If <C>arg[1]</C> is a positive integer, then <C>AllSmallSemigroups</C>
# returns a list of all the small semigroups <C>S</C> in the library with
# <C>Size(S)=arg[1]</C> and <C>arg[2i](S)=arg[2i+1]</C> for all <C>i</C>.
# <P/>
#
# If <C>arg[1]</C> is a list of positive integers, then
# <C>AllSmallSemigroups</C> returns a list of all the small semigroups <C>S</C>
# in the library with <C>Size(S) in arg[1]</C> and <C>arg[2i](S)=arg[2i+1]</C>
# for all <C>i</C>.
# <P/>
#
# If <C>arg[1]</C> is an enumerator or iterator of small semigroups, then
# <C>AllSmallSemigroups</C> returns a list of all the small semigroups <C>S</C>
# in the library with <C>S in arg[1]</C> and <C>arg[2i](S)=arg[2i+1]</C> for
# all <C>i</C>.
#
# <Example><![CDATA[
# gap> AllSmallSemigroups(2);
# [ <small semigroup of size 2>, <small semigroup of size 2>,
#   <small semigroup of size 2>, <small semigroup of size 2> ]
# gap> AllSmallSemigroups([2, 3], IsRegularSemigroup, true,
# > x -> Length(GreensRClasses(x)), 1);
# [ <small semigroup of size 2>, <small semigroup of size 3> ]
# gap> enum := EnumeratorOfSmallSemigroups(8, IsInverseSemigroup, true,
# > IsCommutativeSemigroup, true);;
# gap> AllSmallSemigroups(enum, x -> Length(GreensRClasses(x)), 1);
# [ <small semigroup of size 8>, <small semigroup of size 8>,
#   <small semigroup of size 8> ]
# gap> iter := IteratorOfSmallSemigroups(7, x -> Length(GreensRClasses(x)), 1);;
# gap> AllSmallSemigroups(iter, IsCommutative, true,
# > IsSimpleSemigroup, true);
# [ <small semigroup of size 7> ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareGlobalFunction("AllSmallSemigroups");

# <#GAPDoc Label="EnumeratorOfSmallSemigroups">
# <ManSection>
# <Func Name="EnumeratorOfSmallSemigroups" Arg="arg"/>
# <Description>
# the number of argument of this function should be odd. The first argument
# <C>arg[1]</C> should be a positive integer, an enumerator of small semigroups
# with <Ref Func="IsEnumeratorOfSmallSemigroups"/>, or an iterator of small
# semigroup with <Ref Func="IsIteratorOfSmallSemigroups"/>.
# <P/>
#
# The even arguments <C>arg[2i]</C>, if present, should be functions, and the
# odd arguments <C>arg[2i+1]</C> should be a value that the preceding function
# can have.  For example, a typical input might be <C>3, IsRegularSemigroup,
# true</C>.  The functions <C>arg[2i]</C> can be user defined or existing &GAP;
# functions.
# <P/>
#
# Please see Section <Ref Sect="enums"/> or Chapter <Ref Chap="examples"/> for
# more details.
# <P/>
#
# If <C>arg[1]</C> is a positive integer, then
# <C>EnumeratorOfSmallSemigroups</C> returns an enumerator of all the small
# semigroups <C>S</C> in the library with <C>Size(S)=arg[1]</C> and
# <C>arg[2i](S)=arg[2i+1]</C> for all <C>i</C>.
# <P/>
#
# If <C>arg[1]</C> is a list of positive integers, then
# <C>EnumeratorOfSmallSemigroups</C> returns an enumerator of all the small
# semigroups <C>S</C> in the library with <C>Size(S) in arg[1]</C> and
# <C>arg[2i](S)=arg[2i+1]</C> for all <C>i</C>.
# <P/>
#
# If <C>arg[1]</C> is an enumerator or iterator of small semigroups, then
# <C>EnumeratorOfSmallSemigroups</C> returns an enumerator of all the small
# semigroups <C>S</C> in the library with <C>S in arg[1]</C> and
# <C>arg[2i](S)=arg[2i+1]</C> for all <C>i</C>.
#
# <Example><![CDATA[
# gap> enum := EnumeratorOfSmallSemigroups(7);
# <enumerator of semigroups of size 7>
# gap> EnumeratorOfSmallSemigroups([2, 3], IsRegularSemigroup, true);
# <enumerator of semigroups of sizes [ 2, 3 ]>
# gap> enum := EnumeratorOfSmallSemigroups(8, IsInverseSemigroup, true,
# > IsCommutativeSemigroup, true);
# <enumerator of semigroups of size 8>
# gap> EnumeratorOfSmallSemigroups(enum, IsCommutativeSemigroup, true,
# > IsSimpleSemigroup, false);
# <enumerator of semigroups of size 8>
# gap> iter := IteratorOfSmallSemigroups(8);
# <iterator of semigroups of size 8>
# gap> EnumeratorOfSmallSemigroups(iter, IsCommutativeSemigroup, true,
# > IsSimpleSemigroup, false);
# <enumerator of semigroups of size 8>
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareGlobalFunction("EnumeratorOfSmallSemigroups");

# <#GAPDoc Label="EnumeratorOfSmallSemigroupsByIds">
# <ManSection>
# <Oper Name="EnumeratorOfSmallSemigroupsByIds" Arg="arg"/>
# <Oper Name="EnumeratorOfSmallSemigroupsByIdsNC" Arg="arg"/>
# <Description>
# the argument of this function should be one of the following:
# <List>
#   <Item>
#     a positive integer <A>arg[1]</A> and a set of positive integers less than
#     <Ref Func="NrSmallSemigroups"/> with argument <A>arg[1]</A>. For example,
#     the argument <A>3, [1..10]</A> yields the first 10 semigroups with
#     3 elements.
#   </Item>
#   <Item>
#     a set of positive integers <A>arg[1]</A> and a list of sets of positive
#     integers <A>arg[2]</A> such that <A>x</A> is at most <Ref
#     Func="NrSmallSemigroups"/> with argument <A>arg[1][i]</A> for all
#     <A>x</A> in <A>arg[2][i]</A>. For example, <A>[2,3], [[1..2],[1..10]]</A>
#     yields the first 2 semigroups of size 2, and the first 10 semigroups of
#     size 3.
#   </Item>
#   <Item>
#     a list of id numbers, for example, <A>[[7,1], [6,1], [5,1]]</A>.
#   </Item>
# </List>
# The no check version does not check that the arguments are valid and may
# return unpredictable results.
#
# <Example><![CDATA[
# gap> enum := EnumeratorOfSmallSemigroupsByIds([[7, 1], [6, 1], [5, 1]]);
# <enumerator of semigroups of sizes [ 5, 6, 7 ]>
# gap> enum := EnumeratorOfSmallSemigroupsByIds(7, [1 .. 1000]);
# <enumerator of semigroups of size 7>
# gap> enum := EnumeratorOfSmallSemigroupsByIds([2, 3], [[1 .. 2], [1 .. 10]]);
# <enumerator of semigroups of sizes [ 2, 3 ]>
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareOperation("EnumeratorOfSmallSemigroupsByIds",
                 [IsCyclotomicCollection, IsCyclotomicCollColl]);
DeclareOperation("EnumeratorOfSmallSemigroupsByIds",
                 [IsPosInt, IsCyclotomicCollection]);
DeclareOperation("EnumeratorOfSmallSemigroupsByIds",
                 [IsList]);

DeclareOperation("EnumeratorOfSmallSemigroupsByIdsNC",
                 [IsCyclotomicCollection, IsCyclotomicCollColl]);
DeclareOperation("EnumeratorOfSmallSemigroupsByIdsNC",
                 [IsPosInt, IsCyclotomicCollection]);

##  TODO document
DeclareGlobalFunction("EnumeratorOfSmallSemigroupsByDiagonals");

# <#GAPDoc Label="IdsOfSmallSemigroups">
# <ManSection>
# <Func Name="IdsOfSmallSemigroups" Arg="arg"/>
# <Description>
# the number of argument of this function should be odd. The first argument
# <C>arg[1]</C> should be a positive integer, an enumerator of small semigroups
# with <Ref Func="IsEnumeratorOfSmallSemigroups"/>, or an iterator of small
# semigroup with <Ref Func="IsIteratorOfSmallSemigroups"/>.
# <P/>
#
# The even arguments <C>arg[2i]</C>, if present, should be functions, and the
# odd arguments <C>arg[2i+1]</C> should be a value that the preceding function
# can have.  For example, a typical input might be <C>3, IsRegularSemigroup,
# true</C>.  The functions <C>arg[2i]</C> can be user defined or existing &GAP;
# functions.
# <P/>
#
# Please see Section <Ref Sect="enums"/> or Chapter <Ref Chap="examples"/> for
# more details.
# <P/>
#
# If <C>arg[1]</C> is a positive integer, then <C>IdsOfSmallSemigroups</C>
# returns a list of the id numbers of all the small semigroups <C>S</C> in the
# library with <C>Size(S)=arg[1]</C> and <C>arg[2i](S)=arg[2i+1]</C> for all
# <C>i</C>.
# <P/>
#
# If <C>arg[1]</C> is a list of positive integers, then
# <C>IdsOfSmallSemigroups</C> returns a list of the id numbers of all the small
# semigroups <C>S</C> in the library with <C>Size(S) in arg[1]</C> and
# <C>arg[2i](S)=arg[2i+1]</C> for all <C>i</C>.
# <P/>
#
# If <C>arg[1]</C> is an enumerator or iterator of small semigroups, then
# <C>IdsOfSmallSemigroups</C> returns a list of the id numbers of all the small
# semigroups <C>S</C> in the library with <C>S in arg[1]</C> and
# <C>arg[2i](S)=arg[2i+1]</C> for all <C>i</C>.
#
# <Example><![CDATA[
# gap> enum := EnumeratorOfSmallSemigroups(5,
# > x -> Length(GreensRClasses(x)), 1);;
# gap> IdsOfSmallSemigroups(enum, IsCommutativeSemigroup, true,
# > IsSimpleSemigroup, false);
# [  ]
# gap> IdsOfSmallSemigroups([2, 3], IsRegularSemigroup, true);
# [ [ 2, 2 ], [ 2, 3 ], [ 2, 4 ], [ 3, 10 ], [ 3, 11 ], [ 3, 12 ], [ 3, 13 ],
#   [ 3, 14 ], [ 3, 15 ], [ 3, 16 ], [ 3, 17 ], [ 3, 18 ] ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareGlobalFunction("IdsOfSmallSemigroups");

# <#GAPDoc Label="IsEnumeratorOfSmallSemigroups">
# <ManSection>
# <Prop Name="IsEnumeratorOfSmallSemigroups" Arg="enum"/>
# <Description>
# returns <C>true</C> if <A>enum</A> is an enumerator of small semigroups
# created using <Ref Func="EnumeratorOfSmallSemigroups"/>, <Ref
# Func="EnumeratorOfSmallSemigroupsByIds"/>.
# <Example><![CDATA[
# gap> enum := EnumeratorOfSmallSemigroupsByIds([[2, 1], [3, 1], [4, 1]]);;
# gap> IsEnumeratorOfSmallSemigroups(enum);
# true
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareCategory("IsEnumeratorOfSmallSemigroups",
                IsEnumeratorByFunctionsRep
                and IsEnumeratorByFunctions
                and IsSmallSemigroupEltCollColl
                and IsFinite);

# <#GAPDoc Label="IsIdSmallSemigroup">
# <ManSection>
# <Prop Name="IsIdSmallSemigroup" Arg="arg"/>
# <Description>
# return <C>true</C> if the <A>arg</A> is the id of a small semigroup or
# <A>[arg[1], arg[2]]</A> is the id of a small semigroup.
# <Example><![CDATA[
# gap> IsIdSmallSemigroup(8, 1);
# true
# gap> IsIdSmallSemigroup([1, 2]);
# false
# gap> IsIdSmallSemigroup([3, 18]);
# true
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareGlobalFunction("IsIdSmallSemigroup");

# <#GAPDoc Label="IsIteratorOfSmallSemigroups">
# <ManSection>
# <Prop Name="IsIteratorOfSmallSemigroups" Arg="iter"/>
# <Description>
# returns <C>true</C> if <A>iter</A> is an iterator of small semigroups created
# using <Ref Func="IteratorOfSmallSemigroups"/>.
# <Example><![CDATA[
# gap> iter := IteratorOfSmallSemigroups(8);;
# gap> IsIteratorOfSmallSemigroups(iter);
# true
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareCategory("IsIteratorOfSmallSemigroups",
                IsIteratorByFunctionsRep
                and IsIteratorByFunctions
                and IsSmallSemigroupEltCollColl
                and IsFinite);

# <#GAPDoc Label="IteratorOfSmallSemigroups">
# <ManSection>
# <Func Name="IteratorOfSmallSemigroups" Arg="arg"/>
# <Description>
# the number of argument of this function should be odd. The first argument
# <C>arg[1]</C> should be a positive integer, an enumerator of small semigroups
# with <Ref Func="IsEnumeratorOfSmallSemigroups"/>, or an iterator of small
# semigroup with <Ref Func="IsIteratorOfSmallSemigroups"/>.
# <P/>
#
# The even arguments <C>arg[2i]</C>, if present, should be functions, and the
# odd arguments <C>arg[2i+1]</C> should be a value that the preceding function
# can have.  For example, a typical input might be <C>3, IsRegularSemigroup,
# true</C>.  The functions <C>arg[2i]</C> can be user defined or existing &GAP;
# functions.
# <P/>
#
# Please see Section <Ref Sect="enums"/> or Chapter <Ref Chap="examples"/> for
# more details.
# <P/>
#
# If <C>arg[1]</C> is a positive integer, then <C>IteratorOfSmallSemigroups</C>
# returns an iterator of all the small semigroups <C>S</C> in the library with
# <C>Size(S)=arg[1]</C> and <C>arg[2i](S)=arg[2i+1]</C> for all <C>i</C>.
# <P/>
#
# If <C>arg[1]</C> is a list of positive integers, then
# <C>IteratorOfSmallSemigroups</C> returns an iterator of all the small
# semigroups <C>S</C> in the library with <C>Size(S) in arg[1]</C> and
# <C>arg[2i](S)=arg[2i+1]</C> for all <C>i</C>.
# <P/>
#
# If <C>arg[1]</C> is an enumerator or iterator of small semigroups, then
# <C>IteratorOfSmallSemigroups</C> returns an iterator of all the small
# semigroups <C>S</C> in the library with <C>S in arg[1]</C> and
# <C>arg[2i](S)=arg[2i+1]</C> for all <C>i</C>.
#
# <Example><![CDATA[
# gap> iter := IteratorOfSmallSemigroups(8);
# <iterator of semigroups of size 8>
# gap> NextIterator(iter);
# <small semigroup of size 8>
# gap> IsDoneIterator(iter);
# false
# gap> iter := IteratorOfSmallSemigroups([2, 3], IsRegularSemigroup, true,
# > x -> Length(Idempotents(x)) = 1, true);
# <iterator of semigroups of sizes [ 2, 3 ]>
# gap> NextIterator(iter);
# <small semigroup of size 2>
# gap> NextIterator(iter);
# <small semigroup of size 3>
# gap> NextIterator(iter);
# fail
# gap> enum := EnumeratorOfSmallSemigroups(5, x -> Length(Idempotents(x)) = 1,
# > true);
# <enumerator of semigroups of size 5>
# gap> iter := IteratorOfSmallSemigroups(enum,
# > x -> Length(GreensRClasses(x)) = 2, true);
# <iterator of semigroups of size 5>
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareGlobalFunction("IteratorOfSmallSemigroups");

# <#GAPDoc Label="NrSmallSemigroups">
# <ManSection>
# <Func Name="NrSmallSemigroups" Arg="arg"/>
# <Description>
# the number of argument of this function should be odd. The first argument
# <C>arg[1]</C> should be a positive integer, an enumerator of small semigroups
# with <Ref Func="IsEnumeratorOfSmallSemigroups"/>, or an iterator of small
# semigroup with <Ref Func="IsIteratorOfSmallSemigroups"/>.
# <P/>
#
# The even arguments <C>arg[2i]</C>, if present, should be functions, and the
# odd arguments <C>arg[2i+1]</C> should be a value that the preceding function
# can have.  For example, a typical input might be <C>3, IsRegularSemigroup,
# true</C>.  The functions <C>arg[2i]</C> can be user defined or existing &GAP;
# functions.
# <P/>
#
# Please see Section <Ref Sect="enums"/> or Chapter <Ref Chap="examples"/> for
# more details.
# <P/>
#
# If <C>arg[1]</C> is a positive integer, then <C>NrSmallSemigroups</C> returns
# the number of small semigroups <C>S</C> in the library with
# <C>Size(S)=arg[1]</C> and <C>arg[2i](S)=arg[2i+1]</C> for all <C>i</C>.
# <P/>
#
# If <C>arg[1]</C> is a list of positive integers, then
# <C>NrSmallSemigroups</C> returns the number of small semigroups <C>S</C> in
# the library with <C>Size(S) in arg[1]</C> and <C>arg[2i](S)=arg[2i+1]</C> for
# all <C>i</C>.
# <P/>
#
# If <C>arg[1]</C> is an enumerator or iterator of small semigroups, then
# <C>NrSmallSemigroups</C> returns the number of small semigroups <C>S</C> in
# the library with <C>S in arg[1]</C> and <C>arg[2i](S)=arg[2i+1]</C> for all
# <C>i</C>.
#
# <Example><![CDATA[
# gap> List([1 .. 8], NrSmallSemigroups);
# [ 1, 4, 18, 126, 1160, 15973, 836021, 1843120128 ]
# gap> NrSmallSemigroups(8, IsCommutative, true, IsInverseSemigroup, true);
# 4443
# gap> NrSmallSemigroups([1 .. 8], IsCliffordSemigroup, true);
# 5610
# gap> NrSmallSemigroups(8, IsRegularSemigroup, true,
# > IsCompletelyRegularSemigroup, false);
# 1164
# gap> NrSmallSemigroups(5, NilpotencyDegree, 3);
# 84
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareGlobalFunction("NrSmallSemigroups");

# <#GAPDoc Label="OneSmallSemigroup">
# <ManSection>
# <Func Name="OneSmallSemigroup" Arg="arg"/>
# <Description>
# the number of argument of this function should be odd. The first argument
# <C>arg[1]</C> should be a positive integer, an enumerator of small semigroups
# with <Ref Func="IsEnumeratorOfSmallSemigroups"/>, or an iterator of small
# semigroup with <Ref Func="IsIteratorOfSmallSemigroups"/>.
# <P/>
#
# The even arguments <C>arg[2i]</C>, if present, should be functions, and the
# odd arguments <C>arg[2i+1]</C> should be a value that the preceding function
# can have.  For example, a typical input might be <C>3, IsRegularSemigroup,
# true</C>.  The functions <C>arg[2i]</C> can be user defined or existing &GAP;
# functions.
# <P/>
#
# Please see Section <Ref Sect="enums"/> or Chapter <Ref Chap="examples"/> for
# more details.
# <P/>
#
# If <C>arg[1]</C> is a positive integer, then <C>OneSmallSemigroup</C> returns
# the first small semigroup <C>S</C> in the library with <C>Size(S)=arg[1]</C>
# and <C>arg[2i](S)=arg[2i+1]</C> for all <C>i</C>.
# <P/>
#
# If <C>arg[1]</C> is a list of positive integers, then
# <C>OneSmallSemigroup</C> returns the first small semigroup <C>S</C> in the
# library with <C>Size(S) in arg[1]</C> and <C>arg[2i](S)=arg[2i+1]</C> for all
# <C>i</C>.
# <P/>
#
# If <C>arg[1]</C> is an enumerator or iterator of small semigroups, then
# <C>OneSmallSemigroup</C> returns the first small semigroup <C>S</C> in the
# library with <C>S in arg[1]</C> and <C>arg[2i](S)=arg[2i+1]</C> for all
# <C>i</C>.
#
# <Example><![CDATA[
# gap> OneSmallSemigroup(8, IsCommutative, true, IsInverseSemigroup, true);
# <small semigroup of size 8>
# gap> OneSmallSemigroup([1 .. 8], IsCliffordSemigroup, true);
# <small semigroup of size 1>
# gap> iter := IteratorOfSmallSemigroups(8, IsCommutative, false);
# <iterator of semigroups of size 8>
# gap> OneSmallSemigroup(iter);
# <small semigroup of size 8>
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareGlobalFunction("OneSmallSemigroup");

# <#GAPDoc Label="PositionsOfSmallSemigroups">
# <ManSection>
# <Func Name="PositionsOfSmallSemigroups" Arg="arg"/>
# <Description>
# the number of argument of this function should be odd. The first argument
# <C>arg[1]</C> should be a positive integer or an enumerator with <Ref
# Func="IsEnumeratorOfSmallSemigroups"/>, the even arguments <C>arg[2i]</C>, if
# present, should be functions, and the odd arguments <C>arg[2i+1]</C> should
# be a value that the preceding function can have.  For example, a typical
# input might be <C>3, IsRegularSemigroup, true</C>.  The functions
# <C>arg[2i]</C> can be user defined or existing &GAP; functions. The argument
# can be a list <C>arg</C> with the same components as given above.
# <P/>
#
# The function returns a list of the second components of the <Ref
# Attr="IdSmallSemigroup" /> of all the small semigroups <C>S</C> in the
# library satisfying <C>Size(S)</C> in <C>arg[1]</C> or <C>Size(S)</C> in
# <C>SizesOfSmallSemigroupsIn(arg[1])</C> and <C>arg[2i](S)=arg[2i+1]</C> for
# all <C>i</C> partitioned by size of the semigroups.
#
# <Example><![CDATA[
# gap> PositionsOfSmallSemigroups(3);
# [ [ 1 .. 18 ] ]
# gap> PositionsOfSmallSemigroups(3, IsRegularSemigroup, false);
# [ [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ] ]
# gap> enum := EnumeratorOfSmallSemigroups(3, IsRegularSemigroup, false);;
# gap> PositionsOfSmallSemigroups(enum);
# [ [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ] ]
# gap> PositionsOfSmallSemigroups([1 .. 4], IsBand, true);
# [ [ 1 ], [ 3, 4 ], [ 12 .. 17 ], [ 98 .. 123 ] ]
# gap> PositionsOfSmallSemigroups(enum, Is1IdempotentSemigroup, true,
# > Is2GeneratedSemigroup, true, IsCliffordSemigroup, false);
# [ [ 1, 2 ] ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareGlobalFunction("PositionsOfSmallSemigroups");

# <#GAPDoc Label="RandomSmallSemigroup">
# <ManSection>
# <Func Name="RandomSmallSemigroup" Arg="arg"/>
# <Description>
# the number of argument of this function should be odd. The first argument
# <C>arg[1]</C> should be a positive integer, an enumerator of small semigroups
# with <Ref Func="IsEnumeratorOfSmallSemigroups"/>, or an iterator of small
# semigroup with <Ref Func="IsIteratorOfSmallSemigroups"/>.
# <P/>
#
# The even arguments <C>arg[2i]</C>, if present, should be functions, and the
# odd arguments <C>arg[2i+1]</C> should be a value that the preceding function
# can have. For example, a typical input might be <C>3, IsRegularSemigroup,
# true</C>. The functions <C>arg[2i]</C> can be user defined or existing &GAP;
# functions.
# <P/>
#
# Please see Section <Ref Sect="enums"/> or Chapter <Ref Chap="examples"/> for
# more details.
# <P/>
#
# If <C>arg[1]</C> is a positive integer, then <C>RandomSmallSemigroup</C>
# returns a random small semigroup <C>S</C> in the library with
# <C>Size(S)=arg[1]</C> and <C>arg[2i](S)=arg[2i+1]</C> for all <C>i</C>.
# <P/>
#
# If <C>arg[1]</C> is a list of positive integers, then
# <C>RandomSmallSemigroup</C> returns the a random small semigroup <C>S</C> in
# the library with <C>Size(S) in arg[1]</C> and <C>arg[2i](S)=arg[2i+1]</C> for
# all <C>i</C>.
# <P/>
#
# If <C>arg[1]</C> is an enumerator or iterator of small semigroups, then
# <C>RandomSmallSemigroup</C> returns the a random small semigroup <C>S</C> in
# the library with <C>S in arg[1]</C> and <C>arg[2i](S)=arg[2i+1]</C> for all
# <C>i</C>.
#
# <Example><![CDATA[
# gap> RandomSmallSemigroup(8, IsCommutative, true,
# > IsInverseSemigroup, true);
# <small semigroup of size 8>
# gap> RandomSmallSemigroup([1 .. 8], IsCliffordSemigroup, true);
# <small semigroup of size 8>
# gap> iter := IteratorOfSmallSemigroups([1 .. 7]);
# <iterator of semigroups of sizes [ 1 .. 7 ]>
# gap> RandomSmallSemigroup(iter);
# <small semigroup of size 7>
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareGlobalFunction("RandomSmallSemigroup");

# <#GAPDoc Label="SizesOfSmallSemigroupsIn">
# <ManSection>
# <Func Name="SizesOfSmallSemigroupsIn" Arg="enum"/>
# <Description>
# returns the sizes of the semigroups in the enumerator of small semigroups
# <A>enum</A>.
#
# <Example><![CDATA[
# gap> enum := EnumeratorOfSmallSemigroups([2 .. 4], IsSimpleSemigroup, false);
# <enumerator of semigroups of sizes [ 2, 3, 4 ]>
# gap> SizesOfSmallSemigroupsIn(enum);
# [ 2, 3, 4 ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareAttribute("SizesOfSmallSemigroupsIn", IsEnumeratorOfSmallSemigroups);
# <#GAPDoc Label="ArgumentsUsedToCreate">
# <ManSection>
# <Func Name="ArgumentsUsedToCreate" Arg="enum"/>
# <Description>
# returns a list of the functions and their values that were used to create the
# enumerator of small semigroups <A>enum</A>.
# <Example><![CDATA[
# gap> enum := EnumeratorOfSmallSemigroups([2 .. 4], IsSimpleSemigroup, false,
# > IsRegularSemigroup, true);;
# gap> ArgumentsUsedToCreate(enum);
# [ <Property "IsRegularSemigroup">, true, <Property "IsSimpleSemigroup">,
#   false ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareAttribute("ArgumentsUsedToCreate", IsEnumeratorOfSmallSemigroups);
# <#GAPDoc Label="PositionsOfSmallSemigroupsIn">
# <ManSection>
# <Func Name="PositionsOfSmallSemigroupsIn" Arg="enum"/>
# <Description>
# returns the second components of the id numbers of the small semigroups in
# the enumerator of small semigroups <A>enum</A> in a list partitioned
# according the size of the semigroup.  The same value is returned by using
# <Ref Func="PositionsOfSmallSemigroups"/>.
# <Example><![CDATA[
# gap> enum := EnumeratorOfSmallSemigroups([2 .. 4], IsSimpleSemigroup, true);;
# gap> PositionsOfSmallSemigroupsIn
# > (enum);
# [ [ 2, 4 ], [ 17, 18 ], [ 7, 37, 52, 122, 123 ] ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareAttribute("PositionsOfSmallSemigroupsIn", IsEnumeratorOfSmallSemigroups);
DeclareAttribute("SizesOfSmallSemigroupsIn", IsIteratorOfSmallSemigroups);
DeclareAttribute("ArgumentsUsedToCreate", IsIteratorOfSmallSemigroups);
DeclareAttribute("PositionsOfSmallSemigroupsIn", IsIteratorOfSmallSemigroups);

# <#GAPDoc Label="UpToIsomorphism">
# <ManSection>
# <Oper Name="UpToIsomorphism" Arg="sgrps"/>
# <Description>
# takes a list <A>sgrps</A> of non-equivalent semigroups from the library as
# input and returns a list of non-isomorphic semigroups containing  an
# isomorphic semigroup and an anti-isomorphic semigroup for every semigroup in
# <A>sgrps</A>.
#
# <Example><![CDATA[
# gap> UpToIsomorphism([SmallSemigroup(5, 126), SmallSemigroup(6, 2)]);
# [ <small semigroup of size 5>, <small semigroup of size 6> ]
# gap> UpToIsomorphism([SmallSemigroup(5, 126), SmallSemigroup(5, 3)]);
# [ <small semigroup of size 5>, <small semigroup of size 5>,
#   <semigroup of size 5, with 5 generators> ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareOperation("UpToIsomorphism", [IsList]);
DeclareOperation("UpToIsomorphism", [IsSmallSemigroup]);

###########################################################################
# Internal Functions
###########################################################################
# undocumented: required by iterators.

DeclareGlobalFunction("SHALLOWCOPYITERATORSMALLSEMI");
