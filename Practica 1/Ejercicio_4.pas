{4. Agregar al menú del programa del ejercicio 3, opciones para:
    a. Añadir una o más empleados al final del archivo con sus datos ingresados por
    teclado.
    b. Modificar edad a una o más empleados.
    c. Exportar el contenido del archivo a un archivo de texto llamado
    “todos_empleados.txt”.
    d. Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”, los empleados
    que no tengan cargado el DNI (DNI en 00).
NOTA: Las búsquedas deben realizarse por número de empleado.
}
program ejer3;
type
    Empleado =record
        nombre: String;
        Apellido: String;
        Edad : Integer;
        Dni : string[8];
        numeroEmp: Integer;
    end;

    EmpleadosArch = file of Empleado;

// INCISO A
//Cargar de Empleado
procedure Leer_Empleado(var e: empleado);
begin
    write('Ingrese Apellido: ');
    readln(e.Apellido );
    if (e.Apellido <> 'fin')then  begin    
        write('Ingrese Nombre: ');
        readln(e.nombre);
        write('Ingresue Edad: ');
        readln(e.Edad) ;
        write('Ingrese su Numero de Identificacion (DNI): ');
        readln(e.Dni);
        write('Ingrese su Numero de Empleado: ');
        readln(e.numeroEmp);
    end;
end;

//Crea File
procedure Crear_file (var Arch:EmpleadosArch;NombreFichero: string);
var 
    e: Empleado;
begin
    assign(Arch, NombreFichero);
    rewrite(Arch);    
    reset(Arch);
    Leer_Empleado(e);
    while(e.Apellido <> 'fin') do begin
        write(Arch, e);
        Leer_Empleado(e);
    end;
    close(Arch);
end;
//-------------------------------------------------------------------------------

//INCISO B

//imprime los datos del empleado
procedure print (e: Empleado);
begin
    writeln('Nombre: ',e.nombre);
    writeln('Apellido: ',e.Apellido);
    writeln('Edad : ',e.Edad);
    writeln('DNI: ',e.Dni);
    writeln('Numero de Empleado: ',e.numeroEmp);
end;


procedure Mayores(var fi :EmpleadosArch);
var 
    e:Empleado;
begin
    reset(fi);        
    while not EOF(fi)do begin
        read(fi,e);
        if e.Edad > 70 then 
            print(e)
    end;
    close(fi);
end;


procedure MuestraEmpleados(var Archivo:EmpleadosArch);
var
    E: Empleado;
begin
    reset(Archivo);
    while not eof(Archivo) do begin
        read(Archivo, E);
        print(E);
    end;
    close(Archivo);
end;


Procedure Buscar_empleado(var Arch : EmpleadosArch);
var 
    nom: String;
    e: Empleado;
begin
    reset (Arch);
    write('Ingrese un nombre u Apellido a Buscar:  ');
    readln(nom);
    while not eof(arch) do begin
        read(arch, e);
        if (e.nombre = nom) or (e.Apellido = nom) then  
            print(e);
    end;
    close(Arch);
end;
//---------------------------------------------------------------------------------------------------

//ejer4 a)
procedure addEm (var Arch: EmpleadosArch);
var 
    e:Empleado;
begin
    reset(Arch);
    Leer_Empleado(e);
    while e.Apellido <> 'fin' do begin
        write(Arch, e);
        Leer_Empleado(e);
    end;
    close(arch);
end;

//Ejer 4 b)
Procedure ModificarEdad (Var fi: EmpleadosArch);
var 
    E:Empleado;
    numero,edad: integer;
begin
    Reset( fi );
    writeln('Ingrese numero de empleado a al q cambiar edad: ');
    readln(numero);
    while not eof( fi )do begin
        Read(fi,E);
        if(E.numeroEmp = numero ) then begin
            writeln('Ingrese edad: ');
            readln(edad);
            E.Edad:=edad;
            Seek(fi, filepos(fi) -1 );
            Write( fi, E );
        end;
    end;
    close( fi );
end;

//Ejer4  c)

procedure ExportarEmpleado(var Arch: EmpleadosArch;NombreFichero: string);
var
    e: Empleado;
    ar: Text;
begin
    assign(Arch,NombreFichero);
    assign(ar,'Todos_empleados.txt');
    rewrite(ar);     
    reset(Arch);   
    while  not eof(Arch) do begin
        Read(Arch,e);
        writeln(ar, '|NRO: ', e.numeroEmp);
        writeln(ar, '|EDAD: ', e.Edad);
        writeln(ar, '|DNI: ', e.Dni);
        writeln(ar, '|APELLIDO: ', e.Apellido);
        writeln(ar, '|NOMBRE: ', e.nombre);
    end;
    Close(ar);
    Close(Arch);
end;


// Eje4r4 D)
procedure Exportarsindnio(var Arch: EmpleadosArch;NombreFichero: string);
var
    e: Empleado;
    ar: Text;
begin
    assign(Arch,NombreFichero);
    assign(ar,'sin_dni.txt');
    rewrite(ar);     
    reset(Arch);   
    while  not eof(Arch) do begin
        Read(Arch,e);
        if(e.Dni = '00') then begin
            writeln(ar, '|NRO: ', e.numeroEmp);
            writeln(ar, '|EDAD: ', e.Edad);
            writeln(ar, '|DNI: ', e.Dni);
            writeln(ar, '|APELLIDO: ', e.Apellido);
            writeln(ar, '|NOMBRE: ', e.nombre);
        end;
    end;
    Close(ar);
    Close(Arch);
end;






//Main Menu
procedure SubMenu(var Arch : EmpleadosArch);
var 
    Opc : char;
begin
    while True do begin
        writeln('----------Menu-----------'); 
        writeln('1.Listar en pantalla los datos de empleados que tengan un nombre o apellido determinado');
        writeln('2.Listar en pantalla los empleados de a uno por linea');
        writeln('3.Listar en pantalla empleados mayores de 70 anios, proximos a jubilarse');
        writeln('4.Aniadir empleados');
        writeln('5.Modificar la edad de un empleado');
        writeln('6.salir');
        readln(Opc);

        case Opc of 
            '1' :Buscar_empleado(Arch);
            '2' :MuestraEmpleados(Arch);
            '3' :Mayores(Arch);
            '4' :addEm(Arch);
            '5' :ModificarEdad(Arch);
            '6' :break; 
        else 
            writeln('No existe esa Opcion');
        end;
    end;
end;



//Abrir Achivo
procedure Abrir (var archivo:EmpleadosArch;NombreFichero: string);
begin
    assign(archivo,NombreFichero);    
    SubMenu(archivo);
end;


procedure Menu(var Arch:EmpleadosArch ; NombreFichero: string );
var
    Opc : char;
begin
    while True do begin
        writeln('----------Menu-----------'); 
        writeln('1.Crear un archivo de registros no ordenados de empleados');
        writeln('2.Abrir Archivo');
        writeln('3 Exportar Empleados');
        writeln('4.Exportar dni 00');
        readln(Opc);
        case Opc of 
            '1' :
            begin
                Crear_file (Arch,NombreFichero);
                break;
            end;
            '2' :
            begin
                Abrir(Arch,NombreFichero);
                break;
            end;  
            '3':
            begin
                ExportarEmpleado(Arch,NombreFichero);
                break;
            end;
            '4':
            begin
                Exportarsindnio(Arch,NombreFichero);
                break;
            end;
        else 
            writeln('No existe esa Opcion');
        end;
    end;
end;

var
    Arch:EmpleadosArch;
    NombreFichero: string;
begin
    write('Ingrese el nombre del archivo a crear o abrir: ');
    readln(NombreFichero);   
    Menu(arch,NombreFichero);
end.