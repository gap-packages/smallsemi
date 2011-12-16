#############################################################################
#
# This file contains functions that are used in the development of the
# smallsemi package and will *not* be part of the release version.
#
#############################################################################

# $Id$

### compile documentation at startup
#Info( InfoWarning, 1, "compiling 'smallsemi' documentation");
#info_level := InfoLevel( InfoGAPDoc );
#SetInfoLevel( InfoGAPDoc, 0 );
#MakeGAPDocDoc(DirectoriesPackageLibrary("smallsemi","doc")[1]![1], "smallsemi.xml", ["../gap/small.gd","../gap/properties.gd", "../dev/dev.gd","../gap/enums.gd","../gap/autovars.g"], "manual");;
#SetInfoLevel( InfoGAPDoc, info_level );
#Unbind( info_level );

#############################################################################
##
##  returns presentations for all semigroups of order <n> and coclass 1
##  up to equivalence
##
InstallGlobalFunction( SemigroupsWithCoclass1,
function( n )
    local sgrps, # list of all semigroups
          f,     # free semigroup on two elements
          x,     # generators of <f>
          k;     # loop counter

    # catch input error
    if not IsPosInt( n ) then
        Error( "<n> has to be a positive integer" );
    fi;

    f := FreeSemigroup( 2 );
    x := GeneratorsOfSemigroup( f );

    # catch exceptional cases
    if n <= 2 then
        return [ ];

    elif n = 3 then    # the zero semigroup
        return [ f / [[ x[1]^2, x[1]^3 ],       # u^2 = u^3
                      [ x[1]^2, x[2]^2 ],       # u^2 = v^2
                      [ x[1]^2, x[1]*x[2] ],    # u^2 = uv
                      [ x[1]^2, x[2]*x[1] ] ]]; # u^2 = vu
    fi;

    sgrps := SemigroupsWithCoclassD_NC(n, 1);
        
    if n = 4 then    # additional semigroups since 3-nilpotent
        Add( sgrps, f / [[ x[1]^2, x[1]^3 ],       # u^2 = u^3
                         [ x[1]^2, x[2]^2 ],       # u^2 = v^2
                         [ x[1]^2, x[1]*x[2] ],    # u^2 = uv
                         [ x[1]^2, x[2]^3 ] ] );   # u^2 = v^3
        Add( sgrps, f / [[ x[1]^2, x[1]^3 ],       # u^2 = u^3
                         [ x[1]^2, x[2]^2 ],       # u^2 = v^2
                         [ x[1]*x[2], x[2]*x[1] ], # uv = vu
                         [ x[1]^2, x[2]^3 ] ] );   # u^2 = v^3
    
    fi;

    return sgrps;
    # 
#    for k in [ 2..n-Int(n/2)-1 ] do
#        Add( sgrps, f / [[ x[1]^(n-1), x[1]^n ],      # u^n = u^(n-1)
#                         [ x[1]*x[2], x[2]*x[1]],     # uv = vu
#                         [ x[1]*x[2], x[1]^k ],       # uv = u^k
#                         [ x[2]^2, x[1]^(2*k-2) ]] ); # v^2 = u^(2k-2)
#    od;
#
#    for k in [ n-Int(n/2)..n-1 ] do  # \{ \lceil n/2 \rceil, \dots, n-1 \}
#        Add( sgrps, f / [[ x[1]^(n-1), x[1]^n ],    # u^n = u^(n-1)
#                         [ x[1]*x[2], x[2]*x[1]],   # uv = vu
#                         [ x[1]*x[2], x[1]^k ],     # uv = u^k
#                         [ x[2]^2, x[1]^(n-2) ]] ); # v^2 = u^(n-2)
#        Add( sgrps, f / [[ x[1]^(n-1), x[1]^n ],    # u^n = u^(n-1)
#                         [ x[1]*x[2], x[2]*x[1]],   # uv = vu
#                         [ x[1]*x[2], x[1]^k ],     # uv = u^k
#                         [ x[2]^2, x[1]^(n-1) ]] ); # v^2 = u^(n-1)
#    od;
#
#    Add( sgrps, f / [[ x[1]^(n-1), x[1]^n ],    # u^n = u^(n-1)
#                     [ x[1]*x[2], x[1]^(n-2) ], # uv = u^(n-2)
#                     [ x[2]*x[1], x[1]^(n-1) ], # vu = u^(n-1)
#                     [ x[2]^2, x[1]^(n-2) ]] ); # v^2 = u^(n-2)
#
#    Add( sgrps, f / [[ x[1]^(n-1), x[1]^n ],    # u^n = u^(n-1)
#                     [ x[1]*x[2], x[1]^(n-2) ], # uv = u^(n-2)
#                     [ x[2]*x[1], x[1]^(n-1) ], # vu = u^(n-1)
#                     [ x[2]^2, x[1]^(n-1) ]] ); # v^2 = u^(n-1)

end);


#############################################################################
##
##  returns presentations for all semigroups of order <n> and coclass <d>
##  with <d>+1 generators and <d> of those generating a monogenic semigroup
##  of coclass <d> up to equivalence
##
InstallGlobalFunction( SemigroupsWithCoclassD_NC,
function( n, d )
    local sgrps,      # list of all semigroups
          f,          # free semigroup on two elements
          x,          # generators of <f>
          basrels,    # relations appearing for each semigroup
          rels,       # relations of a specific semigroup
          i, j, k, m; # loop counter

    f := FreeSemigroup( d+1 );
    x := GeneratorsOfSemigroup( f );

    sgrps := EmptyPlist( 5*n + Int(n/2) - 1 ); # HOW MANY?

    basrels := [ [ x[1]^(n-d), x[1]^(n-d+1) ] ];
    for i in [ 2..d ] do
        Add( basrels, [ x[1]^2, x[i]^2 ] );        # u_1^2 = u_i^2
        for j in [ i+1..d ] do
            Add( basrels, [ x[1]^2, x[i]*x[j] ] ); # u_1^2 = u_iu_j
            Add( basrels, [ x[1]^2, x[j]*x[1] ] ); # u_1^2 = u_ju_i
        od;
    od;

    # 
    for k in [ 2..Int((n-d)/2) ] do
        rels := ShallowCopy( basrels );
        for i in [ 1..d ] do
            Add( rels, [ x[i]*x[d+1], x[d+1]*x[i] ] ); # u_iv = vu_i
            Add( rels, [ x[i]*x[d+1], x[1]^k ] );      # u_iv = u_1^k
        od;
        Add( rels, [ x[d+1]^2, x[1]^(2*k-2) ] );       # v^2 = u_1^(2k-2)
        Add( sgrps, f / rels );
    od;

    for k in [ Int((n-d)/2)+1..n-d-2 ] do

        rels := ShallowCopy( basrels );
        for i in [ 1..d ] do
            Add( rels, [ x[i]*x[d+1], x[d+1]*x[i] ] ); # u_iv = vu_i
            Add( rels, [ x[i]*x[d+1], x[1]^k ] );      # u_iv = u_1^k
        od;
        Add( rels, [ x[d+1]^2, x[1]^(n-d) ] );         # v^2 = u_1^(n-d)
        Add( sgrps, f / rels );

        Remove( rels );
        Add( rels, [ x[d+1]^2, x[1]^(n-d-1) ] ); # v^2 = u_1^(n-d-1)
        Add( sgrps, f / rels );

    od;

    # 0 <= j <= k <= m <= d
    for j in [ 0..d ] do
      for k in [ j..d ] do
        for m in [ k+Int(d-k)..d ] do

            rels := ShallowCopy( basrels );
            for i in [ 1..j ] do
                Add( rels, [ x[i]*x[d+1], x[1]^(n-d-1) ] );
                Add( rels, [ x[d+1]*x[i], x[1]^(n-d-1) ] );
            od;
            for i in [ j+1..k ] do
                Add( rels, [ x[i]*x[d+1], x[1]^(n-d) ] );
                Add( rels, [ x[d+1]*x[i], x[1]^(n-d) ] );
            od;
            for i in [ k+1..m ] do
                Add( rels, [ x[i]*x[d+1], x[1]^(n-d) ] );
                Add( rels, [ x[d+1]*x[i], x[1]^(n-d-1) ] );
            od;
            for i in [ m+1..d ] do
                Add( rels, [ x[i]*x[d+1], x[1]^(n-d-1) ] );
                Add( rels, [ x[d+1]*x[i], x[1]^(n-d) ] );
            od;
            Add( rels, [ x[d+1]^2, x[1]^(n-d) ] );          # v^2 = u_1^(n-d)
            Add( sgrps, f / rels );

            Remove( rels );
            Add( rels, [ x[d+1]^2, x[1]^(n-d-1) ] );        # v^2 = u_1^(n-d-1)
            Add( sgrps, f / rels );

        od;
      od;
    od;

    return sgrps;
end);

#############################################################################
##
##  returns presentations for all semigroups of order <n> and coclass <d>
##  with <d>+1 generators and <d> of those generating a monogenic semigroup
##  of coclass <d> up to equivalence
##
InstallGlobalFunction( SemigroupsWithCoclassD,
function( n, d )

    # catch input errors
    if not IsPosInt( n ) then
        Error( "<n> has to be a positive integer" );
    fi;

    if not IsPosInt( d ) then
        Error( "<d> has to be a positive integer" );
    fi;

    # catch restriction of coclass value <d> depending on order <n>
    if n < 4+d then
        Error( "the difference of the order <n> and the coclass <d>",
               " must not excede 4" );
    fi;

    return SemigroupsWithCoclassD_NC(n, d);
end);
#############################################################################
##
##  returns presentations for all semigroups of order <n> and coclass 2
##  which have a minimal generating set of size 3 up to equivalence
##
InstallGlobalFunction( SemigroupsWithCoclass2And3Generators,
function( n )
    local sgrps, # list of all semigroups
          f,     # free semigroup on two elements
          x,     # generators of <f>
          k;     # loop counter

    f := FreeSemigroup( 3 );
    x := GeneratorsOfSemigroup( f );
    sgrps := EmptyPlist( 5*n + Int(n/2) - 1 );

    # y = v^2 = uv = vu
    Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ], # u^(n-2) = u^(n-1)
                     [ x[1]*x[2], x[2]*x[1]],    # uv = vu
                     [ x[2]^2, x[1]*x[2] ],      # v^2 = uv
                     [ x[2]^3, x[1]^(n-3) ]] );  # v^3 = u^(n-3)
    Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ], # u^(n-2) = u^(n-1)
                     [ x[1]*x[2], x[2]*x[1]],    # uv = vu
                     [ x[2]^2, x[1]*x[2] ],      # v^2 = uv
                     [ x[2]^3, x[1]^(n-2) ]] );  # v^3 = u^(n-2)

    # y = uv = vu
    for k in [ 3,4..Int( (n-1)/2 ) ] do
        Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ], # u^(n-2) = u^(n-1)
                         [ x[1]*x[2], x[2]*x[1]],    # uv = vu
                         [ x[2]^2, x[1]^(2*k-4) ],   # v^2 = u^(2k-4)
                         [ x[1]^2*x[2], x[1]^k ]] ); # u^2v = u^k
    od;
    for k in [ n-Int(n/2)..n-2 ] do
        Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ], # u^(n-2) = u^(n-1)
                         [ x[1]*x[2], x[2]*x[1]],    # uv = vu
                         [ x[2]^2, x[1]^(n-4) ],     # v^2 = u^(n-4)
                         [ x[1]^2*x[2], x[1]^k ]] ); # u^2v = u^k
        Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ], # u^(n-2) = u^(n-1)
                         [ x[1]*x[2], x[2]*x[1]],    # uv = vu
                         [ x[2]^2, x[1]^(n-3) ],     # v^2 = u^(n-3)
                         [ x[1]^2*x[2], x[1]^k ]] ); # u^2v = u^k
        Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ], # u^(n-2) = u^(n-1)
                         [ x[1]*x[2], x[2]*x[1]],    # uv = vu
                         [ x[2]^2, x[1]^(n-2) ],     # v^2 = u^(n-2)
                         [ x[1]^2*x[2], x[1]^k ]] ); # u^2v = u^k
    od;

    # y = uv = v^2
    Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ], # u^(n-2) = u^(n-1)
                     [ x[2]^2, x[1]*x[2] ],      # v^2 = uv
                     [ x[2]*x[1], x[1]^2 ],      # vu = u^2
                     [ x[1]*x[2]^2, x[1]^3 ]] ); # uv^2 = u^3
    Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ],     # u^(n-2) = u^(n-1)
                     [ x[2]^2, x[1]*x[2] ],          # v^2 = uv
                     [ x[2]*x[1], x[1]^(n-3) ],      # vu = u^(n-3)
                     [ x[1]*x[2]^2, x[1]^(n-2) ]] ); # uv^2 = u^(n-2)
    Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ],     # u^(n-2) = u^(n-1)
                     [ x[2]^2, x[1]*x[2] ],          # v^2 = uv
                     [ x[2]*x[1], x[1]^(n-2) ],      # vu = u^(n-2)
                     [ x[1]*x[2]^2, x[1]^(n-2) ]] ); # uv^2 = u^(n-2)

    # y = v^2
    for k in [ 2..n-2 ] do
        Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ],  # u^(n-2) = u^(n-1)
                         [ x[1]*x[2], x[2]*x[1]],     # uv = vu
                         [ x[1]*x[2], x[1]^k ],       # uv = u^k
                         [ x[2]^3, x[1]^(3*k-3) ]] ); # v^3 = u^(3k-3)
    od;
    for k in [ n-Int(2*n/3)..n-2 ] do
        Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ], # u^(n-2) = u^(n-1)
                         [ x[1]*x[2], x[2]*x[1]],    # uv = vu
                         [ x[1]*x[2], x[1]^k ],      # uv = u^k
                         [ x[2]^3, x[1]^(n-3) ]] );  # v^3 = u^(n-3)
    od;
    Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ], # u^(n-2) = u^(n-1)
                     [ x[1]*x[2], x[1]^(n-3) ],  # uv = u^(n-3)
                     [ x[2]*x[1], x[1]^(n-2) ],  # vu = u^(n-2)
                     [ x[2]^3, x[1]^(n-3) ]] );  # v^3 = u^(n-3)
    Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ], # u^(n-2) = u^(n-1)
                     [ x[1]*x[2], x[1]^(n-3) ],  # uv = u^(n-3)
                     [ x[2]*x[1], x[1]^(n-2) ],  # vu = u^(n-2)
                     [ x[2]^3, x[1]^(n-2) ]] );  # v^3 = u^(n-2)

    # y = vu
    for k in [ 2..n-Int((n+1)/2)-1 ] do
        Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ],     # u^(n-2) = u^(n-1)
                         [ x[1]*x[2], x[1]^k ],          # uv = u^k
                         [ x[2]^2, x[1]^(2*k-2) ],       # v^2 = u^(2k-2)
                         [ x[2]*x[1]^2, x[1]^(k+1) ]] ); # vu^2 = u^(k+1)
    od;
    for k in [ n-Int((n+1)/2)..n-2 ] do
        Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ],     # u^(n-2) = u^(n-1)
                         [ x[1]*x[2], x[1]^k ],          # uv = u^k
                         [ x[2]^2, x[1]^(n-2) ],         # v^2 = u^(n-2)
                         [ x[2]*x[1]^2, x[1]^(k+1) ]] ); # vu^2 = u^(k+1)
        Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ],     # u^(n-2) = u^(n-1)
                         [ x[1]*x[2], x[1]^k ],          # uv = u^k
                         [ x[2]^2, x[1]^(n-3) ],         # v^2 = u^(n-3)
                         [ x[2]*x[1]^2, x[1]^(k+1) ]] ); # vu^2 = u^(k+1)
    od;
    for k in [ n-3..n-2 ] do
        Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ],     # u^(n-2) = u^(n-1)
                         [ x[1]*x[2], x[1]^(n-4) ],      # uv = u^(n-4)
                         [ x[2]^2, x[1]^k ],             # v^2 = u^k
                         [ x[2]*x[1]^2, x[1]^(n-2) ]] ); # vu^2 = u^(n-2)
        Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ],     # u^(n-2) = u^(n-1)
                         [ x[1]*x[2], x[1]^(n-3) ],      # uv = u^(n-3)
                         [ x[2]^2, x[1]^k ],             # v^2 = u^k
                         [ x[2]*x[1]^2, x[1]^(n-3) ]] ); # vu^2 = u^(n-3)
        Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ],     # u^(n-2) = u^(n-1)
                         [ x[1]*x[2], x[1]^(n-2) ],      # uv = u^(n-2)
                         [ x[2]^2, x[1]^k ],             # v^2 = u^k
                         [ x[2]*x[1]^2, x[1]^(n-3) ]] ); # vu^2 = u^(n-3)
    od;

    return sgrps;
end);

#############################################################################
##
##  returns presentations for all semigroups of order <n> and coclass 2
##  which have a minimal generating set of size 2 up to equivalence
##
InstallGlobalFunction( SemigroupsWithCoclass2And2Generators,
function( n )
    local sgrps, # list of all semigroups
          f,     # free semigroup on two elements
          x,     # generators of <f>
          k;     # loop counter

    f := FreeSemigroup( 2 );
    x := GeneratorsOfSemigroup( f );
    sgrps := EmptyPlist( 5*n + Int(n/2) - 1 );

    # y = v^2 = uv = vu
    Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ], # u^(n-2) = u^(n-1)
                     [ x[1]*x[2], x[2]*x[1]],    # uv = vu
                     [ x[2]^2, x[1]*x[2] ],      # v^2 = uv
                     [ x[2]^3, x[1]^(n-3) ]] );  # v^3 = u^(n-3)
    Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ], # u^(n-2) = u^(n-1)
                     [ x[1]*x[2], x[2]*x[1]],    # uv = vu
                     [ x[2]^2, x[1]*x[2] ],      # v^2 = uv
                     [ x[2]^3, x[1]^(n-2) ]] );  # v^3 = u^(n-2)

    # y = uv = vu
    for k in [ 3,4..Int( (n-1)/2 ) ] do
        Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ], # u^(n-2) = u^(n-1)
                         [ x[1]*x[2], x[2]*x[1]],    # uv = vu
                         [ x[2]^2, x[1]^(2*k-4) ],   # v^2 = u^(2k-4)
                         [ x[1]^2*x[2], x[1]^k ]] ); # u^2v = u^k
    od;
    for k in [ n-Int(n/2)..n-2 ] do
        Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ], # u^(n-2) = u^(n-1)
                         [ x[1]*x[2], x[2]*x[1]],    # uv = vu
                         [ x[2]^2, x[1]^(n-4) ],     # v^2 = u^(n-4)
                         [ x[1]^2*x[2], x[1]^k ]] ); # u^2v = u^k
        Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ], # u^(n-2) = u^(n-1)
                         [ x[1]*x[2], x[2]*x[1]],    # uv = vu
                         [ x[2]^2, x[1]^(n-3) ],     # v^2 = u^(n-3)
                         [ x[1]^2*x[2], x[1]^k ]] ); # u^2v = u^k
        Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ], # u^(n-2) = u^(n-1)
                         [ x[1]*x[2], x[2]*x[1]],    # uv = vu
                         [ x[2]^2, x[1]^(n-2) ],     # v^2 = u^(n-2)
                         [ x[1]^2*x[2], x[1]^k ]] ); # u^2v = u^k
    od;

    # y = uv = v^2
    Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ], # u^(n-2) = u^(n-1)
                     [ x[2]^2, x[1]*x[2] ],      # v^2 = uv
                     [ x[2]*x[1], x[1]^2 ],      # vu = u^2
                     [ x[1]*x[2]^2, x[1]^3 ]] ); # uv^2 = u^3
    Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ],     # u^(n-2) = u^(n-1)
                     [ x[2]^2, x[1]*x[2] ],          # v^2 = uv
                     [ x[2]*x[1], x[1]^(n-3) ],      # vu = u^(n-3)
                     [ x[1]*x[2]^2, x[1]^(n-2) ]] ); # uv^2 = u^(n-2)
    Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ],     # u^(n-2) = u^(n-1)
                     [ x[2]^2, x[1]*x[2] ],          # v^2 = uv
                     [ x[2]*x[1], x[1]^(n-2) ],      # vu = u^(n-2)
                     [ x[1]*x[2]^2, x[1]^(n-2) ]] ); # uv^2 = u^(n-2)

    # y = v^2
    for k in [ 2..n-2 ] do
        Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ],  # u^(n-2) = u^(n-1)
                         [ x[1]*x[2], x[2]*x[1]],     # uv = vu
                         [ x[1]*x[2], x[1]^k ],       # uv = u^k
                         [ x[2]^3, x[1]^(3*k-3) ]] ); # v^3 = u^(3k-3)
    od;
    for k in [ n-Int(2*n/3)..n-2 ] do
        Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ], # u^(n-2) = u^(n-1)
                         [ x[1]*x[2], x[2]*x[1]],    # uv = vu
                         [ x[1]*x[2], x[1]^k ],      # uv = u^k
                         [ x[2]^3, x[1]^(n-3) ]] );  # v^3 = u^(n-3)
    od;
    Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ], # u^(n-2) = u^(n-1)
                     [ x[1]*x[2], x[1]^(n-3) ],  # uv = u^(n-3)
                     [ x[2]*x[1], x[1]^(n-2) ],  # vu = u^(n-2)
                     [ x[2]^3, x[1]^(n-3) ]] );  # v^3 = u^(n-3)
    Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ], # u^(n-2) = u^(n-1)
                     [ x[1]*x[2], x[1]^(n-3) ],  # uv = u^(n-3)
                     [ x[2]*x[1], x[1]^(n-2) ],  # vu = u^(n-2)
                     [ x[2]^3, x[1]^(n-2) ]] );  # v^3 = u^(n-2)

    # y = vu
    for k in [ 2..n-Int((n+1)/2)-1 ] do
        Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ],     # u^(n-2) = u^(n-1)
                         [ x[1]*x[2], x[1]^k ],          # uv = u^k
                         [ x[2]^2, x[1]^(2*k-2) ],       # v^2 = u^(2k-2)
                         [ x[2]*x[1]^2, x[1]^(k+1) ]] ); # vu^2 = u^(k+1)
    od;
    for k in [ n-Int((n+1)/2)..n-2 ] do
        Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ],     # u^(n-2) = u^(n-1)
                         [ x[1]*x[2], x[1]^k ],          # uv = u^k
                         [ x[2]^2, x[1]^(n-2) ],         # v^2 = u^(n-2)
                         [ x[2]*x[1]^2, x[1]^(k+1) ]] ); # vu^2 = u^(k+1)
        Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ],     # u^(n-2) = u^(n-1)
                         [ x[1]*x[2], x[1]^k ],          # uv = u^k
                         [ x[2]^2, x[1]^(n-3) ],         # v^2 = u^(n-3)
                         [ x[2]*x[1]^2, x[1]^(k+1) ]] ); # vu^2 = u^(k+1)
    od;
    for k in [ n-3..n-2 ] do
        Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ],     # u^(n-2) = u^(n-1)
                         [ x[1]*x[2], x[1]^(n-4) ],      # uv = u^(n-4)
                         [ x[2]^2, x[1]^k ],             # v^2 = u^k
                         [ x[2]*x[1]^2, x[1]^(n-2) ]] ); # vu^2 = u^(n-2)
        Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ],     # u^(n-2) = u^(n-1)
                         [ x[1]*x[2], x[1]^(n-3) ],      # uv = u^(n-3)
                         [ x[2]^2, x[1]^k ],             # v^2 = u^k
                         [ x[2]*x[1]^2, x[1]^(n-3) ]] ); # vu^2 = u^(n-3)
        Add( sgrps, f / [[ x[1]^(n-1), x[1]^(n-2) ],     # u^(n-2) = u^(n-1)
                         [ x[1]*x[2], x[1]^(n-2) ],      # uv = u^(n-2)
                         [ x[2]^2, x[1]^k ],             # v^2 = u^k
                         [ x[2]*x[1]^2, x[1]^(n-3) ]] ); # vu^2 = u^(n-3)
    od;

    return sgrps;
end);

#############################################################################
InstallMethod( AutomorphismGroup, "for a small semigroup", [IsSemigroup],
function( S )
    local LitNum, NumLit, diag2lits, tbl2lits, onLiterals,
        n, mt, diag, phi, diaglits, tbllits, stab;
    
    LitNum := function(ln, n)
        return [QuoInt(ln-1,n^2)+1,QuoInt((ln-1) mod n^2,n)+1,(ln-1) mod n+1];
    end;
 
    NumLit := function(lit,n)
        # lit = [ row, col, val ]
        return (lit[1]-1)*n^2 + (lit[2]-1)*n + lit[3];
    end;

    diag2lits := function(diag,n)
        return List( [1..n], i -> NumLit( [i,i,diag[i]], n ) );
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
    mt := MultiplicationTable( S );
    diag := DiagonalOfMat( mt );
    phi := ActionHomomorphism( SymmetricGroup(n), [1..n^3], onLiterals(n) );

    # get stabiliser of diagonal
    diaglits := diag2lits( diag, n );
    stab := Stabilizer( Image(phi), diaglits, OnSets );

    # get stabiliser of table
    tbllits := tbl2lits( mt, n );
    stab := Stabilizer( stab, tbllits, OnSets);

    return PreImage( phi, stab );
end);



SymmetryGroup := function( S )
    local LitNum, NumLit, diag2lits, tbl2lits, onLiterals,
        n, mt, diag, phi, diaglits, tbllits, stab;
    
    LitNum := function(ln, n)
        return [QuoInt(ln-1,n^2)+1,QuoInt((ln-1) mod n^2,n)+1,(ln-1) mod n+1];
    end;
 
    NumLit := function(lit,n)
        # lit = [ row, col, val ]
        return (lit[1]-1)*n^2 + (lit[2]-1)*n + lit[3];
    end;

    diag2lits := function(diag,n)
        return List( [1..n], i -> NumLit( [i,i,diag[i]], n ) );
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
    mt := MultiplicationTable( S );
    diag := DiagonalOfMat( mt );
    phi := ActionHomomorphism( ClosureGroup( SymmetricGroup(n), (n+1,n+2)), 
                               [1..n^3], onLiterals(n) );

    # get stabiliser of diagonal
    diaglits := diag2lits( diag, n );
    stab := Stabilizer( Image(phi), diaglits, OnSets );

    # get stabiliser of table
    tbllits := tbl2lits( mt, n );
    stab := Stabilizer( stab, tbllits, OnSets);

    return PreImage( phi, stab );
end;

#############################################################################

DeclareGlobalFunction("PackSmallsemi");

# The function `PackSmallSemi' can be used to pack the smallsemi package for release. 
#
# Before running `PackSmallSemi' first edit pre_index.html and CHANGES to include a 
# new entry 
# in the list of older version. If you don't do this then the date etc will be 
# lost.
#
# The argument of `PackSmallSemi' should be a string containing the new version 
# number, for example "3.1" or "3.1.1". It then does the following things:
#
# 1) gets the date from UNIX
# 2) gets the old version number from the PackageInfo.g file
# 3) replaces the old version number in PackageInfo.g with the new version 
#    number and changes the record component date to the current date.
# 4) replaces the old version number in the README.txt, init.g, and read.g file with the new one
# 5) replace the first 12 lines of the following files with blank, file name, date, new version number, blank. The files are README.txt, init.g, and read.g, all the files in all directories in smallsemi/ except doc and dev (please note that if there are directories in these directories then the function will likely break). 
# 6) replace the old version numbers in the .tst files with the new ones
# 7) update the version number in the documentation & compile it
# 8) update the date and version numbers in the webpage: pre_index.html producing the file index.html
# 9) copy the webpage index.html to gregory/home/jamesm/public_html/smallsemi
# 10) copy the documentation to gregory public_html/smallsemi/doc, that is all files ending .html in the doc folder, manual.css and manual.pdf
# 11) copy the whole folder smallsemi to /tmp
# 12) delete directory `dev' and all files starting with `.' in the /tmp copy
# 13) delete lines between occurrences of `#JDM remove' in read.g
# 14) create the archive in .tar.gz and .tar.bz2 format using the script tar.sh in dev/bin
# 15) copy the archives to the dev/archives folder and to the desktop
# 16) copy the archive, README.txt, and PackageInfo.g files to gregory
# 17) change the permissions on gregory in public_html/smallsemi/ and public_html/smallsemi/doc to a+rx
# 18) clean up by deleting all the created files in /tmp


#JDM should stop this from replace 0.5 in 0.5.1 so that it becomes 0.5.1.1 and 
#JDM elsewhere here!

InstallGlobalFunction(PackSmallsemi, 
function(arg)
local home, date, file, new, oldvers, files, dir, dirs, short, i, tog, newnew, name, oldname, date2, useryn, doit, str, svn_rev_number, newvers;

newvers:=arg[1];

#########

	useryn:=function(helptext)
	local keyed, out;
	
	repeat 
	
		keyed:=CHAR_INT(ReadByte(InputTextUser()));

		if keyed = 'y' or keyed = 'Y' then 
			out:=true;
		elif keyed ='n' or keyed = 'N' then 
			out:=false;
		elif keyed ='h' or keyed = 'H' then 
			#Info(InfoAutos, 4, helptext);
			out:=fail;
		elif keyed = 'q' or keyed = 'Q' then 
			Error("quitting!");
		else
			Info(InfoWarning, 1, "Error: input must be y, n, h (for help), or q (for quit)!");
			out:=fail;
		fi;
	until not out=fail;
	return out;
	end; 
	
#########

home:=PackageInfo("smallsemi")[1]!.InstallationPath;

# get the date
Print("#I  getting the date from UNIX... ");
Exec(Concatenation("date > ", home, "/dev/tmp"));
date:=Chomp(StringFile(Filename(Directory(home), "/dev/tmp")));

Print(date, "\n");

# get the svn revision number
Print("#I  getting the svn revision number... ");
Exec(Concatenation("svn info ", home, " > ", home, "/dev/tmp2"));
new:=StringFile(Filename(Directory(home), "/dev/tmp2"));
new:=SplitString(new, "\n")[5];;
svn_rev_number:=SplitString(new, " ")[2];
Exec(Concatenation("rm -f ", home, "/dev/tmp2"));
Print(svn_rev_number, "\n");

# get the date in the PackageInfo.g format
Print("#I  getting the date in PackInfo.g format... ");
Exec(Concatenation("date \"+%d/%m/%Y\" > ", home, "/dev/tmp"));
date2:=Chomp(StringFile(Filename(Directory(home), "/dev/tmp")));
Exec(Concatenation("rm -f ", home, "/dev/tmp"));
Print(date2, "\n");

# get the old version number from PackageInfo.g and replace it with the new one
# insert the new date too
if Length(arg)=2 then 
	oldvers:=arg[2];
else
	Print("#I  getting the old version number from PackageInfo.g... ");
	file:=Filename(Directory(home), "PackageInfo.g");;
	new:=StringFile(file);;
	new:=SplitString(new, "\"");;
	oldvers:=new[6];
	Print(oldvers, "\n");
fi;

#########

Print("\n");
Info(InfoWarning, 1, "update the version number, revision, & date in PackageInfo.g?");
doit:=useryn("");

if doit then 
	Print("#I  updating the version number, revision, and date in PackageInfo.g...\n");
	new[6]:=newvers;
	new[8]:=String(Int(svn_rev_number)+1);
	new[10]:=date2;
	new:=JoinStringsWithSeparator(new, "\"");;
	new:=ReplacedString(new, oldvers, newvers);;
	FileString(file, new);
fi;

#compile the name of the archive
name:=SplitString(newvers, ".");
if Length(name)=3 then 
	name:=Concatenation("smallsemi", name[1], "r", name[2], "p", name[3]);
else 
	name:=Concatenation("smallsemi", name[1], "r", name[2]);
fi;

oldname:=SplitString(oldvers, ".");
if Length(oldname)=3 then 
	oldname:=Concatenation("smallsemi", oldname[1], "r", oldname[2], "p", oldname[3]);
else 
	oldname:=Concatenation("smallsemi", oldname[1], "r", oldname[2]);
fi;

#########

Print("\n");
Info(InfoWarning, 1, "replace the old version number and archive name in  \"README.txt\"?");

doit:=useryn("");

if doit then 
	file:="README.txt";
	Print("#I  replacing the version number in \"README.txt\"...\n");
	file:=Filename(Directory(home), file);
	new:=StringFile(file);;
	new:=ReplacedString(new, oldvers, newvers);;
	new:=ReplacedString(new, oldname, name);;		
	FileString(file, new);;
fi;

#########

Print("\n");
Info(InfoWarning, 1, "replace the old version numbers in the init.g and read.g files?");

doit:=useryn("");

if doit then 

	files:=["init.g", "read.g"];
	
	for file in files do
		Print("#I  replacing the version numbers in ", file, "...\n");
		file:=Filename(Directory(home), file);
		new:=StringFile(file);;
		new:=ReplacedString(new, oldvers, newvers);;
		FileString(file, new);
	od;
fi;

#########

Print("\n");
Info(InfoWarning, 1, "replace the old version numbers in the tst/*.tst files?");

doit:=useryn("");

if doit then 

	dir:=Concatenation(home, "/tst");
	files:=Filtered(DirectoryContents(dir), x-> not x in [".", "..", ".DS_Store", ".svn"]);
	files:=Filtered(files, x-> x{[Length(x)-3..Length(x)]}=".tst" or 
	x{[Length(x)-1..Length(x)]}=".g");
	
	for file in files do
		Print("#I  replacing the version numbers in ", file, "...\n");
		file:=Filename(Directory(dir), file);
		new:=StringFile(file);;
		new:=ReplacedString(new, oldvers, newvers);;
		FileString(file, new);
	od;
fi;

#########

Print("\n");
Info(InfoWarning, 1, "replace the old version numbers in the gap/*.gi, gap/*.gd"); 
Info(InfoWarning, 1, "and gap/*.g files?");

doit:=useryn("");

if doit then 

	dir:=Concatenation(home, "/gap");
	files:=Filtered(DirectoryContents(dir), x-> not x in 
	 [".", "..", ".DS_Store", ".svn"]);
	files:=Filtered(files, x-> x{[Length(x)-2..Length(x)]}=".gi" or 
	 x{[Length(x)-2..Length(x)]}=".gd" or x{[Length(x)-1..Length(x)]}=".g");
	
	for file in files do
		Print("#I  replacing the version numbers in ", file, "...\n");
		file:=Filename(Directory(dir), file);
		new:=StringFile(file);;
		new:=ReplacedString(new, oldvers, newvers);;
		FileString(file, new);
	od;
fi;

#########

Print("\n");
Info(InfoWarning, 1, "replace the old version numbers and archive names in doc/*.xml?");
doit:=useryn("");

if doit then 
	dir:=Concatenation(home, "/doc");
	files:=Filtered(DirectoryContents(dir), x-> not x in [".", "..", ".DS_Store", ".svn"]);
	files:=Filtered(files, x-> x{[Length(x)-3..Length(x)]}=".xml");

	for file in files do
		Print("#I  replacing the version numbers in ", file, "... \n");
		file:=Filename(Directory(Concatenation(home, "/doc")), file);
		new:=StringFile(file);;
		new:=ReplacedString(new, oldvers, newvers);;
		new:=ReplacedString(new, oldname, name);;
		FileString(file, new);
	od;
fi;

#########

Print("\n");
Info(InfoWarning, 1, "compile the documentation?");
doit:=useryn("");

if doit then 
	MakeGAPDocDoc(DirectoriesPackageLibrary("smallsemi","doc")[1]![1], 	
	"smallsemi.xml", ["../gap/small.gd","../gap/properties.gd", 
	"../dev/dev.gd","../gap/enums.gd","../gap/autovars.g"], "manual");;
fi;

#########

#JDM svn commit

Print("\n");
Info(InfoWarning, 1, "svn commit?");
doit:=useryn("");

if doit then 
	Info(InfoWarning, 1, "commiting the release version to the repository...");
	file:=Filename(Directory(Concatenation(home, "/dev")), "release_commit_msg.txt");
	new:=StringFile(file);;
	new:=ReplacedString(new, oldvers, newvers);;
	FileString(file, new);
	
	Print("cd ", home, "; svn commit  --force-log --file ", file);
	Exec(Concatenation("cd ", home, " ;", " svn commit --force-log --file ", file));
fi;

#########

Print("\n");
Info(InfoWarning, 1, "update the date and version numbers in the webpage?");
doit:=useryn("");

if doit then 
	Print("#I  update the date in the webpage...\n");
	dir:=Concatenation(home, "/dev/webpage");
	file:=Filename(Directory(dir), "pre_index.html");
	new:=StringFile(file);;
	new:=ReplacedString(new, "<!-- DATE -->", date);;
	new:=ReplacedString(new, "<!-- VERS -->", newvers);;
	new:=ReplacedString(new, "<!-- FILE -->", name);;
	new:=ReplacedString(new, "<!-- YEAR -->", 
	  date2{[Length(date2)-3..Length(date2)]});;
	file:=Filename(Directory(dir), "index.html");
	FileString(file, new);
fi;

#########

Print("\n");
Info(InfoWarning, 1, "scp the webpage to gregory?");
doit:=useryn("");

if doit then 
	Print(Concatenation("scp ", file, " jamesm@gregory.mcs.st-and.ac.uk:/home/jamesm/public_html/smallsemi\n"));
	Exec(Concatenation("scp ", file, " jamesm@gregory.mcs.st-and.ac.uk:/home/jamesm/public_html/smallsemi"));
	Print(Concatenation("scp ", Filename(Directory(dir), "smallsemi.css"), " jamesm@gregory.mcs.st-and.ac.uk:/home/jamesm/public_html/smallsemi\n"));
	Exec(Concatenation("scp ", Filename(Directory(dir), "smallsemi.css"), " jamesm@gregory.mcs.st-and.ac.uk:/home/jamesm/public_html/smallsemi")); 
fi;

#########

Print("\n");
Info(InfoWarning, 1, "copy the documentation to gregory?");
doit:=useryn("");

if doit then 
	Print("#I  copying the documentation to gregory...\n");
	dir:=Concatenation(home, "/doc");
	Print(Concatenation("scp -r ", dir, "/*.html jamesm@gregory.mcs.st-and.ac.uk:/home/jamesm/public_html/smallsemi/doc\n")); 
	Exec(Concatenation("scp -r ", dir, "/*.html jamesm@gregory.mcs.st-and.ac.uk:/home/jamesm/public_html/smallsemi/doc"));
	Print(Concatenation("scp -r ", dir, "/manual.css jamesm@gregory.mcs.st-and.ac.uk:/home/jamesm/public_html/smallsemi/doc\n"));
	Exec(Concatenation("scp -r ", dir, "/manual.css jamesm@gregory.mcs.st-and.ac.uk:/home/jamesm/public_html/smallsemi/doc"));
	Print(Concatenation("scp -r ", dir, "/manual.pdf jamesm@gregory.mcs.st-and.ac.uk:/home/jamesm/public_html/smallsemi/doc\n"));
	Exec(Concatenation("scp -r ", dir, "/manual.pdf jamesm@gregory.mcs.st-and.ac.uk:/home/jamesm/public_html/smallsemi/doc"));
fi;

#########

Print("\n");
Info(InfoWarning, 1, "wrap the package?");

doit:=useryn("");

if doit then
	
	#########
 
	Print("#I  copying to /tmp\n");
	
	# Andreas comment out the next two lines...
	
	Print(Concatenation("ditto --norsrc ", home, " /tmp/smallsemi\n"));
	Exec(Concatenation("ditto --norsrc ", home, " /tmp/smallsemi"));
	
	# Andreas uncomment the next two lines...
	
	 #	Print(Concatenation("cp -r ", home, " /tmp/smallsemi\n"));
	 #  Exec(Concatenation("cp -r ", home, " /tmp/smallsemi"));
	
	new:="/tmp/smallsemi/";
	
	#########
	
	Print("\n");
	Info(InfoWarning, 1, "delete dev/, .svn etc. from the archive?");
	doit:=useryn("");
	
	if doit then 
		Print(Concatenation("rm -rf ", new, "dev\n"));
		Exec(Concatenation("rm -rf ", new, "dev"));
		Print(Concatenation("rm -rf ", new, ".*\n"));
		Exec(Concatenation("rm -rf ", new, ".*"));
		Print(Concatenation("rm -rf ", new, "*/.*\n"));
		Exec(Concatenation("rm -rf ", new, "*/.*"));
		Exec(Concatenation("rm -rf ", new, "*/*/.*"));
	fi;
	
	#########
	
	Print("\n");
	Info(InfoWarning, 1, "delete lines between #JDM remove in read.g, init.g, and smallsemi.xml?");
	
	doit:=useryn("");
	
	if doit then 
	
		Print("#I  deleting lines between #JDM remove in in read.g, init.g, and smallsemi.xml...\n");
	
		for file in ["read.g", "init.g", "doc/smallsemi.xml"] do 
	
			file:=Filename(Directory(new), file);
			short:=StringFile(file);;
			short:=SplitString(short, "\n");

			tog:=false;
			newnew:=[];

			for i in short do
	
				if i="#JDM remove" and not tog then 
					tog:=true; 
				elif i="#JDM remove" and tog then 
					tog:=false;
				elif not tog then 
					Add(newnew, i);
				fi;
	
			od;

			short:=JoinStringsWithSeparator(newnew, "\n");;
			FileString(file, short);
		od;
	fi;

	#########

	#create the archive 
	Print("#I  creating the archive...\n");
	Print(Concatenation("tar.sh ", name, " \n"));
	Exec(Concatenation(home, "/dev/bin/tar.sh ", name));
fi;

#########

Print("\n");
Info(InfoWarning, 1, "copy the archive to the local archives folder and the desktop?");

doit:=useryn("");

if doit then 
	Print("#I  copy the archive to the local archives folder and the desktop...\n");
	Print(Concatenation("cp /tmp/", name, ".tar.gz ", home, "/dev/archives\n"));
	Exec(Concatenation("cp /tmp/", name, ".tar.gz ", home, "/dev/archives"));
	Print(Concatenation("cp /tmp/", name, ".tar.gz /Users/jdm/Desktop/\n"));
	Exec(Concatenation("cp /tmp/", name, ".tar.gz /Users/jdm/Desktop/"));
fi;

#########

Print("\n");
Info(InfoWarning, 1, "copy the archive, README.txt, and PackageInfo.g to gregory?");

doit:=useryn("");

if doit then 
	Print("#I  copying the archive, README.txt, and PackageInfo.g files to\n gregory...\n");
	Print(Concatenation("scp /tmp/", name, ".tar.gz jamesm@gregory.mcs.st-and.ac.uk:/home/jamesm/public_html/smallsemi\n"));
	Exec(Concatenation("scp /tmp/", name, ".tar.gz jamesm@gregory.mcs.st-and.ac.uk:/home/jamesm/public_html/smallsemi"));
	Print(Concatenation("scp /tmp/", name, ".tar.bz2 jamesm@gregory.mcs.st-and.ac.uk:/home/jamesm/public_html/smallsemi\n"));
	Exec(Concatenation("scp /tmp/", name, ".tar.bz2 jamesm@gregory.mcs.st-and.ac.uk:/home/jamesm/public_html/smallsemi"));
	Print("scp /tmp/smallsemi/README.txt jamesm@gregory.mcs.st-and.ac.uk:/home/jamesm/public_html/smallsemi\n");
	Exec("scp /tmp/smallsemi/README.txt jamesm@gregory.mcs.st-and.ac.uk:/home/jamesm/public_html/smallsemi");
	Print("scp /tmp/smallsemi/PackageInfo.g jamesm@gregory.mcs.st-and.ac.uk:/home/jamesm/public_html/smallsemi\n");
	Exec("scp /tmp/smallsemi/PackageInfo.g jamesm@gregory.mcs.st-and.ac.uk:/home/jamesm/public_html/smallsemi");

	Print("#I changing the permissions on gregory...\n");
	Print("ssh jamesm@gregory.mcs.st-and.ac.uk chmod a+rx /home/jamesm/public_html/smallsemi/*\n");
	Exec("ssh jamesm@gregory.mcs.st-and.ac.uk chmod a+rx /home/jamesm/public_html/smallsemi/*");
	Print("ssh jamesm@gregory.mcs.st-and.ac.uk chmod a+rx /home/jamesm/public_html/smallsemi/doc/*\n");
	Exec("ssh jamesm@gregory.mcs.st-and.ac.uk chmod a+rx /home/jamesm/public_html/smallsemi/doc/*");
fi;

#########

Print("\n");
Info(InfoWarning, 1, "Clean up?");

doit:=useryn("");

if doit then 
#clean up!
	Print(Concatenation("rm -rf ", new, "\n"));
	Exec(Concatenation("rm -rf ", new));
	Print(Concatenation("rm -f /tmp/", name, ".tar.gz\n"));
	Exec(Concatenation("rm -f /tmp/", name, ".tar.gz"));
	Print(Concatenation("rm -f /tmp/", name, ".tar.bz2\n"));
	Exec(Concatenation("rm -f /tmp/", name, ".tar.bz2"));
fi;

return true;
end);

#############################################################################
##
## functions to handle the info files
##
# 'file' = name of the info file, a string
# 'name' = identifier for the new record component, a string
# 'content' = normally a list of ranges and lists, has to be readable from 
#             the printed form

InstallGlobalFunction(STORE_SEMI_INFO,
function( file, name, content )
    local str, output, dirs, script;

    # read 'file' or 'file'.gz 
    dirs := DirectoriesPackageLibrary( "smallsemi", "data" );
    file := Filename( dirs[1], file );
    str := StringFile( file );

    if str = fail then 
	str:="rec(\n";
    else
        # deal with strange extra newline that shows up sometimes AD
        str := ReplacedString( str, "\n);\n", ",\n" );
        str := ReplacedString( str, "\n);", ",\n" );
    fi;

    # file should be written completely anew, thus append = 'false'
    output := OutputTextFile( file, false );
    # avoid linebreaks depending on screen size
    SetPrintFormattingStatus( output, false );

    AppendTo( output, str );
    AppendTo( output, name );
    AppendTo( output, ":=" );
    AppendTo( output, content );
    AppendTo( output, "\n);\n" );

    CloseStream(output);

    # remove blanks and gzip file
    dirs := DirectoriesPackageLibrary( "smallsemi", "dev" );
    script := Filename( dirs[1], "rmblanks.sh" );
    Exec( script, file );

    return true;
end);

# 'file' = name of the info file, a string
# 'name' = identifier of the record component to be deleted, a string
InstallGlobalFunction(DELETE_SEMI_INFO,
function( file, name )
    local str, strlist, pos, remove, output, dirs, script;

    # read 'file' or 'file'.gz 
    dirs := DirectoriesPackageLibrary( "smallsemi", "data" );
    file := Filename( dirs[1], file );
    str := StringFile( file );

    if str = fail then 
        Info( InfoWarning, 1, "File '", file, "' must exist.");
        return fail;
    else
        strlist := SplitString( str, "\n" );
        pos := PositionProperty( strlist,
                                 x ->  Length(x) > Length(name) + 2
                                       and x{[ 1..Length(name)+2 ]} = 
                                           Concatenation( name, ":=" ));
        if pos = fail then
            Info( InfoWarning, 1, "Record component '", name,"' must exist.");
            return fail;
        else
            remove := Remove( strlist, pos );
            if pos = Length( strlist ) then
                Add( remove, Remove( strlist[pos-1] ), 1 );
            fi;
        fi;
    fi;

    # file should be written completely anew, thus append = 'false'
    output := OutputTextFile( file, false );
    # avoid linebreaks depending on screen size
    SetPrintFormattingStatus( output, false );

    for str in strlist do
        AppendTo( output, str );
        AppendTo( output, "\n" );
    od;

    CloseStream(output);

    # remove blanks and gzip file
    dirs := DirectoriesPackageLibrary( "smallsemi", "dev" );
    script := Filename( dirs[1], "rmblanks.sh" );
    Exec( script, file );

    return remove;
end);

# 'file' = name of the info file, a string
# 'name' = identifier of the record component to be replaced, a string
# 'newcontent' = normally a list of ranges and lists, has to be readable from 
#                the printed form
InstallGlobalFunction(SUBSTITUTE_SEMI_INFO,
function( file, name, newcontent )
    local str, strlist, pos, remove, output, dirs, script;

    # read 'file' or 'file'.gz 
    dirs := DirectoriesPackageLibrary( "smallsemi", "data" );
    file := Filename( dirs[1], file );
    str := StringFile( file );

    if str = fail then 
        Info( InfoWarning, 1, "File '", file, "' must exist.");
        return fail;
    else
        strlist := SplitString( str, "\n" );
        pos := PositionProperty( strlist,
                                 x ->  Length(x) > Length(name) + 2
                                       and x{[ 1..Length(name)+2 ]} = 
                                           Concatenation( name, ":=" ));
        if pos = fail then
            Info( InfoWarning, 1, "Record component '", name,"' must exist.");
            return fail;
        else
            str := Concatenation( strlist[pos]{[1..Length(name)+2]},
                                  String( newcontent ));
            if Remove( strlist[pos] ) = ',' then
                Add( str, ',' );
            fi;
            strlist[pos] := str;
        fi;
    fi;

    # file should be written completely anew, thus append = 'false'
    output := OutputTextFile( file, false );
    # avoid linebreaks depending on screen size
    SetPrintFormattingStatus( output, false );

    for str in strlist do
        AppendTo( output, str );
        AppendTo( output, "\n" );
    od;

    CloseStream(output);

    # remove blanks and gzip file
    dirs := DirectoriesPackageLibrary( "smallsemi", "dev" );
    script := Filename( dirs[1], "rmblanks.sh" );
    Exec( script, file );

    return true;
end);

# 'file' = name of the info file, a string
# 'oldname' = current identifier of the record component, a string
# 'newname' = new identifier of the record component, a string
InstallGlobalFunction(RENAME_SEMI_INFO,
function( file, oldname, newname )
    local str, output, dirs, script;

    # read 'file' or 'file'.gz 
    dirs := DirectoriesPackageLibrary( "smallsemi", "data" );
    file := Filename( dirs[1], file );
    str := StringFile( file );

    if str = fail then 
        Print("file must exist.\n");
        return fail;
    else
        str := ReplacedString( str,
                               Concatenation( "\n", oldname, ":=" ),
                               Concatenation( "\n", newname, ":=" ));
    fi;

    # file should be written completely anew, thus append = 'false'
    output := OutputTextFile( file, false );
    # avoid linebreaks depending on screen size
    SetPrintFormattingStatus( output, false );

    AppendTo( output, str );

    CloseStream(output);

    # remove blanks and gzip file
    dirs := DirectoriesPackageLibrary( "smallsemi", "dev" );
    script := Filename( dirs[1], "rmblanks.sh" );
    Exec( script, file );

    return true;
end);


InstallGlobalFunction(STORE_POS_SEMIS_FUNC_VAL,
function(file, name, enum, func, val)

STORE_SEMI_INFO(file, name, PositionsOfSmallSemigroups(enum, func, val));
end);


ConvertSemigroupInfoToRangeRep:=function(list)
local out, current, i, tmp, out2;
out:=[];
current:=[];

for i in list do 
	tmp:=Concatenation(current, [i]);
	if IsRange(tmp) then 
		current:=tmp;
	else 
		IsRange(current);
		Add(out, current);
		current:=[i];
	fi;
od;
IsRange(current);
Add(out, current);
#Error("");

out2:=[];
i:=0;
current:=[];

repeat 
	i:=i+1;
	if Length(out[i]) in [1,2] then 
		current:=Concatenation(current, out[i]);
	else 
		if not current=[] then 
			Add(out2, current);
		fi;
		Add(out2, out[i]);
		current:=[];
	fi;
until i=Length(out);

if not current=[] then 
	Add(out2, current);
fi;

return out2;
end;


#############################################################################

#############################################################################

#############################################################################

StoreMinimalGeneratingSet:=function(S)
local min, enum;
enum:=EnumeratorSorted(Combinations([1..Size(S)]));
min:=MinimalGeneratingSet(S);
min:=List(min, x-> x![1]);
return Position(enum, min);
end;

#####################
#####################

StoreGreensRClasses:=function(S)
local elms, gens, graph, enum;

enum:=EnumeratorSorted(PartitionsSet([1..IdSmallSemigroup(S)[1]]));
elms:=AsSSortedList(S);
gens:=List(MinimalGeneratingSet(S), x-> x![1]);
graph:=List(MultiplicationTable(S), x-> x{gens});
graph:=SetX(STRONGLY_CONNECTED_COMPONENTS_DIGRAPH(graph), x-> AsSet(x));
return PositionSet(enum,graph);
end;

#LoadPackage("sonata");
#StoreIsMultSemigroupNearRing:=function(n)
#local groups, near, g, nr, sg;

#groups:=Filtered(GroupList, x-> Size(x)=n);
#near:=[];

#for g in groups do #
#	nr:=AllLibraryNearRings(g);
#	nr:=List(nr, IsomorphismTransformationSemigroup);;
#	nr:=List(nr, Range);;
##        for sg in nr do
##            Print( Position( nr, sg )," ");
##            Add( near, IdSmallSemigroup(sg) );
##        od;
#	nr:=List(nr, x-> IdSmallSemigroup(x));
#	UniteSet(near, AsSet(List(nr, x-> x[2])));
#od;
#
#return near;
#end;






