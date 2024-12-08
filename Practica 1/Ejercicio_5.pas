{Realizar un programa para una tienda de celulares, que presente un menú con
opciones para:
    a. Crear un archivo de registros no ordenados de celulares y cargarlo con datos
    ingresados desde un archivo de texto denominado “celulares.txt”. Los registros
    correspondientes a los celulares, deben contener: código de celular, el nombre,
    descripcion, marca, precio, stock mínimo y el stock disponible.
    b. Listar en pantalla los datos de aquellos celulares que tengan un stock menor al
    stock mínimo.
    c. Listar en pantalla los celulares del archivo cuya descripción contenga una
    cadena de caracteres proporcionada por el usuario.
    d. Exportar el archivo creado en el inciso a) a un archivo de texto denominado
    “celulares.txt” con todos los celulares del mismo.

NOTA 1: El nombre del archivo binario de celulares debe ser proporcionado por el usuario
una única vez.
NOTA 2: El archivo de carga debe editarse de manera que cada celular se especifique en
tres líneas consecutivas: en la primera se especifica: código de celular, el precio y
marca, en la segunda el stock disponible, stock mínimo y la descripción y en la tercera
nombre en ese orden. Cada celular se carga leyendo tres líneas del archivo
“celulares.txt”.}
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
    datos:string;
begin
    while True do begin
        writeln('----------Menu-----------'); 
        writeln('1.Crear un archivo');
        writeln('2.Listar en pantalla los datos de aquellos celulares que tengan un stock menor al stock mínimo');
        writeln('3.Listar en pantalla los celulares del archivo cuya descripción contenga una cadena de caracteres proporcionada por el usuario');
        writeln('4.Exportar');
        writeln('5.salir');

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
            '4':Exportar(Arch);
            '5': break;
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