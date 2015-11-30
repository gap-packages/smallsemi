#############################################################################
##
#W  small.gd                       Smallsemi - a GAP library of semigroups
#Y  Copyright (C) 2008-2012            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

## $Id$

###########################################################################
##
##  <#GAPDoc Label="EquivalenceSmallSemigroup">
##  <ManSection>
##  <Attr Name="EquivalenceSmallSemigroup" Arg="sgrp"/>
##  <Description>
##  returns a mapping <C>map</C> from <A>sgrp</A> to the semigroup in
##  <Package>Smallsemi</Package> equivalent to <A>sgrp</A>. The mapping
##  is an isomorphism if such exists and an anti-isomorphism otherwise.
##  The argument <A>sgrp</A> has to be a semigroup of size 8 or less,
##  otherwise an error is signalled.
##  <Example>
##  gap> sgrp:=Semigroup(Transformation( [ 1, 2, 2 ] ), 
##  > Transformation( [ 1, 2, 3 ] ));;
##  gap> EquivalenceSmallSemigroup(sgrp);
##  SemigroupHomomorphismByImages ( Monoid( 
##  [ Transformation( [ 1, 2, 2 ] ) ] )->&lt;small semigroup of size 2>)
##  </Example>
##  </Description>
##  </ManSection>
##	<#/GAPDoc>

DeclareAttribute("EquivalenceSmallSemigroup", IsSemigroup);

###########################################################################
##
##  <#GAPDoc Label="IdSmallSemigroup">
##  <ManSection>
##  <Attr Name="IdSmallSemigroup" Arg="sgrp"/>
##  <Description>
##  returns a pair <C>[m, n]</C> such that <M>(m,n)</M> is the ID of
##  a semigroup in <Package>Smallsemi</Package> equivalent to <A>sgrp</A>.
##  The argument <A>sgrp</A> has to be a semigroup of size 8 or less,
##  otherwise an error is signalled.
##  <Example>
##gap> sgrp:=Semigroup(Transformation( [ 1, 2, 2 ] ), Transformation( [ 1, 2, 3 ] ));;
##gap> IdSmallSemigroup(sgrp);
##[ 2, 3 ]
##  </Example>
##  </Description>
##  </ManSection>
##	<#/GAPDoc>

DeclareAttribute("IdSmallSemigroup", IsSemigroup);

###########################################################################
##
##  <#GAPDoc Label="InfoSmallsemi">
##  <ManSection>
##  <InfoClass Name="InfoSmallsemi"/>
##  <Description>
##  is the info class (see <Ref Subsect="Info Functions" BookName="ref"/>) of
##  <Package>Smallsemi</Package>. The info level is initially set to 1 which
##  triggers a message whenever data is loaded into &GAP;.
##  </Description>
##  </ManSection>
##	<#/GAPDoc>

DeclareInfoClass("InfoSmallsemi");

###########################################################################
##
##  <#GAPDoc Label="InfoSmallsemiEnums">
##  <ManSection>
##  <InfoClass Name="InfoSmallsemiEnums"/>
##  <Description>
##  is an info class (see <Ref Subsect="Info Functions" BookName="ref"/>) for
##  debugging the <Package>Smallsemi</Package> file <C>enums.gi</C>.
##  </Description>
##  </ManSection>
##	<#/GAPDoc>

DeclareInfoClass("InfoSmallsemiEnums");


###########################################################################
##
##  <#GAPDoc Label="IsSmallSemigroup">
##  <ManSection>
##  <Filt Name="IsSmallSemigroup" Arg="sgrp"/>
##  <Description>
##  returns <C>true</C> if <A>sgrp</A> is a semigroup from the library,
##  that is if it was created using <Ref Func="SmallSemigroup"/>. Otherwise
##  <C>false</C> is returned.<P/>
##  <Example>
##  gap> sgrp:=RandomSmallSemigroup(5);
##  &lt;small semigroup of size 5&gt;
##  gap> IsSmallSemigroup(sgrp);
##  true
##  gap> sgrp:=Semigroup(Transformation([1]));;
##  gap&gt; IsSmallSemigroup(sgrp);
##  false
##  </Example>
##  </Description>
##  </ManSection>
##	<#/GAPDoc>
##

DeclareCategory("IsSmallSemigroup", IsSemigroup);

###########################################################################
##
##  <#GAPDoc Label="IsSmallSemigroupElt">
##  <ManSection>
##  <Filt Name="IsSmallSemigroupElt" Arg="x"/>
##  <Description>
##  returns <C>true</C> if <A>x</A> is an element of a semigroup from the
##  library, and <C>false</C> otherwise.<P/>
##
##  <A>IsSmallSemigroupElt</A> is a
##  representation satisfying <A>IsPositionalObjectRep</A> and
##  <Ref Filt="IsMultiplicativeElement" BookName="ref"/> and
##  <A>IsAttributeStoringRep</A>.
##  <Example>
##  gap&gt; IsSmallSemigroupElt(Transformation([1]));
##  false
##  gap&gt; sgrp:=RandomSmallSemigroup(5);;
##  gap&gt; IsSmallSemigroupElt(Random(sgrp));
##  true
##  </Example>
##  </Description>
##  </ManSection>
##	<#/GAPDoc>
##

DeclareRepresentation( "IsSmallSemigroupElt",
IsPositionalObjectRep and IsMultiplicativeElement and IsAssociativeElement and IsAttributeStoringRep,
[ 2 ] );

###########################################################################
##
##  <#GAPDoc Label="RecoverMultiplicationTable">
##  <ManSection>
##  <Func Name="RecoverMultiplicationTable" Arg="m, n"/>
##  <Func Name="RecoverMultiplicationTableNC" Arg="m, n"/>
##  <Description>
##    return the multiplication table of the <A>n</A>-th semigroup with
##    <A>m</A> elements from the library.
##    <P/>
##    If <A>m</A> is greater than 8 or <A>n</A> greater than the number
##    of semigroups of size <A>m</A>, then <C>fail</C> is returned. The
##    NC version does not perform any tests on the input and will most likely
##    run into an error in such a case.
##  <Example>
##  gap> RecoverMultiplicationTable(10,2);
##  fail
##  gap> RecoverMultiplicationTable(1,2); 
##  fail
##  gap> RecoverMultiplicationTable(2,1);
##  [ [ 1, 1 ], [ 1, 1 ] ]
##  gap> RecoverMultiplicationTable(8,11111111);
##  [ [ 1, 1, 1, 1, 1, 1, 1, 1 ], [ 1, 1, 1, 1, 1, 1, 1, 3 ], 
##    [ 3, 3, 3, 3, 3, 3, 3, 3 ], [ 1, 1, 1, 4, 4, 4, 4, 1 ], 
##    [ 1, 2, 3, 4, 5, 6, 7, 1 ], [ 1, 2, 3, 4, 5, 6, 7, 1 ], 
##    [ 1, 2, 3, 4, 5, 6, 7, 1 ], [ 8, 8, 8, 8, 8, 8, 8, 8 ] ]
##  gap> RecoverMultiplicationTable(2,11111111);
##  fail
##  </Example>
##    Note that no semigroup is created calling this function but just the 
##    table is created. This makes it useful if one wants to perform very
##    simple (i.e. quick in &GAP;) tests on a large number of semigroups which
##    can be performed on the multiplication table.
##    <P/>
##    To create a semigroup with the multiplication table obtained by 
##    <C>RecoverMultiplicationTable(<A>m,n</A>)</C> use the function 
##    <Ref Func="SmallSemigroup"/> with arguments <A>m,n</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction("RecoverMultiplicationTable");
DeclareGlobalFunction("RecoverMultiplicationTableNC");

###########################################################################
##
##  <#GAPDoc Label="SemigroupByMultiplicationTableNC">
##  <ManSection>
##  <Func Name="SemigroupByMultiplicationTableNC" Arg="table"/>
##  <Description>
##  returns an object with <Ref Prop="IsSemigroup" BookName="ref"/>
##  and multiplication table <A>table</A> without
##  checking if the multiplication defined by the table is associative.<P/>
##
##  If <A>table</A> is not associative, this can lead to errors and wrong
##  results or might even crash &GAP;.
##
##  <Example>
##  gap&gt; s:=SemigroupByMultiplicationTableNC([[1,2],[2,1]]);
##  &lt;semigroup of size 2, with 2 generators&gt;
##  gap&gt; IsSmallSemigroup(s);
##  false
##  </Example>
##  Note that this function is <Emph>not</Emph> used to create semigroups when
##  <Ref Func="SmallSemigroup"/> is called. It can be useful in combination
##  with <Ref Func="RecoverMultiplicationTable"/> if one wants to avoid that
##  a semigroup knows it comes from the library.
##  </Description>
##  </ManSection>
##	<#/GAPDoc>
##

DeclareGlobalFunction("SemigroupByMultiplicationTableNC");

###########################################################################
##
##  <#GAPDoc Label="SmallSemigroup">
##  <ManSection>
##  <Func Name="SmallSemigroup" Arg="m, n"/>
##  <Func Name="SmallSemigroupNC" Arg="m, n"/>
##  <Description>
##  returns the semigroup with ID <M>(<A>m,n</A>)</M> from the library, that
##   is the <A>n</A>th semigroup with <A>m</A> elements.<P/>
##
##  In <C>SmallSemigroupNC</C> no check is performed to verify that <A>m</A> and <A>n</A>
##	are valid arguments. <P/>
##
##	In <C>SmallSemigroup</C> an error is signalled if the semigroups
##	of size <A>m</A> are not classified or if <A>n</A> is greater than the number of semigroups
##  with <A>m</A> elements.
##  <Example>
##  gap> SmallSemigroup(8,1353452);
##  &lt;small semigroup of size 8>
##  gap> SmallSemigroupNC(5,1);
##  &lt;small semigroup of size 5>
##  gap> SmallSemigroupNC(5,1)=SmallSemigroup(5,1);
##  true
##  </Example>
##  </Description>
##  </ManSection>
##	<#/GAPDoc>

DeclareGlobalFunction("SmallSemigroup");
DeclareGlobalFunction("SmallSemigroupNC");

############################################################################
##
##  <#GAPDoc Label="UnloadSmallsemiData">
##  <ManSection>
##  <Func Name="UnloadSmallsemiData" Arg="use_later"/>
##  <Description>
##	deletes most or all of the data from the &GAP; workspace that was
##      loaded by <Package>Smallsemi</Package>. <P/>
##
##      If the boolean <A>use_later</A> is <C>false</C> all data loaded by
##      <Package>Smallsemi</Package> is deleted from the workspace, in which
##      case <Package>Smallsemi</Package> is not guaranteed to work properly
##      without restarting your &GAP; session.
##      <P/>
##      If the boolean <A>use_later</A> is <C>true</C> only the recoverable data
##      is deleted. This leaves roughly 10 MB of data in the workspace.
##  </Description>
##  </ManSection>
##	<#/GAPDoc>
##

DeclareGlobalFunction("UnloadSmallsemiData");

######################
## GLOBAL VARIABLES ##
######################

###########################################################################
##
##  <#GAPDoc Label="3NIL_DATA">
##  <ManSection>
##  <Var Name="3NIL_DATA"/>
##  <Description>
##        is a record carrying data to restore 3-nilpotent semigroups of
##        size 8.<P/>
##        At the time <Package>Smallsemi</Package> is loaded only the component
##        <C>diag</C> is bound and has the value <C>fail</C>. This changes
##        when a 3-nilpotent semigroup of size 8 is called. Then <C>diag</C>
##        becomes a list element from the component <C>3nildiags</C> of the
##        global variable <Ref Var="MOREDATA2TO8"/> corresponding to the
##        diagonal of the last called 3-nilpotent semigroup of size 8.<P/>
##        The other components are <C>strlist</C>, a list of strings carrying
##        the information about the entries of the stored multiplication
##        tables; <C>positions</C>, a list of integers, the positions of the
##        stored solutions relative to the first one with the same diagonal and
##        <C>next</C>, an integer storing which position was last called for.
##  <Example>
##  gap&gt; LoadPackage("smallsemi");
##  true
##  gap&gt; 3NIL_DATA;
##  rec( diag := fail )
##  gap&gt; SmallSemigroup( 8, NrSmallSemigroups(8)-2 );;
##  gap&gt; 3NIL_DATA;
##  rec( diag := [ 2, 3 ], strlist := [ "0013", "0313" ],
##    positions := [ 1, 3, 4, 7 ], next := 4 )
##  </Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalVariable("3NIL_DATA",
                      "record carrying the current 3-nilpotent data");

###########################################################################
##
##  <#GAPDoc Label="BLUEPRINT_MATS">
##  <ManSection>
##  <Var Name="BLUEPRINT_MATS"/>
##  <Description>
##      see <Ref Func="GENERATE_BLUEPRINT_MATS"/>.
##  <Example>
##  gap&gt; Display( BLUEPRINT_MATS[3] );
##  [ [  1,  1,  1,  1,  1,  1,  1,  1 ],
##    [  1,  1,  1,  1,  1,  1,  1,  1 ],
##    [  1,  1,  1,  1,  1,  1,  1,  1 ],
##    [  1,  1,  1 ],
##    [  1,  1,  1 ],
##    [  1,  1,  1 ],
##    [  1,  1,  1 ],
##    [  1,  1,  1 ] ]
##  </Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalVariable("BLUEPRINT_MATS",
                      "list of matrices to built 3-nilpotent semigroups");

###########################################################################
##
##  <#GAPDoc Label="DATA2TO7">
##  <ManSection>
##  <Var Name="DATA2TO7"/>
##  <Description>
##      is a list containing the raw data of the multiplication tables of
##      semigroups of sizes <A>2</A> to <A>7</A>. The <M>i</M>-th entry is a
##      list of strings from which the multiplication tables of semigroups of
##      size <M>i+1</M> can be recovered.<P/>
##
##      The <M>i</M>-th entry is bound after the first call of
##      <Ref Func="RecoverMultiplicationTable" BookName="smallsemi"/>
##      with argument <A>i+1, j</A> for
##      some valid <A>j</A>.  The function
##      <Ref Func="UnloadSmallsemiData" BookName="smallsemi"/>
##      will unbind all entries.
##  <Example>
##  gap&gt; IsBound(DATA2TO7[1]);
##  false
##  gap&gt; RecoverMultiplicationTable(2,1);;
##  gap&gt; DATA2TO7[1];
##  [ "0100", "0101", "0011" ]
##  gap&gt; UnloadSmallsemiData(true);
##  gap&gt; DATA2TO7;
##  [  ]
##  </Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalVariable("DATA2TO7","raw data for semigroup tables sizes 2-7");

###########################################################################
##
##  <#GAPDoc Label="DATA8">
##  <ManSection>
##  <Var Name="DATA8"/>
##  <Description>
##      is a list containing the raw data of the multiplication tables of
##      semigroups of size <A>8</A>. The <A>i</A>-th entry is a list of strings
##      from which it is possible to recover the multiplication tables of semigroups with
##      diagonal equal to the <A>i</A>-th entry
##      in the component <C>diags</C> of the record <Ref Var="MOREDATA2TO8"/>.
##      <P/>
##      At most one entry of the list is bound at a time. The initial value
##      is the empty list. The variable is flushable.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalVariable("DATA8","raw data for semigroup tables size 8");

###########################################################################
##
##  <#GAPDoc Label="MOREDATA2TO8">
##  <ManSection>
##  <Var Name="MOREDATA2TO8"/>
##  <Description>
##	contains the precomputed information stored in the files <C>infon.g</C>
##	for <M>n</M> in <M>\{1,...,8\}</M> in a list where the <M>n</M>th entry
##	is a record with components named after the function values they store.
##	For example, to retrieve the stored value of the function
##	<C>MinimalGeneratorsOfSemigroup</C> for a semigroup <C>S</C> of size
##	<M>5</M> do
##	<Log>
##  MOREDATA2TO8[5].MinimalGeneratorsOfSemigroup[IdSmallSemigroup(S)[2]];
##	</Log>
##  </Description>
##  </ManSection>
##	<#/GAPDoc>

DeclareGlobalVariable("MOREDATA2TO8");

########################
## INTERNAL FUNCTIONS ##
########################

###########################################################################
##
##  <#GAPDoc Label="GENERATE_BLUEPRINT_MATS">
##  <ManSection>
##  <Func Name="GENERATE_BLUEPRINT_MATS" Arg=""/>
##  <Description>
##	generates a list of matrices bound for k in <M>\{2,...,7\}</M> such
##  that the k-th entry has k 'zero' rows and columns. To be stored in the
##  variable <C>BLUEPRINT_MATS</C>.
##  </Description>
##  </ManSection>
##	<#/GAPDoc>

DeclareGlobalFunction("GENERATE_BLUEPRINT_MATS");

#############################################################################
##
##  <#GAPDoc Label="READ_3NIL_DATA">
##  <ManSection>
##  <Func Name="READ_3NIL_DATA" Arg="diag"/>
##  <Description>
##      reads data to recover multiplication tables of 3-nilpotent
##      semigroups of size 8 into the global variable <Ref Var="3NIL_DATA"/>.
##      The data to be read is determined by <A>diag</A>. (All information for
##      multiplication tables of which <A>diag</A> is the part of the diagonal
##      belonging to the non zero rows and columns.) Is is assumed that
##      <A>diag</A> is an element in the component <C>3nildiags</C> of the
##      record <Ref Var="MOREDATA2TO8"/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction("READ_3NIL_DATA");

###########################################################################
##
##  <#GAPDoc Label="READ_MOREDATA2TO8">
##  <ManSection>
##  <Func Name="READ_MOREDATA2TO8" Arg="S"/>
##  <Description>
##	reads the precomputed information stored in the files <C>infon.g</C> for
##	<M>n</M> in <M>\{1,...,8\}</M> into the variable <C>MOREDATA2TO8</C>.
##  </Description>
##  </ManSection>
##	<#/GAPDoc>

DeclareGlobalFunction("READ_MOREDATA2TO8");

###########################################################################
##
##  <#GAPDoc Label="SmallSemigroupCreator">
##  <ManSection>
##  <Func Name="SmallSemigroupCreator" Arg="table"/>
##  <Description>
##  returns a small semigroup <A>s</A> with multiplication table
##  <A>table</A>. That is, an element in the category
##  <Ref Filt="IsSmallSemigroup"/> with
##  <Ref Attr="AsSSortedList" BookName="ref"/>,
##  <Ref Attr="GeneratorsOfSemigroup" BookName="ref"/>,
##  <Ref Attr="Size" BookName="ref"/>, and
## <Ref Attr="MultiplicationTable" BookName="ref"/> with the property
##  <Ref Prop="IsAssociative" BookName="ref"/> set to <C>true</C>.<P/>
##
##  Although this function can be used to create semigroups in the category
##  <Ref Filt="IsSmallSemigroup"/> where <A>table</A> is not a  table in the
##  library this may cause problems and there is no reason to do it! <P/>
##
##  If you want to create semigroups from multiplication table, then use either
##  <Ref Func="SemigroupByMultiplicationTableNC"/> if you know the table is
##  associative, or <Ref Func="MagmaByMultiplicationTable" BookName="ref"/> if
##  you do not know.
##  <Example>
##gap&gt; RecoverMultiplicationTable(5, 1000);
##[ [ 1, 1, 1, 1, 1 ], [ 1, 1, 1, 1, 1 ], [ 1, 2, 3, 4, 5 ], [ 1, 2, 4, 5, 3 ],
##  [ 1, 2, 5, 3, 4 ] ]
##gap&gt; SmallSemigroupCreator(last);
##&lt;small semigroup of size 5&gt;
##  </Example>
##  </Description>
##  </ManSection>
##	<#/GAPDoc>
##

DeclareGlobalFunction("SmallSemigroupCreator");

###########################################################################
##
##  <#GAPDoc Label="SmallSemigroupEltFamily">
##  <ManSection>
##  <Var Name="SmallSemigroupEltFamily"/>
##  <Description>
##  <A>SmallSemigroupEltFamily</A> is a global variable containing the family
##  of elements satisfying <A>IsSmallSemigroupElt</A>. <P/>
##
##  The value of <A>SmallSemigroupEltFamily</A> is installed when
##  <Package>Smallsemi</Package> is loaded.  This is done to avoid the cost of
##  repeatedly creating a new family when, say, running through the semigroups
##  of order <M>8</M>.
##  <Example>
##  gap&gt; SmallSemigroupEltFamily;
##  NewFamily( "SmallSemigroupEltFamily", [ 2201 ], [ 35, 36, 38, 114, 117, 120, 2201 ] )
##  </Example>
##  </Description>
##  </ManSection>
##	<#/GAPDoc>
##

BindGlobal("SmallSemigroupEltFamily", NewFamily("SmallSemigroupEltFamily", IsSmallSemigroupElt));

###########################################################################
##
##  <#GAPDoc Label="SmallSemigroupEltType">
##  <ManSection>
##  <Var Name="SmallSemigroupEltType"/>
##  <Description>
##  <A>SmallSemigroupEltType</A> is a global variable containing the type of
##  <A>IsSmallSemigroupElt</A>.<P/>
##
##  The value of <A>SmallSemigroupEltType</A> is installed when
##  <Package>Smallsemi</Package> is loaded.  This is done to avoid the cost of
##  repeatedly creating a new family when, say, running through the semigroups
##  of order <M>8</M>.
##  <Example>
##  gap&gt; SmallSemigroupEltType;
##  NewType( NewFamily( "SmallSemigroupEltFamily", [ 2201 ],
##  [ 35, 36, 38, 114, 117, 120, 2201 ] ), [ 35, 36, 38, 114, 117, 120, 2201 ] )
##  </Example>
##  </Description>
##  </ManSection>
##	<#/GAPDoc>
##

BindGlobal("SmallSemigroupEltType", NewType(SmallSemigroupEltFamily, IsSmallSemigroupElt));

###########################################################################
##
##  <#GAPDoc Label="SmallSemigroupType">
##  <ManSection>
##  <Var Name="SmallSemigroupType"/>
##  <Description>
##  <A>SmallSemigroupType</A> is a global variable containing the type of
##  the collections family of <A>IsSmallSemigroupEltFamily</A>.<P/>
##
##  The value of <A>SmallSemigroupType</A> is installed when
##  <Package>Smallsemi</Package> is loaded.  This is done to avoid the cost of
##  repeatedly creating a new family when, say, running through the semigroups
##  of order <M>8</M>.
##
##  <Example>
##  gap&gt; SmallSemigroupType;
##  NewType( NewFamily( "CollectionsFamily(...)", [ 52 ],
##  [ 51, 52, 114, 115, 117, 118, 121, 133 ] ),
##  [ 36, 38, 51, 52, 90, 91, 114, 115, 117, 118, 121, 133, 196, 420, 431, 432,
##    2200 ] )
##  </Example>
##  </Description>
##  </ManSection>
##	<#/GAPDoc>
##

BindGlobal("SmallSemigroupType", NewType(CollectionsFamily( SmallSemigroupEltFamily ),
IsSmallSemigroup and IsAttributeStoringRep));
