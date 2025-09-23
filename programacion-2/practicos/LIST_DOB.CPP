#include<stdio.h>
#include<conio.h>
#include<alloc.h>
#define memoria (struct lista*) malloc(sizeof(struct lista))
struct lista{
    char dato;
    struct lista*psig;
    struct lista*pant;
}*p;
struct lista* insertar(struct lista*p,struct lista*otro){
   if(!p)
      p=otro;
   else if(!p->psig){
      otro->pant=p;
      p->psig=otro;
      }
      else
	 p->psig=insertar(p->psig,otro);
   return(p);
}
void imprimir(struct lista*punt){
   if(punt){
     printf("DATO:%c ",punt->dato);
     if(punt->pant)
	printf(" ATRAS(%c)\n",punt->pant->dato);
     else
	printf("ATRAS NO HAY NADA\n");
     imprimir(punt->psig);
   }
   else
      printf("NULL...\n");
}
void main(){
   char res;
   struct lista*nuevo;
   clrscr();
   p=NULL;
   printf("QUIERE INGRESAR DATOS A UNA LISTA DOBLEMENTE ENLAZADA? S/N: ");
   res=getchar();
   getchar();
   if(res=='s'||res=='S')
      while(res=='s'||res=='S'){
	 nuevo=memoria;
	 nuevo->psig=NULL;
	 nuevo->pant=NULL;
	 printf("INGRESE CARACTER:\n");
	 nuevo->dato=getchar();
	 getchar();
	 p=insertar(p,nuevo);
	 printf("QUIERE SEGUIR INGRESANDO DATOS? S/N: ");
	 res=getchar();
	 getchar();
      }
   printf("FIN DE INGRESO\n");
   printf(" IMPRESION DE LISTA\n");
   imprimir(p);
   getchar();
}
