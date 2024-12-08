{3. Realizar un programa que presente un menú con opciones para:
    a. Crear un archivo de registros no ordenados de empleados y completarlo con
    datos ingresados desde teclado. De cada empleado se registra: número de
    empleado, apellido, nombre, edad y DNI. Algunos empleados se ingresan con
    DNI 00. La carga finaliza cuando se ingresa el String ‘fin’ como apellido.
    b. Abrir el archivo anteriormente generado y
        i. Listar en pantalla los datos de empleados que tengan un nombre o apellido
        determinado.
        ii. Listar en pantalla los empleados de a uno por línea.
        iii.Listar en pantalla empleados mayores de 70 años, próximos a jubilarse.
NOTA: El nombre del archivo a crear o utilizar debe ser proporcionado por el usuario una
única vez.
}
program ejer3;
type
    Empleado =record
        nombre: String;
        Apellido: String;
        Edad : Integer;
        Dni : string[8];
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
    while(e.Apellido <> 'fin') do begin
        Leer_Empleado(e);
        write(Arch, e);
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
end;




procedure Mayores(var fi :EmpleadosArch);
var 
    e:Empleado;
begin
    reset(fi);        
    while not EOF(fi)do begin
        read(fi,e);
        if e.Edad > 1500 then 
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
        writeln('4.salir');
        readln(Opc);

        case Opc of 
            '1' :Buscar_empleado(Arch);
            '2' :MuestraEmpleados(Arch);
            '3' :Mayores(Arch);
            '4' :break; 
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