# This file contains functions that are used in the development of the 
# smallsemi package and will *not* be part of the release version. 
# JDM 02/04/08


DeclareGlobalFunction("SemigroupsWithCoclass1");

DeclareGlobalFunction("SemigroupsWithCoclassD_NC");

DeclareGlobalFunction("SemigroupsWithCoclassD");

DeclareGlobalFunction("SemigroupsWithCoclass2And3Generators");

DeclareGlobalFunction("SemigroupsWithCoclass2And2Generators");

###########################################################################
##
##  <#GAPDoc Label="STORE_SEMI_INFO">
##  <ManSection> 
##  <Func Name="STORE_SEMI_INFO" Arg="file, name, content"/>
##  <Description>
##	this function appends <C>content</C> to the file with  
##	name <C>file</C>. This file is assumed to carry a record and thus
##      the printed version of <C>content</C> should better be GAP-readable!
##      <P/>
##      The string <C>name</C> will be the identifier for the record component
##      taking <C>content</C> as value.
##  </Description>
##  </ManSection>
##	<#/GAPDoc>
DeclareGlobalFunction("STORE_SEMI_INFO");

DeclareGlobalFunction("DELETE_SEMI_INFO");

DeclareGlobalFunction("SUBSTITUTE_SEMI_INFO");

DeclareGlobalFunction("RENAME_SEMI_INFO");

DeclareGlobalFunction("STORE_POS_SEMIS_FUNC_VAL");

##	
##	For example, to store the value of <C>MinimalGeneratorsOfSemigroup</C> for every semigroup of order <M>2</M> do the following.
##	<Example>
##  STORE_SEMIGROUP_FUNCTION(2, StoreMinimalGeneratorsOfSemigroup,
##  "MinimalGeneratorsOfSemigroup", "info2.g", true);
##	</Example>

