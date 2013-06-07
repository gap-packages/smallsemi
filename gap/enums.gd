#############################################################################
##
#W  enums.gd                       Smallsemi - a GAP library of semigroups
#Y  Copyright (C) 2008-2012            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

## $Id$

###########################################################################
##
##  <#GAPDoc Label="AllSmallSemigroups">
##  <ManSection> 
##  <Func Name="AllSmallSemigroups" Arg="arg"/>
##  <Description>
##	the number of argument of this function should be odd. The first argument 
##	<C>arg[1]</C> should be a positive integer, an 
##	enumerator of small semigroups with <Ref Func="IsEnumeratorOfSmallSemigroups"/>, or an iterator
##	of small semigroup with <Ref Func="IsIteratorOfSmallSemigroups"/>. <P/>
##
##	The even 
##	arguments <C>arg[2i]</C>, if present, should be functions, and the odd 
##	arguments <C>arg[2i+1]</C> should be a value that the preceeding function 
##	can have.  For example, a typical input might be 
## <C>3, IsRegularSemigroup, true</C>.  The functions <C>arg[2i]</C> can be user 
##	defined or existing &GAP; functions.<P/>
##
##	Please see Section <Ref Sect="enums"/> or Chapter <Ref Chap="examples"/> for more details. <P/>
##
##	If <C>arg[1]</C> is a positive integer, then <C>AllSmallSemigroups</C> returns 
##	a list of all the small semigroups <C>S</C> in the 
##	library with <C>Size(S)=arg[1]</C> and <C>arg[2i](S)=arg[2i+1]</C> for all <C>i</C>. <P/>
##
##	If <C>arg[1]</C> is a list of positive integers, then <C>AllSmallSemigroups</C> returns 
##	a list of all the small semigroups <C>S</C> in the 
##	library with <C>Size(S) in arg[1]</C> and <C>arg[2i](S)=arg[2i+1]</C> for all <C>i</C>. <P/>
##
##	If <C>arg[1]</C> is an enumerator or iterator of small semigroups, then 
##	<C>AllSmallSemigroups</C> returns 
##	a list of all the small semigroups <C>S</C> in the 
##	library with <C>S in arg[1]</C> and <C>arg[2i](S)=arg[2i+1]</C> for all <C>i</C>. <P/>
##  <Example>
##    gap> AllSmallSemigroups(2);
##    [ &lt;small semigroup of size 2>, &lt;small semigroup of size 2>, 
##      &lt;small semigroup of size 2>, &lt;small semigroup of size 2> ]
##    gap> AllSmallSemigroups([2,3], IsRegularSemigroup, true,
##    > x-&gt; Length(GreensRClasses(x)), 1);
##    [ &lt;small semigroup of size 2>, &lt;small semigroup of size 2>, 
##      &lt;small semigroup of size 3>, &lt;small semigroup of size 3> ]
##    gap> enum:=EnumeratorOfSmallSemigroups(8, IsInverseSemigroup, true,
##    > IsCommutativeSemigroup, true);;
##    gap> AllSmallSemigroups(enum, x-> Length(GreensRClasses(x)), 1);
##    [ &lt;small semigroup of size 8&gt;, &lt;small semigroup of size 8&gt;,
##      &lt;small semigroup of size 8&gt; ]
##    gap> iter:=IteratorOfSmallSemigroups(7, x-&gt; Length(GreensRClasses(x)), 1);;
##    gap> AllSmallSemigroups(iter, IsCommutative, true,
##    > IsSimpleSemigroup, true);
##    [ &lt;small semigroup of size 7> ]
##  </Example> <!-- enums.tst --> 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareGlobalFunction("AllSmallSemigroups");

###########################################################################
##
##  <#GAPDoc Label="EmptyEnumeratorOfSmallSemigroups">
##  <ManSection> 
##  <Func Name="EmptyEnumeratorOfSmallSemigroups" Arg=""/>
##  <Description>
##	the argument should be empty and the returned enumerator is too.<P/>
##
##  <Example>
##gap&gt; EmptyEnumeratorOfSmallSemigroups(); 
##&lt;empty enumerator of semigroups&gt;
##  </Example><!-- enums.tst --> 
##  </Description>
##  </ManSection>
##	<#/GAPDoc>

DeclareGlobalFunction("EmptyEnumeratorOfSmallSemigroups");

###########################################################################
##
##  <#GAPDoc Label="EmptyIteratorOfSmallSemigroups">
##  <ManSection> 
##  <Func Name="EmptyIteratorOfSmallSemigroups" Arg=""/>
##  <Description>
##	the argument should be empty and the returned iterator is too.<P/>
##
##  <Example>
##gap&gt; EmptyIteratorOfSmallSemigroups(); 
##&lt;empty iterator of semigroups&gt;
##  </Example><!-- enums.tst --> 
##  </Description>
##  </ManSection>
##	<#/GAPDoc>

DeclareGlobalFunction("EmptyIteratorOfSmallSemigroups");

###########################################################################
##
##  <#GAPDoc Label="EnumeratorOfSmallSemigroups">
##  <ManSection> 
##  <Func Name="EnumeratorOfSmallSemigroups" Arg="arg"/>
##  <Description>
##	the number of argument of this function should be odd. The first argument 
##	<C>arg[1]</C> should be a positive integer, an 
##	enumerator of small semigroups with <Ref Func="IsEnumeratorOfSmallSemigroups"/>, or an iterator
##	of small semigroup with <Ref Func="IsIteratorOfSmallSemigroups"/>. <P/>
##
##	The even 
##	arguments <C>arg[2i]</C>, if present, should be functions, and the odd 
##	arguments <C>arg[2i+1]</C> should be a value that the preceeding function 
##	can have.  For example, a typical input might be 
## <C>3, IsRegularSemigroup, true</C>.  The functions <C>arg[2i]</C> can be user 
##	defined or existing &GAP; functions.<P/>
##
##	Please see Section <Ref Sect="enums"/> or Chapter <Ref Chap="examples"/> for more details. <P/>
##
##	If <C>arg[1]</C> is a positive integer, then <C>EnumeratorOfSmallSemigroups</C> returns 
##	an enumerator of all the small semigroups <C>S</C> in the 
##	library with <C>Size(S)=arg[1]</C> and <C>arg[2i](S)=arg[2i+1]</C> for all <C>i</C>. <P/>
##
##	If <C>arg[1]</C> is a list of positive integers, then <C>EnumeratorOfSmallSemigroups</C> returns 
##	an enumerator of all the small semigroups <C>S</C> in the 
##	library with <C>Size(S) in arg[1]</C> and <C>arg[2i](S)=arg[2i+1]</C> for all <C>i</C>. <P/>
##
##	If <C>arg[1]</C> is an enumerator or iterator of small semigroups, then 
##	<C>EnumeratorOfSmallSemigroups</C> returns 
##	an enumerator of all the small semigroups <C>S</C> in the 
##	library with <C>S in arg[1]</C> and <C>arg[2i](S)=arg[2i+1]</C> for all <C>i</C>. <P/>
##  <Example>
##  gap> enum:=EnumeratorOfSmallSemigroups(7);
##  &lt;enumerator of semigroups of size 7>
##  gap> EnumeratorOfSmallSemigroups([2,3], IsRegularSemigroup, true); 
##  &lt;enumerator of semigroups of sizes [ 2, 3 ]>
##  gap> enum:=EnumeratorOfSmallSemigroups(8, IsInverseSemigroup, true, 
##  > IsCommutativeSemigroup, true);
##  &lt;enumerator of semigroups of size 8>
##  gap> EnumeratorOfSmallSemigroups(enum, IsCommutativeSemigroup, true, 
##  > IsSimpleSemigroup, false);
##  &lt;enumerator of semigroups of size 8>
##  gap> iter:=IteratorOfSmallSemigroups(8);
##  &lt;iterator of semigroups of size 8>
##  gap> EnumeratorOfSmallSemigroups(iter, IsCommutativeSemigroup, true, 
##  > IsSimpleSemigroup, false);
##  &lt;enumerator of semigroups of size 8>
##  </Example><!-- enums.tst --> 
##  </Description>
##  </ManSection>
##	<#/GAPDoc>

DeclareGlobalFunction("EnumeratorOfSmallSemigroups");

###########################################################################
##
##  <#GAPDoc Label="EnumeratorOfSmallSemigroupsByIds">
##  <ManSection> 
##  <Oper Name="EnumeratorOfSmallSemigroupsByIds" Arg="arg"/>
##  <Oper Name="EnumeratorOfSmallSemigroupsByIdsNC" Arg="arg"/>
##  <Description>
##	the argument of this function should be one of the following:
##	<List>
##	<Item> a positive integer <A>arg[1]</A> and a set of positive integers less 
##  than  <Ref Func="NrSmallSemigroups"/> with argument <A>arg[1]</A>. For 
##  example, the argument <A>3, [1..10]</A> yields the first 10 semigroups with
##  3 elements.
##  </Item>
##	<Item> a set of positive integers <A>arg[1]</A> and a list of sets of 
##  positive integers <A>arg[2]</A> such that <A>x</A> is at most 
##	<Ref Func="NrSmallSemigroups"/> with argument <A>arg[1][i]</A> for all 
##	<A>x</A> in <A>arg[2][i]</A>. For example, 
##	<A>[2,3], [[1..2],[1..10]]</A> yields the first 2 semigroups of size 2, 
##	and the first 10 semigroups of size 3.</Item>
##	<Item> a list of id numbers, for example, <A>[[7,1], [6,1], [5,1]]</A>.</Item>
##	</List>
##	The no check version does not check that the arguments are valid and may return unpredictable 
##	results.
##	
##  <Example>
##  gap&gt; enum:=EnumeratorOfSmallSemigroupsByIds([[7,1],[6,1],[5,1]]);
##  &lt;enumerator of semigroups of sizes [ 5, 6, 7 ]&gt;
##  gap&gt; enum:=EnumeratorOfSmallSemigroupsByIds(7, [1..1000]);
##  &lt;enumerator of semigroups of size 7&gt;
##  gap&gt; enum:=EnumeratorOfSmallSemigroupsByIds([2,3], [[1..2],[1..10]]); 
##  &lt;enumerator of semigroups of sizes [ 2, 3 ]&gt;
##  </Example><!-- enums.tst -->
##  </Description>
##  </ManSection>
##	<#/GAPDoc>

DeclareOperation("EnumeratorOfSmallSemigroupsByIds", [IsCyclotomicCollection , IsCyclotomicCollColl]);

DeclareOperation("EnumeratorOfSmallSemigroupsByIdsNC", [IsCyclotomicCollection , IsCyclotomicCollColl]);

#############################################################################
##
##  EnumeratorOfSmallSemigroupsByDiagonals
##
##  should become obsolete in 0.7 and is therefore undocumented
##

DeclareGlobalFunction("EnumeratorOfSmallSemigroupsByDiagonals"); 

###########################################################################
##
##  <#GAPDoc Label="EnumeratorSortedOfSmallSemigroups">
##  <ManSection> 
##  <Func Name="EnumeratorSortedOfSmallSemigroups" Arg="arg"/>
##  <Description>
##  accepts the same arguments and returns the same values as 
##  <Ref Func="EnumeratorOfSmallSemigroups"/>. 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareGlobalFunction("EnumeratorSortedOfSmallSemigroups");

###########################################################################
##
##  <#GAPDoc Label="IdsOfSmallSemigroups">
##  <ManSection> 
##  <Func Name="IdsOfSmallSemigroups" Arg="arg"/>
##  <Description>
##	the number of argument of this function should be odd. The first argument 
##	<C>arg[1]</C> should be a positive integer, an 
##	enumerator of small semigroups with <Ref Func="IsEnumeratorOfSmallSemigroups"/>, or an iterator
##	of small semigroup with <Ref Func="IsIteratorOfSmallSemigroups"/>. <P/>
##
##	The even 
##	arguments <C>arg[2i]</C>, if present, should be functions, and the odd 
##	arguments <C>arg[2i+1]</C> should be a value that the preceeding function 
##	can have.  For example, a typical input might be 
## <C>3, IsRegularSemigroup, true</C>.  The functions <C>arg[2i]</C> can be user 
##	defined or existing &GAP; functions.<P/>
##
##	Please see Section <Ref Sect="enums"/> or Chapter <Ref Chap="examples"/> for more details. <P/>
##
##	If <C>arg[1]</C> is a positive integer, then <C>IdsOfSmallSemigroups</C> returns 
##	a list of the id numbers of all the small semigroups <C>S</C> in the 
##	library with <C>Size(S)=arg[1]</C> and <C>arg[2i](S)=arg[2i+1]</C> for all <C>i</C>. <P/>
##
##	If <C>arg[1]</C> is a list of positive integers, then <C>IdsOfSmallSemigroups</C> returns 
##	a list of the id numbers of all the small semigroups <C>S</C> in the 
##	library with <C>Size(S) in arg[1]</C> and <C>arg[2i](S)=arg[2i+1]</C> for all <C>i</C>. <P/>
##
##	If <C>arg[1]</C> is an enumerator or iterator of small semigroups, then 
##	<C>IdsOfSmallSemigroups</C> returns 
##	a list of the id numbers of all the small semigroups <C>S</C> in the 
##	library with <C>S in arg[1]</C> and <C>arg[2i](S)=arg[2i+1]</C> for all <C>i</C>. <P/>
##  <Example>
##  gap>  enum:=EnumeratorOfSmallSemigroups(5, x-> Length(GreensRClasses(x)), 1);;
##  gap> IdsOfSmallSemigroups(enum, IsCommutativeSemigroup, true,
##  > IsSimpleSemigroup, false);                                              
##  [  ]
##  gap> IdsOfSmallSemigroups([2,3], IsRegularSemigroup, true);  
##  [ [ 2, 2 ], [ 2, 3 ], [ 2, 4 ], [ 3, 10 ], [ 3, 11 ], [ 3, 12 ], 
##    [ 3, 13 ], [ 3, 14 ], [ 3, 15 ], [ 3, 16 ], [ 3, 17 ], [ 3, 18 ] ]
##  </Example> <!-- enums.tst -->
##  </Description>
##  </ManSection>
##	<#/GAPDoc>

DeclareGlobalFunction("IdsOfSmallSemigroups");

###########################################################################
##
##  <#GAPDoc Label="IsEnumeratorOfSmallSemigroups">
##  <ManSection> 
##  <Prop Name="IsEnumeratorOfSmallSemigroups" Arg="enum"/>
##  <Description>
##	returns <C>true</C> if <A>enum</A> is an enumerator of small semigroups
##	created using <Ref Func="EnumeratorOfSmallSemigroups"/>, 
##	<Ref Func="EnumeratorOfSmallSemigroupsByIds"/>.
##  <Example>
##  gap> enum:=EnumeratorOfSmallSemigroupsByIds([[2,1], [3,1], [4,1]]);;
##  gap> IsEnumeratorOfSmallSemigroups(enum);
##  true
##  </Example> <!-- enums.tst -->
##  </Description>
##  </ManSection>
##	<#/GAPDoc>

DeclareProperty("IsEnumeratorOfSmallSemigroups", IsEnumeratorByFunctions);

###########################################################################
##
##  <#GAPDoc Label="FuncsOfSmallSemisInEnum">
##  <ManSection> 
##  <Func Name="FuncsOfSmallSemisInEnum" Arg="enum"/>
##  <Description>
##    returns a list of the functions and their values that were used to create
##    the enumerator of small semigroups <A>enum</A>. If you only want the
##    names of these functions use <Ref Func="NamesFuncsSmallSemisInEnum"/>.
##  <Example>
##  gap> enum:=EnumeratorOfSmallSemigroups([2..4], IsSimpleSemigroup, false,
##  > IsRegularSemigroup, true);;                                         
##  gap> FuncsOfSmallSemisInEnum(enum);
##  [ &lt;Property "IsRegularSemigroup">, true, 
##    &lt;Property "IsSimpleSemigroup">, false ]
##  </Example><!-- enums.tst -->
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

##  JDM this is out of sequence it requires IsEnumeratorOfSmallSemigroups

DeclareGlobalFunction("FuncsOfSmallSemisInEnum");

###########################################################################
##
##  <#GAPDoc Label="IsIdSmallSemigroup">
##  <ManSection> 
##  <Prop Name="IsIdSmallSemigroup" Arg="arg"/>
##  <Description>
##	return <C>true</C> if the <A>arg</A> is the id of a small semigroup or 
##	<A>[arg[1], arg[2]]</A> is the id of a small semigroup.
##  <Example>
##  gap> IsIdSmallSemigroup(8,1);
##  true
##  gap> IsIdSmallSemigroup([1,2]);
##  false
##  gap> IsIdSmallSemigroup([3,18]);
##  true
##  </Example> <!-- enums.tst -->
##  </Description>
##  </ManSection>
##	<#/GAPDoc>

DeclareGlobalFunction("IsIdSmallSemigroup");

###########################################################################
##
##  <#GAPDoc Label="IsIteratorOfSmallSemigroups">
##  <ManSection> 
##  <Prop Name="IsIteratorOfSmallSemigroups" Arg="iter"/>
##  <Description>
##	returns <C>true</C> if <A>iter</A> is an iterator of small semigroups
##	created using <Ref Func="IteratorOfSmallSemigroups"/>.
##  <Example>
##  gap> iter:=IteratorOfSmallSemigroups(8);;
##  gap> IsIteratorOfSmallSemigroups(iter);
##  true
##  </Example> <!-- enums.tst -->
##  </Description>
##  </ManSection>
##	<#/GAPDoc>

DeclareProperty("IsIteratorOfSmallSemigroups", IsIteratorByFunctions);

###########################################################################
##
##  <#GAPDoc Label="FuncsOfSmallSemisInIter">
##  <ManSection> 
##  <Func Name="FuncsOfSmallSemisInIter" Arg="iter"/>
##  <Description>
##	returns a list of the functions and their values that were used to create
##	the iterator of small semigroups <A>iter</A>. If you only want the names 
##	of these functions use <Ref Func="NamesFuncsSmallSemisInIter"/>.
##  <Example>
##  gap> enum:=IteratorOfSmallSemigroups([2..4], IsSimpleSemigroup, false,
##  > IsRegularSemigroup, true);;                                        
##  gap> FuncsOfSmallSemisInIter(enum);
##  [ &lt;Property "IsRegularSemigroup">, true, 
##    &lt;Property "IsSimpleSemigroup">, false ]
##  </Example><!-- enums.tst -->
##  </Description>
##  </ManSection>
##	<#/GAPDoc>

##  JDM this is out of sequence it requires IsIteratorOfSmallSemigroups

DeclareGlobalFunction("FuncsOfSmallSemisInIter");

###########################################################################
##
##  <#GAPDoc Label="IteratorOfSmallSemigroups">
##  <ManSection> 
##  <Func Name="IteratorOfSmallSemigroups" Arg="arg"/>
##  <Description>
##	the number of argument of this function should be odd. The first argument 
##	<C>arg[1]</C> should be a positive integer, an 
##	enumerator of small semigroups with <Ref Func="IsEnumeratorOfSmallSemigroups"/>, 
##	or an iterator of small semigroup with <Ref Func="IsIteratorOfSmallSemigroups"/>.
##	<P/>
##
##	The even 
##	arguments <C>arg[2i]</C>, if present, should be functions, and the odd 
##	arguments <C>arg[2i+1]</C> should be a value that the preceeding function 
##	can have.  For example, a typical input might be 
## <C>3, IsRegularSemigroup, true</C>.  The functions <C>arg[2i]</C> can be user 
##	defined or existing &GAP; functions.<P/>
##
##	Please see Section <Ref Sect="enums"/> or Chapter <Ref Chap="examples"/> 
##	for more details. <P/>
##
##	If <C>arg[1]</C> is a positive integer, then <C>IteratorOfSmallSemigroups</C> 
##	returns an iterator of all the small semigroups <C>S</C> in the 
##	library with <C>Size(S)=arg[1]</C> and <C>arg[2i](S)=arg[2i+1]</C> 
##	for all <C>i</C>. <P/>
##
##	If <C>arg[1]</C> is a list of positive integers, then 
##	<C>IteratorOfSmallSemigroups</C> returns 
##	an iterator of all the small semigroups <C>S</C> in the 
##	library with <C>Size(S) in arg[1]</C> and <C>arg[2i](S)=arg[2i+1]</C> 
##	for all <C>i</C>. <P/>
##
##	If <C>arg[1]</C> is an enumerator or iterator of small semigroups, then 
##	<C>IteratorOfSmallSemigroups</C> returns 
##	an iterator of all the small semigroups <C>S</C> in the 
##	library with <C>S in arg[1]</C> and <C>arg[2i](S)=arg[2i+1]</C> for all <C>i</C>.
##	<P/>
##  <Example>
##  gap> iter:=IteratorOfSmallSemigroups(8);
##  &lt;iterator of semigroups of size 8>
##  gap> NextIterator(iter);
##  &lt;small semigroup of size 8>
##  gap> IsDoneIterator(iter);
##  false
##  gap> iter:=IteratorOfSmallSemigroups([2,3], IsRegularSemigroup, true,
##  > x-> Length(Idempotents(x))=1, true);
##  &lt;iterator of semigroups of sizes [ 2, 3 ]>
##  gap> NextIterator(iter); 
##  &lt;small semigroup of size 2>
##  gap> NextIterator(iter);
##  &lt;small semigroup of size 3>
##  gap> NextIterator(iter);
##  fail
##  gap> enum:=EnumeratorOfSmallSemigroups(5, x-> Length(Idempotents(x))=1, true);
##  &lt;enumerator of semigroups of size 5>
##  gap> iter:=IteratorOfSmallSemigroups(enum, x-> Length(GreensRClasses(x))=2, true);
##  &lt;iterator of semigroups of size 5>
##  </Example><!-- enums.tst -->
##  </Description>
##  </ManSection>
##	<#/GAPDoc>

DeclareGlobalFunction("IteratorOfSmallSemigroups");

###########################################################################
##
##  <#GAPDoc Label="NamesFuncsSmallSemisInEnum">
##  <ManSection> 
##  <Func Name="NamesFuncsSmallSemisInEnum" Arg="enum"/>
##  <Description>
##	returns a list of the names of functions and their values that were used 
##	to create the enumerator of small semigroups <A>enum</A>. If you only want the 
##	actual functions themselves then use <Ref Func="FuncsOfSmallSemisInEnum"/>.
##  <Example>
##  gap> enum:=EnumeratorOfSmallSemigroups([2..4], IsSimpleSemigroup, false,
##  > IsRegularSemigroup, true);; 
##  gap> NamesFuncsSmallSemisInEnum(enum);
##  [ "IsRegularSemigroup", true, "IsSimpleSemigroup", false ]
##  </Example><!-- enums.tst -->
##  </Description>
##  </ManSection>
##	<#/GAPDoc>

DeclareGlobalFunction("NamesFuncsSmallSemisInEnum");

###########################################################################
##
##  <#GAPDoc Label="NamesFuncsSmallSemisInIter">
##  <ManSection> 
##  <Attr Name="NamesFuncsSmallSemisInIter" Arg="iter"/>
##  <Description>
##	returns a list of the names of functions and their values that were used 
##	to create the iterator of small semigroups <A>iter</A>. If you only want the 
##	actual functions themselves then use 
##  <Ref Func="FuncsOfSmallSemisInIter"/>.
##  <Example>
##  gap> iter:=IteratorOfSmallSemigroups([2..4], IsSimpleSemigroup, false,
##  > IsRegularSemigroup, true);;                              
##  gap> NamesFuncsSmallSemisInIter(iter);
##  [ "IsRegularSemigroup", true, "IsSimpleSemigroup", false ]
##  </Example><!-- enums.tst -->
##  </Description>
##  </ManSection>
##	<#/GAPDoc>

DeclareGlobalFunction("NamesFuncsSmallSemisInIter");

###########################################################################
##
##  <#GAPDoc Label="Nr3NilpotentSemigroups">
##  <ManSection> 
##  <Func Name="Nr3NilpotentSemigroups" Arg="n[, type]"/>
##  <Description>
##	returns the number of 3-nilpotent semigroups on a set with <A>n</A>
##      elements. If the optional argument <A>type</A> is given it must be one
##      of <C>"UpToEquivalence", "UpToIsomorphism", "SelfDual", "Commutative",
##      "Labelled", "Labelled-Commutative"</C>.
##      The number will be returned for the respective type of semigroup.
##      By default <A>type</A> is <C>"UpToEquivalence"</C>.
##	<P/>
##      The function implements the formulae calculating the number of
##      3-nilpotent semigroups developed in <Cite Key="Dis10"/>
##  <Example>
##  gap> Nr3NilpotentSemigroups( 4 );
##  8
##  gap> Nr3NilpotentSemigroups( 9, "UpToIsomorphism" );
##  105931872028455
##  gap> Nr3NilpotentSemigroups( 9, "Labelled" ); 
##  38430603831264883632
##  gap> Nr3NilpotentSemigroups( 16, "SelfDual" );
##  4975000837941847814744710290469890455985530
##  gap> Nr3NilpotentSemigroups( 19, "Commutative" );
##  12094270656160403920767935604624748908993169949317454767617795
##  </Example> <!-- enums.tst -->
##  </Description>
##  </ManSection>
##	<#/GAPDoc>
##

DeclareGlobalFunction("Nr3NilpotentSemigroups");

###########################################################################
##
##  <#GAPDoc Label="NrSmallSemigroups">
##  <ManSection> 
##  <Func Name="NrSmallSemigroups" Arg="arg"/>
##  <Description>
##	the number of argument of this function should be odd. The first argument 
##	<C>arg[1]</C> should be a positive integer, an 
##	enumerator of small semigroups with <Ref Func="IsEnumeratorOfSmallSemigroups"/>, 
##	or an iterator of small semigroup with <Ref Func="IsIteratorOfSmallSemigroups"/>.
##	<P/>
##
##	The even 
##	arguments <C>arg[2i]</C>, if present, should be functions, and the odd 
##	arguments <C>arg[2i+1]</C> should be a value that the preceeding function 
##	can have.  For example, a typical input might be 
## <C>3, IsRegularSemigroup, true</C>.  The functions <C>arg[2i]</C> can be user 
##	defined or existing &GAP; functions.<P/>
##
##	Please see Section <Ref Sect="enums"/> or Chapter <Ref Chap="examples"/> 
##	for more details. <P/>
##
##	If <C>arg[1]</C> is a positive integer, then <C>NrSmallSemigroups</C> 
##	returns the number of small semigroups <C>S</C> in the 
##	library with <C>Size(S)=arg[1]</C> and <C>arg[2i](S)=arg[2i+1]</C> 
##	for all <C>i</C>. <P/>
##
##	If <C>arg[1]</C> is a list of positive integers, then 
##	<C>NrSmallSemigroups</C> returns 
##	the number of small semigroups <C>S</C> in the 
##	library with <C>Size(S) in arg[1]</C> and <C>arg[2i](S)=arg[2i+1]</C> 
##	for all <C>i</C>. <P/>
##
##	If <C>arg[1]</C> is an enumerator or iterator of small semigroups, then 
##	<C>NrSmallSemigroups</C> returns 
##	the number of small semigroups <C>S</C> in the 
##	library with <C>S in arg[1]</C> and <C>arg[2i](S)=arg[2i+1]</C> for all <C>i</C>.
##	<P/>
##  <Example>
##  gap> List([1..8], NrSmallSemigroups);
##  [ 1, 4, 18, 126, 1160, 15973, 836021, 1843120128 ]
##  gap> NrSmallSemigroups(8, IsCommutative, true, IsInverseSemigroup, true);
##  4443
##  gap> NrSmallSemigroups([1..8], IsCliffordSemigroup, true);               
##  5610
##  gap> NrSmallSemigroups(8, IsRegularSemigroup, true, 
##  > IsCompletelyRegularSemigroup, false);
##  1164
##  gap> NrSmallSemigroups(5, NilpotencyRank, 3);
##  84
##  </Example> <!-- enums.tst -->
##  </Description>
##  </ManSection>
##	<#/GAPDoc>
##

DeclareGlobalFunction("NrSmallSemigroups");

###########################################################################
##
##  <#GAPDoc Label="OneSmallSemigroup">
##  <ManSection> 
##  <Func Name="OneSmallSemigroup" Arg="arg"/>
##  <Description>
##	the number of argument of this function should be odd. The first argument 
##	<C>arg[1]</C> should be a positive integer, an 
##	enumerator of small semigroups with <Ref Func="IsEnumeratorOfSmallSemigroups"/>, 
##	or an iterator of small semigroup with <Ref Func="IsIteratorOfSmallSemigroups"/>.
##	<P/>
##
##	The even 
##	arguments <C>arg[2i]</C>, if present, should be functions, and the odd 
##	arguments <C>arg[2i+1]</C> should be a value that the preceeding function 
##	can have.  For example, a typical input might be 
## <C>3, IsRegularSemigroup, true</C>.  The functions <C>arg[2i]</C> can be user 
##	defined or existing &GAP; functions.<P/>
##
##	Please see Section <Ref Sect="enums"/> or Chapter <Ref Chap="examples"/> 
##	for more details. <P/>
##
##	If <C>arg[1]</C> is a positive integer, then <C>OneSmallSemigroup</C> 
##	returns the first small semigroup <C>S</C> in the 
##	library with <C>Size(S)=arg[1]</C> and <C>arg[2i](S)=arg[2i+1]</C> 
##	for all <C>i</C>. <P/>
##
##	If <C>arg[1]</C> is a list of positive integers, then 
##	<C>OneSmallSemigroup</C> returns 
##	the first small semigroup <C>S</C> in the 
##	library with <C>Size(S) in arg[1]</C> and <C>arg[2i](S)=arg[2i+1]</C> 
##	for all <C>i</C>. <P/>
##
##	If <C>arg[1]</C> is an enumerator or iterator of small semigroups, then 
##	<C>OneSmallSemigroup</C> returns 
##	the first small semigroup <C>S</C> in the 
##	library with <C>S in arg[1]</C> and <C>arg[2i](S)=arg[2i+1]</C> for all <C>i</C>.
##	<P/>
##  <Example>
##  gap> OneSmallSemigroup(8, IsCommutative, true, IsInverseSemigroup, true);
##  &lt;small semigroup of size 8>
##  gap> OneSmallSemigroup([1..8], IsCliffordSemigroup, true);
##  &lt;small semigroup of size 1>
##  gap> iter:=IteratorOfSmallSemigroups(8, IsCommutative, false);
##  &lt;iterator of semigroups of size 8>
##  gap> OneSmallSemigroup(iter);
##  &lt;small semigroup of size 8>
##  </Example><!-- enums.tst -->
##  </Description>
##  </ManSection>
##	<#/GAPDoc>

DeclareGlobalFunction("OneSmallSemigroup");

###########################################################################
##
##	<#GAPDoc Label="PositionsOfSmallSemigroups">
##	<ManSection> 
##	<Func Name="PositionsOfSmallSemigroups" Arg="arg"/>
##	<Description>
##	the number of argument of this function should be odd. The first argument 
##	<C>arg[1]</C> should be a positive integer or an 
##	enumerator with <Ref Func="IsEnumeratorOfSmallSemigroups"/>, the even 
##	arguments <C>arg[2i]</C>, if present, should be functions, and the odd 
##	arguments <C>arg[2i+1]</C> should be a value that the preceeding function 
##	can have.  For example, a typical input might be 
## <C>3, IsRegularSemigroup, true</C>.  The functions <C>arg[2i]</C> can be user 
##	defined or existing &GAP; functions. The argument can be a list <C>arg</C> 
##	with the same components as given above.<P/>
##
##	The function returns a list of the second components of the 
##	<Ref Attr="IdSmallSemigroup" /> of all the small semigroups <C>S</C> in the 
##	library satisfying <C>Size(S)</C> in <C>arg[1]</C> or <C>Size(S)</C> in 
##	<C>SizesOfSmallSemisInEnum(arg[1])</C> and <C>arg[2i](S)=arg[2i+1]</C> 
##	for all <C>i</C> partitioned by size of the semigroups. 
##
##<Example>
##  gap> PositionsOfSmallSemigroups(3);
##  [ [ 1 .. 18 ] ]
##  gap> PositionsOfSmallSemigroups(3, IsRegularSemigroup, false);
##  [ [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ] ]
##  gap> enum:=EnumeratorOfSmallSemigroups(3, IsRegularSemigroup, false);;
##  gap> PositionsOfSmallSemigroups(enum);
##  [ [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ] ]
##  gap> PositionsOfSmallSemigroups([1..4], IsBand, true);
##  [ [ 1 ], [ 3, 4 ], [ 12 .. 17 ], [ 98 .. 123 ] ]
##  gap> PositionsOfSmallSemigroups(enum, Is1IdempotentSemigroup, true,
##  > Is2GeneratedSemigroup, true, IsCliffordSemigroup, false);
##  [ [ 1, 2 ], [ 2, 3, 5, 6, 8, 9, 10, 12, 34, 35, 36, 97 ], 
##    [ 5, 20, 21, 22, 23, 26, 29, 32, 35, 54, 55, 56, 60, 61, 62, 63, 64, 65, 
##        152, 156, 159, 177, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 
##        191, 192, 193, 540, 1009, 1157, 1158 ] ]
##  </Example> <!-- enums.tst -->
##  </Description>
##  </ManSection>
##	<#/GAPDoc>
##

DeclareGlobalFunction("PositionsOfSmallSemigroups");

###########################################################################
##
##  <#GAPDoc Label="PositionsOfSmallSemisInEnum">
##  <ManSection> 
##  <Func Name="PositionsOfSmallSemisInEnum" Arg="enum"/>
##  <Description>
##    returns the second components of the id numbers of the small semigroups 
##    in the enumerator of small semigroups <A>enum</A> in a list partitioned
##    according the size of the semigroup.  The same value is returned by
##    using <Ref Func="PositionsOfSmallSemigroups"/>. 
##  <Example>
##  gap> enum := EnumeratorOfSmallSemigroups([2..4],IsSimpleSemigroup,true);;
##  gap> PositionsOfSmallSemisInEnum
##  > (enum);
##  [ [ 2, 4 ], [ 17, 18 ], [ 7, 37, 52, 122, 123 ] ]
##  </Example><!-- enums.tst -->
##  </Description>
##  </ManSection>
##	<#/GAPDoc>

DeclareGlobalFunction("PositionsOfSmallSemisInEnum");

###########################################################################
##
##  <#GAPDoc Label="RandomSmallSemigroup">
##  <ManSection> 
##  <Func Name="RandomSmallSemigroup" Arg="arg"/>
##  <Description>
##    the number of argument of this function should be odd. The first
##    argument <C>arg[1]</C> should be a positive integer, an enumerator 
##    of small semigroups with <Ref Func="IsEnumeratorOfSmallSemigroups"/>, 
##    or an iterator of small semigroup with
##    <Ref Func="IsIteratorOfSmallSemigroups"/>.
##    <P/>
##    The even arguments <C>arg[2i]</C>, if present, should be functions,
##    and the odd arguments <C>arg[2i+1]</C> should be a value that the
##    preceeding function can have. For example, a typical input might be 
##    <C>3, IsRegularSemigroup, true</C>. The functions <C>arg[2i]</C> can
##    be user defined or existing &GAP; functions.
##    <P/>
##    Please see Section <Ref Sect="enums"/> or Chapter <Ref Chap="examples"/> 
##    for more details.
##    <P/>
##    If <C>arg[1]</C> is a positive integer, then <C>RandomSmallSemigroup</C> 
##    returns a random small semigroup <C>S</C> in the library with
##    <C>Size(S)=arg[1]</C> and <C>arg[2i](S)=arg[2i+1]</C> for all <C>i</C>.
##    <P/>
##    If <C>arg[1]</C> is a list of positive integers, then 
##    <C>RandomSmallSemigroup</C> returns the a random small semigroup
##    <C>S</C> in the library with <C>Size(S) in arg[1]</C> and 
##    <C>arg[2i](S)=arg[2i+1]</C> for all <C>i</C>.
##    <P/>
##    If <C>arg[1]</C> is an enumerator or iterator of small semigroups, then 
##    <C>RandomSmallSemigroup</C> returns the a random small semigroup
##    <C>S</C> in the library with <C>S in arg[1]</C> and 
##    <C>arg[2i](S)=arg[2i+1]</C> for all <C>i</C>.
##  <Example>
##    gap> RandomSmallSemigroup(8, IsCommutative, true, 
##    > IsInverseSemigroup, true);
##    &lt;small semigroup of size 8>
##    gap> RandomSmallSemigroup([1..8], IsCliffordSemigroup, true);
##    &lt;small semigroup of size 8>
##    gap> iter:=IteratorOfSmallSemigroups([1..7]);
##    &lt;iterator of semigroups of size [ 1 .. 7 ]>
##    gap> RandomSmallSemigroup(iter);
##    &lt;small semigroup of size 7>
##  </Example><!-- enums.tst -->
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareGlobalFunction("RandomSmallSemigroup");

###########################################################################
##
##  <#GAPDoc Label="SizesOfSmallSemisInEnum">
##  <ManSection> 
##  <Func Name="SizesOfSmallSemisInEnum" Arg="enum"/>
##  <Description>
##	returns the sizes of the semigroups in the enumerator of small semigroups 
##	<A>enum</A>. 
##  <Example>
##  gap> enum:=EnumeratorOfSmallSemigroups([2..4], IsSimpleSemigroup, false);
##  &lt;enumerator of semigroups of sizes [ 2, 3, 4 ]>
##  gap> SizesOfSmallSemisInEnum(enum);
##  [ 2, 3, 4 ]
##  </Example>
##  </Description>
##  </ManSection>
##	<#/GAPDoc>

DeclareGlobalFunction("SizesOfSmallSemisInEnum");

###########################################################################
##
##  <#GAPDoc Label="SizesOfSmallSemisInIter">
##  <ManSection> 
##  <Func Name="SizesOfSmallSemisInIter" Arg="iter"/>
##  <Description>
##    returns the sizes of the semigroups in the iterator <A>iter</A>
##    of small semigroups. 
##  <Example>
##    gap> iter:=IteratorOfSmallSemigroups(7, IsCommutative, false);
##    &lt;iterator of semigroups of size 7>
##    gap> SizesOfSmallSemisInIter(iter);
##    [ 7 ]
##  </Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareGlobalFunction("SizesOfSmallSemisInIter");

###########################################################################
##
##  <#GAPDoc Label="UpToIsomorphism">
##  <ManSection> 
##  <Oper Name="UpToIsomorphism" Arg="sgrps"/>
##  <Description>
##      takes a list <A>sgrps</A> of non-equivalent semigroups from the
##      library as input and returns a list of non-isomorphic semigroups
##      containing  an isomorphic
##      semigroup and an anti-isomorphic semigroup for every semigroup 
##	in <A>sgrps</A>.
##  <Example>
##  gap&gt; UpToIsomorphism([SmallSemigroup(5,126),SmallSemigroup(6,2)]);
##  [ &lt;small semigroup of size 5&gt;, &lt;small semigroup of size 6&gt; ]
##  gap&gt; UpToIsomorphism([SmallSemigroup(5,126),SmallSemigroup(5,3)]);
##  [ &lt;small semigroup of size 5&gt;, &lt;small semigroup of size 5&gt;, 
##    &lt;semigroup with 5 generators&gt; ]
##  </Example>
##  </Description>
##  </ManSection>
##	<#/GAPDoc>
##
DeclareOperation("UpToIsomorphism", [ IsList ]);
DeclareOperation("UpToIsomorphism", [ IsSmallSemigroup ]);

#Internal Functions
###################

###########################################################################
# undocumented: required by iterators. 

DeclareGlobalFunction("SHALLOWCOPYITERATORSMALLSEMI");

###########################################################################
##
##  <#GAPDoc Label="SMALLSEMI_ARG_OK">
##  <ManSection> 
##  <Func Name="SMALLSEMI_ARG_OK" Arg="arg"/>
##  <Description>
##  checks that the argument <A>arg</A> is valid for any of the functions 
##  <Ref Func="EnumeratorOfSmallSemigroups" BookName="smallsemi"/>, 
##	<Ref Func="AllSmallSemigroups" BookName="smallsemi"/>, 
##  <Ref Func="EnumeratorSortedOfSmallSemigroups" BookName="smallsemi"/>, 
##  <Ref Func="IdsOfSmallSemigroups" BookName="smallsemi"/>, 
##  <Ref Func="IteratorOfSmallSemigroups" BookName="smallsemi"/>, 
##  <Ref Func="NrSmallSemigroups" BookName="smallsemi"/>, 
##  <Ref Func="OneSmallSemigroup" BookName="smallsemi"/>, 
##	<Ref Func="PositionsOfSmallSemigroups" BookName="smallsemi"/>, 
##  <Ref Func="RandomSmallSemigroup" BookName="smallsemi"/>.<P/> 
##  
##	Currently a valid argument is one with:
##  <List>
##	<Item>odd length</Item>
##	<Item><A>arg[1]</A> is a positive integer between 1 and 8, a list of positive integers
##	between 1 and 8, an enumerator of small semigroups or an iterator of small semigroups</Item>
##	<Item> <A>arg[2i]</A> (the even indexed arguments) should be functions.
##	</Item>
##	</List>
##  </Description>
##  </ManSection>
##	<#/GAPDoc>

DeclareGlobalFunction("SMALLSEMI_ARG_OK");

###########################################################################
##
##  <#GAPDoc Label="SMALLSEMI_CAN_CREATE_ENUM_NC">
##  <ManSection> 
##  <Func Name="SMALLSEMI_CAN_CREATE_ENUM_NC" Arg="arg"/>
##  <Description>
##  checks that the argument <A>arg</A> can be used to produce an enumerator. 
##	This function does not check <Ref Func="SMALLSEMI_ARG_OK"/> is <C>true</C> with 
##	argument <A>arg</A> and it is assumed that <A>arg</A> is of this form.<P/>
##	
##	Currently a valid argument is one with:
##  <List>
##	<Item>the maximum size of semigroup satisfying <A>arg</A> at most 7; OR</Item>
##	<Item>the maximum size of semigroup satisfying <A>arg</A> equal 8 and there exists 
##	<C>i</C> such that <A>arg[2i]</A> in 
##	<Ref Var="PrecomputedSmallSemisInfo" BookName="smallsemi"/><C>[8]</C>
##	and <A>arg[2i+1]</A> is <C>true</C>. </Item>
##	</List>
##	The reason for this is that on a 32-bit computer the maximum length of a list is 
##	smaller than the number of semigroups with 8 elements. Enumerators use lists of id numbers
##	to specify their elements and so it is not currently possible to create arbitrary 
##	enumerators of small semigroups containing semigroups with 8 elements. 
##  </Description>
##  </ManSection>
##	<#/GAPDoc>

DeclareGlobalFunction("SMALLSEMI_CAN_CREATE_ENUM_NC");

###########################################################################
##
##  <#GAPDoc Label="SMALLSEMI_CONVERT_ARG_NC">
##  <ManSection> 
##  <Func Name="SMALLSEMI_CONVERT_ARG_NC" Arg="arg"/>
##  <Description>
##  <A>arg</A> is assumed to satisfy <Ref Func="SMALLSEMI_ARG_OK"/>
##  <C>(arg)=true</C> but this is not checked. 
##
##  <C>SMALLSEMI_CONVERT_ARG_NC</C> replaces every function <A>arg[2i]</A> 
##  by an equivalent function in 
##	<Ref Var="PrecomputedSmallSemisInfo" BookName="smallsemi"/> if it exists. <P/>
##
##  See  <Ref Var="SMALLSEMI_EQUIV"/> for
##  more details. 
##  <Example>
##gap&gt; SMALLSEMI_CONVERT_ARG_NC(5, IsCommutativeSemigroup, true);
##[ 5, &lt;Operation "IsCommutative"&gt;, true ]
##gap&gt; SMALLSEMI_CONVERT_ARG_NC(7, Is4GeneratedSemigroup, true); 
##[ 7, &lt;Operation "Is1GeneratedSemigroup"&gt;, false, 
##  &lt;Operation "Is2GeneratedSemigroup"&gt;, false, 
##  &lt;Operation "Is3GeneratedSemigroup"&gt;, false, 
##  &lt;Operation "Is5GeneratedSemigroup"&gt;, false, 
##  &lt;Operation "Is6GeneratedSemigroup"&gt;, false, 
##  &lt;Operation "Is7GeneratedSemigroup"&gt;, false ]
##gap&gt; SMALLSEMI_CONVERT_ARG_NC(5, IsCommutative, true);         
##[ 5, &lt;Operation "IsCommutative"&gt;, true ]
##  </Example><!-- enums.tst -->
##  </Description>
##  </ManSection>
##	<#/GAPDoc>

DeclareGlobalFunction("SMALLSEMI_CONVERT_ARG_NC");

###########################################################################
##
##  <#GAPDoc Label="SMALLSEMI_CREATE_ENUM">
##  <ManSection> 
##  <Func Name="SMALLSEMI_CREATE_ENUM" Arg="source, positions, names"/>
##  <Description>
##  <List>
##  <Item><A>source</A> should be a positive integer between 1 and 8, a list of 
##  positive integers between 1 and 8, an enumerator of small semigroups, or
##  an iterator of small semigroups;</Item>
##	<Item><A>positions</A> should be the list 
##  such that <A>positions[i]</A> is the list of second components of id numbers ##  of small semigroups in the enumerator we are creating</Item>
##  <Item><A>names</A> is the list of functions and values being used to create 
##  the enumerator. It is not checked if it is possible to create an enumerator ##  using <A>Concatenation([source],names)</A> as an argument. See 
##  <Ref Func="SMALLSEMI_CAN_CREATE_ENUM_NC"/> for more details.</Item>
##  </List>
##  <C>SMALLSEMI_CREATE_ENUM</C> returns the same value as 
##  <Ref Func="EnumeratorOfSmallSemigroupsByIds" BookName="smallsemi"/>
##  but here the attributes <Ref Func="FuncsOfSmallSemisInEnum" BookName="smallsemi"/> and 
##  <Ref Func="NamesFuncsSmallSemisInEnum" BookName="smallsemi"/> are set according to 
##  the argument <A>names</A>. <P/>
##	
##	Elements of enumerators creating using <C>SMALLSEMI_CREATE_ENUM</C> should have any
##	operation in <A>names</A> set to the value specified when the enumerator was created. 
##	That is, it should not be necessary to recompute this information.
##  </Description>
##  </ManSection>
##	<#/GAPDoc>

DeclareGlobalFunction("SMALLSEMI_CREATE_ENUM");

###########################################################################
##
##  <#GAPDoc Label="SMALLSEMI_ENTAB">
##  <ManSection> 
##  <Func Name="SMALLSEMI_ENTAB" Arg="str"/>
##  <Description>
##  returns the string <A>str</A> with <Ref Var="SMALLSEMI_TAB_LEVEL"/> 
##  characters '>' and a space juxtaposed at the beginning. 
##  </Description>
##  </ManSection>
##	<#/GAPDoc>

DeclareGlobalFunction("SMALLSEMI_ENTAB");

###########################################################################
##
##  <#GAPDoc Label="SMALLSEMI_SORT_ARG_NC">
##  <ManSection> 
##  <Func Name="SMALLSEMI_SORT_ARG_NC" Arg="arg"/>
##  <Description>
##  <A>arg</A> is assumed to satisfy <Ref Func="SMALLSEMI_ARG_OK"/>
##  <C>(arg)=true</C> but this is not checked. 
##
##  <C>SMALLSEMI_SORT_ARG_NC</C> sorts <A>arg</A> so that the functions 
##	<A>arg[2i]</A> where <A>arg[2i+1]</A> is <C>true</C> come at the start, and
##	then the arguments <A>arg[2i]</A> are ordered alphabetically.  
##  </Description>
##  </ManSection>
##	<#/GAPDoc>

DeclareGlobalFunction("SMALLSEMI_SORT_ARG_NC");

###########################################################################
##
##  <#GAPDoc Label="SMALLSEMI_STRIP_ARG">
##  <ManSection> 
##  <Func Name="SMALLSEMI_STRIP_ARG" Arg="arg"/>
##  <Description>
##  returns <A>arg</A> or <A>arg[1]</A> if <A>arg</A> is a list containing an 
##  argument in its first position. This is required as an <C>arg</C> is not 
##  input as a list but occurs as a list in the function where it is used. Hence
##  passing the <C>arg</C> to another function passes a list rather than the 
##  correct argument.
##  </Description>
##  </ManSection>
##	<#/GAPDoc>

DeclareGlobalFunction("SMALLSEMI_STRIP_ARG");

###########################################################################
##
##  <#GAPDoc Label="SMALLSEMI_RETURN">
##  <ManSection> 
##  <Func Name="SMALLSEMI_RETURN" Arg="arg"/>
##  <Description>
##	
##  <Example>
##  </Example>
##  </Description>
##  </ManSection>
##	<#/GAPDoc>
DeclareGlobalFunction("SMALLSEMI_RETURN");

###########################################################################
##
##  <#GAPDoc Label="SMALLSEMI_RS">
##  <ManSection> 
##  <Var Name="SMALLSEMI_RS" />
##  <Description>
##  <Example>
##  </Example>
##  </Description>
##  </ManSection>
##	<#/GAPDoc>

DeclareGlobalVariable("SMALLSEMI_RS");

###########################################################################
##
##  <#GAPDoc Label="SMALLSEMI_TAB_LEVEL">
##  <ManSection> 
##  <Func Name="SMALLSEMI_TAB_LEVEL" Arg="arg"/>
##  <Description>
##
##  <Example>
##  </Example>
##  </Description>
##  </ManSection>
##	<#/GAPDoc>

SMALLSEMI_TAB_LEVEL:=-1;

#OLD?
###################

#DeclareAttribute("ParentEnumOfSmallSemi", IsSmallSemigroup);
