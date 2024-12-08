{Una cadena de tiendas de indumentaria posee un archivo maestro no ordenado con
la información correspondiente a las prendas que se encuentran a la venta. De cada
prenda se registra: cod_prenda, descripción, colores, tipo_prenda, stock y
precio_unitario. Ante un eventual cambio de temporada, se deben actualizar las
prendas a la venta. Para ello reciben un archivo conteniendo: cod_prenda de las
prendas que quedarán obsoletas. Deberá implementar un procedimiento que reciba
ambos archivos y realice la baja lógica de las prendas, para ello deberá modificar el
stock de la prenda correspondiente a valor negativo.
Adicionalmente, deberá implementar otro procedimiento que se encargue de
efectivizar las bajas lógicas que se realizaron sobre el archivo maestro con la
información de las prendas a la venta. Para ello se deberá utilizar una estructura
auxiliar (esto es, un archivo nuevo), en el cual se copien únicamente aquellas prendas
que no están marcadas como borradas. Al finalizar este proceso de compactación
del archivo, se deberá renombrar el archivo nuevo con el nombre del archivo maestro
original}

program tienda;
type 
    prenda =record 
        cod: integer;
        descripcion: String;
        colores: string;
        tipo:integer;
        stock: integer;
        precio:real;
    end;

    prendaact=record
        cod: integer;
    end;

    prendas  : file of prenda;
    prendasOb: file of prendaact;
    prendasAct:file of prenda;

procedure Leer(var  f:prendas; p:prenda);
begin
    if(not eof(f))then
        read(f,p);
    else
        p.cod=32000;
end;

procedure Leer2(var  f:prendasOb; p:prendaact);
begin
    if(not eof(f))then
        read(f,p);
    else
        p.cod=32000;
end;


procedure baja_Logica(var f: prendas; var f2:prendasob);
var
    p1,p2 : prenda ;
    p: prendaact;
begin
    reset(f);
    reset(f2);
    Leer(f,p1);
    Leer2(f2,p);
    while(p1.cod<>32000) do begin
        while (p1.cod <> p.cod) do begin
            Leer(f,p1);
        end;
        if(p1.cod == p.cod) then begin
            p1.stock=p1.stock * -1;
        end;
        Leer2(f2,p);
    end;
    close(f);
    close(f2);
end;

procedure Efectivizar_baja(var f: prenda ; var f2:prendasAct);
var
    p1:prenda;
begin
    reset(f);
    rewrite(f2);
    Leer(f,p1);
    while(p1.cod <> 32000) do begin
        if(p1.stock > 0) then begin
            write(f2,p1);
        end;
        Leer(f,p1);
    end;
    rename(f2,'prendas');
    close(f);
    close(f2);
end; 

var
f,f3:file of prenda;
f2: file of prendasAct;
begin
    Assing(f,'prendas');
    assign(f2, 'prendasAct');
    assign(f3, 'prendasBajadas');
    baja_Logica(f,f2);
    Efectivizar_baja(f,f3);
end;