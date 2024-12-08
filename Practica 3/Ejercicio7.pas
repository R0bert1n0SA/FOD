{Se cuenta con un archivo que almacena información sobre especies de aves en vía
de extinción, para ello se almacena: código, nombre de la especie, familia de ave,
descripción y zona geográfica. El archivo no está ordenado por ningún criterio. Realice
un programa que elimine especies de aves, para ello se recibe por teclado las
especies a eliminar. Deberá realizar todas las declaraciones necesarias, implementar
todos los procedimientos que requiera y una alternativa para borrar los registros. Para
ello deberá implementar dos procedimientos, uno que marque los registros a borrar y
posteriormente otro procedimiento que compacte el archivo, quitando los registros
marcados. Para quitar los registros se deberá copiar el último registro del archivo en la
posición del registro a borrar y luego eliminar del archivo el último registro de forma tal
de evitar registros duplicados.
Nota: Las bajas deben finalizar al recibir el código 500000}

program especies;
type
    especies =record
        codigo      : integer ;
        nombre      : string[30];
        familia     :string[20] ;
        descripcion : string[100] ;
        zona        : string [40] ;
    end;

    aves:file of  especies;

procedure Leer(var  f:aves;  e:especies);
begin
    if not eof(f) then
        read(f,e);
    else
        e.codigo:=500000;
end;

procedure extintas (var f: aves ; num:integer);
var
    e:especies;
begin
    reset(f);
    Leer(f,e);
    while(e.codigo <> 32000) and (e.codigo <> num)do begin
        Leer(f,e);
    end;
    if e.codigo=num then 
        e.codigo=e.codigo*-1;
    close(f);
end;

procedure Compactar(var f:aves);
var
    e,aux,aux2:especies;
    pos:integer;
begin
    reset(f);
    Leer(f,e);
    while(e.codigo <> 32000) do begin
        if(e.codigo < 0)then begin
            pos:=filepos(f);
            seek(f,filepos(f)+1);
            read(f, aux);
            seek(f,pos);
            write(f,aux);
            seek(f,filesize(f));
            write(f,e);
            truncate(f);
        end;
        Leer(f,e);
    end;
    close(f);
end;