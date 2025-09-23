program main (nreinas);
const
   maximo=22;
type
   cuadro=array[1..maximo,1..maximo]of char;
{****************************************************************************}
procedure imprimir_tab(mat:cuadro;n:integer);
var
   f,c:integer;
begin
   for f:=1 to n do
      begin
      writeln;
      for c:=1 to n do
         write(mat[f,c],' ');
      end;
   writeln;
end;
{****************************************************************************}
procedure inic_tab(var tab:cuadro;n:integer);
var
   f,c:integer;
begin
   f:=1;
   c:=1;
   while f<=n do
      begin
         while c<=n do
            begin
               if ((c=1)and(f=2))then
                  tab[f,c]:='R'
               else
                  tab[f,c]:='.';
               c:=c+1;
            end;
         f:=f+1;
         c:=1;
      end;
end;

{****************************************************************************}
procedure n_reinas(var mat:cuadro;nro:integer);
var
   f,c:integer;
begin
   f:=2;
   c:=1;
   inic_tab(mat,nro);
   while c<nro do
      begin
        c:=c+1;
        f:=f+2;
        if f> nro then f:=1;
        mat[f,c]:='R';
      end;
end;
{****************************************************************************}
var
   tablero:cuadro;
   numero:integer;
begin
   writeln('INTRODUSCA DIMENCION DEL TABLERO, MAYOR A 0 Y NO MAYOR A ',maximo);
   read(numero);
   if ((numero>0)and(numero<=maximo)) then
      begin
         n_reinas(tablero,numero);
         imprimir_tab(tablero,numero);
         writeln('NINGUNA REINA PUEDE ATACAR A OTRA');
      end;
   writeln;
   writeln('FIN PROGRAMA...');
   readln;
   readln;
end.
