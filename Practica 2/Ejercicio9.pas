{Se necesita contabilizar los votos de las diferentes mesas electorales registradas por
provincia y localidad. Para ello, se posee un archivo con la siguiente información: código de
provincia, código de localidad, número de mesa y cantidad de votos en dicha mesa.
Presentar en pantalla un listado como se muestra a continuación:

Código de Provincia
Código de Localidad Total de Votos
................................ ......................
................................ ......................
Total de Votos Provincia: ____
Código de Provincia 
Código de Localidad Total de Votos
................................ ......................
Total de Votos Provincia: ___
…………………………………………………………..
Total General de Votos: ___


NOTA: La información está ordenada por código de provincia y código de localidad.}
program Provincia;
const
    tope=-1;

type
    Urna= record
        codpro: integer;
        codlo:integer;
        numeromesa:integer; 
        votos:integer;
    end;

    Mesas=file of urna;




procedure Leer(var f: Mesas, var u:Urna);
begin
    if(not eof(f))then 
    begin
        read(f,u);
    end;
    else 
        u.codpro:=tope;
end;



procedure Mostrar (var m:Mesas);
var
    u:Urna;
    localidadact provinciaact:integer;
    total,totaL,totalP:integer;
begin
    reset(m);
    total=0;
    Leer(m,u);
    while(u.codpro <> tope) do begin
        totalP=0;
        provinciaact=u.codpro;
        writeln(' Codigo Provincia:  ',provinciaact);
        while(u.codpro = provinciaact)do begin
            writeln('Codigo Localidad: ',u.codlo);
            totaL=0;
            localidadact=u.codlo;
            while(u.codlo = localidadact)do begin
                totaL=totaL +u.votos;
                Leer(m,u);
            end;
            write(' Total Votos: ',totoL);
            totalP=totalP+totaL;
        end;
        writeln('Total de Votos Provincia: ',totalP);
        total=total+totalP;
    end;
    writeln('Total General de Votos: ',total)
    close(m);
end;




var
    m:Mesas;
begin
    assign(m,'urna.dat');
    mostrar(m);
end;