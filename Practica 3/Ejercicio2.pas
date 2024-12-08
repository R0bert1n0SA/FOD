{Definir un programa que genere un archivo con registros de longitud fija conteniendo
información de empleados de una empresa de correo privado. Se deberá almacenar:
código de empleado, apellido y nombre, dirección, teléfono, D.N.I y fecha
nacimiento. Implementar un algoritmo que, a partir del archivo de datos generado,
elimine de forma lógica todo los empleados con DNI inferior a 8.000.000.
Para ello se podrá utilizar algún carácter especial delante de algún campo String a su
elección. Ejemplo: ‘*PEDRO.
}

program ejer2;
const
    valoralto =32000; 
type 
    emp= record
        cod: integer;
        apellido:String;
        nombre:String;
        direccion:String;
        telefono:String; 
        dni: integer;  
        nacimiento:String;
    end;

    archiemp: file of emp;


procedure leer(	var archivo: archiemp;var dato: emp);
begin
    if (not(EOF(archivo))) then 
        read (archivo, dato)
    else 
		dato.cod := valoralto;
end;

procedure eliminar(var f:archiemp);
var
    e: emp;
begin
    reset(f);
    leer(f,e);
    while(e.dni  <> 8000000) do begin
        leer(f,e);
    end;
    e.nombre='*'+e.nombre;
    seek(f, filepos(f)-1 );
	write(f,e);
    close(f);
end;


var
    f: archiemp; 
begin   
    assign(f,'empleados.dat');
    eliminar(f);
end.