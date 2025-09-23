program main(test);
uses crt;
const
   max=8;
   max2=10;
type
   arr=array[1..max]of integer;
   arr2=array[1..max2]of integer;
   arr3=array[1..max+max2]of integer;
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
procedure insercion(var a:arr);
var
   i,j,aux:integer;
begin
   i:=1;
   j:=i+1;
   while j<=max do
    begin
      if a[j]<a[i] then
         begin
            aux:=a[j];
            while ((j>1)and(aux<a[j-1]))do
               begin
               a[j]:=a[j-1];
               j:=j-1;
               end;
            a[j]:=aux;
         end;
      i:=i+1;
      j:=i+1;
     end;
   writeln('FIN DE INSERCION');
end;
{****************************************************************************}
procedure cargar(var a:arr);
var
   i:integer;
begin
   writeln('CARGAR ARRREGLO DE ',max,' ENTEROS');
   i:=1;
   while i<=max do
      begin
         read(a[i]);
         inc(i);
      end;
   readln;
end;
{****************************************************************************}
procedure cargar_num(var n:integer);
begin
   writeln('INTRODUSCA NUMERO A BUSCAR');
   readln(n);
end;
{****************************************************************************}
{****************************************************************************}
{****************************************************************************}
procedure inic(var ar3:arr3);
var
   j:integer;
begin
   for j:=1 to max+max2 do
      ar3[j]:=0;
end;
{****************************************************************************}
procedure imp_tres(tres:arr3);
var
   k:integer;
begin
   writeln;
   for k:=1 to max+max2 do
      write(tres[k],' ');
   writeln;
end;
{****************************************************************************}
procedure mezclar(uno:arr;dos:arr2;var tres:arr3);
var
   i,j,k:integer;
begin
   i:=1;
   j:=1;
   k:=1;
   while((i<=max)and(j<=max2))do
      begin
         if uno[i]<=dos[j] then
            begin
               tres[k]:=uno[i];
               inc(i);
            end
         else
            begin
               tres[k]:=dos[j];
               inc(j);
            end;
         k:=k+1;
      end;
   if i<=max then
      while i<=max do
         begin
            tres[k]:=uno[i];
            inc(i);
            k:=k+1;
         end
   else
       while j<=max2 do
          begin
             tres[k]:=dos[j];
             inc(j);
             k:=k+1;
          end;
   writeln('UNO Y DOS MEZCLADO EN TRES');
end;
{****************************************************************************}
procedure cargar_arr2(var arrdos:arr2);
var
   j:integer;
begin
   j:=1;
   writeln('CARGAR ARREGLO ''DOS'' DE ',max2,' ENTEROS');
   writeln('DEBE SER EN ORDEN ASCENDENTE');
   while j<= max2 do
      begin
         read(arrdos[j]);
         inc(j);
      end;
end;
procedure imp_dos(a2:arr2);
var
   j:integer;
begin
   writeln;
   for j:=1 to max2 do
      write(a2[j],' ');
   writeln;
end;
{****************************************************************************}
procedure imprimir(a:arr);
var
   j:integer;
begin
   writeln;
   for j:=1to max do
      write(a[j],' ');
   writeln;
end;
{****************************************************************************}
procedure orden_mezcla(nro:integer;var a:arr;var a2:arr2;var c:arr3);
begin
   case nro of
     1: mezclar(a,a2,c);
     2: imprimir(a);
     3: imp_dos(a2);
     4: imp_tres(c);
     5: cargar_arr2(a2);
     6: insercion(a);
   end;
end;
{****************************************************************************}
procedure mezcla(var a:arr);
var
   dos:arr2;
   tres:arr3;
   n:integer;
begin
   cargar_arr2(dos);
   n:=0;
   inic(tres);
   while n<> 7 do
      begin
         writeln('------------------------------');
         writeln('| 1- mezclar en arreglo tres |');
         writeln('| 2- visualizar arreglo uno  |');
         writeln('| 3- visualizar arreglo dos  |');
         writeln('| 4- visualizar arreglo tres |');
         writeln('| 5- recargar arreglo dos    |');
         writeln('| 6- ordenar arreglo uno     |');
         writeln('| 7- salir de mezcla         |');
         writeln('------------------------------');
         readln(n);
         clrscr;
         orden_mezcla(n,a,dos,tres);
      end;
   writeln('FIN DE MEZCLA');
end;

{****************************************************************************}
function binaria(a:arr;num:integer):integer;
var
   ini,fin,centro:integer;
   enc:boolean;
begin
   ini:=1;
   fin:=max;
   enc:=false;
   while((ini<=fin)and(not enc))do
      begin
         centro:=(ini+fin)div 2;
         if a[centro]=num then
            enc:=true
         else
            if a[centro]>num then
               fin:=centro-1
            else
               ini:=centro+1;
      end;
   if enc then
      binaria:=centro
   else
     binaria:=0;
end;
{****************************************************************************}
procedure busqueda_binaria(a:arr);
var
   nro,res:integer;
begin
   cargar_num(nro);
   res:=binaria(a,nro);
   if res <>0 then
      writeln(nro,' ESTA EN LA POSICION ',res)
   else
      writeln(nro,' NO ESTA EN EL ARREGLO');
end;
{****************************************************************************}
function busc_lineal(a:arr;n:integer):integer;
var
  enc:boolean;
  i:integer;
begin
   i:=1;
   enc:=false;
   while((i<=max)and(not enc))do
      if a[i]=n then
         enc:=true
      else
         i:=i+1;
   if enc then
      busc_lineal:=i
   else
      busc_lineal:=0;
end;
{****************************************************************************}
procedure busqueda_lineal(a:arr);
var
   num,res:integer;
begin
   cargar_num(num);
   res:=busc_lineal(a,num);
   if res<>0 then
      writeln('EL NUMERO ',num,' ESTA EN LA POSICION: ',res)
   else
      writeln(num,' NO ESTA EN EL ARREGLO');
end;
{****************************************************************************}
procedure burbujeo(var a:arr);
var
  i,j:integer;
  camb:boolean;
begin
   i:=max;
   j:=1;
   camb:=true;
   while((j<max)and(camb))do
     begin
      camb:=false;
      while i> j do
         begin
            if a[i]<a[i-1] then
               begin
                  camb:=true;
                  cambio(a[i],a[i-1]);
               end;
            i:=i-1;
         end;
      i:=max;
      j:=j+1;
     end;
   writeln('FIN DE BURBUJEO');
end;
{****************************************************************************}
function menor(a:arr;ini:integer):integer;
var
   j:integer;
begin
   j:=ini+1;
   while j<= max do
      begin
         if a[ini]>a[j] then
            ini:=j;
         j:=j+1;
      end;
   menor:=ini;
end;
{****************************************************************************}
procedure seleccion(var a:arr);
var
   i,min:integer;
begin
   i:=1;
   while i<max do
      begin
         min:=menor(a,i);
         if i<> min then
            cambio(a[i],a[min]);
         i:=i+1;
      end;
   writeln('FIN DE SELECCION');
end;
{****************************************************************************}
procedure derivar(n:integer;var a:arr);
begin
   case n of
     1: seleccion(a);
     2: insercion(a);
     3: burbujeo(a);
     4: busqueda_lineal(a);
     5: busqueda_binaria(a);
     6: mezcla(a);
     7: imprimir(a);
     8: cargar(a);
   end;
end;
{****************************************************************************}
procedure logo(var a:arr);
var
   nro:integer;
begin
   writeln('ESCOJA OPCION:');
   nro:=0;
   clrscr;
   while nro <>9 do
      begin
         writeln('****************************');
         writeln('* 1- ordenar por seleccion  *');
         writeln('* 2- ordenar por insercion  *');
         writeln('* 3- ordenar por burbujeo   *');
         writeln('* 4- busqueda lineal        *');
         writeln('* 5- busqueda binaria       *');
         writeln('* 6- mezcla                 *');
         writeln('* 7- imprimir               *');
         writeln('* 8- recargar arreglo       *');
         writeln('* 9- salir                  *');
         writeln('*****************************');
         readln(nro);
         clrscr;
         derivar(nro,a);
      end;
   clrscr;
   writeln(' FIN DE LOGO');
end;
{****************************************************************************}
var
   arreglo:arr;
   car:char;
begin
   writeln('BIENVENIDO A ORDENAMIENTO BUSQUEDA Y MEZCLA INTERNA');
   writeln('---------------------------------------------------');
   writeln;
   cargar(arreglo);
   writeln('QUIERE INGRESAR A LOGO? S/N');
   readln(car);
   while ((upcase(car)<>'N')and(upcase(car)<>'S'))do
      begin
         writeln('S/N?');
         readln(car);
      end;
   if upcase(car)='S' then
         while upcase(car)='S' do
            begin
               logo(arreglo);
               writeln('QUIERE VOLVER A LOGO? S/N');
               readln(car);
            end
   else
       writeln('VOS TE LO PERDES');
   writeln;
   writeln('FIN DE PROGRAMA...');
   writeln('presione cualquier tecla para salir');
   readln;
   clrscr;
end.