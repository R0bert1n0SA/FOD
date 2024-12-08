program ejer_1;
type 
    Enteros = file of integer;

{
Procedure Recorrido(var archivo: Enteros );
var 
    nro: integer; 
    arc_fisico : string[12];
begin
    reset( archivo ); 
    while not eof( archivo) do begin
        read( archivo, nro ); 
        write( nro ); 
    end;
close( archivo );
end;
}

var 
    archivo: Enteros; {variable que define el nombre lógico del archivo}
        nro: integer;          {nro será utilizada para obtener la información de teclado}
        arc_fisico: string[12]; {utilizada para obtener el nombre físico del archivo desde teclado}
begin
    write( 'Ingrese el nombre del archivo:' );
    read( arc_fisico ); { se obtiene el nombre del archivo}
    assign( archivo, arc_fisico );
    rewrite( archivo ); { se crea el archivo }
    write( 'Ingrese el numero del archivo:' );
    read( nro ); { se obtiene de teclado el primer valor }
    while nro <> 30000 do begin
        write( archivo, nro ); { se escribe en el archivo cada número }
        read( nro );
    end;
    close( archivo ); { se cierra el archivo abierto oportunamente con la instrucción rewrite } 
end.