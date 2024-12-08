{6. Agregar al menú del programa del ejercicio 5, opciones para:

    a. Añadir uno o más celulares al final del archivo con sus datos ingresados por
    teclado.
    b. Modificar el stock de un celular dado.
    c. Exportar el contenido del archivo binario a un archivo de texto denominado:
    ”SinStock.txt”, con aquellos celulares que tengan stock 0.
NOTA: Las búsquedas deben realizarse por nombre de celular.}
program Ejercicio5;
type
    celular =record
        id: String[6];
        nombre: String;
        descripcion: string;
        marca:string; 
        precio:integer; 
        stockM:integer;
        stockD:integer;
    end;

    CelularesB = file of celular;


procedure carga (var f :CelularesB);
var
    F2 :Text;
    c :celular;
begin
    assign(F2,'Lista_Celulares.txt');
    reset(F2);
    rewrite(f);
    while not  eof(F2) do begin       
        readln(F2, c.id, c.precio, c.marca);
        readln(F2, c.stockD,c.stockM,c.descripcion);        
        readln(F2, c.nombre); 
        readln(f2);
        write(f,c);    
    end;
    close(f);
    close(F2);
end;


procedure CrearCel (var c:celular);
begin
    writeln( 'Id del celular: ');
    readln(c.id);
    writeln( 'Descripcion del Celular: ');
    readln(c.descripcion);
    writeln( 'Precio del Celular: ');
    readln(c.precio);
    writeln( 'Nombre del Celular: ');
    readln(c.nombre);
    writeln( 'Stock Disponible : ');
    readln(c.stockD);
    writeln( 'Stock Minimo:  ');
    readln(c.stockM);
    writeln( 'Marca del Celular: ');
    readln(c.marca);
end;


procedure ImprimirStock (var f: CelularesB);
var 
    e:celular;
begin
    reset(f);
    while not eof(f) do begin
        read(f,e);
        if(e.stockD < e.stockM) then begin
            writeln('Celular:',e.marca,' ',e.nombre);
            writeln('codigo: ',e.id);
            writeln(e.descripcion);
            writeln('Stock Disponible: ',e.stockD);
            writeln('Stock Minimo: ',e.stockM);
            writeln('Precio: ',e.precio);
        end;
    end;
    close(f);
end; 


procedure Exportar (var f :CelularesB);
var 
    cel: text;
    c:celular;
begin
    assign(cel,'Celulares.txt');
    rewrite(cel);
    reset(f);
    while not eof(f) do begin
        read (f,c);
        writeln (cel,'Id del producto: ',c.id);
        writeln(cel,'Precio: $',c.precio);
        writeln(cel,'Marca: ',c.marca);
        writeln(cel,'Stock Disponsible: ',c.stockD);
        writeln(cel,'Stock Mayorista: ',c.stockM);
        writeln(cel,'Descripción: ',c.descripcion);
        writeln(cel,'Nombre : ',c.nombre);
    end;
    close(f);
    close(cel);
end;

procedure Exportar0Stock (var f :CelularesB);
var 
    cel: text;
    c:celular;
begin
    assign(cel,'SinStock.txt');
    rewrite(cel);
    reset(f);
    while not eof(f) do begin
        read (f,c);
        if(c.stockD = 0) then begin
            writeln (cel,'Id del producto: ',c.id);
            writeln(cel,'Precio: $',c.precio);
            writeln(cel,'Marca: ',c.marca);
            writeln(cel,'Stock Disponsible: ',c.stockD);
            writeln(cel,'Stock Mayorista: ',c.stockM);
            writeln(cel,'Descripción: ',c.descripcion);
            writeln(cel,'Nombre : ',c.nombre);
        end;
    end;
    close(f);
    close(cel);
end;


procedure Agregar (var f :CelularesB);
var
    c: celular;
begin
    reset(f);
    CrearCel(c);
    seek(f,fileSize(f));
    write(f,c);
    close(f);
end;

procedure Modificar(var f :CelularesB; cadena:string);
var
    c :celular;
    SD,SM:integer;
begin
    reset(f);
    while not eof(f) do begin
        read(f,c);
        if (c.nombre = cadena) then  begin
            Writeln('Ingrese valor de Stock Disponible: ');
            readln(SD);
            Writeln ('Ingrese Stock Minimo: ');
            readln(SM);            
            c.stockD:=SD;
            c.stockM:=SM;
            seek (f,fileSize(f)-1);
            write(f,c);
        end;
    end;
    close(f);
end;

procedure found(var fil: CelularesB; var datos:string);
var 
    c: celular;
    
begin    
    datos:= '  ' + datos;    
    reset(fil);
    while not eof(fil) do begin
        read (fil,c);
        writeln(c.descripcion);
        writeln(datos);
        if (c.descripcion = datos) then begin
            writeln('Celular:',c.marca,' ',c.nombre);
            writeln('codigo: ',c.id);
            writeln(c.descripcion);
            writeln('Stock Disponible: ',c.stockD);
            writeln('Stock Minimo: ',c.stockM);
            writeln('Precio: ',c.precio);
        end;
    end;
    close(fil);
end;

procedure Crear_file(var Arch:CelularesB);
begin
    carga(Arch);
end;




procedure Menu(var Arch:CelularesB );
var
    Opc : char;
    datos,cadena:string;
begin
    while True do begin
        writeln('----------Menu-----------'); 
        writeln('1.Crear un archivo');
        writeln('2.Listar en pantalla los datos de aquellos celulares que tengan un stock menor al stock minimo');
        writeln('3.Listar en pantalla los celulares del archivo cuya descripcion contenga una cadena de caracteres proporcionada por el usuario');
        writeln('4.Exportar');
        writeln('5.Añadir celular');
        writeln('6.Modificar el stock de un celular dado');
        writeln('7.Exportar el contenido del archivo a un archivo con aquellos celulares que tengan stock 0');
        writeln('8.salir');

        readln(Opc);
        case Opc of 
            '1' :Crear_file (Arch);
            '2' :ImprimirStock(Arch); 
            '3' :
            begin
                write('Ingrese una cadena de descripcion: ');
                readln(datos);
                found(Arch,datos);
            end;
            '4' :Exportar(Arch);
            '5' :Agregar(Arch);
            '6' :
            begin
                writeln('Ingrese nombre del celular a modificar: ');
                readln(cadena)
                Modificar(Arch,cadena);
            end;
            '7':Exportar0Stock(Arch) ;
            '8': break;
        else 
            writeln('No existe esa Opcion');
        end;
    end;
end;
var
    Arch : CelularesB;
    NombreFichero : String;
begin
    write ('Ingrese Nombre del archivo: ');
    readln(NombreFichero) ;
    assign(Arch,NombreFichero);
    Menu(Arch);
end.