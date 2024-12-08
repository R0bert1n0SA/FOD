{Una empresa posee un archivo con información de los ingresos percibidos por diferentes
empleados en concepto de comisión, de cada uno de ellos se conoce: código de empleado,
nombre y monto de la comisión. La información del archivo se encuentra ordenada por
código de empleado y cada empleado puede aparecer más de una vez en el archivo de
comisiones.
Realice un procedimiento que reciba el archivo anteriormente descripto y lo compacte. En
consecuencia, deberá generar un nuevo archivo en el cual, cada empleado aparezca una
única vez con el valor total de sus comisiones.
NOTA: No se conoce a priori la cantidad de empleados. Además, el archivo debe ser
recorrido una única vez.}
program ejercicio1;
const
valorAlto='zzz';
type
    Empleado=record
        codigo:string[5];
        nombre:string[30];
        moncomision:real;
    end;

    Empleado2=record
        codigo:string[5];
        moncomision:real;
    end;

    Empleados =file of Empleado;
    EmpleadosComp =file of Empleado2;



procedure leer( var archivo: Empleados; var dato: Empleado);
begin
    if (not(EOF(archivo))) then
        read (archivo, dato)
    else
        dato.codigo := valorAlto;
end;

procedure Compactar(var e:Empleados;var e2:EmpleadosComp);
var
    em:Empleado;
    em2:Empleado2;
    act: string[5];
begin
    reset(e);
    rewrite(e2);        
    leer(e,em);
    while(em.codigo <> valorAlto) do begin       
        act:=em.codigo;
        em2.codigo:=act;        
        while (em.codigo=act) do begin
            em2.moncomision:= em2.moncomision + em.moncomision;
            leer(e,em);
        end;         
        write (e2,em2);
        em2.moncomision:=0;
    end;
    close(e);
    close(e2);
end;

var
    nombre,nombre2:string;
    e:Empleados;
    e2:EmpleadosComp;
begin
    assign(e,'Comisiones.dat');  //asignamos el archivo de entrada
    assign(e2, 'ComisionesCompactadas.dat');
    Compactar(e,e2);
end.