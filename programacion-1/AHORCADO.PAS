program main(ahorcado);
const
   maxfila= 4;
   maxcol=5;
type
   tabla=array[1..maxfila,1..maxcol]of char;
   arreglo=array[1..maxcol]of char;
{****************************************************************************}
procedure imp_arr(arr:arreglo);
var
   j:integer;
begin
   j:=1;
   while j<=maxcol do
      begin
         write(arr[j]);
         j:=j+1;
      end;
   writeln;
end;
{****************************************************************************}
function iguales(uno,dos:arreglo):boolean;
var
   f:integer;
begin
   f:=1;
   while ((f<=maxcol)and(uno[f]=dos[f]))do
      f:=f+1;
   if f<=maxcol then
      iguales:=false
   else
      iguales:=true;
end;
{****************************************************************************}
procedure arriesgar(uno:arreglo;var dos:arreglo;var win:boolean;var cont:integer);
var
   r:integer;
begin
   r:=1;
   writeln('INTRODUCI PALABRA DE ',maxcol,' LETRAS');
   while r<=maxcol do
      begin
         read(dos[r]);
         r:=r+1;
      end;
   if iguales(uno,dos)then
      win:=true
   else
      cont:=0;
end;
{****************************************************************************}
procedure imp(uno:arreglo;var dos:arreglo;car:char;var aci:boolean);
var
   j:integer;
begin
   j:=1;
   aci:=false;
   writeln;
   while j<=maxcol do
      begin
         if uno[j]=car then
           begin
            dos[j]:=uno[j];
            aci:=true;
           end;
         write(dos[j]);
         j:=j+1;
      end;
end;
{****************************************************************************}
procedure inicializar(var a:arreglo);
var
   k:integer;
begin
   for k:=1 to maxcol do
      a[k]:='*';
end;
{****************************************************************************}
procedure ahorcado(ori:arreglo;var jug:arreglo);
var
   cont:integer;
   ganar,acierto:boolean;
   letra:char;
begin
   inicializar(jug);
   cont:=5;
   ganar:=false;
   writeln('TENES UN TOTAL DE: ',cont,' POSIBILIDADES');
   while ((cont>0)and(not ganar)) do
      begin
         writeln('ARRIESGA LETRA');
         readln(letra);
         imp(ori,jug,letra,acierto);
         writeln;
         if acierto then
            if not iguales(ori,jug) then
               begin
                  writeln('BUENA ELECCION, QUERES ARRIESGAR? S/N');
                  readln(letra);
                  if upcase(letra)='S' then
                     arriesgar(ori,jug,ganar,cont)
                  else
                     writeln('CAGON...');
               end
            else
               ganar:=true
         else
            begin
               writeln('NO, NO PERTENECE LA ',letra);
               cont:=cont-1;
               if cont<>0 then
                  writeln('TE QUEDAN ',cont,' POSIBILIDADES');
            end;
      end;
   if ganar then
      writeln('GANASTE!!!, TODAVIA TENIAS ',cont,' POSIBILIDADES')
   else
      writeln('NO!!!, PERDISTE, INTENTA DE NUEVO');
end;
{****************************************************************************}
procedure pasar_arr(mat:tabla;var arr:arreglo;fila:integer);
var
   c:integer;
begin
   c:=1;
   while c<=maxcol do
      begin
         arr[c]:=mat[fila,c];
         c:=c+1;
      end;
end;
{****************************************************************************}
procedure jugar(mat:tabla;var arr:arreglo);
var
   res:char;
   num:integer;
   jugador:arreglo;
begin
   writeln('QUIERE JUGAR AL AHORCADO? S/N');
   readln;
   readln(res);
   while upcase(res)='S' do
      begin
         writeln('INTRODUSCA NRO DE PALABRA A JUGAR DEL 1 AL ',maxfila);
         readln(num);
         pasar_arr(mat,arr,num);
         ahorcado(arr,jugador);
         writeln('--------------------------------------');
         writeln('SI QUIERE VOLVER A JUGAR PRESIONE ''S''');
         readln;
         readln(res);
      end;
   writeln('FIN PROGRAMA...');
   readln;
end;
{****************************************************************************}
procedure imp_mat(mat:tabla);
var
   f,c:integer;
begin
   writeln;
   for f:=1 to maxfila do
      begin
      for c:=1 to maxcol do
         write(mat[f,c]);
      writeln;
      end;
end;
{****************************************************************************}
procedure cargar_mat(var mat:tabla);
var
   f,c:integer;
begin
   f:=1;
   c:=1;
   writeln('CARGAR MATRIZ CON ',maxfila,' PALABRAS DE ',maxcol,' LETRAS');
   while f<= maxfila do
      begin
         while c<= maxcol do
            begin
               read(mat[f,c]);
               c:=c+1;
            end;
         f:=f+1;
         c:=1;
      end;
end;
{****************************************************************************}
var
   archivo:tabla;
   palabra:arreglo;
begin
   cargar_mat(archivo);
   imp_mat(archivo);
   jugar(archivo,palabra);
end.