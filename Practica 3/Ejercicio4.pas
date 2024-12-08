{4.Dada la siguiente estructura:
type
reg_flor = record
nombre: String[45];
codigo:integer;
end;
tArchFlores = file of reg_flor;


Las bajas se realizan apilando registros borrados y las altas reutilizando registros
borrados. El registro 0 se usa como cabecera de la pila de registros borrados: el
número 0 en el campo código implica que no hay registros borrados y -N indica que el
próximo registro a reutilizar es el N, siendo éste un número relativo de registro válido.
a. Implemente el siguiente módulo:

Abre el archivo y agrega una flor, recibida como parámetro
manteniendo la política descrita anteriormente

procedure agregarFlor (var a: tArchFlores ; nombre: string;
codigo:integer);

b. Liste el contenido del archivo omitiendo las flores eliminadas. Modifique lo que
considere necesario para obtener el listado.
}

{5.Dada la estructura planteada en el ejercicio anterior, implemente el siguiente módulo:
Abre el archivo y elimina la flor recibida como parámetro manteniendo
la política descripta anteriormente
procedure eliminarFlor (var a: tArchFlores; flor:reg_flor);
}

program ejer4;
type
    reg_flor = record
    nombre: String[45];
    codigo:integer;
    end;
    tArchFlores = file of reg_flor;
    
    procedure  leer(var f : tArchRevistas ; var n :reg_flor );
    begin
        if( not eof(f)) then
            read(f , n);
        else
            n.codigo:=32000;
    end;


//A)
    procedure agregarFlor (var f: tArchFlores ; nombre: string; codigo:integer);
    var
        reutilizable:reg_flor;
        reg:reg_flor;
    begin
        reset (f);
        leerArc (f,reg ); //LEO REGISTRO CABECERA
        if (reg.codigo < 0) then begin 
            seek (f,abs(n.codigo)); //me muevo a la posicion del ultimo borrado abs lo toma como positivo 
            read (a,reutilizable);
            seek (a,filePos(a)-1);
            reg.nombre := nombre;
            reg.codigo := codigo;
            write (a,reg);
            seek (a,0);
            write (a,reutilizable);
            writeln ('FLOR AGREGADA CON EXITO');
        end
        else begin
            seek(f,filesize(f));
            reg.nombre := nombre;
            reg.codigo := codigo;
            write(f,reg);
        end;
        close(a);
    end;

//B
procedure Mostrar(var f:tArchFlores );
var
    reg: reg_flor;
begin
    reset(f);
    leerArc(f,reg);
    while(reg.codigo <> 32000) do begin
        if(reg.codigo > 0) then
            writeln('Codigo : ',reg.codigo,' - Nombre : ',reg.Nombre);
        leerArc(f,reg);
    end;
    clore(f);
end;


//C
    procedure eliminarFlor (var a: tArchFlores; flor:reg_flor);
    var
        aux,regcabe: reg_flor;
    begin
        reset(f);
        leerArc(f;aux);
        while(aux.codigo <> 32000) and (aux.codigo <> flor.codigo)do begin
            leerArc(f,aux);
        end;
        if(flor.codigo == aux.codigo) then begin
            read(f,aux);
            aux.codigo=aux.codigo*-1;
            seek(f,0);
            read(f,regcabe);
            seek(f,0);
            write(f,aux);
            seek(f,filepos(flor.codigo));
            write(f,regcabe);
        end
        else
            writeln('No se encontro la flor');
        close(f);
    end;



