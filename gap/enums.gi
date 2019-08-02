#############################################################################
##
#W  enums.gi             	   Smallsemi - a GAP library of semigroups
#Y  Copyright (C) 2008-2012            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##


##################

InstallGlobalFunction(AllSmallSemigroups, 
function(arg)
SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL+1;

Info(InfoSmallsemiEnums, 3, SMALLSEMI_ENTAB("AllSmallSemigroups"));

arg:=SMALLSEMI_STRIP_ARG(arg);

return SMALLSEMI_RETURN(ConstantTimeAccessList(EnumeratorSortedOfSmallSemigroups(arg)));
end);

##################
# empty enum. over a pos. int. or list of pos. ints. 

InstallGlobalFunction(EmptyEnumeratorOfSmallSemigroups, 
function(arg)
local enum, fam;

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL+1;

Info(InfoSmallsemiEnums, 3, SMALLSEMI_ENTAB("EmptyEnumeratorOfSmallSemigroups"));

if not arg=[] then 
	Error("argument should be empty");
fi;

fam:=CollectionsFamily(SmallSemigroupEltFamily);
	
enum:=EnumeratorByFunctions(Domain(fam, []), rec(
	ElementNumber:= ReturnFail,

	NumberElement:= ReturnFail, 

	Length:=enum -> 0,

	PrintObj:=function(enum)
	Print( "<empty enumerator of semigroups>");
	return;
	end, 
        
        pos:=[[]], sizes:=[]));
	
	SetIsEnumeratorOfSmallSemigroups(enum, true);
	#SetPositionsOfSmallSemisInEnum(enum, [[]]);
	#SetSizesOfSmallSemisInEnum(enum, []);
	SetIsFinite(enum, true);
	
	SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;
	
	return enum;
end);

##################

InstallGlobalFunction(EmptyIteratorOfSmallSemigroups, 
function(arg)
local iter;

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL+1;

Info(InfoSmallsemiEnums, 3, SMALLSEMI_ENTAB("EmptyIteratorOfSmallSemigroups"));

if not arg=[] then 
	Error("argument should be empty");
fi;

iter:=IteratorByFunctions( rec(
		
				IsDoneIterator := ReturnTrue,
				
				NextIterator := ReturnFail,
				
				PrintObj := function( iter ) Print( "<empty iterator of semigroups>"); end,
				
				ShallowCopy := SHALLOWCOPYITERATORSMALLSEMI,
				
				at := 0, 
				
				max:= 0, 
				
				enum:=[],
				
				user:=[],
				
				sizes:=[0]));
	
SetIsIteratorOfSmallSemigroups(iter, true);

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;
return iter;
end);

##################

InstallGlobalFunction(EnumeratorOfSmallSemigroups, 
function(arg)
local fam, enum, pos, index, tot, lens, enums, i;

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL+1;

Info(InfoSmallsemiEnums, 3, SMALLSEMI_ENTAB("EnumeratorOfSmallSemigroups"));

arg:=SMALLSEMI_STRIP_ARG(arg);

if not SMALLSEMI_ARG_OK(arg) then 
	SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;
	Error("input is incorrect"); #JDM could just call SMALLSEMI_ARG_OK and have errors from there
fi;

arg:=SMALLSEMI_SORT_ARG_NC(SMALLSEMI_CONVERT_ARG_NC(arg));

#comment out the following if statement to allow the creation of all 
#enumerators of semigroups of size 8. BEWARE this might have unpredictable
#consequences. JDM

if not SMALLSEMI_CAN_CREATE_ENUM_NC(arg) then
	SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1; 
	Error("it is not currently possible to find all enumerators containing \n semigroups of order 8");
fi;

if Length(arg)=1 and IsEnumeratorOfSmallSemigroups(arg[1]) then 
	SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;
	return arg[1]; #do nothing 
elif Length(arg)=1 and IsIteratorOfSmallSemigroups(arg[1]) then 
	return SMALLSEMI_RETURN(SMALLSEMI_CREATE_ENUM(SizesOfSmallSemisInIter(arg[1]), 
	 PositionsOfSmallSemigroups(arg[1]), FuncsOfSmallSemisInIter(arg[1]))); 
		#convert iterator to enumerator
elif Length(arg)=1 and IsPosInt(arg[1]) then #all semigroups
	
	fam:=CollectionsFamily(SmallSemigroupEltFamily);

	enum:=EnumeratorByFunctions(Domain(fam, []), rec(
	ElementNumber:=function(enum, pos)
	return SmallSemigroupNC(arg[1], pos);
	end, 

	NumberElement:=function(enum, elm)
	return IdSmallSemigroup(elm)[2];
	end, 

	Length:=enum -> NrSmallSemigroups(arg[1]),

	PrintObj:=function(enum)
	Print( "<enumerator of semigroups of size ", arg[1], ">");
	return;
	end, 
        pos:= [[1..NrSmallSemigroups(arg[1])]],
        funcs:=[], names:=["AllSmallSemigroups", arg[1]], 
        sizes:=[arg[1]]));
	
	SetIsEnumeratorOfSmallSemigroups(enum, true);
	#SetPositionsOfSmallSemisInEnum(enum, [[1..NrSmallSemigroups(arg[1])]]);
	#SetFuncsOfSmallSemisInEnum(enum, []);
	#SetNamesFuncsSmallSemisInEnum(enum, ["AllSmallSemigroups", arg[1]]);
	#SetSizesOfSmallSemisInEnum(enum, [arg[1]]);
	SetIsFinite(enum, true);
elif Length(arg)=1 and ForAll(arg[1], IsPosInt) then 
	enum:=SMALLSEMI_CREATE_ENUM(arg[1], List(arg[1], x-> 
	 [1..NrSmallSemigroups(x)]), arg{[2..Length(arg)]});
elif IsPosInt(arg[1]) then 
	#enumerator by list of properties and their values
	enum:=SMALLSEMI_CREATE_ENUM(arg[1], PositionsOfSmallSemigroups(arg), 
	 arg{[2..Length(arg)]});
elif IsEnumeratorOfSmallSemigroups(arg[1]) then 
	enum:=SMALLSEMI_CREATE_ENUM(SizesOfSmallSemisInEnum(arg[1]), 
	  PositionsOfSmallSemigroups(arg), arg{[2..Length(arg)]});
elif IsIteratorOfSmallSemigroups(arg[1]) then 
	enum:=SMALLSEMI_CREATE_ENUM(SizesOfSmallSemisInIter(arg[1]), 
	 PositionsOfSmallSemigroups(arg), arg{[2..Length(arg)]});
elif Length(arg)>1 and ForAll(arg[1], IsPosInt) then #enumerator over range
	enum:=SMALLSEMI_CREATE_ENUM(arg[1], PositionsOfSmallSemigroups(arg), 
	 arg{[2..Length(arg)]});
fi;

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;
return enum;

end);

##################
# input ids, a list of ids, a pos. int. & list of positions, a list of pos. 
# ints. and a list of positions of equal length

InstallMethod(EnumeratorOfSmallSemigroupsByIds, 
"for a set of pos. ints. and list of sets of positions",
 [IsCyclotomicCollection, IsCyclotomicCollColl], 0, 
function(sizes, positions)

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL+1;

Info(InfoSmallsemiEnums, 3, SMALLSEMI_ENTAB("EnumeratorOfSmallSemigroupsByIds 1"));

if not ForAll(sizes, x-> x>0 and x<9) then 
  Info(InfoWarning, 1, "can only create enums of semigroups of sizes 1 to 8");
  return fail;
fi;

if not IsSet(sizes) then 
	Info(InfoWarning, 1,
             "1st argument must be a set of pos. int. in the range 1 .. 8");
	return fail;
fi;

if not Length(sizes)=Length(positions) then 
  Info(InfoWarning, 1, "1st and 2nd arg. must have equal length");
  return fail;
fi;

if not ForAll(positions, x-> ForAll(x, IsPosInt)) 
 or not ForAll(positions, IsSet) then 
  Info(InfoWarning, 1, "2nd arg. must be a list of sets of pos. ints.");
  return fail;
fi;

if ForAny([1..Length(positions)], i-> Maximum(positions[i])
  > NrSmallSemigroups(sizes[i])) then 
  Info(InfoWarning, 1, "all sets in 2nd arg. should be in the range 1 to ", 
  "the number of semigroups of the appropriate size ");
  return fail;
fi;

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;

return EnumeratorOfSmallSemigroupsByIdsNC(sizes, positions);
end);

##################

InstallMethod(EnumeratorOfSmallSemigroupsByIdsNC,
"for a set of pos. ints. and list of sets of positions",
[IsCyclotomicCollection, IsCyclotomicCollColl], 0, 
function(sizes, positions)
local fam, enum, id1, id2, tot, lens, i;

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL+1;

Info(InfoSmallsemiEnums, 3, SMALLSEMI_ENTAB("EnumeratorOfSmallSemigroupsByIdsNC 1"));

if ForAll(positions, x-> x=[]) then 
  return SMALLSEMI_RETURN(EmptyEnumeratorOfSmallSemigroups());
fi;

fam:=CollectionsFamily(SmallSemigroupEltFamily);

tot:=0;
lens:=[0];
for i in positions do 
	tot:=tot+Length(i);
	Add(lens, tot);
od;

enum:=EnumeratorByFunctions(Domain(fam, []), rec(
ElementNumber:=function(enum, pos)
local i;
if pos>Length(enum) then 
	return fail;
fi;
i:=PositionProperty(lens, x-> pos<=x)-1;
return SmallSemigroupNC(sizes[i], positions[i][pos-lens[i]]);
end, 

NumberElement:=function(enum, elm)
local id;
id:=IdSmallSemigroup(elm);
return PositionSorted(positions[id[1]], id[2]);
end, 

Length:=enum -> tot,

PrintObj:=function(enum)
if Length(sizes)>1 then 
	Print( "<enumerator of semigroups of sizes ", sizes, ">");
else 
	Print( "<enumerator of semigroups of size ", sizes[1], ">");
fi;
return;
end, pos:=positions, sizes:=sizes, names:=["enumerator by ids", sizes], 
funcs:=[]));

SetIsEnumeratorOfSmallSemigroups(enum, true);
#SetPositionsOfSmallSemisInEnum(enum, positions);
#SetFuncsOfSmallSemisInEnum(enum, []);
#SetNamesFuncsSmallSemisInEnum(enum, ["enumerator by ids", sizes]);
#SetSizesOfSmallSemisInEnum(enum, sizes);
SetIsFinite(enum, true);
SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;

return enum;
end);

##################

InstallOtherMethod(EnumeratorOfSmallSemigroupsByIds, 
"for a pos. int. and set of positions", 
[IsPosInt, IsCyclotomicCollection], 0, 
function(sizes, positions)

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL+1;

Info(InfoSmallsemiEnums, 3, SMALLSEMI_ENTAB("EnumeratorOfSmallSemigroupsByIds 2"));

return SMALLSEMI_RETURN(EnumeratorOfSmallSemigroupsByIds([sizes], [positions]));
end);

##################

InstallOtherMethod(EnumeratorOfSmallSemigroupsByIdsNC, 
"for a pos. int. and set of positions", 
[IsPosInt, IsCyclotomicCollection], 0, 
function(sizes, positions)

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL+1;

Info(InfoSmallsemiEnums, 3, SMALLSEMI_ENTAB("EnumeratorOfSmallSemigroupsByIdsNC 2"));

return SMALLSEMI_RETURN(EnumeratorOfSmallSemigroupsByIdsNC([sizes],
 [positions]));
end);

##################

InstallOtherMethod(EnumeratorOfSmallSemigroupsByIds, 
"for a list of smallsemi ids", [IsList], 0, 
function(ids)
local id1, id2, i, pos;
SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL+1;

Info(InfoSmallsemiEnums, 3, SMALLSEMI_ENTAB("EnumeratorOfSmallSemigroupsByIds 3"));

ids:=Set(ids);

if not ForAll(ids, IsIdSmallSemigroup) then 
	Info(InfoWarning, 1,
             "argument must be a list of ids of small semigroups");
	return fail;
fi;

#JDM changes here

#sort the ids etc

#id1:=Set(List(ids, x-> x[1]));
#id2:=List(ids, x-> []);
#for i in [1..Length(ids)] do 
#	Add(id2[i], ids[i][2]);
#od;

id1:=[]; id2:=[];

for i in ids do 
	pos:=PositionSet(id1, i[1]);
	if pos = fail then 
		AddSet(id1, i[1]);
		id2[PositionSet(id1, i[1])]:=[i[2]];
	else
		AddSet(id2[pos], i[2]);
	fi;
od;

#Print(id1, id2, "\n");

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;

return SMALLSEMI_RETURN(EnumeratorOfSmallSemigroupsByIdsNC(id1, id2));
end);

#############################################################################
InstallGlobalFunction( EnumeratorOfSmallSemigroupsByDiagonals, 
function(diagonals)
    local sizes, ranges, diag, n, sizepos, diagpos, start, ende, i, offset, id;

    sizes := [ ];
    ranges := [ ];

    for diag in diagonals do
        n := Length(diag);
        sizepos := Position(sizes, n);
        diagpos := Position(MOREDATA2TO8[n].diags, diag);
        start := MOREDATA2TO8[n].endpositions[diagpos]+1;
        ende := MOREDATA2TO8[n].endpositions[diagpos+1];
        if sizepos = fail then
            Add(sizes, n);
            sizepos := Length(sizes);
            Add(ranges, [start..ende]);
        else
            ranges[sizepos] := Union(ranges[sizepos], [start..ende]);
        fi;
        offset := 11433106;
        if n = 8 then
            for i in [3..8] do
                diagpos := Position(MOREDATA2TO8[n].3nildiags, diag{[i..n]});
                if diagpos <> fail then
                    start := MOREDATA2TO8[n].3nilendpositions[diagpos]+1;
                    ende := MOREDATA2TO8[n].3nilendpositions[diagpos+1];
                    id := start + offset;
                    repeat
                        Add(ranges[sizepos], id);
                        id := id+1;
                    until id > ende + offset;
                fi;
            od;
        fi;
    od;

    return EnumeratorOfSmallSemigroupsByIds(sizes, ranges);
end);



##################

#InstallOtherMethod(EnumeratorOfSmallSemigroupsByIdsNC, 
#"for a list of small semi ids", [IsList], 0, 
#function(ids)

#SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL+1;

#Info(InfoSmallsemi, 3, SMALLSEMI_ENTAB("EnumeratorOfSmallSemigroupsByIdsNC"));

#return SMALLSEMI_RETURN(EnumeratorOfSmallSemigroupsByIdsNC(ids[1], ids[2]));
#end);


##################

InstallGlobalFunction(EnumeratorSortedOfSmallSemigroups, 
function(arg) 

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL+1;

Info(InfoSmallsemiEnums, 3, SMALLSEMI_ENTAB("EnumeratorSortedOfSmallSemigroups"));

arg:=SMALLSEMI_STRIP_ARG(arg);

return SMALLSEMI_RETURN(EnumeratorOfSmallSemigroups(arg));
end);

##################

InstallGlobalFunction(IdsOfSmallSemigroups, 
function(arg)
local enum, size, pos;

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL+1;

Info(InfoSmallsemiEnums, 3, SMALLSEMI_ENTAB("IdsOfSmallSemigroups"));

enum:=EnumeratorOfSmallSemigroups(arg);
size:=SizesOfSmallSemisInEnum(enum);
pos:=PositionsOfSmallSemisInEnum(enum);

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;
return Concatenation(List([1..Length(size)], x-> List(pos[x], y-> [size[x], y])));
end);

###############

InstallOtherMethod(IsEnumeratorOfSmallSemigroups, "for an object", [IsObject], 0, 
ReturnFalse);

###############

InstallGlobalFunction(IsIdSmallSemigroup, 
function(arg)
local m, n, nr;

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL+1;

Info(InfoSmallsemiEnums, 3, SMALLSEMI_ENTAB("IsIdSmallSemigroup"));

if Length(arg)=2 and IsPosInt(arg[1]) and IsPosInt(arg[2]) then 
	m:=arg[1]; 
	n:=arg[2];
elif Length(arg)=1 and IsCyclotomicCollection(arg[1]) and Length(arg[1])=2 then 
	return SMALLSEMI_RETURN(IsIdSmallSemigroup(arg[1][1], arg[1][2]));
else
	SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;
	return false;
fi;

nr:=NrSmallSemigroups(m);
SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;

return 0<m and m<9 and 1<=n and n<=nr;
end);

###############

InstallGlobalFunction(FuncsOfSmallSemisInEnum,
enum-> enum!.funcs);

InstallGlobalFunction(FuncsOfSmallSemisInIter,
enum-> enum!.funcs);

###############

InstallOtherMethod(IsIteratorOfSmallSemigroups, "for an object", [IsObject], 0, 
ReturnFalse);

###############

BindGlobal( "PrintObj_IsIteratorOfSmallSemigroups",
function(iter)
if not iter!.sizes=[0] then
	if Length(iter!.sizes)>1 then  
		Print( "<iterator of semigroups of sizes ", iter!.sizes, ">");
		return;
	else
		Print( "<iterator of semigroups of size ", iter!.sizes[1], ">");
	fi;
else 
	Print( "<empty iterator of semigroups>");
fi;
end);

###############

InstallGlobalFunction(IteratorOfSmallSemigroups, 
function ( arg )
local iter, enum, user, i, max, sizes, names, funcs;

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL+1;

Info(InfoSmallsemiEnums, 3, SMALLSEMI_ENTAB("IteratorOfSmallSemigroups"));

arg:=SMALLSEMI_STRIP_ARG(arg);

if not SMALLSEMI_ARG_OK( arg ) then 
	Error("argument is incorrect"); 
	#JDM could just call SMALLSEMI_ARG_OK and have errors from there
fi;

if Length(arg)=1 and IsPosInt(arg[1]) then #all semigroups
	
	iter:=IteratorByFunctions( rec(
				
				IsDoneIterator := iter-> iter!.next(iter, false)=fail,
				
				NextIterator := iter-> iter!.next(iter, true),
				
				PrintObj := PrintObj_IsIteratorOfSmallSemigroups,
				
				next:=function(iter, advance) 
				
				if iter!.at=iter!.max then 
					return fail;
				fi;
				
				if advance then 
					iter!.at:=iter!.at+1;
					return SmallSemigroupNC(arg[1], iter!.at);
				fi;
				
				return true;
				end,
				
				ShallowCopy := SHALLOWCOPYITERATORSMALLSEMI,
							
				at := 0,
				
				max:= NrSmallSemigroups(arg[1]), 
				
				enum:=[],
				
				user:=[],
				
				sizes:=[arg[1]], 
                                
                                funcs:=[], 

                                names:=["AllSmallSemigroups", arg[1]]
                                
                                ));
	
	SetIsIteratorOfSmallSemigroups(iter, true);
	#SetSizesOfSmallSemisInIter(iter, [arg[1]]);
	#SetFuncsOfSmallSemisInIter(iter, []);
	#SetNamesFuncsSmallSemisInIter(iter, ["AllSmallSemigroups", arg[1]]);
	return iter;
	
elif IsOddInt(Length(arg)) and (IsPosInt(arg[1]) or 
  IsEnumeratorOfSmallSemigroups(arg[1]) or 
  IsIteratorOfSmallSemigroups(arg[1]) or 
  (IsCyclotomicCollection(arg[1]) and ForAll(arg[1], IsPosInt))) then 
    #for a list of functions and their values
  
	if IsPosInt(arg[1]) then 
		sizes:=[arg[1]];
		names:=[];
		funcs:=[];
	elif IsEnumeratorOfSmallSemigroups(arg[1]) then 
		if Length(arg[1])=0 then 
			return SMALLSEMI_RETURN(EmptyIteratorOfSmallSemigroups());
		fi;
		sizes:=SizesOfSmallSemisInEnum(arg[1]);
		names:=NamesFuncsSmallSemisInEnum(arg[1]);
		funcs:=FuncsOfSmallSemisInEnum(arg[1]);
	elif IsIteratorOfSmallSemigroups(arg[1]) then 
		sizes:=SizesOfSmallSemisInIter(arg[1]);
		names:=NamesFuncsSmallSemisInIter(arg[1]);
		funcs:=FuncsOfSmallSemisInIter(arg[1]);
	elif IsCyclotomicCollection(arg[1]) and ForAll(arg[1], IsPosInt) then 
		sizes:=arg[1];
		names:=[];
		funcs:=[];
	fi;
	
	arg:=SMALLSEMI_SORT_ARG_NC(SMALLSEMI_CONVERT_ARG_NC(arg));

	enum:=[arg[1]]; 
	user:=[];
	
	for i in [2,4..Length(arg)-1] do
		if NAME_FUNC(arg[i]) in SMALLSEMI_ALWAYS_FALSE and arg[i+1] then 
			return SMALLSEMI_RETURN(EmptyIteratorOfSmallSemigroups());
		elif ForAll(sizes, j-> NAME_FUNC(arg[i]) 
		  in PrecomputedSmallSemisInfo[j]) then #precomputed function
			enum:=Concatenation(enum, [arg[i], arg[i+1]]);
		else #user function
			user:=Concatenation(user, [arg[i], arg[i+1]]);
		fi;
	od;
	
	if IsEnumeratorOfSmallSemigroups(arg[1]) and enum=[arg[1]] then 
		enum:=enum[1];
		max:=Length(enum);
		if Length(enum)=0 then 
			return EmptyIteratorOfSmallSemigroups();
		fi;
	elif not enum=[arg[1]] and SMALLSEMI_CAN_CREATE_ENUM_NC(enum) then
		enum:=EnumeratorOfSmallSemigroups(enum);
		max:=Length(enum);
		if Length(enum)=0 then 
			return EmptyIteratorOfSmallSemigroups();
		fi;
	else
		enum:=[];
		max:=Sum(sizes, j-> NrSmallSemigroups(j));
		user:=arg{[2..Length(arg)]};
	fi;
	
	iter:=IteratorByFunctions( rec(
				
				#JDM changes here...
				
				IsDoneIterator := iter-> iter!.next(iter, IsDoneIterator)=fail,
				
				NextIterator := iter-> iter!.next(iter, NextIterator),
				
				PrintObj := PrintObj_IsIteratorOfSmallSemigroups,
				
				next:=function(iter, called_by) #JDM new!
					local enum, user, s;
					
					if iter!.last_called = IsDoneIterator then 
						iter!.last_called := called_by;
						return iter!.last_value; 
					fi;
					
					if iter!.last_called = NextIterator then
						iter!.last_called := called_by;
						if iter!.at=iter!.max or iter!.last_value=fail then 
							iter!.last_value:=fail;
							return fail;
						fi;

						enum:=iter!.enum; user:=iter!.user;
						
						if not enum=[] and Length(enum)<=iter!.at then 
							#JDM shouldn't this be IdSmallSemigroup(enum[Length[enum]])[2]<=
							iter!.last_value:=fail;
							return fail;
						fi;
						
						repeat
							iter!.at:=iter!.at+1;
							if not enum=[] then 
								s:=enum[iter!.at];
							else
								s:=SmallSemigroupNC(iter!.at_size, iter!.at-
								Sum(Filtered(iter!.sizes, x-> x< iter!.at_size), 
									NrSmallSemigroups));
							fi;
							
							if not enum=[] then 
								iter!.at_size:=Size(s);
							elif Length(iter!.sizes)>1 and iter!.at<iter!.max and iter!.at-
								Sum(Filtered(iter!.sizes, x-> x< iter!.at_size), 
									NrSmallSemigroups)>=NrSmallSemigroups(iter!.at_size) then 
								iter!.at_size:=
									iter!.sizes[Position(iter!.sizes, iter!.at_size)+1];
							fi;
	
							if Length(user)=0 then
								iter!.last_value:=s;
								return s;
							elif ForAll([1,3..Length(user)-1], i-> user[i](s)=user[i+1]) 	
								then 
								iter!.last_value:=s;
								return s;
							else
								iter!.last_value:=fail;
							fi;
						until iter!.at=iter!.max; 
						
						iter!.last_value:=fail;
						return fail;
					fi;
				end, 
				
				last_called := NextIterator,
				
				last_value := 0,
				
				#JDM ...changes end.
				
				ShallowCopy:= SHALLOWCOPYITERATORSMALLSEMI,
				
				at := 0, 
				
				max:= max,
				
				enum:=enum,
				
				user:=user,
				
				sizes:=sizes, #JDM changed from n
				
				at_size:=sizes[1], 

                                funcs:=Concatenation(funcs, arg{[2..          
                                Length(arg)]}), 

                                names:= Concatenation(names, List(arg{[2..  
                                Length(arg)]},
                                        function(x)
                                                if IsFunction(x) then return
                                                NAME_FUNC(x); else return x; fi;
                                                end))
				));
	

	SetIsIteratorOfSmallSemigroups(iter, true);
	#SetNamesFuncsSmallSemisInIter(iter, Concatenation(names, List(arg{[2..Length(arg)]},
	#function(x)
	#if IsFunction(x) then return NAME_FUNC(x); else return x; fi; end)));
	#SetFuncsOfSmallSemisInIter(iter, Concatenation(funcs, arg{[2..Length(arg)]}));
	#SetSizesOfSmallSemisInIter(iter, sizes);
	
	SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;
	return iter;

fi;

end);

##################

InstallGlobalFunction(NamesFuncsSmallSemisInEnum,
enum-> enum!.names);

InstallGlobalFunction(NamesFuncsSmallSemisInIter,
enum-> enum!.names);

##################

InstallGlobalFunction(Nr3NilpotentSemigroups, function( arg )

    local size,   # input, order of semigroups
          type,   # optional input, type of semigroups
          types,  # list of valid second (optional) arguments
          i,      # loop counter

          nr3NilIso,
          # takes a positive integer <n> as input and returns the number of
          # 3-nilpotent semigroups with <n> elements up to isomorphism

          nr3NilSelfDual,
          # takes a positive integer <n> as input and returns the number of
          # self-dual 3-nilpotent semigroups with <n> elements 

          nr3NilComm,
          # takes a positive integer <n> as input and returns the number of
          # commutative 3-nilpotent semigroups with <n> elements up to iso

          nr3NilAll,
          # takes a positive integer <n> as input and returns the number of
          # all different 3-nilpotent semigroups on a set with <n> elements 

          nr3NilAllComm,
          # takes a positive integer <n> as input and returns the number of
          # all different, commutative 3-nilpotent semigroups on a set with 
          # <n> elements 

          sizeConjugacyClass,
          # returns for a partition <part> of <size> the number of permutations
          # in the symmetric group on <size> elements with disjoint cycle
          # notation given by <part> (corresponds to a conjugacy class) 

          transformPart;
          # takes a partition as a list of summands and returns a vector with 
          # the number of summands with value i in the i-th position

    ##################################################################
    ### local functions


    sizeConjugacyClass := function( partition )
        return Factorial( Sum( partition ) ) / 
               Product( Collected(partition), pair -> Factorial(pair[2])*
                                                      pair[1]^pair[2] );
    end;


    transformPart := function( part )

        local n, coll, i, jvec;

        n := Sum( part );
        jvec := [ ];
        coll := Collected(part);
        for i in [1..n] do
            if IsBound( coll[1] ) and coll[1][1] = i then
                Add( jvec, coll[1][2] );
                Remove( coll , 1 );
            else
                Add( jvec, 0 );
            fi;
        od;

        return jvec;
    end;


    nr3NilIso := function( n )

        local NrIsomorphismClasses;

        NrIsomorphismClasses := function( n, m )
            local parts, sum, nrs, Produkt;

            Produkt := function( p1, p2 )
                local prod, i, j;

                prod := 1;

                for i in [ 1.. Length(p1) ] do
                    # if exponent is 0, prod is multiplied by 1 => omit
                    if p1[i] <> 0 then
                        for j in [ 1..Length(p1) ] do
                            # if exponent is 0, prod is multiplied by 1 => omit
                            if p1[j] <> 0 then
                                prod := prod * 
                                        (1+Sum(Filtered(DivisorsInt(Lcm(i, j)),
                                                        x -> x <= Length(p2)), 
                                               d->d*p2[d]))
                                        ^(p1[i]*p1[j]*Gcd(i,j));
                            fi;
                        od;
                    fi;
                od;

                return prod;
            end;

            # only the zero semigroup in the case |B|=1
            if m = 1 then
                return 1;
            fi;

            # the elements in the Cartesian product are pairs of partitions
            # they stand for elements in a conjugacy class of S_{n-m} x S_{m-1}
            parts := Cartesian( Partitions( n-m ), Partitions( m-1 ));

            # pp is a partition pair
            nrs := List(parts, 
                        pp -> Produkt(transformPart(pp[1]), 
                                      Concatenation(transformPart(pp[2]),[0]))*
                        sizeConjugacyClass(pp[1]) * sizeConjugacyClass(pp[2]));

            return Sum( nrs ) / (Factorial( n-m ) * Factorial( m-1 )); 
        end;

        return Sum([2..n-1],
               m -> NrIsomorphismClasses(n,m) - NrIsomorphismClasses(n-1,m-1));
    end;


    nr3NilSelfDual := function( n )

        local NrEquivalenceClasses;

        NrEquivalenceClasses := function( n, m )
            local parts, sum, nrs, Produkt, Prod1, Prod2, Prod3, Prod4, smallc;

            smallc := function( int, part )
                return 1 + Sum( Filtered( DivisorsInt( int ), 
                                          x -> x <= Length(part)), 
                                d -> d * part[d] );
            end;

            Prod1 := function( p1, p2 )
                local prod, i;

                prod := 1;

                for i in [1..Minimum( Int((Length(p1)+1)/2), Int((n+1)/2) )] do
                    # if exponent is 0, prod is multiplied by 1 => omit
                    if p1[2*i-1] <> 0 then
                        prod := prod *
                                (smallc(2*i-1,p2)*smallc(4*i-2,p2)^(i-1))
                                ^(p1[2*i-1]);
                    fi;
                od;

                return prod;
            end;

            Prod2 := function( p1, p2 )
                local prod, i;

                prod := 1;

                for i in [ 1..Minimum( Int(Length(p1)/4), Int(n/4) ) ] do
                    # if exponent is 0, prod is multiplied by 1 => omit
                    if p1[4*i] <> 0 then
                        prod := prod * smallc(4*i,p2)^(4*i*p1[4*i]);
                    fi;
                od;

                return prod;
            end;

            Prod3 := function( p1, p2 )
                local prod, i;

                prod := 1;

                for i in [ 1..Minimum( Int((Length(p1)+2)/4), Int(n+2/4) ) ] do
                    # if exponent is 0, prod is multiplied by 1 => omit
                    if p1[4*i-2] <> 0 then
                        prod := prod *
                                (smallc(2*i-1,p2)^2*smallc(4*i-2,p2)^(4*i-3))
                                ^p1[4*i-2];
                    fi;
                od;

                return prod;
            end;

            Prod4 := function( p1, p2 )
                local prod, i, j;

                prod := 1;

                for i in [ 1.. Length(p1) ] do
                    # if exponent is 0, prod is multiplied by 1 => omit
                    if p1[i] <> 0 then
                        prod := prod * smallc(Lcm(2,i),p2)
                                       ^(i*Gcd(2,i)*(p1[i]^2-p1[i])/2);
                        for j in [ 1..Minimum( Length(p1), i-1 ) ] do
                            # if exponent is 0, prod is multiplied by 1 => omit
                            if p1[j] <> 0 then
                                prod := prod * smallc(Lcm(2,i,j),p2)
                                               ^(p1[i]*p1[j]*2*i*j/Lcm(2,i,j));
                            fi;
                        od;
                    fi;
                od;

                return prod;
            end;

            Produkt := function( p1, p2 );
                return Prod1(p1, p2)*Prod2(p1, p2)*Prod3(p1, p2)*Prod4(p1, p2);
            end;

            # only the zero semigroup in the case |B|=1, counted half
            if m = 1 then
                return 1;
            fi;

            # the elements in the Cartesian product are pairs of partitions
            # they stand for elements in a conjugacy class of S_{n-m} x S_{m-1}
            parts := Cartesian( Partitions( n-m ), Partitions( m-1 ));

            # pp is a partition pair
            nrs := List(parts, 
                        pp -> Produkt(transformPart(pp[1]), 
                                      Concatenation(transformPart(pp[2]),[0]))*
                       sizeConjugacyClass(pp[1])* sizeConjugacyClass(pp[2]));

            return Sum( nrs ) / (Factorial( n-m ) * Factorial( m-1 )); 
        end;

        return Sum([2..n-1],
               m -> NrEquivalenceClasses(n,m) - NrEquivalenceClasses(n-1,m-1));
    end;


    nr3NilComm := function( n )

        local NrIsomorphismClasses;

        NrIsomorphismClasses := function( n, m )
            local parts,sum,nrs, Produkt, Produkt1, Produkt2, Produkt3, smallc;

            smallc := function( int, part )
                return 1 + Sum( Filtered( DivisorsInt( int ), 
                                          x -> x <= Length(part)), 
                                d -> d * part[d] );
            end;

            Produkt1 := function( p1, p2 )
                local prod, i;

                prod := 1;

                for i in [ 1..Minimum( Int(Length(p1)/2), Int(n/2) ) ] do
                    # if exponent is 0, prod is multiplied by 1 => omit
                    if p1[2*i] <> 0 then
                        prod := prod *
                                (smallc(i,p2)*smallc(2*i,p2)^i)^p1[2*i];
                    fi;
                od;

                return prod;
            end;

            Produkt2 := function( p1, p2 )
                local prod, i;

                prod := 1;

                for i in [1..Minimum( Int((Length(p1)+1)/2), Int((n+1)/2) )] do
                    # if exponent is 0, prod is multiplied by 1 => omit
                    if p1[2*i-1] <> 0 then
                        prod := prod *
                                (smallc(2*i-1,p2))^(i*p1[2*i-1]);
                    fi;
                od;

                return prod;
            end;

            Produkt3 := function( p1, p2 )
                local prod, i, j;

                prod := 1;

                for i in [ 1.. Length(p1) ] do
                    # if exponent is 0, prod is multiplied by 1 => omit
                    if p1[i] <> 0 then
                        prod := prod * smallc(i,p2)^(i*(p1[i]^2-p1[i])/2);
                        for j in [ 1..Minimum( Length(p1), i-1 ) ] do
                            # if exponent is 0, prod is multiplied by 1 => omit
                            if p1[j] <> 0 then
                                prod := prod * smallc(Lcm(i,j),p2)
                                               ^(p1[i]*p1[j]*Gcd(i,j));
                            fi;
                        od;
                    fi;
                od;

                return prod;
            end;

            Produkt := function( p1,p2 );
                return Produkt1( p1,p2 )*Produkt2( p1,p2 )*Produkt3( p1,p2 );
            end;

            # only the zero semigroup in the case |B|=1
            if m = 1 then
                return 1;
            fi;

            # the elements in the Cartesian product are pairs of partitions
            # they stand for elements in a conjugacy class of S_{n-m} x S_{m-1}
            parts := Cartesian( Partitions( n-m ), Partitions( m-1 ));

            # pp is a partition pair
            nrs := List(parts, 
                        pp -> Produkt(transformPart(pp[1]), 
                                      Concatenation(transformPart(pp[2]),[0]))*
                        sizeConjugacyClass(pp[1])* sizeConjugacyClass(pp[2]));

            return Sum( nrs ) / (Factorial( n-m ) * Factorial( m-1 )); 
        end;

        return Sum([2..n-1],
               m -> NrIsomorphismClasses(n,m) - NrIsomorphismClasses(n-1,m-1));
    end;


    nr3NilAll := function( n )
        return Sum([2..Int(n + 1/2 - RootInt(n-1))],
                   k -> Binomial(n,k) * k
                        * Sum([0..k-1],
                              i -> (-1)^i * Binomial(k-1,i)
                                   *(k-i)^((n-k)^2)));
    end; 


    nr3NilAllComm := function( n )
        return Sum([1..Int(n + 3/2 - RootInt(2*n))], 
                   k -> Binomial(n,k) * k
                        *  Sum([0..k-1],
                               i -> (-1)^i * Binomial(k-1,i)
                                    * (k-i)^((n-k)*(n-k+1)/2))); 
    end;

    ##################################################################
    ### MAIN FUNCTION

    types := ["UpToEquivalence", "UpToIsomorphism", "SelfDual", "Commutative",
              "Labelled", "Labelled-Commutative" ];

    # check input
    if Length( arg ) > 2 then
        Error( "number of arguments must be two" );
    elif not IsPosInt( arg[1] ) then
        Error( "first argument must be a positive integer" );
    elif Length( arg ) = 2 and not IsString( arg[2] ) then
        Error( "second argument must be a string" );
    elif Length( arg ) = 2 and not arg[2] in types then
        Error( "invalid second argument, string must be in ", types );
    fi;

    # get input
    size := arg[1];
    if Length( arg ) = 2 then
        type := arg[2];
    else
        type := types[1];
    fi;

    # up to equivalence
    if type = types[1] then
        return ( nr3NilSelfDual( size ) + nr3NilIso( size ) ) / 2;

    # up to isomorphism
    elif type = types[2] then
        return nr3NilIso( size );

    # self dual semigroups
    elif type = types[3] then
        return nr3NilSelfDual( size );

    # commutative semigroups
    elif type = types[4] then
        return nr3NilComm( size );

    # labelled semigroups
    elif type = types[5] then
        return nr3NilAll( size );

    # labelled commutative semigroups
    else
        return nr3NilAllComm( size );
    fi;  
end);


##################

InstallGlobalFunction(NrSmallSemigroups, 
function(arg)
local numb;

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL+1;

Info(InfoSmallsemiEnums, 4, SMALLSEMI_ENTAB("NrSmallSemigroups"));
#this has info level 4 as it is called every time a small semigroup 
#is created

if Length(arg)=1 and IsPosInt(arg[1]) then 
	numb:=[ 1, 4, 18, 126, 1160, 15973, 836021, 1843120128 ];
	if arg[1]>0 and arg[1]<=8 then 
		
		SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;
		return numb[arg[1]];
	else 
		SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;
		Error("only the semigroups of sizes from 1 to 8 are in the library");
	fi;
else
	
	return SMALLSEMI_RETURN(Sum(List(PositionsOfSmallSemigroups(arg), Length)));
fi;	
end);

##################

InstallGlobalFunction(OneSmallSemigroup, 
function(arg)
local iter;

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL+1;

Info(InfoSmallsemiEnums, 3, SMALLSEMI_ENTAB("OneSmallSemigroup"));

if Length(arg)=1 then 
	if IsEnumeratorOfSmallSemigroups(arg[1]) and not Length(arg[1])=0 then 
		return arg[1][1];
	elif IsIteratorOfSmallSemigroups(arg[1]) then 
		iter:=arg[1];
	else
		iter:=IteratorOfSmallSemigroups(arg);
	fi;
else
	iter:=IteratorOfSmallSemigroups(arg);
fi;

if not IsDoneIterator(iter) then 
	return SMALLSEMI_RETURN(NextIterator(IteratorOfSmallSemigroups(arg)));
fi;
SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;
return fail;
end);

##################

InstallGlobalFunction(PositionsOfSmallSemigroups,
function(arg)
local stored, sizes, enum, user, i, j, positions, out, enum2, s, id;

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL+1;

Info(InfoSmallsemiEnums, 3, SMALLSEMI_ENTAB("PositionsOfSmallSemigroups"));

arg:=SMALLSEMI_STRIP_ARG(arg);

if not SMALLSEMI_ARG_OK(arg) then  
		SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;
		Error("input is incorrect.");
fi;

arg:=SMALLSEMI_CONVERT_ARG_NC(arg);
arg:=SMALLSEMI_SORT_ARG_NC(arg);

if not SMALLSEMI_CAN_CREATE_ENUM_NC(arg) then 
	SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;
	Error("cannot create an enumerator or list of positions with input");
fi;

if IsPosInt(arg[1]) and Length(arg)=3 and arg[3]=true then #a single stored value
	stored:=STORED_INFO(arg[1], NAME_FUNC(arg[2])); 
	if not stored=fail then 
		SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;
		return [stored];
	fi;
fi;

if Length(arg)=1 and IsPosInt(arg[1]) then #all semigroups not of order 8
	return SMALLSEMI_RETURN([[1..NrSmallSemigroups(arg[1])]]);
elif IsOddInt(Length(arg)) and (IsPosInt(arg[1]) or 
 IsEnumeratorOfSmallSemigroups(arg[1]) or IsIteratorOfSmallSemigroups(arg[1]) 
 or (IsCyclotomicCollection(arg[1]) and ForAll(arg[1], IsPosInt))) then 
 #for a list of functions and their values

	#find sizes of semigroups
	if IsPosInt(arg[1]) then 
		sizes:=[arg[1]];
	elif IsEnumeratorOfSmallSemigroups(arg[1]) then 
		sizes:=SizesOfSmallSemisInEnum(arg[1]);
	elif IsIteratorOfSmallSemigroups(arg[1]) then 
		sizes:=SizesOfSmallSemisInIter(arg[1]);
	elif IsCyclotomicCollection(arg[1]) and ForAll(arg[1], IsPosInt) then 
		sizes:=arg[1];
	fi;
	
	enum:=[arg[1]];
	user:=[];
	
	if IsIteratorOfSmallSemigroups(arg[1]) then 
		arg:=Concatenation([SizesOfSmallSemisInIter(arg[1])], arg{[2..Length(arg)]}, 
												FuncsOfSmallSemisInIter(arg[1]));
		arg:=SMALLSEMI_SORT_ARG_NC(SMALLSEMI_CONVERT_ARG_NC(arg));
	fi;
	
	#split input into precomputed and user
	for i in [2,4..Length(arg)-1] do
		if NAME_FUNC(arg[i]) in SMALLSEMI_ALWAYS_FALSE and arg[i+1] then 
			SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;
			return [];
		elif ForAll(sizes, j-> NAME_FUNC(arg[i]) in 
		 PrecomputedSmallSemisInfo[j]) then 
			#precomputed function
			enum:=Concatenation(enum, [arg[i], arg[i+1]]);
		else #user function
			user:=Concatenation(user, [arg[i], arg[i+1]]);
		fi;
	od;
	
	#initialize positions
	if IsEnumeratorOfSmallSemigroups(arg[1]) then 
		positions:=List(PositionsOfSmallSemisInEnum(arg[1]), ShallowCopy);
	elif ForAny([3,5..Length(enum)], i-> enum[i]=true) then 
		i:=First([3,5..Length(enum)], i-> enum[i]=true);
		positions:=List(sizes, j-> ShallowCopy(STORED_INFO(j, 
		  NAME_FUNC(enum[i-1]))));
	else
		positions:=List(sizes, i-> [1..NrSmallSemigroups(i)]);
	fi;
	
	#elif Maximum(sizes)<8 or GAPInfo.BytesPerVariable=8 then JDM  
	#	positions:=List(sizes, i-> [1..NrSmallSemigroups(i)]);
	#else #length enum > 1 and one argument is true
	#	i:=First([3,5..Length(enum)], i-> enum[i]=true);
	#	positions:=List(sizes, j-> ShallowCopy(STORED_INFO(j, 
	#	  NAME_FUNC(enum[i-1]))));
	#fi;

	# find what function values are stored already
	for j in [1..Length(sizes)] do 
		
		if Length(enum)>1 then #not just arg[1]
		
			i:=0;
			repeat
				i:=i+2;
				stored:=STORED_INFO(sizes[j], NAME_FUNC(enum[i]));
				if not stored=fail then 
					if enum[i+1]=true then 
						IntersectSet(positions[j], stored);
					elif enum[i+1]=false then 
						SubtractSet(positions[j], stored);
					fi;
				fi;
			until i=Length(enum)-1 or positions[j]=[];
		fi;
		
		# compute the values of any remaining functions
		if not user=[] and not positions[j]=[] then 
			i:=-1;
	
			repeat
				enum2:=EnumeratorOfSmallSemigroupsByIds(sizes[j], positions[j]);
				i:=i+2;
				out:=[];
				#Info(InfoSmallsemi, 4, "testing for ", NAME_FUNC(arg[i]));
				for s in [1..Length(enum2)] do
					if InfoLevel(InfoSmallsemiEnums)=4 then 
						Print("#I  at ", s, " of ", Length(enum2), "\r");
					fi;
					s:=enum2[s];
					if user[i](s)=user[i+1] then 
						Add(out, IdSmallSemigroup(s)[2]); #JDM was AddSet, ok?
					fi;
				od;
				IntersectSet(positions[j], out);
			until i=Length(user)-1 or positions[j]=[];
		fi;
	od;
fi;

if InfoLevel(InfoSmallsemiEnums)=4 then 
	Print("\n");
fi;

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;
return positions;
end);

##################

InstallGlobalFunction(PositionsOfSmallSemisInEnum, enum-> enum!.pos);

##################

InstallGlobalFunction(RandomSmallSemigroup, 
function(arg)
local iter, i, j, s, t, enum;

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL+1;

Info(InfoSmallsemiEnums, 3, SMALLSEMI_ENTAB("RandomSmallSemigroup"));

arg:=SMALLSEMI_STRIP_ARG(arg);

if Length(arg)=1 and IsPosInt(arg[1]) then 
	i:=Random(SMALLSEMI_RS, 1, NrSmallSemigroups(arg[1]));
	SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;
	return SmallSemigroupNC(arg[1], i);
elif SMALLSEMI_CAN_CREATE_ENUM_NC(arg) then 
	enum:=EnumeratorOfSmallSemigroups(arg);
	if not IsEmpty(enum) then 
		i:=Random([1..Length(enum)]); 
		return enum[i];
	fi;
	return fail;	
else
	iter:=IteratorOfSmallSemigroups(arg);
	i:=0;
	j:=Random(SMALLSEMI_RS, 1, 500);
	t:=Runtime();
	
	if not IsDoneIterator(iter) then #in case of the empty iterator
		repeat 
			i:=i+1;
			s:=NextIterator(iter);
		until IsDoneIterator(iter) or Runtime()-t>j;
		
		if IsDoneIterator(iter) and i>1 then 
			iter:=IteratorOfSmallSemigroups(arg);
			for j in [1..RandomList([1..i-1])] do 
				s:=NextIterator(iter);
			od;
		elif IsDoneIterator(iter) and i=1 then #iterators of length 1
			iter:=IteratorOfSmallSemigroups(arg);
			s:=NextIterator(iter);
		fi;
		SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;
		return s;
	fi;
fi;

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;
return fail;

end);

###################

InstallGlobalFunction(SizesOfSmallSemisInEnum,
enum-> enum!.sizes);

InstallGlobalFunction(SizesOfSmallSemisInIter,
enum-> enum!.sizes);


###################

InstallMethod( UpToIsomorphism, "for a list of non-equivalent semigroups",
   [ IsList ], function(semis)
    local out, s, dual, equi;
    
    SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL+1;
    
    Info(InfoSmallsemiEnums, 3, SMALLSEMI_ENTAB("UpToIsomorphism"));
    
    if not ForAll( semis, IsSmallSemigroup ) then
        Error( "input has to be a list of semigroups obtained from ", 
               "the smallsemi library");
    fi;

    out:=[];

    for s in semis do
	Add(out, s);
        if not IsSelfDualSemigroup( s ) then
            # creator for small semigroups cannot be used here as this would
            # result in an object with 'IsSmallSemi' being true but not in
            # the library
            dual := SemigroupByMultiplicationTableNC( 
                        TransposedMat(MultiplicationTable(s)));
            equi := MappingByFunction(dual, s,
                                      function(x)
                                          return AsSSortedList(s)[x![1]];
                                      end);
            SetRespectsMultiplication( equi, false );
            SetIsBijective( equi, true );
            SetEquivalenceSmallSemigroup( dual, equi );
            SetIdSmallSemigroup( dual, IdSmallSemigroup(s));
            Add(out, dual);
        fi;
    od;
    
    SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;
    return out;
end);

InstallMethod( UpToIsomorphism, "for a small semigroup",
   [ IsSmallSemigroup ], s -> UpToIsomorphism( [s] ) );

#Internal Functions
###################

InstallGlobalFunction(SHALLOWCOPYITERATORSMALLSEMI, 
function(iter)

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL+1;

Info(InfoSmallsemiEnums, 3, SMALLSEMI_ENTAB("SHALLOWCOPYITERATORSMALLSEMI"));

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;
return rec(at := 0, max:=iter!.max, enum:=iter!.enum, user:=iter!.user, n:=iter!.n);
end);

###################

InstallGlobalFunction(SMALLSEMI_ARG_OK, 
function(arg)

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL+1;

Info(InfoSmallsemiEnums, 3, SMALLSEMI_ENTAB("SMALLSEMI_ARG_OK"));

arg:=SMALLSEMI_STRIP_ARG(arg);

if not IsOddInt(Length(arg)) then 
	SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;
	return false;
	#Error("there must be an odd number arguments");
fi;

if not (IsPosInt(arg[1]) or IsEnumeratorOfSmallSemigroups(arg[1]) or
	(IsCyclotomicCollection(arg[1]) and ForAll(arg[1], IsPosInt)) or
   IsIteratorOfSmallSemigroups(arg[1])) then 
  SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;
	return false;
	#Error("the first argument must be a pos. int., list of pos. ints., enumerator of small semigps, or
				#an iterator of small semigroups");
fi;

if IsPosInt(arg[1]) and arg[1]>8 then 
	SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;
	return false;
elif IsCyclotomicCollection(arg[1]) and ForAll(arg[1], IsPosInt) and 
 not ForAll(arg[1], x-> x>0 and x<9) then 
 	SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;
	return false;
fi;

if not ForAll([2,4..Length(arg)-1], i-> IsFunction(arg[i])) then 
	SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;
	return false;
fi;

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;

return true;

end);

###################
#only allow precomputed, sorted, and converted functions as input

InstallGlobalFunction(SMALLSEMI_CAN_CREATE_ENUM_NC, 
function(arg)
local max;

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL+1;

Info(InfoSmallsemiEnums, 3, SMALLSEMI_ENTAB("SMALLSEMI_CAN_CREATE_ENUM_NC"));

arg:=SMALLSEMI_STRIP_ARG(arg);

if IsPosInt(arg[1]) then
	max:=arg[1]; 
elif IsEnumeratorOfSmallSemigroups(arg[1]) then 
	SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;
	return true;
elif IsIteratorOfSmallSemigroups(arg[1]) then
	max:=Maximum(SizesOfSmallSemisInIter(arg[1]));
	arg:=Concatenation([SizesOfSmallSemisInIter(arg[1])], arg{[2..Length(arg)]}, 
												FuncsOfSmallSemisInIter(arg[1]));
	arg:=SMALLSEMI_SORT_ARG_NC(SMALLSEMI_CONVERT_ARG_NC(arg));
elif IsCyclotomicCollection(arg[1]) and ForAll(arg[1], IsPosInt) then
	max:=Maximum(arg[1]);
fi;

#precomputed must contain at least 1 true

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;

if Length(arg)>1 then 
	#return max < 8 or GAPInfo.BytesPerVariable=8 or ForAny([2,4..Length(arg)-1], 
	#  i-> NAME_FUNC(arg[i]) in 
	#	  PrecomputedSmallSemisInfo[8] and arg[i+1]);
	return max < 8 or ForAny([2,4..Length(arg)-1], 
	  i-> NAME_FUNC(arg[i]) in 
		  PrecomputedSmallSemisInfo[8] and arg[i+1]);
else
	return max < 8 or (GAPInfo.BytesPerVariable=8 and IsPosInt(arg[1])) or (GAPInfo.BytesPerVariable=8 and ForAll(arg[1], IsPosInt));
	#JDM should be replaced with:
	# return max < 8 or GAPInfo.BytesPerVariable=8 as we should never call this
	# function unless arg[1] is a list of integers or an integer. I.e. we should 
	# have passed SMALLSEMI_ARG_OK before calling this function. 
fi;
end);

###################

InstallGlobalFunction(SMALLSEMI_CONVERT_ARG_NC, 
function(arg)
local out, i, j, pos1, pos2;

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL+1;

Info(InfoSmallsemiEnums, 3, SMALLSEMI_ENTAB("SMALLSEMI_CONVERT_ARG_NC"));

arg:=SMALLSEMI_STRIP_ARG(arg);

out:=[arg[1]];

for i in [2,4..Length(arg)-1] do
	
	pos1:=PositionProperty(SMALLSEMI_EQUIV, x-> [arg[i], arg[i+1]]=x[1]);
	
	if not pos1=fail then 
		out:=Concatenation(out, SMALLSEMI_EQUIV[pos1][2]);
	elif not (arg[i] in SMALLSEMI_ALWAYS_FALSE and not arg[i+1]) then 
		out:=Concatenation(out, [arg[i], arg[i+1]]);
	fi;
od;	
#	pos2:=PositionProperty(SMALLSEMI_CONVERSE, x-> NAME_FUNC(arg[i])=x[1]);
	
#	if not pos2=fail then 
#		if arg[i+1] then 
#			out:=Concatenation(out, SMALLSEMI_CONVERSE[pos2][2]);
#		else
#			out:=Concatenation(out, SMALLSEMI_CONVERSE[pos2][2]);
#			for j in [3, 5..Length(out)] do 
#				if out[j] then 
#					out[j]:=false;
#				else
#				out[j]:=true;
#				fi;
#			od;
#			
#		fi;
#	fi;

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;
return out;
end);

################

InstallGlobalFunction(SMALLSEMI_CREATE_ENUM, 
function(source, position, names)
local fam, enum, i, j, enums, tot, positions, lens, sizes;

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL+1;

Info(InfoSmallsemiEnums, 3, SMALLSEMI_ENTAB("SMALLSEMI_CREATE_ENUM"));

if ForAll(position, x-> x=[]) then
	return SMALLSEMI_RETURN(EmptyEnumeratorOfSmallSemigroups());
fi;

if IsPosInt(source) then 
	sizes:=[source];
elif IsEnumeratorOfSmallSemigroups(source) then 
	sizes:=SizesOfSmallSemisInEnum(source);
	names:=Concatenation(FuncsOfSmallSemisInEnum(source), names);
elif IsIteratorOfSmallSemigroups(source) then 
	sizes:=SizesOfSmallSemisInIter(source);
	names:=Concatenation(FuncsOfSmallSemisInIter(source), names);
elif IsCyclotomicCollection(source) and ForAll(source, IsPosInt) then 
	sizes:=source;
fi;

# some inherited sizes may now not occur
j:=[];

for i in [1..Length(sizes)] do 
  if not position[i]=[] then 
    AddSet(j, i);
  fi;
od;

sizes:=sizes{j};
position:=position{j};

if Length(sizes)=1 then #one size
	fam:=CollectionsFamily(SmallSemigroupEltFamily);

	enum:=EnumeratorByFunctions(Domain(fam, []), rec(

	ElementNumber:=function(enum, pos)
		local s;
		s:=SmallSemigroupNC(sizes[1], position[1][pos]); 
		for i in [1,3..Length(names)-1] do 
			if IsOperation(names[i]) then #JDM ok?
				Setter(names[i])(s, names[i+1]);
			fi;
		od;
		return s;
		end, 

	NumberElement:=function(enum, elm)
		return PositionSorted(position[1], IdSmallSemigroup(elm)[2]);
		end, 

	Length:=enum -> Length(position[1]),

	PrintObj:=function(enum)
		Print( "<enumerator of semigroups of size ", sizes[1], ">");
		#JDM is this optimal?
		return;
		end, 

        pos:=position, sizes:=sizes, funcs:=names, names:= List(names, 
        function(x) if IsFunction(x) then return NAME_FUNC(x); else return x;
        fi; end)));

	SetIsEnumeratorOfSmallSemigroups(enum, true);
	#SetPositionsOfSmallSemisInEnum(enum, position);
	#SetSizesOfSmallSemisInEnum(enum, sizes);
	SetIsFinite(enum, true);
	#SetFuncsOfSmallSemisInEnum(enum, names);
	#SetNamesFuncsSmallSemisInEnum(enum, List(names, 
	#function(x) 
	#if IsFunction(x) then return NAME_FUNC(x); 
	#	else return x; fi; end));
		
	SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;
	return enum;

else #range of sizes

	enums:=[];
	for i in [1..Length(sizes)] do 
		enum:=SMALLSEMI_CREATE_ENUM(sizes[i], [position[i]], names);
		Add(enums, enum);
	od;
	
	if ForAll(enums, x-> Length(x)=0) then 
		return SMALLSEMI_RETURN(EmptyEnumeratorOfSmallSemigroups());
	fi;
	
	tot:=0;
	lens:=[0];
	for i in enums do 
		tot:=tot+Length(i);
		Add(lens, tot);
	od;
	
	enum:=First(enums, x-> not Length(x)=0);
	fam:=CollectionsFamily(FamilyObj(enum[1]));
	
	enum:=EnumeratorByFunctions(Domain(fam, []), rec(
	ElementNumber:=function(enum, pos)
	local i;
	i:=PositionProperty(lens, x-> pos<=x)-1;
	
	return enums[i][pos-lens[i]];
	end, 

	NumberElement:=function(enum, elm)
	local id, i;
	
	id:=IdSmallSemigroup(elm);
	i:=Position(sizes, id[2]);
	
	return Position(enums[i], elm)+tot[i-1];
	end, 

	Length:=enum -> tot,

	PrintObj:=function(enum)
	Print( "<enumerator of semigroups of sizes ", sizes, ">");
        #JDM is this optimal?
	return;
	end, 
        
        pos:=List(enums, x->PositionsOfSmallSemisInEnum(x)[1]), 
        sizes:=sizes, funcs:=names, names:=List(names, function(x) 
        if IsFunction(x) then return NAME_FUNC(x); else return x; fi; end)));

	SetIsEnumeratorOfSmallSemigroups(enum, true);
	#SetPositionsOfSmallSemisInEnum(enum, List(enums, 
        # x->PositionsOfSmallSemisInEnum(x)[1]));
	#SetFuncsOfSmallSemisInEnum(enum, names);
	#SetNamesFuncsSmallSemisInEnum(enum, List(names, 
	#function(x) 
	#if IsFunction(x) then return NAME_FUNC(x); 
	#	else return x; fi; end));
  	#SetSizesOfSmallSemisInEnum(enum, sizes);
	SetIsFinite(enum, true);
	
	SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;
	return enum;
fi;

end);

###################

InstallGlobalFunction(SMALLSEMI_ENTAB,
function(str)
local sp;

sp:="";

if SMALLSEMI_TAB_LEVEL>0 then 
	sp:=" ";
fi;

return Concatenation(Concatenation(List([1..SMALLSEMI_TAB_LEVEL], x-> ">")), sp, str);
end);

###################

InstallGlobalFunction(SMALLSEMI_SORT_ARG_NC, 
function(arg)
local input;

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL+1;

Info(InfoSmallsemiEnums, 3, SMALLSEMI_ENTAB("SMALLSEMI_SORT_ARG_NC"));

arg:=SMALLSEMI_STRIP_ARG(arg);

input:=List([2,4..Length(arg)-1], i-> [arg[i], arg[i+1]]);
Sort(input, function(x,y) 
if x[2]<y[2] then 
	return true; 
elif x[2]=y[2] then 
	return NAME_FUNC(x[1])<NAME_FUNC(y[1]);
fi;

end);

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;

return Concatenation([arg[1]], Concatenation(input));
end);

###################

InstallGlobalFunction(SMALLSEMI_STRIP_ARG, 
function(input)

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL+1;

Info(InfoSmallsemiEnums, 3, SMALLSEMI_ENTAB("SMALLSEMI_STRIP_ARG"));

if IsList(input) and Length(input)=1 and not IsPosInt(input[1]) and 
		not IsEnumeratorOfSmallSemigroups(input[1]) 
		and not IsIteratorOfSmallSemigroups(input[1]) and not (IsCyclotomicCollection(input[1]) and
		 ForAll(input[1], IsPosInt)) then 
	SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;
	return input[1];
fi;

SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;

return input;
end);


###################

InstallValue(SMALLSEMI_RS, RandomSource(IsMersenneTwister));

###################

InstallGlobalFunction(SMALLSEMI_RETURN,
function(out)
if SMALLSEMI_TAB_LEVEL>-1 then 
	SMALLSEMI_TAB_LEVEL:=SMALLSEMI_TAB_LEVEL-1;
fi;
return out;
end);
