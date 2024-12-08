{4. Suponga que trabaja en una oficina donde está montada una LAN (red local). La misma
fue construida sobre una topología de red que conecta 5 máquinas entre sí y todas las
máquinas se conectan con un servidor central. Semanalmente cada máquina genera un
archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por
cuánto tiempo estuvo abierta. Cada archivo detalle contiene los siguientes campos:
cod_usuario, fecha, tiempo_sesion. Debe realizar un procedimiento que reciba los archivos
detalle y genere un archivo maestro con los siguientes datos: cod_usuario, fecha,
tiempo_total_de_sesiones_abiertas.
Notas:
- Cada archivo detalle está ordenado por cod_usuario y fecha.
- Un usuario puede iniciar más de una sesión el mismo dia en la misma o en diferentes
máquinas.
- El archivo maestro debe crearse en la siguiente ubicación física: /var/log.}
program oficina;
const
    valorMAX=32000;
    tope=5;
type
    Logs=record
        codu :integer; 
        fecha:integer;
        tiempo_sesion: integer;
    end;

    LogsMast  = record
        codu :integer; 
        fecha:integer;
        tiempo_total: integer;
    end;

    Maestro: file of  LogsMast;
    detalle:file of  Logs;
    ArregloCompus = array[1..tope] of detalles;
    ArregloLogs   = array[1..tope] of Logs;

procedure  LeerC(var f:detalle;var l:Logs);
begin
    if(not eof(f)) then
        read(f,l);
    else
        l.cod:=valorMAX;
end;


procedure Minimo (var vC:ArregloCompus;var l:Logs; var vL:ArregloLogs);
var
    i,indiceMin: integer;
begin
    indiceMin:=0;
    l.codu:= valorMAX;
    for i:=1 to tope do begin
        if(vL[i].codu <> -1) then begin
            if(vL[i].codu < l.codu) then  begin
                l.codu:=vL.codu;
                indiceMin := i;
            end;
        end;
        if (indiceMin <> 0) then begin
            LeerC(vC[indiceMin],vL[indiceMin]);
        end;
    end;
end;

procedure CrearMaestro(var f:maestro, var d:ArregloCompus);
var 
    i, codact,tiempt: integer;
    ind:String;
    L:ArregloLogs;
    minl:Logs;
    lm:LogsMast;
begin
    rewrite(f);
    for i:=1 to  tope do begin
        str(i,ind);
        assign(d[i],'detalle'+ ind +'dat');
        reset(d[i]);
        LeerC(d[i],L[i]);
    end;
    Minimo(d,minl,L);
    while (minl <> -1)do begin
        codact:=minl.codu;
        tiempt:=0;
        while(minl.codu < codact.codu) do begin
            tiempt:=tiemp +minl.tiempo_sesion;
            Minimo(d,minl,L);
        end;
        lm.codu:= codact;
        lm.fecha:=minl.fecha;
        lm.tiempo_total:=tiempo;
        write(f,lm);
    end;
    for i:=1 to tope do begin
        close(d[i]);
    end;
    close(f);
end;

var
    m:Maestro;
    dV:ArregloCompus;
begin 
    assign(m,'/var/log/maestro.dat');
    CrearMaestro(m,dV);
end.