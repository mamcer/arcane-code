#include "cosa.h"
#include<stdio.h>
#include<conio.h>
#include<iostream.h>
void main(){
	clrscr();
	int nro,n;
	cosa<int> mia;
	mia.agregar(7);
	nro=mia.ver();
	printf("LA COSA TIENE: %d",nro);
	getchar();
	clrscr();
}