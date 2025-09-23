#include "cosa.h"
#include<stdio.h>
cosa<int> mia;
template<class t>
cosa<t>::cosa(){
  printf("CREANDO COSA\n");
	dato=0;
}
template<class t>
cosa<t>::~cosa(){
printf("DESTRUYENDO COSA\n");
	 dato=0;
}
template<class t>
void cosa<t>::agregar(t e){
printf("A COSA SE LE AGREGA %d \n",e);
	dato=e;
}
template<class t>
t cosa<t>::ver(){
printf("MUESTRA LO QUE TIENE COSA \n");
	return (dato);
}
