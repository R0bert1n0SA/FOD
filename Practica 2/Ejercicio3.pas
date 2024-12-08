{Se cuenta con un archivo de productos de una cadena de venta de alimentos congelados.
De cada producto se almacena: código del producto, nombre, descripción, stock disponible,
stock mínimo y precio del producto.
Se recibe diariamente un archivo detalle de cada una de las 30 sucursales de la cadena. Se
debe realizar el procedimiento que recibe los 30 detalles y actualiza el stock del archivo
maestro. La información que se recibe en los detalles es: código de producto y cantidad
vendida. Además, se deberá informar en un archivo de texto: nombre de producto,
descripción, stock disponible y precio de aquellos productos que tengan stock disponible por
debajo del stock mínimo.
Nota: todos los archivos se encuentran ordenados por código de productos. En cada detalle
puede venir 0 o N registros de un determinado producto.}
program eje3;
type
    TProducto = record
        Codigo :integer;
        Nombre : string[40];
        Descripcion : string[80] ;
        StockDisponible : integer;
        StockMinimo : integer;
        Precio : real;
    end;
    
    sucursal = record
        codigo:integer;
        cantidadvendida:integer;
    end;

    maestro=file of  Tproducto;
    detalle=file of  sucursal;

    detalleVF= array[1..3] of detalle;
    detalleVR= array[1..3] of sucursal;



procedure Leerp( var p: Tproducto);
begin
    readln(p.Codigo);
    if(p.Codigo <> -1) then begin 
        readln(p.Nombre); 
        readln(p.Descripcion); 
        readln(p.StockDisponible);
        readln(p.StockMinimo); 
        readln(P.Precio);
    end;
end;

procedure LeerS( var p: sucursal);
begin
    readln(p.Codigo);
    if(p.Codigo <> -1) then begin 
        readln(p.cantidadvendida); 
    end;
end;

procedure CrearMaestro(var f: maestro);
var
    p:TProducto;
begin
    //rewrite(f);
    Leerp(p);
    while(p.Codigo <> -1) do begin
        //write(f,p);
        LeerP(p);
    end;
    //close(f);
end;

procedure Creardetalle(var v:detalleVF);
var
    s:sucursal;
    i:integer;
    d: detalle;
    indice:string;
begin
    for i:=1 to 3 do begin   
        Str(i,indice); 
        assign(v[i],'Detalles'+ indice +'.dat');  
        rewrite(v[i]);         
        write(5);
        LeerS(s);
        while (s.codigo <> -1) do begin
            write(d,s);
            LeerS(s);
        end;
        close(d);        
    end;
    Close(d);
end;

procedure Leerdato(var d:detalle;var s:sucursal);
begin
    if ( not eof(d)) then
        read(d,s)
    else
        s.codigo:=32000;
end;


procedure minimo (var vr:detalleVR; var min:sucursal ; var  v:detalleVF);
var 
    i,indiceMin: integer;
begin
	indiceMin:= 0;
	min.codigo:= 32000;
	for i:= 1 to 3 do begin
		if (vr[i].codigo <> -1) then
			if (vr[i].codigo < min.codigo ) then begin
				min:= vr[i];
				indiceMin:= i;
			end;
    end;
	if (indiceMin <> 0) then begin
		Leerdato(v[indiceMin], vr[indiceMin]);	
	end;
end;

procedure actualizar(var m:maestro;var v:detalleVF);
var
    p:Tproducto;
    d:sucursal;
    i,cant,codact:integer;
    vr:detalleVR;
    indice:String;
begin
    reset(m);
    for i := 1 to 3 do begin
        Str(i,indice);
        assign(v[i],'Detalles'+indice+'.dat');  
        reset(v[i]);
        Leerdato(v[i],vr[i]);
    end;
    minimo(vr,d,v);
    while(d.codigo <> 32000) do begin
        codact:=d.codigo;
        cant:=0;
        while (d.codigo <> codact) do begin 
            cant:= cant+ d.cantidadvendida;
            minimo(vr,d,v);
        end;
        read (m,p);
		while(p.codigo <> codact)do begin  //busco el codigo de maestro para que coincida con el minimo
			read (m,p);
		end;
        seek (m,filePos (m)-1);
        p.StockDisponible:= p.StockDisponible -cant;
        write(m,p);
    end;
    close(m);
    for i:=1 to 3 do begin
        close(v[i]);
    end;
end;

procedure Stocktxt( var f: maestro);
var
    stock:text;
    c:tproducto;
begin
    assign(stock,'Stock.txt');
    rewrite(stock);
    reset(f);
    while not eof(f) do begin
        read(f,c);
        if(c.StockDisponible < c.StockMinimo) then begin
            writeln(stock,c.Codigo,c.Nombre,c.Descripcion);
            writeln(stock,c.StockDisponible,c.StockMinimo,c.Precio);
        end;
    end;
    close(stock);
    close(f);
end;


var
    f:maestro;
    v:detalleVF;
begin
    assign(f,'Productos.dat');
    CrearMaestro(f);
    Creardetalle(v);
    actualizar (f,v);
    Stocktxt(f);
end.