#include<stdio.h>
#include<alloc.h>
#include<conio.h>
#define memoria (struct arbol*) malloc(sizeof(struct arbol));
struct arbol{
   char dato;
   arbol*dcha;
   arbol*ida;
}*p=NULL;
struct arbol* insertar(struct arbol*pto,char letra){
   if(pto)
      if(pto->dato<=letra)
	 pto->dcha=insertar(pto->dcha,letra);
      else
	 pto->ida=insertar(pto->ida,letra);
   else{
      pto=memoria;
      pto->dato=letra;
      pto->dcha=NULL;
      pto->ida=NULL;
   }
   return(pto);
}
void imprimir(struct arbol*pa){
   if(pa){
      printf("raiz %c",pa->dato);
      imprimir(pa->ida);
      imprimir(pa->dcha);
   }
}
void main(){
   clrscr();
   char res;
   /*p=memoria;*/
   /*if(p)
      printf("tiene algo");
   else
      printf("es NULL");*/
   printf("QUIERE CARGAR UN DATO EN EL ARBOL S/N\n");
   res=getchar();
   getchar();
   if(res=='s')
      while(res=='s'){
	 printf("introdusca dato:\n");
	 res=getchar();
	 getchar();
	 p=insertar(p,res);
	 printf("quiere seguir ingresando s/n\n");
	 res=getchar();
	 getchar();
	 if(res!='s')
	    printf("FIN PROGRAMA\n");
      }
   else
      printf("FIN PROGRAMA\n");
   /*if(p){
      printf("dato%c\n",p->dato);
      if(!p->ida&&!p->dcha)
	 printf("son NULL\n");
   }
   else
      printf("FALLA");*/
   imprimir(p);
   getchar();
}
