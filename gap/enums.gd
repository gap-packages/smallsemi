#############################################################################
##
##  enums.gd                       Smallsemi - a GAP library of semigroups
##  Copyright (C) 2008-2024            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

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
# odd arguments <C>arg[2i+1]</C> should be a value that the preceeding function
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
# gap> AllSmallSemigroups([2,3], IsRegularSemigroup, true,
# > x-> Length(GreensRClasses(x)), 1);
# [ <small semigroup of size 2>, <small semigroup of size 3> ]
# gap> enum:=EnumeratorOfSmallSemigroups(8, IsInverseSemigroup, true,
# > IsCommutativeSemigroup, true);;
# gap> AllSmallSemigroups(enum, x-> Length(GreensRClasses(x)), 1);
# [ <small semigroup of size 8>, <small semigroup of size 8>,
#   <small semigroup of size 8> ]
# gap> iter:=IteratorOfSmallSemigroups(7, x-> Length(GreensRClasses(x)), 1);;
# gap> AllSmallSemigroups(iter, IsCommutative, true,
# > IsSimpleSemigroup, true);
# [ <small semigroup of size 7> ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareGlobalFunction("AllSmallSemigroups");

#  <#GAPDoc Label="EmptyEnumeratorOfSmallSemigroups">
#  <ManSection>
#  <Func Name="EmptyEnumeratorOfSmallSemigroups" Arg=""/>
#  <Description>
#  the argument should be empty and the returned enumerator is too.
#
#  <Example><![CDATA[
#  gap> EmptyEnumeratorOfSmallSemigroups();
#  <empty enumerator of semigroups>
#  ]]></Example>
#  </Description>
#  </ManSection>
#  <#/GAPDoc>
DeclareGlobalFunction("EmptyEnumeratorOfSmallSemigroups");

#  <#GAPDoc Label="EmptyIteratorOfSmallSemigroups">
#  <ManSection>
#  <Func Name="EmptyIteratorOfSmallSemigroups" Arg=""/>
#  <Description>
#  the argument should be empty and the returned iterator is too.
#
#  <Example><![CDATA[
#  gap> EmptyIteratorOfSmallSemigroups();
#  <empty iterator of semigroups>
#  ]]></Example>
#  </Description>
#  </ManSection>
#  <#/GAPDoc>
DeclareGlobalFunction("EmptyIteratorOfSmallSemigroups");

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
# odd arguments <C>arg[2i+1]</C> should be a value that the preceeding function
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
# gap> enum:=EnumeratorOfSmallSemigroups(7);
# <enumerator of semigroups of size 7>
# gap> EnumeratorOfSmallSemigroups([2,3], IsRegularSemigroup, true);
# <enumerator of semigroups of sizes [ 2, 3 ]>
# gap> enum:=EnumeratorOfSmallSemigroups(8, IsInverseSemigroup, true,
# > IsCommutativeSemigroup, true);
# <enumerator of semigroups of size 8>
# gap> EnumeratorOfSmallSemigroups(enum, IsCommutativeSemigroup, true,
# > IsSimpleSemigroup, false);
# <enumerator of semigroups of size 8>
# gap> iter:=IteratorOfSmallSemigroups(8);
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
# gap> enum:=EnumeratorOfSmallSemigroupsByIds([[7,1],[6,1],[5,1]]);
# <enumerator of semigroups of sizes [ 5, 6, 7 ]>
# gap> enum:=EnumeratorOfSmallSemigroupsByIds(7, [1..1000]);
# <enumerator of semigroups of size 7>
# gap> enum:=EnumeratorOfSmallSemigroupsByIds([2,3], [[1..2],[1..10]]);
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

# <#GAPDoc Label="EnumeratorSortedOfSmallSemigroups">
# <ManSection>
# <Func Name="EnumeratorSortedOfSmallSemigroups" Arg="arg"/>
# <Description>
# accepts the same arguments and returns the same values as
# <Ref Func="EnumeratorOfSmallSemigroups"/>.
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareGlobalFunction("EnumeratorSortedOfSmallSemigroups");

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
# odd arguments <C>arg[2i+1]</C> should be a value that the preceeding function
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
# gap>  enum:=EnumeratorOfSmallSemigroups(5, x-> Length(GreensRClasses(x)), 1);;
# gap> IdsOfSmallSemigroups(enum, IsCommutativeSemigroup, true,
# > IsSimpleSemigroup, false);
# [  ]
# gap> IdsOfSmallSemigroups([2,3], IsRegularSemigroup, true);
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
# gap> enum:=EnumeratorOfSmallSemigroupsByIds([[2,1], [3,1], [4,1]]);;
# gap> IsEnumeratorOfSmallSemigroups(enum);
# true
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareProperty("IsEnumeratorOfSmallSemigroups", IsObject);

# <#GAPDoc Label="FuncsOfSmallSemisInEnum">
# <ManSection>
# <Func Name="FuncsOfSmallSemisInEnum" Arg="enum"/>
# <Description>
# returns a list of the functions and their values that were used to create the
# enumerator of small semigroups <A>enum</A>. If you only want the names of
# these functions use <Ref Func="NamesFuncsSmallSemisInEnum"/>.
# <Example><![CDATA[
# gap> enum:=EnumeratorOfSmallSemigroups([2..4], IsSimpleSemigroup, false,
# > IsRegularSemigroup, true);;
# gap> FuncsOfSmallSemisInEnum(enum);
# [ <Property "IsRegularSemigroup">, true, <Property "IsSimpleSemigroup">,
#   false ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>

DeclareGlobalFunction("FuncsOfSmallSemisInEnum");

# <#GAPDoc Label="IsIdSmallSemigroup">
# <ManSection>
# <Prop Name="IsIdSmallSemigroup" Arg="arg"/>
# <Description>
# return <C>true</C> if the <A>arg</A> is the id of a small semigroup or
# <A>[arg[1], arg[2]]</A> is the id of a small semigroup.
# <Example><![CDATA[
# gap> IsIdSmallSemigroup(8,1);
# true
# gap> IsIdSmallSemigroup([1,2]);
# false
# gap> IsIdSmallSemigroup([3,18]);
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
# gap> iter:=IteratorOfSmallSemigroups(8);;
# gap> IsIteratorOfSmallSemigroups(iter);
# true
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>

DeclareProperty("IsIteratorOfSmallSemigroups", IsIteratorByFunctions);

# <#GAPDoc Label="FuncsOfSmallSemisInIter">
# <ManSection>
# <Func Name="FuncsOfSmallSemisInIter" Arg="iter"/>
# <Description>
# returns a list of the functions and their values that were used to create the
# iterator of small semigroups <A>iter</A>. If you only want the names of these
# functions use <Ref Func="NamesFuncsSmallSemisInIter"/>.
# <Example><![CDATA[
# gap> enum:=IteratorOfSmallSemigroups([2..4], IsSimpleSemigroup, false,
# > IsRegularSemigroup, true);;
# gap> FuncsOfSmallSemisInIter(enum);
# [ <Property "IsRegularSemigroup">, true, <Property "IsSimpleSemigroup">,
#   false ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>

DeclareGlobalFunction("FuncsOfSmallSemisInIter");

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
# odd arguments <C>arg[2i+1]</C> should be a value that the preceeding function
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
# gap> iter:=IteratorOfSmallSemigroups(8);
# <iterator of semigroups of size 8>
# gap> NextIterator(iter);
# <small semigroup of size 8>
# gap> IsDoneIterator(iter);
# false
# gap> iter:=IteratorOfSmallSemigroups([2,3], IsRegularSemigroup, true,
# > x-> Length(Idempotents(x))=1, true);
# <iterator of semigroups of sizes [ 2, 3 ]>
# gap> NextIterator(iter);
# <small semigroup of size 2>
# gap> NextIterator(iter);
# <small semigroup of size 3>
# gap> NextIterator(iter);
# fail
# gap> enum:=EnumeratorOfSmallSemigroups(5, x-> Length(Idempotents(x))=1, true);
# <enumerator of semigroups of size 5>
# gap> iter:=IteratorOfSmallSemigroups(enum,
# > x-> Length(GreensRClasses(x))=2, true);
# <iterator of semigroups of size 5>
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareGlobalFunction("IteratorOfSmallSemigroups");

# <#GAPDoc Label="NamesFuncsSmallSemisInEnum">
# <ManSection>
# <Func Name="NamesFuncsSmallSemisInEnum" Arg="enum"/>
# <Description>
# returns a list of the names of functions and their values that were used to
# create the enumerator of small semigroups <A>enum</A>. If you only want the
# actual functions themselves then use <Ref Func="FuncsOfSmallSemisInEnum"/>.
# <Example><![CDATA[
# gap> enum:=EnumeratorOfSmallSemigroups([2..4], IsSimpleSemigroup, false,
# > IsRegularSemigroup, true);;
# gap> NamesFuncsSmallSemisInEnum(enum);
# [ "IsRegularSemigroup", true, "IsSimpleSemigroup", false ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareGlobalFunction("NamesFuncsSmallSemisInEnum");

# <#GAPDoc Label="NamesFuncsSmallSemisInIter">
# <ManSection>
# <Attr Name="NamesFuncsSmallSemisInIter" Arg="iter"/>
# <Description>
# returns a list of the names of functions and their values that were used to
# create the iterator of small semigroups <A>iter</A>. If you only want the
# actual functions themselves then use <Ref Func="FuncsOfSmallSemisInIter"/>.
# <Example><![CDATA[
# gap> iter:=IteratorOfSmallSemigroups([2..4], IsSimpleSemigroup, false,
# > IsRegularSemigroup, true);;
# gap> NamesFuncsSmallSemisInIter(iter);
# [ "IsRegularSemigroup", true, "IsSimpleSemigroup", false ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareGlobalFunction("NamesFuncsSmallSemisInIter");

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
# odd arguments <C>arg[2i+1]</C> should be a value that the preceeding function
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
# gap> List([1..8], NrSmallSemigroups);
# [ 1, 4, 18, 126, 1160, 15973, 836021, 1843120128 ]
# gap> NrSmallSemigroups(8, IsCommutative, true, IsInverseSemigroup, true);
# 4443
# gap> NrSmallSemigroups([1..8], IsCliffordSemigroup, true);
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
# odd arguments <C>arg[2i+1]</C> should be a value that the preceeding function
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
# gap> OneSmallSemigroup([1..8], IsCliffordSemigroup, true);
# <small semigroup of size 1>
# gap> iter:=IteratorOfSmallSemigroups(8, IsCommutative, false);
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
# be a value that the preceeding function can have.  For example, a typical
# input might be <C>3, IsRegularSemigroup, true</C>.  The functions
# <C>arg[2i]</C> can be user defined or existing &GAP; functions. The argument
# can be a list <C>arg</C> with the same components as given above.
# <P/>
#
# The function returns a list of the second components of the <Ref
# Attr="IdSmallSemigroup" /> of all the small semigroups <C>S</C> in the
# library satisfying <C>Size(S)</C> in <C>arg[1]</C> or <C>Size(S)</C> in
# <C>SizesOfSmallSemisInEnum(arg[1])</C> and <C>arg[2i](S)=arg[2i+1]</C> for
# all <C>i</C> partitioned by size of the semigroups.
#
# <Example><![CDATA[
# gap> PositionsOfSmallSemigroups(3);
# [ [ 1 .. 18 ] ]
# gap> PositionsOfSmallSemigroups(3, IsRegularSemigroup, false);
# [ [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ] ]
# gap> enum:=EnumeratorOfSmallSemigroups(3, IsRegularSemigroup, false);;
# gap> PositionsOfSmallSemigroups(enum);
# [ [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ] ]
# gap> PositionsOfSmallSemigroups([1..4], IsBand, true);
# [ [ 1 ], [ 3, 4 ], [ 12 .. 17 ], [ 98 .. 123 ] ]
# gap> PositionsOfSmallSemigroups(enum, Is1IdempotentSemigroup, true,
# > Is2GeneratedSemigroup, true, IsCliffordSemigroup, false);
# [ [ 1, 2 ] ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareGlobalFunction("PositionsOfSmallSemigroups");

# <#GAPDoc Label="PositionsOfSmallSemisInEnum">
# <ManSection>
# <Func Name="PositionsOfSmallSemisInEnum" Arg="enum"/>
# <Description>
# returns the second components of the id numbers of the small semigroups in
# the enumerator of small semigroups <A>enum</A> in a list partitioned
# according the size of the semigroup.  The same value is returned by using
# <Ref Func="PositionsOfSmallSemigroups"/>.
# <Example><![CDATA[
# gap> enum := EnumeratorOfSmallSemigroups([2..4],IsSimpleSemigroup,true);;
# gap> PositionsOfSmallSemisInEnum
# > (enum);
# [ [ 2, 4 ], [ 17, 18 ], [ 7, 37, 52, 122, 123 ] ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareGlobalFunction("PositionsOfSmallSemisInEnum");

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
# odd arguments <C>arg[2i+1]</C> should be a value that the preceeding function
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
# gap> RandomSmallSemigroup([1..8], IsCliffordSemigroup, true);
# <small semigroup of size 8>
# gap> iter:=IteratorOfSmallSemigroups([1..7]);
# <iterator of semigroups of sizes [ 1 .. 7 ]>
# gap> RandomSmallSemigroup(iter);
# <small semigroup of size 7>
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareGlobalFunction("RandomSmallSemigroup");

# <#GAPDoc Label="SizesOfSmallSemisInEnum">
# <ManSection>
# <Func Name="SizesOfSmallSemisInEnum" Arg="enum"/>
# <Description>
# returns the sizes of the semigroups in the enumerator of small semigroups
# <A>enum</A>.
#
# <Example><![CDATA[
# gap> enum:=EnumeratorOfSmallSemigroups([2..4], IsSimpleSemigroup, false);
# <enumerator of semigroups of sizes [ 2, 3, 4 ]>
# gap> SizesOfSmallSemisInEnum(enum);
# [ 2, 3, 4 ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareGlobalFunction("SizesOfSmallSemisInEnum");

# <#GAPDoc Label="SizesOfSmallSemisInIter">
# <ManSection>
# <Func Name="SizesOfSmallSemisInIter" Arg="iter"/>
# <Description>
# returns the sizes of the semigroups in the iterator <A>iter</A> of small
# semigroups.
#
# <Example><![CDATA[
# gap> iter:=IteratorOfSmallSemigroups(7, IsCommutative, false);
# <iterator of semigroups of size 7>
# gap> SizesOfSmallSemisInIter(iter);
# [ 7 ]
# ]]></Example>
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareGlobalFunction("SizesOfSmallSemisInIter");

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
# gap> UpToIsomorphism([SmallSemigroup(5,126),SmallSemigroup(6,2)]);
# [ <small semigroup of size 5>, <small semigroup of size 6> ]
# gap> UpToIsomorphism([SmallSemigroup(5,126),SmallSemigroup(5,3)]);
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

# <#GAPDoc Label="SMALLSEMI_CREATE_ENUM">
# <ManSection>
# <Func Name="SMALLSEMI_CREATE_ENUM" Arg="source, positions, names"/>
# <Description>
# <List>
#   <Item>
#     <A>source</A> should be a positive integer between 1 and 8, a list of
#     positive integers between 1 and 8, an enumerator of small semigroups, or an
#     iterator of small semigroups;
#   </Item>
#   <Item>
#     <A>positions</A> should be the list such that <A>positions[i]</A> is the
#     list of second components of id numbers of small semigroups in the
#     enumerator being created;
#   </Item>
#   <Item>
#     <A>names</A> is the list of functions and values being used to create the
#     enumerator. It is not checked if it is possible to create an enumerator
#     using <A>Concatenation([source],names)</A> as an argument. See <Ref
#     Func="SMALLSEMI_CAN_CREATE_ENUM_NC"/> for more details.
#   </Item>
# </List>
# <C>SMALLSEMI_CREATE_ENUM</C> returns the same value as <Ref
# Func="EnumeratorOfSmallSemigroupsByIds" BookName="smallsemi"/> but here the
# attributes <Ref Func="FuncsOfSmallSemisInEnum" BookName="smallsemi"/> and
# <Ref Func="NamesFuncsSmallSemisInEnum" BookName="smallsemi"/> are set
# according to the argument <A>names</A>.
# <P/>
#
# Elements of enumerators creating using <C>SMALLSEMI_CREATE_ENUM</C> should
# have any operation in <A>names</A> set to the value specified when the
# enumerator was created. That is, it should not be necessary to recompute this
# information.
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareGlobalFunction("SMALLSEMI_CREATE_ENUM");

# <#GAPDoc Label="SMALLSEMI_SORT_ARG_NC">
# <ManSection>
# <Func Name="SMALLSEMI_SORT_ARG_NC" Arg="arg"/>
# <Description>
# <A>arg</A> is assumed to satisfy <Ref Func="SMALLSEMI_ValidateArgs"/>
# <C>(arg)=true</C> but this is not checked.
#
# <C>SMALLSEMI_SORT_ARG_NC</C> sorts <A>arg</A> so that the functions
# <A>arg[2i]</A> where <A>arg[2i+1]</A> is <C>true</C> come at the start, and
# then the arguments <A>arg[2i]</A> are ordered alphabetically.
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareGlobalFunction("SMALLSEMI_SORT_ARG_NC");

# <#GAPDoc Label="SMALLSEMI_STRIP_ARG">
# <ManSection>
# <Func Name="SMALLSEMI_STRIP_ARG" Arg="arg"/>
# <Description>
# returns <A>arg</A> or <A>arg[1]</A> if <A>arg</A> is a list containing an
# argument in its first position. This is required as an <C>arg</C> is not
# input as a list but occurs as a list in the function where it is used. Hence
# passing the <C>arg</C> to another function passes a list rather than the
# correct argument.
# </Description>
# </ManSection>
# <#/GAPDoc>
DeclareGlobalFunction("SMALLSEMI_STRIP_ARG");
