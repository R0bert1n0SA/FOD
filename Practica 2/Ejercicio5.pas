{5. A partir de un siniestro ocurrido se perdieron las actas de nacimiento y fallecimientos de
toda la provincia de buenos aires de los últimos diez años. En pos de recuperar dicha
información, se deberá procesar 2 archivos por cada una de las 50 delegaciones distribuidas
en la provincia, un archivo de nacimientos y otro de fallecimientos y crear el archivo maestro
reuniendo dicha información.
Los archivos detalles con nacimientos, contendrán la siguiente información: nro partida
nacimiento, nombre, apellido, dirección detallada(calle,nro, piso, depto, ciudad), matrícula
del médico, nombre y apellido de la madre, DNI madre, nombre y apellido del padre, DNI del
padre.
En cambio los 50 archivos de fallecimientos tendrán: nro partida nacimiento, DNI, nombre y
apellido del fallecido, matrícula del médico que firma el deceso, fecha y hora del deceso y
lugar.
Realizar un programa que cree el archivo maestro a partir de toda la información los
archivos. Se debe almacenar en el maestro: nro partida nacimiento, nombre, apellido,
dirección detallada(calle,nro, piso, depto, ciudad), matrícula del médico, nombre y apellido
de la madre, DNI madre, nombre y apellido del padre, DNI del padre y si falleció, además
matrícula del médico que firma el deceso, fecha y hora del deceso y lugar. Se deberá,
además, listar en un archivo de texto la información recolectada de cada persona.

Nota: Todos los archivos están ordenados por nro partida de nacimiento que es única.
Tenga en cuenta que no necesariamente va a fallecer en el distrito donde nació la persona y
además puede no haber fallecido.}
program Actas;
const 
    Dele=3;
    ValorAlto=32000;
type
    direccion=record 
        calle:integer;
        nro:integer; 
        piso:integer; 
        depto:integer; 
        ciudad:String;
    end;

    Nacimiento=record
        nroP:integer;
        nacimiento:integer;
        nombre:String; 
        apellido:String; 
        direccion_:direccion; 
        matricula:String; 
        nPadre:String; 
        aPadre:String; 
        DNIp:integer; 
        nMadre:String; 
        aMadre:String;
        DNIm:integer;
    end;


    Fallecido=record
        nroP:integer;
        nacimiento:integer;
        nombre:String;
        apellido:String;
        matricula:String; 
        fecha:integer;  
        horad: Integer;
        lugar:String;
    end;

    Persona=record
        nroP:integer;
        nombre:String; 
        apellido:String; 
        nPadre:String; 
        aPadre:String; 
        DNIp:integer; 
        nMadre:String; 
        aMadre:String;
        DNIm:integer;
        matriculana:String;
        direccion_:direccion; 
        fallecio:boolean;
        matriculade:String;
        fecha:integer;  
        horad: Integer;
        lugar:String;
    end;

    Master:   file of Persona ;
    DetalleN: file of Nacimiento;
    DetalleF: file of Fallecido;
    DeleFalle=Array[1..Dele] of DetalleF;
    DeleNaci =Array[1..Dele] of DetalleN;
    RFalle   =Array[1..Dele] of Fallecimiento;
    RNaci    =Array[1..Dele] of Nacimiento;

procedure LeerN(var f: DetalleN; var dato: Nacimiento);
begin
    if(not  EOF(f)) then begin
        Read(f,dato);
    else
        dato.nroP:=ValorAlto;
end;


procedure LeerF(var f: DetalleF; var dato: Fallecido);
begin
    if(not  EOF(f)) then begin
        Read(f,dato);
    else
        dato.nroP:=ValorAlto;
end;


procedure MinimoN( var vN: DeleNaci; var min : Nacimiento; var vrn:RNaci );
var
    i,indmin:integer;
begin
    indmin := 0;
    min.nrop:=ValorAlto;
    for i := 1 to Dele do begin
        if(vN[i].nroP <> -1) then begin
            if (vN[i].nroP < min.nroP ) then begin
                min := vN[i].nroP;
                indmin := i;
            end;
        end;
    end;
    if(indmin <> 0) then begin
        LeerN(vN[indmin],vrn[indmin]);
end;





procedure MinimoF(var vN: DeleF; var min : Fallecido; var vrn:RFalle );
var
    i,indmin:integer;
begin
    indmin := 0;
    min.nrop:=ValorAlto;
    for i := 1 to Dele do begin
        if(vN[i].nroP <> -1) then begin
            if (vN[i].nroP < min.nroP ) then begin
                min.nroP := vN[i].nroP;
                indmin := i;
            end;
        end;
    end;
    if(indmin <> 0) then begin
        LeerF(vN[indmin],vrn[indmin]);
end;


procedure CrearMaster (var f:Master;var nd:DeleNaci; var fd:DeleFalle);
var 
    i,j,numact :integer;
    minN:Nacimiento;
    minF:Fallecido;
    p:Persona;
    rn:RNaci;
    rf:RFalle;
    ind:string;
begin
    rewrite(f);
    for j:=1 to 2 do begin
        for i:=1 to Dele do begin
            str(i,ind);
            if( j = 1) then begin
                assign(nd[i],'NacimentoSucu' + ind);
                reset(nd[i]);
                Leer(nd[i],rn[i]);
            end;
            if(j=2)then begin
                assign(fd[i],'DefuncionSucu'+ind);
                reset(fd[i]) ;
                LeerF(fd[i],rf[i]);
            end;
        end;
    end;
    MinimoN(nd,minN,rn);
    MinimoF(fd,minF,rf);
    while (minN.nroP <> -1 ) and (minF.nroP <> -1) do begin
        if(minN.nroP = minF.nroP) then begin
            p.nroP:=minF.nroP;
            p.nombre:=minN.nombre; 
            p.apellido:=minN.apellido; 
            p.nPadre:=minN.nPadre; 
            p.aPadre:=minN.aPadre; 
            p.DNIp:=minN.DNIp; 
            p.nMadre:=minN.nMadre; 
            p.aMadre:=minN.aMadre; 
            p.DNIm:=minN.DNIm; 
            p.matriculana:=minN.matricula;
            p.direccion_.calle:=minN.direccion_.calle; 
            p.direccion_.nro:=minN.direccion_.nro; 
            p.direccion_.piso:=minN.direccion_.piso;  
            p.direccion_.depto:=minN.direccion_.depto; 
            p.direccion_.ciudad:=minN.direccion_.ciudad;
            p.fallecio:=True;
            p.matriculade:=minF.matricula;
            p.fecha:=minF.fecha;  
            p.horad:= minF.horad;
            p.lugar:=minF.lugar;
        end;
        else if (minN.nroP < minF.nroP) then begin
            p.nroP:=minN.nroP;
            p.nombre:=minN.nombre; 
            p.apellido:=minN.apellido; 
            p.nPadre:=minN.nPadre; 
            p.aPadre:=minN.aPadre; 
            p.DNIp:=minN.DNIp; 
            p.nMadre:=minN.nMadre; 
            p.aMadre:=minN.aMadre; 
            p.DNIm:=minN.DNIm; 
            p.matriculana:=minN.matricula;
            p.direccion_.calle:=minN.direccion_.calle; 
            p.direccion_.nro:=minN.direccion_.nro; 
            p.direccion_.piso:=minN.direccion_.piso;  
            p.direccion_.depto:=minN.direccion_.depto; 
            p.direccion_.ciudad:=minN.direccion_.ciudad;
            p.fallecio:=False;
            p.matriculade:='-';
            p.fecha:=0;  
            p.horad:=0;
            p.lugar:='-';
        end;
        write(f,p);
    end;
    close (f);
	for i:= 1 to Dele do begin
		close (nd[i]);
		close (fd[i]);
    end;
end;

var
    f:Master;
    nd:DeleNaci; 
    fd:DeleFalle;
begin
    assign(f,'Registros.dat');
    CrearMaestro(f,nd fd);
end.