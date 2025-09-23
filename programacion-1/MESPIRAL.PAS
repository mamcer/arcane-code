program main(matprod);
const
   maxfila=3;
   maxcol=4;
type
   mat=array[1..maxfila,1..maxcol]of integer;
{****************************************************************************}
procedure imprimir(m:mat);
var
   f,c:integer;
begin
   for f:=1 to maxfila do
      begin
        for c:=1 to maxcol do
           write(m[f,c],' ');
        writeln;
      end;
end;
{****************************************************************************}
function ordenada(m:mat):boolean;
var
   f,c,cont:integer;
   ord,cambio:boolean;
begin
   f:=1;
   c:=1;
   cont:=0;
   ord:=true;
   cambio:=true;
   while((ord)and(cambio))do
      begin
         cambio:=false;
         while f< maxfila-cont do
            begin
               cambio:=true;
               if m[f,c]>m[f+1,c] then
                  ord:=false;
               f:=f+1;
            end;
         while((ord)and(c<maxcol-cont))do
            begin
               cambio:=true;
               if m[f,c]>m[f,c+1] then
                  ord:=false;
               c:=c+1;
            end;
         while((ord)and(f>1+cont))do
            begin
               cambio:=true;
               if m[f,c]>m[f-1,c] then
                  ord:=false;
               f:=f-1;
            end;
         cont:=cont+1;
         while((ord)and(c>1+cont))do
            begin
               cambio:=true;
               if m[f,c]>m[f,c-1] then
                 ord:=false;
               c:=c-1;
            end;
      end;
   ordenada:=ord;
end;
{****************************************************************************}
procedure cargar(var m:mat);
var
   f,c:integer;
begin
   f:=1;
   c:=1;
   writeln('CARGAR MATRIZ DE: ',maxfila,' POR ',maxcol,' ENTEROS');
   writeln('INTRODUCI: ',maxfila*maxcol,' ENTEROS');
   while f<= maxfila do
      begin
         while c<= maxcol do
            begin
               read(m[f,c]);
               c:=c+1;
            end;
         inc(f);
         c:=1;
      end;
   readln;
end;
{****************************************************************************}
var
   matra:mat;
begin
   cargar(matra);
   writeln;
   imprimir(matra);
   if ordenada(matra) then
      writeln('ESTA ORDENADA EN ESPIRAL')
   else
      writeln('NO ESTA ORDENADA EN FORMA ESPIRAL');
   writeln('FIN PROGRAMA...');
   readln;
end.