program main(romanos);
uses crt;
const
   max=10;
type
   cadena=string[max];
   arreglo=array[1..max]of integer;
{****************************************************************************}
function suma(a:arreglo;maximo:integer):integer;
var
   sum,j:integer;
begin
   sum:=0;
   j:=maximo;
   while j>=1 do
      if ((j>1)and(a[j-1]<a[j]))then
         begin
         sum:=sum+a[j]-a[j-1];
         j:=j-2;
         end
      else
         begin
              if ((j=1)and(a[j+1]>a[j]))then
                 sum:=sum-a[j]
              else
                 sum:=sum+a[j];
              j:=j-1;
         end;

    suma:=sum;
end;
{****************************************************************************}
function valor(j:char):integer;
begin
   case upcase(j) of
     'M':valor:=1000;
     'D':valor:=500;
     'C':valor:=100;
     'L':valor:=50;
     'X':valor:=10;
     'V':valor:=5;
     'I':valor:=1;
   end;
end;
{****************************************************************************}
procedure romanos(cad:cadena; var nro:integer);
var
   i:integer;
   arr:arreglo;
begin
   i:=1;
   while i<=length(cad)do
      begin
         arr[i]:=valor(cad[i]);
         i:=i+1;
      end;
   nro:=suma(arr,length(cad));
end;
{****************************************************************************}
var
   romano:cadena;
   numero:integer;
begin
   writeln('INTRODUSCA NUMERO EN NUMERACION ROMANA');
   readln(romano);
   romanos(romano,numero);
   writeln(romano,' ',numero);
   writeln('FIN PROGRAMA...');
   writeln('Presione cualquier tecla');
   readkey;
   clrscr;
end.