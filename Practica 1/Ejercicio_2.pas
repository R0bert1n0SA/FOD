program procesar_numeros;
type
    Enteros = file of integer;

procedure Mostrar_Numeros( var  f : Enteros);
var 
    suma, contador, promedio,numero: integer;
begin
    suma := 0;
    contador := 0;
    while not eof(f) do begin
        read(f, numero);
        inc(suma);
        if  (numero < 1500) then 
            inc(contador);
        writeln(numero);
    end;
    write(suma);
    promedio := suma div contador;
    writeln('Cantidad de numeros menores a 1500: ', contador);
    writeln('Promedio de los numeros menores a 1500: ', promedio );
    close(f);
end;
var
    archivo: Enteros;
    nombreArchivo: string;
begin
    write('Ingrese el nombre del archivo: ');
    read(nombreArchivo);
    assign(archivo,nombreArchivo );    
    reset(archivo);
    Mostrar_Numeros(archivo);
end.

