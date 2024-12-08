{7. Realizar un programa que permita:

    a. Crear un archivo binario a partir de la información almacenada en un archivo de texto.
    El nombre del archivo de texto es: “novelas.txt”
    b. Abrir el archivo binario y permitir la actualización del mismo. Se debe poder agregar
    una novela y modificar una existente. Las búsquedas se realizan por código de novela.

NOTA: La información en el archivo de texto consiste en: código de novela,
nombre,género y precio de diferentes novelas argentinas. De cada novela se almacena la
información en dos líneas en el archivo de texto. La primera línea contendrá la siguiente
información: código novela, precio, y género, y la segunda línea almacenará el nombre
de la novela.}
program ejercicio7;
type
    novela=record;
        codigo:string[10];
        nombre:string[50];
        genero:char;
        precio:real;
    end;

    NovelasF : file of novelas;


procedure crear(var f: NovelasF);
var
    n:novelas;
    nov: text;
    nombre:string;
begin
    writeln('Nombre el archivo: ');
    readln(nombre);    
    assign(nov,'novelas.txt');
    assign(f,nombre);
    reset(nov);
    rewrite(f);
    while not eof(nov) do begin
        readln(nov,n.codigo , n.precio, n.genero)
        readln(nov,n.nombre);
        readln(nov);
        write(f,n);
    end;
    close(f);
    close(nov);
end;

procedure cargarNovela(var n: novela);
begin
    writeln('Ingrese codigo : ');
    readln(n.codigo);
    writeln('Ingrese precio : ' );
    readln(n.precio);
    writeln('Ingrese genero: ');
    readln(n.genero);
    writeln('Ingrese nombre de la novela : ');    
    readln(n.nombre);
end;








procedure Modificar(var f :NovelasF);
var 
    n: novela;
    nombre: string;
begin
    writeln('Ingrese nombre de la novela a editar: ');
    readln(nombre);
    reset(f);
    while not eof(f) do begin
        read(f,n);
        if(n.nombre = nombre) then begin
            writeln('Ingrese nuevo Precio: ');
            readln(precio);
            n.precio:=precio;
        end;
    end;
    close(f);
end;



procedure Agregar(var  f : NovelasF );
var
    n:novela;
begin
    reset(f);
    seek(f, filesize(f));
    cargarNovela(n);
    write(f,n);
    close(f);
end;

procedure Buscar( var f: NovelasF);
var
    n:novela;
    nombre:string;
begin
    reset(f);
    writeln('Ingrese nombre de la novela a editar: ');
    readln(nombre);
    while not eof(f) do begin
        read(f,n);
        if(nombre = n.nombre) then begin
            writeln('Nombre: ',n.nombre);
            writeln('Precio: ',n.precio);
            writeln('Genero: ',n.genero);
            writeln('Codigo: ',n.codigo);
        end;
    end;
    close(f);
end;

procedure Menu(var f:NovelasF);
var
    op,nombre: string;
begin
    writeln('Nombre el archivo: ');
    readln(nombre); 
    assign(f,nombre)
    while true do begin
        writeln('----------Menu-----------'); 
        writeln('1.Modificar una novela');
        writeln('2.Agregar una novela');
        writeln('3.Buscar una novela');
        writeln('4.salir');
        readln(op);
        case op of 
            '1' : Modificar(f);
            '2' : Agregar(f);
            '3' : Buscar(f);
            '4' : break;
            else 
                writeln('Opcion no valida');
            end;
    end;



var
    f:NovelasF;
begin
    crear(f);
    Menu(f);
end;