# file for outdated function which we want to keep
# AD 05/2008

#############################################################################
# reconstructs the multiplication table of the semigroup of order 'ord' 
# which comes next in 'stream'. The table is encoded in the next 'blocks' 
# each of size 'bytes'
RecoverOneMultiplicationTable := function( stream, ord, blocks, bytes )
    local flatmat,elms,int,pot,byte,block,rem,i, ListToMatrix;

    # converts a list into the corresponding multiplication table
    ListToMatrix := function( line )
        local mat, i;

        mat := EmptyPlist( ord );

        for i in [ 1..ord ] do
            Add( mat, line{[ 1+(i-1)*ord .. i*ord ]} );
        od;

        return mat; 
    end;

    # set up list with first idempotent
    flatmat := EmptyPlist( ord^2 );
    if ord <> 7 then
        Add( flatmat, 0 );
        elms := (ord^2-1) / blocks;
    else
        elms := ord^2 / blocks;
    fi;

    for block in [ 1..blocks ] do
        int := 0;
        pot := 1;
        for byte in [ 1..bytes ] do
            int := int + ( ReadByte( stream ) - 32 ) * pot;
            pot := pot * 95;
        od;
        for i in [ 1..elms ] do
            rem := RemInt( int, ord );
            Add( flatmat, rem );
            int := ( int - rem ) / ord;
        od;
    od;

    return ListToMatrix( flatmat + 1 );
end;

#############################################################################
# recovers the multiplication table of the 'nr'-th semigroup of order 'ord'
# returns fail if 'nr' is to big
#
RecoverMultiplicationTableOLD := function( ord, nr )
    local bytes, blocks, offset, input, table, numbers;

    # numbers of semigroups of orders 1-7
    numbers := [ 1, 4, 18, 126, 1160, 15973, 836021 ];

    if nr > numbers[ ord ] then 
        return fail;
    fi;

    if ord = 1 then
        return [[ 1 ]];
    fi;

    # number of blocks and their size for the orders 2-7
    blocks := [,1,2,5,3,5,7];
    bytes := [,1,1,1,3,3,3];

    # open input stream and choose right position
    ### AD this works with zipped files 
    input := InputTextString( DATA2TO7 );
    ### AD this is faster 
    #input := InputTextFile( file );
    offset := [,0,5,42,673,11114,250710];
    SeekPositionStream( input, offset[ord] + (nr-1)*(blocks[ord]*bytes[ord]));

    # get multiplication table
    table := RecoverOneMultiplicationTable(input,ord,blocks[ord],bytes[ord]);

    CloseStream( input );

    return table;
end;


