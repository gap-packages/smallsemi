#############################################################################
##
#W  properties.gi                  Smallsemi - a GAP library of semigroups
#Y  Copyright (C) 2008-2012            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

## $Id$

##  The functions in this file are used to test whether a given 
##  small semigroup has a given property.  

InstallMethod( Annihilators, "for a small semigroup", [ IsSmallSemigroup ],
function( sg )
    local n,       # size of the <sg>
          mt,      # multiplication table of <sg>
          zero,    # index of the zero element in <sg>
          indices; # indices of annihilators in <sg>

    # AD maybe this should run into an error or return the empty list?
    if not IsSemigroupWithZero( sg ) then return fail; fi;

    n := Size( sg );
    mt := MultiplicationTable( sg );
    zero := MultiplicativeZero( sg )!.index;

    indices := Filtered( [ 1..n ], i -> Unique( mt{[ 1..n ]}[i] ) = [ zero ] 
                                        and Unique( mt[i] ) = [ zero ] );

    return Elements( sg ){ indices };
end);

###########################################################################

InstallMethod(DiagonalOfMultiplicationTable, "for a semigroup", true,
[IsSemigroup and HasIsFinite and IsFinite], 0,
x -> DiagonalOfMat(MultiplicationTable(x)));

###########################################################################

InstallGlobalFunction(DisplaySmallSemigroup, 
function(s)
local id, pre, out, info, max, eval, tab;
if not IsSmallSemigroup(s) then 
	return fail;
fi;

id:=IdSmallSemigroup(s);
# collect function names for display
info:=Concatenation(PrecomputedSmallSemisInfo[id[1]],
                    ["IsSemigroupWithClosedIdempotents",
                     "IsMonogenicSemigroup",
                     "IsRectangularBand",
                     "IsOrthodoxSemigroup",
                     "IsBrandtSemigroup"]);

# delete those that we do not want to display, sort alphabetically
info:=Difference(info,["IsSemigroupWithoutClosedIdempotents",
                       "Is1GeneratedSemigroup",
                       "Is2GeneratedSemigroup",
                       "Is3GeneratedSemigroup",
                       "Is4GeneratedSemigroup",
                       "Is5GeneratedSemigroup",
                       "Is6GeneratedSemigroup",
                       "Is7GeneratedSemigroup",
                       "Is8GeneratedSemigroup"]);

# glue things at the end of the display
info := Concatenation( info, [ "MinimalGeneratingSet", "Idempotents",
                               "GreensRClasses","GreensLClasses",
                               "GreensHClasses","GreensDClasses"] );
                 
out:=[];
max:=Maximum(List(info, Length));

for pre in info do
		eval:=EvalString(pre)(s);
		tab:=Concatenation(List([1..(max-Length(pre))+3], x-> " "));
		Add(out, Concatenation(pre, ":", tab, String(eval), "\n"));
od;

Print(Concatenation(out));
end);

#############################################################################

InstallMethod( Idempotents, "for a small semigroup", [IsSmallSemigroup],
function(s)
    local i, idems;

    idems := EmptyPlist( 1 );
    for i in [ 1..Size(s) ] do
        if MultiplicationTable(s)[i][i] = i then Add(idems,i); fi;
    od;

    return Elements(s){idems};
end);


#############################################################################

InstallMethod(IndexPeriod, "for a small semigroup elt", true, [IsSmallSemigroupElt], 0, 
function(x)
local i, y, m, powers;

i:=1;
y:=x;
powers:=[y];

repeat 
	i:=i+1; 
	y:=y*x;
	Add(powers, y);
until not IsDuplicateFreeList(powers);

m:=Position(powers, powers[i]);

return [m, Length(powers)-m];
end);


###########################################################################


InstallMethod(IsBand, "for a small semigroup",
true, [IsSmallSemigroup], 0,
function(s)

if HasIsCompletelyRegularSemigroup(s) and not IsCompletelyRegularSemigroup(s) then 
   return false;
else
	return DiagonalOfMat(s!.table)=[1..Size(s)];
fi; 
end);

###########################################################################

InstallMethod(IsBrandtSemigroup, "for a small semigroup", 
true, [IsSmallSemigroup], 0, 
function(s)

if HasIsInverseSemigroup(s) and not IsInverseSemigroup(s) then 
	return false;
elif HasIsZeroSimpleSemigroup(s) and not IsZeroSimpleSemigroup(s) then 
	return false;
fi;

return IsInverseSemigroup(s) and IsZeroSimpleSemigroup(s);
end);

###########################################################################

InstallMethod(IsCliffordSemigroup, "for a small semigroup", true, [IsSmallSemigroup], 0, 
function(M)

if HasIsInverseSemigroup(M) and not IsInverseSemigroup(M) then 
	return false;
elif HasIsRegularSemigroup(M) and not IsRegularSemigroup(M) then 
	return false;
elif HasIsCompletelyRegularSemigroup(M) and not IsCompletelyRegularSemigroup(M) then 
	return false;
elif HasIsGroupAsSemigroup(M) and IsGroupAsSemigroup(M) then 
	return true;
else
	if ForAll(Idempotents(M), x-> x in Center(M)) then 
		return IsRegularSemigroup(M);
	fi;
fi;

return false;

end);

###########################################################################

InstallMethod(IsCommutativeSemigroup, "for a small semigroup", true, [IsSmallSemigroup], 0,
function(M)
return IsCommutative(M);
end);

###########################################################################

InstallMethod(IsCompletelySimpleSemigroup, "for a small semigroup",
[IsSmallSemigroup], IsSimpleSemigroup);

InstallMethod(IsSemiband, "for a small semigroup",
[IsSmallSemigroup], IsIdempotentGenerated);

InstallMethod(IsSemilatticeAsSemigroup, "for a small semigroup", 
[IsSmallSemigroup], s-> IsCommutative(s) and IsBand(s));

###########################################################################

InstallMethod( IsCompletelyRegularSemigroup, "for a small semigroup", true, [IsSmallSemigroup], 0,  
function(M)

if HasIsRegularSemigroup(M) and not IsRegularSemigroup(M) then 
	return false;
elif IsRegularSemigroup(M) then 
	return Length(GreensHClasses(M))=Length(Idempotents(M));
fi;

return false;
end);

###########################################################################

InstallMethod(IsFullTransformationSemigroupCopy, "for a small semigroup", 
[IsSmallSemigroup], function(s)
    return IdSmallSemigroup(s)=[4,96] or IdSmallSemigroup(s)=[1,1];
end);


###########################################################################

InstallMethod(IsGroupAsSemigroup, "for a small semigroup", true, [IsSmallSemigroup], 0, 
function(s)
local table, id;

id:=IdSmallSemigroup(s);

table:=ShallowCopy(MultiplicationTable(s));
return ForAll(table, x-> AsSet(x)=[1..Size(s)]) and ForAll(TransposedMat(table), x-> AsSet(x)=[1..Size(s)]);

SetIsRegularSemigroup(s, true);
SetIsSimpleSemigroup(s, true);
SetIsCompletelyRegularSemigroup(s, true);
SetIsCliffordSemigroup(s, true);
if Size(s)>1 then 
	SetIsRectangularBand(s, false);
else
	SetIsRectangularBand(s, true);
fi;
end);

###########################################################################

InstallMethod(IsIdempotentGenerated, "for a small semigroup", 
true, [IsSmallSemigroup], 0, function(S)

    # semigroup contains only idempotents
    if IsBand(S) then 
	return true;
    # in a nilpotent semigroup zero does not generate the semigroup 
    # (except if size is 1, but then it is already a band)
    elif IsNilpotentSemigroup(S) then
        return false;
    fi;

    return Size(Semigroup(Idempotents(S)))=Size(S);
end);

###########################################################################
#JDM is the `other' required here? 

InstallMethod(IsInverseSemigroup, "for a small semigroup", 
true, [IsSmallSemigroup], 0,
function(M)
local i, j, idem;

if HasIsCliffordSemigroup(M) and IsCliffordSemigroup(M) then 
	return true;
elif IsRegularSemigroup(M) then 
idem:=Idempotents(M);

for i in [1..Length(idem)] do 
	for j in [i+1..Length(idem)] do
		if not idem[i]*idem[j]=idem[j]*idem[i] then 	
			return false;
		fi;
	od;
od;
return true;
fi;

return false;

end);

###########################################################################

InstallMethod(IsLeftZeroSemigroup, "for a small semigroup", 
true, [IsSmallSemigroup], 0,
function(S)
    local table, i, j;

    table := MultiplicationTable( S );
    for i in [ 1..Size(S) ] do
        for j in [ 1..Size(S) ] do
            # for every entry test whether it equals its row index
            if table[i][j] <> i then
                return false;
            fi;
        od;
    od;

    return true;
end);

###################

InstallMethod(IsMonoidAsSemigroup, "for a small semigroup", true, [IsSmallSemigroup], 0, 
function(S)
local table, id, pos;

table:=MultiplicationTable(S);
id:=IdSmallSemigroup(S);

pos:=Position(table, [1..id[1]]);

if not pos=fail then 
	return List(table, x-> x[pos])=[1..id[1]];
fi;

return false;
end);

###################

InstallMethod(IsMultSemigroupOfNearRing, "for a small semigroup", true,
[IsSmallSemigroup], 0, 
function(s)
    local id, vals;

    id := IdSmallSemigroup(s);
    vals := STORED_INFO( id[1], "IsMultSemigroupOfNearRing" );

    if id[2] in vals then
        return true;
    else
        return false;
    fi;
end);


#########################

InstallMethod(IsNGeneratedSemigroup, "for a small semigroup and a pos. int", 
[IsSmallSemigroup, IsPosInt], function(S, n)
    local id, funcname, idlist;

    id:=IdSmallSemigroup(S);

    if n > id[1] then
        return false;
    fi;

    funcname := Concatenation("Is",String(n),"GeneratedSemigroup");

    idlist := STORED_INFO( id[1], funcname );

    if not idlist=fail then 
	return id[2] in idlist;
    else
	return Length(MinimalGeneratingSet(S))=n;
    fi;
end);

#########################

InstallMethod(Is1GeneratedSemigroup, "for a small semigroup", true, 
[IsSmallSemigroup], 0, function(S)
local out;

out:=IsNGeneratedSemigroup(S, 1);
if out then 
	SetIs2GeneratedSemigroup(S, false);
	SetIs3GeneratedSemigroup(S, false); 
	SetIs4GeneratedSemigroup(S, false);
	SetIs5GeneratedSemigroup(S, false);
	SetIs6GeneratedSemigroup(S, false);
	SetIs7GeneratedSemigroup(S, false);
	SetIs8GeneratedSemigroup(S, false);
fi;
return out;
end);

#########################

InstallMethod(Is2GeneratedSemigroup, "for a small semigroup", true, 
[IsSmallSemigroup], 0, function(S)
local out;

out:=IsNGeneratedSemigroup(S, 2);
if out then 
	SetIs1GeneratedSemigroup(S, false);
	SetIs3GeneratedSemigroup(S, false); 
	SetIs4GeneratedSemigroup(S, false);
	SetIs5GeneratedSemigroup(S, false);
	SetIs6GeneratedSemigroup(S, false);
	SetIs7GeneratedSemigroup(S, false);
	SetIs8GeneratedSemigroup(S, false);
fi;
return out;
end);

#########################

InstallMethod(Is3GeneratedSemigroup, "for a small semigroup", true, 
[IsSmallSemigroup], 0, function(S)
local out;

out:=IsNGeneratedSemigroup(S, 3);
if out then 
	SetIs1GeneratedSemigroup(S, false);
	SetIs2GeneratedSemigroup(S, false); 
	SetIs4GeneratedSemigroup(S, false);
	SetIs5GeneratedSemigroup(S, false);
	SetIs6GeneratedSemigroup(S, false);
	SetIs7GeneratedSemigroup(S, false);
	SetIs8GeneratedSemigroup(S, false);
fi;
return out;
end);

#########################

InstallMethod(Is4GeneratedSemigroup, "for a small semigroup", true, 
[IsSmallSemigroup], 0, function(S)
local out;

out:=IsNGeneratedSemigroup(S, 4);
if out then 
	SetIs1GeneratedSemigroup(S, false);
	SetIs2GeneratedSemigroup(S, false); 
	SetIs3GeneratedSemigroup(S, false);
	SetIs5GeneratedSemigroup(S, false);
	SetIs6GeneratedSemigroup(S, false);
	SetIs7GeneratedSemigroup(S, false);
	SetIs8GeneratedSemigroup(S, false);
fi;
return out;
end);

#########################

InstallMethod(Is5GeneratedSemigroup, "for a small semigroup", true, 
[IsSmallSemigroup], 0, function(S)
local out;

out:=IsNGeneratedSemigroup(S, 5);
if out then 
	SetIs1GeneratedSemigroup(S, false);
	SetIs2GeneratedSemigroup(S, false); 
	SetIs3GeneratedSemigroup(S, false);
	SetIs4GeneratedSemigroup(S, false);
	SetIs6GeneratedSemigroup(S, false);
	SetIs7GeneratedSemigroup(S, false);
	SetIs8GeneratedSemigroup(S, false);
fi;
return out;
end);

#########################

InstallMethod(Is6GeneratedSemigroup, "for a small semigroup", true, 
[IsSmallSemigroup], 0, function(S)
local out;

out:=IsNGeneratedSemigroup(S, 6);
if out then 
	SetIs1GeneratedSemigroup(S, false);
	SetIs2GeneratedSemigroup(S, false); 
	SetIs3GeneratedSemigroup(S, false);
	SetIs4GeneratedSemigroup(S, false);
	SetIs5GeneratedSemigroup(S, false);
	SetIs7GeneratedSemigroup(S, false);
	SetIs8GeneratedSemigroup(S, false);
fi;
return out;
end);

#########################

InstallMethod(Is7GeneratedSemigroup, "for a small semigroup", true, 
[IsSmallSemigroup], 0, function(S)
local out;

out:=IsNGeneratedSemigroup(S, 7);
if out then 
	SetIs1GeneratedSemigroup(S, false);
	SetIs2GeneratedSemigroup(S, false); 
	SetIs3GeneratedSemigroup(S, false);
	SetIs4GeneratedSemigroup(S, false);
	SetIs5GeneratedSemigroup(S, false);
	SetIs6GeneratedSemigroup(S, false);
	SetIs8GeneratedSemigroup(S, false);
fi;
return out;
end);

#########################

InstallMethod(Is8GeneratedSemigroup, "for a small semigroup", true, 
[IsSmallSemigroup], 0, function(S)
local out;

out:=IsNGeneratedSemigroup(S, 8);
if out then 
	SetIs1GeneratedSemigroup(S, false);
	SetIs2GeneratedSemigroup(S, false); 
	SetIs3GeneratedSemigroup(S, false);
	SetIs4GeneratedSemigroup(S, false);
	SetIs5GeneratedSemigroup(S, false);
	SetIs6GeneratedSemigroup(S, false);
	SetIs7GeneratedSemigroup(S, false);
fi;
return out;
end);

#########################
#########################
#########################

###########################################################################
# Is there really a point in having Is<n>IdempotentSemigroup functions
# if they don't do something more clever than calling Length(Idempotents)?
# (It's not needed for enumerator etc., is it?)
#
# Besides, storing of the values should probably behave in a different way.
# The values for Is<n>IdempotentSemigroup are at the moment not known after
# calling IsNIdempotentSemigroup (compare maybe MovedPoints vs. NrMovedPoints
# for Permutations). 
#
InstallMethod(IsNIdempotentSemigroup, "for a small semigroup and a pos. int", 
true, [IsSmallSemigroup, IsPosInt], 0, 
function(S, n)

if n>Size(S) then 
	return false;
fi;

if IsBand(S) then 
	if n=Size(S) then 
		return true;
	fi;
	return false;
fi;

return Length(Idempotents(S))=n;
end);

#########################

InstallMethod(Is1IdempotentSemigroup, "for a small semigroup", true, 
[IsSmallSemigroup], 0, function(S)
local out;

out:=IsNIdempotentSemigroup(S, 1);
if out then 
	SetIs2IdempotentSemigroup(S, false);
	SetIs3IdempotentSemigroup(S, false); 
	SetIs4IdempotentSemigroup(S, false);
	SetIs5IdempotentSemigroup(S, false);
	SetIs6IdempotentSemigroup(S, false);
	SetIs7IdempotentSemigroup(S, false);
	SetIs8IdempotentSemigroup(S, false);
fi;
return out;
end);

#########################

InstallMethod(Is2IdempotentSemigroup, "for a small semigroup", true, 
[IsSmallSemigroup], 0, function(S)
local out;

out:=IsNIdempotentSemigroup(S, 2);
if out then 
	SetIs1IdempotentSemigroup(S, false);
	SetIs3IdempotentSemigroup(S, false); 
	SetIs4IdempotentSemigroup(S, false);
	SetIs5IdempotentSemigroup(S, false);
	SetIs6IdempotentSemigroup(S, false);
	SetIs7IdempotentSemigroup(S, false);
	SetIs8IdempotentSemigroup(S, false);
fi;
return out;
end);

#########################

InstallMethod(Is3IdempotentSemigroup, "for a small semigroup", true, 
[IsSmallSemigroup], 0, function(S)
local out;

out:=IsNIdempotentSemigroup(S, 3);
if out then 
	SetIs2IdempotentSemigroup(S, false);
	SetIs1IdempotentSemigroup(S, false); 
	SetIs4IdempotentSemigroup(S, false);
	SetIs5IdempotentSemigroup(S, false);
	SetIs6IdempotentSemigroup(S, false);
	SetIs7IdempotentSemigroup(S, false);
	SetIs8IdempotentSemigroup(S, false);
fi;
return out;
end);

#########################

InstallMethod(Is4IdempotentSemigroup, "for a small semigroup", true, 
[IsSmallSemigroup], 0, function(S)
local out;

out:=IsNIdempotentSemigroup(S, 4);
if out then 
	SetIs2IdempotentSemigroup(S, false);
	SetIs3IdempotentSemigroup(S, false); 
	SetIs1IdempotentSemigroup(S, false);
	SetIs5IdempotentSemigroup(S, false);
	SetIs6IdempotentSemigroup(S, false);
	SetIs7IdempotentSemigroup(S, false);
	SetIs8IdempotentSemigroup(S, false);
fi;
return out;
end);

#########################

InstallMethod(Is5IdempotentSemigroup, "for a small semigroup", true, 
[IsSmallSemigroup], 0, function(S)
local out;

out:=IsNIdempotentSemigroup(S, 5);
if out then 
	SetIs2IdempotentSemigroup(S, false);
	SetIs3IdempotentSemigroup(S, false); 
	SetIs4IdempotentSemigroup(S, false);
	SetIs1IdempotentSemigroup(S, false);
	SetIs6IdempotentSemigroup(S, false);
	SetIs7IdempotentSemigroup(S, false);
	SetIs8IdempotentSemigroup(S, false);
fi;
return out;
end);

#########################

InstallMethod(Is6IdempotentSemigroup, "for a small semigroup", true, 
[IsSmallSemigroup], 0, function(S)
local out;

out:=IsNIdempotentSemigroup(S, 6);
if out then 
	SetIs2IdempotentSemigroup(S, false);
	SetIs3IdempotentSemigroup(S, false); 
	SetIs4IdempotentSemigroup(S, false);
	SetIs5IdempotentSemigroup(S, false);
	SetIs1IdempotentSemigroup(S, false);
	SetIs7IdempotentSemigroup(S, false);
	SetIs8IdempotentSemigroup(S, false);
fi;
return out;
end);

#########################

InstallMethod(Is7IdempotentSemigroup, "for a small semigroup", true, 
[IsSmallSemigroup], 0, function(S)
local out;

out:=IsNIdempotentSemigroup(S, 7);
if out then 
	SetIs2IdempotentSemigroup(S, false);
	SetIs3IdempotentSemigroup(S, false); 
	SetIs4IdempotentSemigroup(S, false);
	SetIs5IdempotentSemigroup(S, false);
	SetIs6IdempotentSemigroup(S, false);
	SetIs1IdempotentSemigroup(S, false);
	SetIs8IdempotentSemigroup(S, false);
fi;
return out;
end);

#########################

InstallMethod(Is8IdempotentSemigroup, "for a small semigroup", true, 
[IsSmallSemigroup], 0, function(S)
local out;

out:=IsNIdempotentSemigroup(S, 8);
if out then 
	SetIs2IdempotentSemigroup(S, false);
	SetIs3IdempotentSemigroup(S, false); 
	SetIs4IdempotentSemigroup(S, false);
	SetIs5IdempotentSemigroup(S, false);
	SetIs6IdempotentSemigroup(S, false);
	SetIs7IdempotentSemigroup(S, false);
	SetIs1IdempotentSemigroup(S, false);
fi;
return out;
end);

#########################
#########################
#########################

InstallMethod(IsNilpotent, "for a small semigroup", true, [IsSmallSemigroup],
IsNilpotentSemigroup);

InstallMethod(IsNilpotentSemigroup,"for a small semigroup",[IsSmallSemigroup],
function( S )

    if ForAll( [2..Size(S)], i -> MultiplicationTable( S )[i][i] <> i ) and
       IsSemigroupWithZero( S ) then
        return true;
    else
        return false;
    fi;
end);

###########################################################################

InstallTrueMethod(IsOrthodoxSemigroup,
                  IsSemigroupWithClosedIdempotents and IsRegularSemigroup);

InstallMethod(IsOrthodoxSemigroup, "for a semigroup", [IsSemigroup],
function(s)
    return IsSemigroupWithClosedIdempotents(s) and IsRegularSemigroup(s);
end);

###########################################################################

InstallMethod(IsRectangularBand, "for a small semigroup", 
true, [IsSmallSemigroup], 0,
function(s)
return IsBand(s) and IsSimpleSemigroup(s);
end);

###########################################################################

InstallMethod(IsRegularSemigroup, "for a small semigroup", true, [IsSmallSemigroup], 0,
function ( s )

if HasIsCompletelyRegularSemigroup(s) and IsCompletelyRegularSemigroup(s) then 
	return true;
elif HasIsGroupAsSemigroup(s) and IsGroupAsSemigroup(s) then 
	return true;
elif IsBand(s) then 
	return true;
else
	return ForAll(GreensRClasses(s), x-> ForAny(Idempotents(s), y-> y in x));
fi;

end);

###########################################################################
# no semigroup in smallsemi is right zero, keep code for change of methods to
# be applicable to every semigroup with multiplication table
#

InstallMethod(IsRightZeroSemigroup, "for a small semigroup", 
[IsSmallSemigroup], function(s)

    Info(InfoSmallsemi, 1, "Semigroups are stored up to isomorphism ",
         "and anti-isomorphism in Smallsemi");
    Info(InfoSmallsemi, 1, 
         "and there are only left zero semigroups in the library.");

    return false;
end);

#true, [IsSmallSemigroup], 0,
#function(S)
#    local table, i, j;
#
#    table := MultiplicationTable( S );
#    for i in [ 1..Size(S) ] do
#        for j in [ 1..Size(S) ] do
#            # for every entry test whether it equals its column index
#            if table[i][j] <> j then
#                return false;
#            fi;
#        od;
#    od;
#
#    return true;
#end);

###########################################################################

InstallMethod(IsSemigroupWithClosedIdempotents, "for a small semigroup", 
true, [IsSmallSemigroup], 0,
function(s)
    local idems, i, j;

    if HasIsBand(s) and IsBand(s) then 
        return true;
    fi;

    if HasIsNilpotentSemigroup(s) and IsNilpotentSemigroup(s) then 
        return true;
    fi;

    # most likely one idempotent
    idems := EmptyPlist(1);
    for i in [ 1..Size(s) ] do
        if MultiplicationTable(s)[i][i] = i then Add(idems,i); fi;
    od;

    # AD the following seems natural but slows down the computation by a factor
    # AD of 4. To have a separate call to 'Idempotents' if necessary seems the
    # AD better solution.
    #SetIdempotents( s, AsSSotedList(s){idems} );

    for i in idems do
        for j in idems do
            if i <> j and not MultiplicationTable(s)[i][j] in idems then
                return false;
            fi;
        od;
    od;

    return true;
end);

###########################################################################

InstallMethod(IsSemigroupWithoutClosedIdempotents, "for a small semigroup", 
true, [IsSmallSemigroup], 0,
function(s)

return not IsSemigroupWithClosedIdempotents(s);
end);

###########################################################################

InstallMethod(IsSemigroupWithZero, "for a small semigroup", [IsSmallSemigroup],
function(s)
    local i, hasleftzero;

    hasleftzero := false;
    # search for a left zero
    for i in [ 1..Size(s) ] do
        if ForAll([ 1..Size(s) ], j -> MultiplicationTable(s)[i][j] = i) then
            hasleftzero := true;
            break;
        fi;
    od;

    if hasleftzero then
        # test whether the left zero is as well a right zero
        return ForAll([ 1..Size(s) ], j -> MultiplicationTable(s)[j][i] = i);
    else
        # there is no left zero
        return false;
    fi;
end);

#    # get idempotent elements -> possible zeros
#    idems := EmptyPlist(1);
#    for i in [ 1..Size(s) ] do
#        if MultiplicationTable(s)[i][i] = i then Add(idems,i); fi;
#    od;
#
#    # idempotent is zero if all entries in row and column are equal to it
#    for id in idems do
#        bool := true;
#        for i in [ 1..Size(s) ] do
#        od;
#        if bool then return true; fi;
#    od;
#
#    return false;
#end);

#############################################################################

InstallMethod( IsSelfDualSemigroup, "for a small semigroup",
 [ IsSmallSemigroup ], function( S )
    local orbit,NumLit,tbl2lits,onLiterals,n,LitNum,phi,literals,vals;

    LitNum := function(ln, n)
        return [QuoInt(ln-1,n^2)+1,QuoInt((ln-1) mod n^2,n)+1,(ln-1) mod n+1];
    end;
 
    NumLit := function(lit,n)
        local row,col, val;
        row := lit[1];
        col := lit[2];
        val := lit[3];
        return val+(row-1)*n^2+(col-1)*n;
    end;

    tbl2lits := function(table,n)
        local i,j,literals, val;
        literals := [];
        for i in [1..n] do
            for j in [1..n] do
                val :=  table[i][j];
                Add(literals, NumLit([i,j,val],n));
            od;
        od;

        return literals;
    end;

    onLiterals := n->function(ln,pi)
        local lit,imlit;
        lit := LitNum(ln,n);
        imlit := OnTuples(lit,pi);
        if (n+1)^pi = n+2 then
                imlit := Permuted(imlit,(1,2));
        fi;
        return NumLit(imlit,n);
    end;

    n := Size( S );
    vals := STORED_INFO( n, "IsSelfDualSemigroup" );
    if vals = fail then
        if IsCommutativeSemigroup( S ) then
            return true;
        fi;
        phi := ActionHomomorphism(SymmetricGroup(n),[1..n^3],onLiterals(n));
        literals := tbl2lits( MultiplicationTable( S ), n );
        orbit := Orbit( Image( phi, SymmetricGroup( n ) ), literals, OnSets );

        if tbl2lits(TransposedMat(MultiplicationTable( S )), n) in orbit then
            return true;
        else
            return false;
        fi;
    else
        return IdSmallSemigroup(S)[2] in vals;
    fi;
end);

###########################################################################

InstallMethod( IsSimpleSemigroup, "for a small semigroup", true, [IsSmallSemigroup], 0,  
function(M)

if IsGroupAsSemigroup(M) then 
	return true;
elif HasIsCompletelyRegularSemigroup(M) and not IsCompletelyRegularSemigroup(M) then 
	return false;
fi;

if Length(GreensDClasses(M))=1 then 
	SetIsCompletelyRegularSemigroup(M,true);
	SetIsRegularSemigroup(M, true);
	return true;
fi;

return false;

end);

###########################################################################

InstallMethod(IsSingularSemigroupCopy, "for a small semigroup", 
[IsSmallSemigroup], function(s)
    return IdSmallSemigroup(s)=[2,4];
end);

###########################################################################

#JDM the following method could surely be better

InstallMethod(IsZeroGroup, "for a small semigroup", true, [IsSmallSemigroup], 0, 
function(s)
local zero, elts;

zero:=MultiplicativeZero(s);
if not zero=fail then 
	elts:=Difference(Elements(s), [zero]);
	return IsGroupAsSemigroup(SmallSemigroup(IdSmallSemigroup(Semigroup(elts))));
fi;	#JDM the previous line is a good example of why IsomorphismSmallSemigroup is required 
        # AD shouldn't this rather be something like:
        # AD return fail <> AsGroup( elts );
return false;

end);

###########################################################################

InstallMethod(IsZeroSemigroup, "for a small semigroup",
[IsSmallSemigroup], 
function(s)
    return Length( Unique( Flat(MultiplicationTable(s)))) = 1;
end);

###########################################################################

InstallMethod( IsZeroSimpleSemigroup, "for a small semigroup", true, 
[IsSmallSemigroup], 0,
function(M)
local zero;

if IsGroupAsSemigroup(M) then 
	return false;
elif HasIsCompletelyRegularSemigroup(M) and IsCompletelyRegularSemigroup(M) then 
	return false;
elif IsRegularSemigroup(M) then 
	zero:=MultiplicativeZero(M);
	if not zero=fail and Length(GreensDClasses(M))=2 then 
		return true;
	fi;
fi;

return false;

end);

###########################################################################
#
# split in two methods, second one for abitrary semigroups
#
InstallMethod(MinimalGeneratingSet,"for a small semigroup",[IsSmallSemigroup],
function(s)
    local subsets, id, pos, entries, gens, subset, k, subsgrp, generatedSubSG,
          mt, generated;

    generatedSubSG := function( indices )
        local new, old;

        new := indices;

        repeat
            old := new;
            new := Union( old, Unique( Flat(mt{old}{old}) ));
        until new = old;

        return new;
    end;

    mt := MultiplicationTable( s );

    # elements not in the mult. table have to be in every generating set
    entries := Unique(Flat(MultiplicationTable(s)));
    gens := Difference( [ 1..Size(s) ], entries );

    # for nilpotent semigroups the non-entries are a generating set
    if IsNilpotentSemigroup( s ) then
        return AsSSortedList(s){gens};
    fi;

    if not IsEmpty( gens ) then
        generated := generatedSubSG( gens );
        entries := Difference( entries, generated );
    fi;

    # try inductively adding sets of size k to get generating set
    for k in [ Maximum(0,1-Length(gens))..Length(entries) ] do
        # subsets of elements not generated by <gens>
        subsets := Combinations( entries, k );
        for subset in subsets do
            if Length(generatedSubSG(Concatenation(gens,subset)))=Size(s) then 
                return  AsSSortedList(s){Concatenation(gens,subset)};
            fi;
        od;
    od;
end);

###########################################################################

InstallMethod( NilpotencyRank, "for a small semigroup", [ IsSmallSemigroup ],
function( S )
    local elms, rank, gens, gen, elm, elmslist;

    if not IsNilpotentSemigroup(S) then
        Info(InfoSmallsemi,2,
             "Only nilpotent semigroups have a nilpotency rank.");
        return fail;
    fi;

    # special case trivial semigroup
    if Size(S) = 1 then return 1; fi;

    # special treatment for 3-nilpotent semigroups of size 8
    if Size(S) = 8 and IdSmallSemigroup(S)[2] > 11433106 then
        return 3; 
    fi;

    # the generators of a nilpotent semigroup are precisely the elements
    # which do not appear in the multplication table
    gens := Difference( [1..Size(S)], Unique(Flat(MultiplicationTable(S))) );
    elms := gens;
    rank := 1;

    # for a 'small semigroup' 1 is the zero
    while [ 1 ] <> elms do
        rank := rank+1;
        # max. 6 generators (for zero semigroup of size 7)
        elmslist := EmptyPlist( 36 );
        # repeatedly calculate {gens}^(rank)
        for gen in gens do
            for elm in elms do
                Add( elmslist, MultiplicationTable(S)[gen][elm] );
            od;            
        od;
        elms := Unique( elmslist );
    od;

    return rank;
end);

# the following are special methods for library functions - no doc
###########################################################################
###########################################################################
###########################################################################

InstallMethod(GreensRClasses, "for a small semigroup", [IsSmallSemigroup], 
function(S)
local pos, elms, id, class, gens, graph, out, i;

elms:=AsSSortedList(S);

if HasMinimalGeneratingSet(S) then 
	gens:=List(MinimalGeneratingSet(S), x-> x!.index);
else
	gens:=List(GeneratorsOfSemigroup(S), x-> x!.index);
fi;

graph:=List(MultiplicationTable(S), x-> x{gens}); #the left Cayley graph
class:=STRONGLY_CONNECTED_COMPONENTS_DIGRAPH(graph);

elms:=AsSet(List(class, x-> AsSet(elms{x})));
out:=[];
for i in [1..Length(elms)] do 
	out[i]:=GreensRClassOfElement(S, elms[i][1]);
	SetAsSSortedList(out[i], elms[i]);
od;

return out;

end);

###########################################################################

InstallMethod(GreensLClasses, "for a small semigroup", [IsSmallSemigroup], 
function(S)
local pos, elms, id, class, gens, graph, out, i;

elms:=AsSSortedList(S);

if HasMinimalGeneratingSet(S) then 
	gens:=List(MinimalGeneratingSet(S), x-> x!.index);
else
	gens:=List(GeneratorsOfSemigroup(S), x-> x!.index);
fi;

graph:=List(TransposedMat(MultiplicationTable(S)), x-> x{gens}); 
#the right Cayley graph
class:=STRONGLY_CONNECTED_COMPONENTS_DIGRAPH(graph);

elms:=AsSet(List(class, x-> AsSet(elms{x})));
out:=[];
for i in [1..Length(elms)] do 
	out[i]:=GreensLClassOfElement(S, elms[i][1]);
	SetAsSSortedList(out[i], elms[i]);
od;

return out;

end);

###########################################################################

InstallMethod(GreensHClasses, "for a small semigroup", true, 
[IsSmallSemigroup], 0, 
function(S)
local r, l, H, c, i, h;

r:=GreensRClasses(S);
l:=GreensLClasses(S);

#Info(InfoWarning, 1, "THIS FUNCTION IS CURRENTLY FAULTY");

if Length(r)=Size(S) then 
	SetGreensDClasses(S, List(l, x-> 
	 GreensDClassOfElement(S, Representative(x))));
	
	for i in [1..Length(GreensLClasses(S))] do 
		SetAsSSortedList(GreensDClasses(S)[i], Elements(GreensLClasses(S)[i]));
	od;
	
	SetGreensHClasses(S, List(r, x-> 
	 GreensHClassOfElement(S, Representative(x))));
	
	for c in GreensHClasses(S) do 
		SetAsSSortedList(c, [Representative(c)]);
	od;
	
	return GreensHClasses(S);
elif Length(l)=Size(S) then 
	SetGreensDClasses(S, List(r, x-> 
	 GreensDClassOfElement(S, Representative(x))));
	 
	for i in [1..Length(GreensRClasses(S))] do 
		SetAsSSortedList(GreensDClasses(S)[i], Elements(GreensRClasses(S)[i]));
	od;
	
	SetGreensHClasses(S, List(l, x-> 
	 GreensHClassOfElement(S, Representative(x))));
	
	for c in GreensHClasses(S) do 
		SetAsSSortedList(c, [Representative(c)]);
	od;
	
	return GreensHClasses(S);
fi;

r:=List(r, x-> List(Elements(x), y->y!.index));
l:=List(l, x-> List(Elements(x), y->y!.index));

H:=[];

repeat
	c:=r[1];
	i:=0; 
	repeat
		i:=i+1;
		if not l[i]=[] then 
			h:=Intersection(c, l[i]);
			if not h=[] then 
				Add(H, h);
				SubtractSet(l[i], h);
				SubtractSet(c, h);
			fi;
		fi;
	until c=[];
	SubtractSet(r, [c]);
until r=[];

SetGreensHClasses(S, List(H, x-> GreensHClassOfElement(S, Elements(S)[x[1]])));

for i in [1..Length(H)] do 
	SetAsSSortedList(GreensHClasses(S)[i], Elements(S){H[i]});
od;

return GreensHClasses(S);

end);

###########################################################################

InstallMethod(GreensDClasses, "for a small semigroup", true, 
[IsSmallSemigroup], 0, 
function(S)
local elts, gens, r, l, d, i, c;

if HasGreensRClasses(S) and Length(GreensRClasses(S))=Size(S) then 
	SetGreensHClasses(S, List(GreensRClasses(S), x-> 
	 GreensHClassOfElement(S, Representative(x))));
	
	for c in GreensHClasses(S) do 
		SetAsSSortedList(c, [Representative(c)]);
	od;
	
	SetGreensDClasses(S, List(GreensLClasses(S), x-> GreensDClassOfElement(S, 
	 Representative(x))));
	
	for i in [1..Length(GreensLClasses(S))] do 
		SetAsSSortedList(GreensDClasses(S)[i], Elements(GreensLClasses(S)[i]));
	od;
	
	return GreensDClasses(S);
	
	elif HasGreensLClasses(S) and Length(GreensLClasses(S))=Size(S) then 
		SetGreensHClasses(S, List(GreensLClasses(S), x-> 
	 		GreensHClassOfElement(S, Representative(x))));
	 	for c in GreensHClasses(S) do 
			SetAsSSortedList(c, [Representative(c)]);
		od;
		
	SetGreensDClasses(S, List(GreensRClasses(S), x-> 
		 GreensDClassOfElement(S, Representative(x))));
		 
	for i in [1..Length(GreensRClasses(S))] do 
		SetAsSSortedList(GreensDClasses(S)[i], Elements(GreensRClasses(S)[i]));
	od;
fi;

if HasMinimalGeneratingSet(S) then 
	gens:=List(MinimalGeneratingSet(S), x-> x!.index);
else
	gens:=List(GeneratorsOfSemigroup(S), x-> x!.index);
fi;

r:=List(TransposedMat(MultiplicationTable(S)), x-> x{gens}); #right 
l:=List(MultiplicationTable(S), x-> x{gens}); #left

d:=List([1..Size(S)], i-> Union(r[i], l[i])); #union of the two graphs
d:=STRONGLY_CONNECTED_COMPONENTS_DIGRAPH(d);

elts:=AsSSortedList(S);
elts:=AsSet(List(d, x-> AsSet(elts{x})));
d:=[];
for i in [1..Length(elts)] do 
	d[i]:=GreensDClassOfElement(S, elts[i][1]);
	SetAsSSortedList(d[i], elts[i]);
od;

return d;
end);

###########################################################################

InstallOtherMethod(IsGreensRClass, "for any object", 
true, [IsObject], 0, ReturnFalse);

InstallOtherMethod(IsGreensLClass, "for any object", 
true, [IsObject], 0, ReturnFalse);

InstallOtherMethod(IsGreensHClass, "for any object", 
true, [IsObject], 0, ReturnFalse);

InstallOtherMethod(IsGreensDClass, "for any object",
true, [IsObject], 0, ReturnFalse);

##  Method for 'String' missing for Green's classes in the GAP library. AD
#############################################################################
##
#M  String( <greensclass> ) . . . for Green's classes
##
InstallMethod(String, "for Green's classes of a semigroup", [IsGreensClass], 
function(c)
return Concatenation("{", String(Representative( c )), "}");
end);


# Internal functions - documented in the dev manual
###########################################################################
###########################################################################
###########################################################################

InstallGlobalFunction(STORED_INFO, [IsPosInt, IsString], function(n, name)
    local i;

    if name in RecNames(MOREDATA2TO8[n]) then 
        return MOREDATA2TO8[n].(name);
    elif name="IsBand" then 
        i := Position(MOREDATA2TO8[n].diags, [1..n]);
	return [ MOREDATA2TO8[n].endpositions[i]+1 .. 
                     MOREDATA2TO8[n].endpositions[i+1]];
    else 
        return fail;
    fi;
end);

#this is the same as using DeclareSynonymAttr(SMALLSEMI_EQUIV[1], 
#SMALLSEMI_EQUIV[2]) but where SMALLSEMI_EQUIV[2] is not a property of 
#semigroups alone or is not true for all semigroups. For example, 
#IsMonogenicSemigroup implies Is1GeneratedSemigroup for all semigroups, and is 
#hence a synonym. On the other hand, IsCompletelySimpleSemigroup only holds for 
#IsSimpleSemigroup and IsFinite, and IsCommutativeSemigroup only holds for 
#IsCommutative and IsSemigroup.

if IsBound(IsSingularSemigroup) then 
	InstallValue(SMALLSEMI_ALWAYS_FALSE,
             [IsFullTransformationSemigroup, 
              IsSingularSemigroup]);
else
		InstallValue(SMALLSEMI_ALWAYS_FALSE,
             [IsFullTransformationSemigroup]);
fi;

#InstallValue(SMALLSEMI_EQUIV, 
#             [["IsCompletelySimpleSemigroup", "IsSimpleSemigroup"],
#              ["IsCommutativeSemigroup", "IsCommutative"], 
#              ["IsNilpotent", "IsNilpotentSemigroup"]]);

# the entries in the variable SMALLSEMI_EQUIV should be sorted according to 
# SMALLSEMI_SORT_ARG_NC, i.e. the ones with true as argument come
# first and then are sorted alphabetically. Currently, the first 
# component of every instance in SMALLSEMI_EQUIV should have length
# two!

InstallValue(SMALLSEMI_EQUIV, [
[[IsCliffordSemigroup, true],
[IsCompletelyRegularSemigroup, true, IsInverseSemigroup, true]], 

[[IsCompletelySimpleSemigroup, true], [IsSimpleSemigroup, true]],

[[IsCompletelySimpleSemigroup, false], [IsSimpleSemigroup, false]],

[[IsCommutativeSemigroup, true], [IsCommutative, true]], 

[[IsCommutativeSemigroup, false], [IsCommutative, false]],

[[IsNilpotent, true], [IsNilpotentSemigroup, true]],

[[IsNilpotent, false], [IsNilpotentSemigroup, false]],

[[IsSemigroupWithClosedIdempotents, false],
[IsSemigroupWithoutClosedIdempotents, true]],

[[IsSemigroupWithClosedIdempotents, true],
[IsSemigroupWithoutClosedIdempotents, false]],

[[IsSemilatticeAsSemigroup, true],
[IsBand, true, IsCommutative, true]],

#JDM see comment in the NV note about the four below. Waiting for 
#JDM anti-position list to allow for [IsOrthodoxSemigroup, false] and similar.

# [[Is4GeneratedSemigroup, true], 
# [Is1GeneratedSemigroup, false, Is2GeneratedSemigroup, false, 
#  Is3GeneratedSemigroup, false, Is5GeneratedSemigroup, false, 
#  Is6GeneratedSemigroup, false, Is7GeneratedSemigroup, false,
#  Is8GeneratedSemigroup, false ]],

[[IsRectangularBand, true], [IsBand, true, IsSimpleSemigroup, true]],

[[IsOrthodoxSemigroup, true], 
[IsRegularSemigroup, true, IsSemigroupWithoutClosedIdempotents, false]],
              
[[IsBrandtSemigroup, true], [IsInverseSemigroup, true, 
 IsZeroSimpleSemigroup, true]],

]);

#InstallValue(SMALLSEMI_CONVERSE, 
#             [["Is4GeneratedSemigroup", 
#               [Is1GeneratedSemigroup, false, Is2GeneratedSemigroup, false, 
#                Is3GeneratedSemigroup, false, Is5GeneratedSemigroup, false, 
#                Is6GeneratedSemigroup, false, Is7GeneratedSemigroup, false]],
#              ["IsRectangularBand", [IsBand, true, IsSimpleSemigroup, true]],
#              ["IsOrthodoxSemigroup", 
#               [IsRegularSemigroup, true, 
#                IsSemigroupWithoutClosedIdempotents, false]],
#              ["IsSemigroupWithClosedIdempotents",
#               [IsSemigroupWithoutClosedIdempotents, false]]]);
