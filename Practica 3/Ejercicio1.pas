{Modificar el ejercicio 4 de la práctica 1 (programa de gestión de empleados),
agregándole una opción para realizar bajas copiando el último registro del archivo en
la posición del registro a borrar y luego truncando el archivo en la posición del último
registro de forma tal de evitar duplicados.}

procedure Eliminar (f:emp; num: integer);
var
    e:empleado;
    r:empleado;

begin
    reset(f);
    seek(f, filesize(f)-1);
    read(f,r);
    seek(f,0);
    while not eof(f) do begin
        read(f,e);
        if e.numero = num then begin
            seek(f,filepos(f)-1);
            write(f,r);
            seek(f,filesize(f)-1);
            truncate(f);
        end;
    end;  
    close(f);
end;