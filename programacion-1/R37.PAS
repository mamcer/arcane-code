program main (r37);
uses crt;
const
   max=10;
type
   arreglo=array[1..max]of integer;
{****************************************************************************}
{****************************************************************************}
{****************************************************************************}
procedure cambio(var uno:integer;var dos:integer);
var
   aux:integer;
begin
   aux:=uno;
   uno:=dos;
   dos:=aux;
end;
{****************************************************************************}
function menor(a:arreglo;ini,tope:integer):integer;
var
   j:integer;
begin
   j:=ini+1;
   while j<=tope do
      begin
         if a[j]<a[ini] then
            ini:=j;
         j:=j+1;
      end;
   menor:=ini;
end;
{****************************************************************************}
procedure ordenar(var a:arreglo);
var
   min,maximo,nro:integer;
begin
   min:=1;
   maximo:=max;
   while min<maximo do
      begin
         nro:=menor(a,min,maximo);
         if nro<>min then
            cambio(a[min],a[nro]);
         min:=min+1;
         nro:=menor(a,min,maximo);
         if nro<>maximo then
            cambio(a[maximo],a[nro]);
         maximo:=maximo-1;
      end;
end;
{****************************************************************************}
procedure imprimir(a:arreglo);
var
   j:integer;
begin
  j:=1;
  writeln;
  while j<=max do
     begin
        write(a[j],'-');
        j:=j+1;
     end;
  writeln;
end;
{****************************************************************************}
procedure cargar(var a:arreglo);
var
   i:integer;
begin
   i:=1;
   writeln('CARGAR ARREGLO DE ', MAX,' REALES');
   while i<=max do
     begin
        read(a[i]);
        i:=i+1;
     end;
end;
{****************************************************************************}
var
   numeros:arreglo;
begin
   cargar(numeros);
   writeln('NUMEROS CARGADOS:');
   imprimir(numeros);
   ordenar(numeros);
   writeln('ORDENADOS EN FORMA PIRAMIDAL:');
   imprimir(numeros);
   readkey;
   clrscr;
end.