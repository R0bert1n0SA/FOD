{Se dispone de un archivo con información de los alumnos de la Facultad de Informática. Por
cada alumno se dispone de su código de alumno, apellido, nombre, cantidad de materias
(cursadas) aprobadas sin final y cantidad de materias con final aprobado. Además, se tiene
un archivo detalle con el código de alumno e información correspondiente a una materia
(esta información indica si aprobó la cursada o aprobó el final).
Todos los archivos están ordenados por código de alumno y en el archivo detalle puede
haber 0, 1 ó más registros por cada alumno del archivo maestro. Se pide realizar un
programa con opciones para:
    a. Crear el archivo maestro a partir de un archivo de texto llamado “alumnos.txt”.
    b. Crear el archivo detalle a partir de en un archivo de texto llamado “detalle.txt”.
    c. Listar el contenido del archivo maestro en un archivo de texto llamado
    “reporteAlumnos.txt”.
    d. Listar el contenido del archivo detalle en un archivo de texto llamado
    “reporteDetalle.txt”.
    e. Actualizar el archivo maestro de la siguiente manera:
    i.Si aprobó el final se incrementa en uno la cantidad de materias con final aprobado.
    ii.Si aprobó la cursada se incrementa en uno la cantidad de materias aprobadas sin
    final.
    f. Listar en un archivo de texto los alumnos que tengan más de cuatro materias
    con cursada aprobada pero no aprobaron el final. Deben listarse todos los campos.
NOTA: Para la actualización del inciso e) los archivos deben ser recorridos sólo una vez.}
program Ejercicio_2;
type
    alumno =record;
        codigo: integer;
        apellido: String;
        nombre: String;
        materiasASF:integer;
        materiasAF:integer;
    end;

    Materia =record
        codigoAlumno : integer;
        Aprobo:char;
    end;

    Maestro =file of alumno;
    Detalle =file of Materia;




procedure Readd(var f:Detalle; var m:Materia);
begin
    if(eof(f)) then 
        read(f,m);
    else 
        m.codigoAlumno:=32700;
end;

//a. Crear el archivo maestro a partir de un archivo de texto llamado “alumnos.txt”.
procedure Crear (var MA:Maestro, var F:text);
var
    A: alumno;
begin
    reset(F);
    Rewrite(MA);
    while not EOF(F) do  begin
        Readln(F,A.codigo,A.nombre,A.apellido);
        Readln(F,A.materiasASF,A.materiasAF);
        write(MA,A);
    end;
    close(MA);
    close(F);
end;



//b. Crear el archivo detalle a partir de en un archivo de texto llamado “detalle.txt”.
procedure  CrearDetalle(var DT:Detalle; var FDT:text);
var
    M:Materia;
begin
    Reset(FTD);
    rewrite(DT);
    While not  eof(FTD) Do Begin
        Readln(FDT,M.codigoAlumno);
        Readln(FDT,M.Aprobo);
        Write(DT,M);
    end;
    Close(DT);
    Close(FDt);
end;


//c. Listar el contenido del archivo maestro en un archivo de texto llamado “reporteAlumnos.txt”.

procedure Pasaje (var f:Maestro;var ft:text);
var
    a:alumno;
begin
    reset(f);
    rewrite(ft);
    while not eof(f)  do begin
        read(f,a);
        writeln(ft,a.codigo,a.apellido,a.nombre);
        writeln(ft,a.materiasAF,a.materiasASF);
        writeln(ft);
    end;
    close(f);
    close(ft);
end;

procedure Listar_maestro(var f: Maestro;var ft:text);
var
    a: alumno;
begin
    Pasaje(f,ft);
    reset(ft);
    while (not eof(ft)) do begin
        readln(ft,a.codigo,a.apellido,a.nombre);
        readln(ft,a.materiasAF,a.materiasASF)
        readln(ft);
        writeln('Codigo: ',a.codigo);
        writeln(a.apellido,' ',a.nombre);
        writeln('Materias Cursada: ',a.materiasASF);
        writeln('Materias Final: ',a.materiasAF);
    end;
    close(ft);
end;


//d. Listar el contenido del archivo detalle en un archivo de texto llamado “reporteDetalle.txt”.
procedure PasajeD (var f:Detalle;var ft:text);
var
    m:materia;
begin
    reset(f);
    rewrite(ft);
    while not eof(f)  do begin
        read(f,a);
        writeln(ft,a.codigo);
        writeln(ft,a.Aprobo);
        writeln(ft);
    end;
    close(f);
    close(ft);
end;

procedure Listar_detalle(var f:Detalle;var ft:text);
var
    m: materia;
begin
    PasajeD(f,ft);
    reset(ft);
    while (not eof(ft)) do begin
        readln(ft,a.codigo);
        readln(ft,a.materiasAF,a.materiasASF)
        readln(ft);
        writeln('Codigo: ',a.codigo);
        writeln('Materia por final o cursada: ',a.Aprobo);
    end;
    close(ft);
end;

{e. Actualizar el archivo maestro de la siguiente manera:
    i.Si aprobó el final se incrementa en uno la cantidad de materias con final aprobado.
    ii.Si aprobó la cursada se incrementa en uno la cantidad de materias aprobadas sin
final.}

procedure ActualizarMaestro (var f: Maestro; var fd:Detalle);
var 
    m: materia;
    a:alumno;
begin
    reset(f);
    Reset(fd);
    Readd(fd,m);
    while (m.codigoAlumno <> 32700) do begin
        codact:=m.codigoAlumno;
        contF:=0;
        contC=0;
        while(m.codigoAlumno = codact) do begin
            if (m.Aprobo ='F')  or (m.Aprobo ='f') then
                contF:=contF +1:
            if (m.Aprobo ='C')  or (m.Aprobo ='c') then
                contC:=contC+1;
            Readd(fd,m);
        end;
        read(f,a);
        while(a.codigo <> codact) do begin
            read(f,a);
        end;
        a.materiasAF:=a.materiasAF+contF;
        a.materiasASF:=a.materiasASF+contC;
        seek(f,FileSize(f)-1);
        write(f,a);
    end;
    close(fd);
    close(f);
end;

//f. Listar en un archivo de texto los alumnos que tengan más de cuatro materias con cursada aprobada 
//pero no aprobaron el final. Deben listarse todos los campos.

procedure ListarCursada (var f:Maestro;var ft:text );
var
    a:alumno;
begin
    reset (f);
    rewrite(ft);
    while( not eof(f)) do begin
        read(f,a);
        if (a.materiasAF > 4 )then begin
            writeln(ft,a.nombre,a.apellido,a.codigo);
            writeln(ft,a.materiasAF,a.materiasASF);
            writeln(ft);
        end;
    end;
    while not eof(ft) do begin
        readln(ft,a.nombre,a.apellido,a.codigo)
        readln(ft,a.materiasAF,a.materiasASF)
        readln(ft)
        writeln('Nombre: ',a.nombre,' Apellido: ',a.apellido,' Codigo: 'a.codigo);
        writeln('Materias Aprobadas Finales: ',a.materiasAF, ' Materias Sin Final: ',a.materiasASF);
    close(f);
    close(ft);
end;

var
    m:maestro;
    t1,t2,t3,t4,t5:text;
    d:Detalle;
begin
    assign(t1,'Alumnos.txt');
    assign(t2,'Detalles.txt');
    assign(t3,'reporteAlumnos.txt');
    assign(t4,'reporteDetalle.txt');
    assign(t5,'CursadaAprobada.txt');
    assign(m,'Maestro.dat');
    assing(d,'Detalle.dat');
    Crear(m,t1);
    CrearDetalle(d,t2);
    Listar_maestro(m,t3);
    Listar_detalle(d,t4);
    ActualizarMaestro (m,d);
    ListarCursada(m,t5);
end.