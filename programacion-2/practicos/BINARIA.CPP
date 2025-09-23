#include <stdio.h>
#include <iostream.h>
#include <conio.h>
const max=10;
int binaria(int a[],int inic,int fin,int elem){
	int n=(inic+fin)/2;
	if(inic<=fin)
		if(a[n]!=elem)
			if(a[n]<elem)
				return(binaria(a,n+1,fin,elem));
			else
				return(binaria(a,inic,n-1,elem));
		else
			return(1);
	else
		return(0);
}
void cargar(int a[],int n){
	int s;
	cout<<"INGRESE "<<n<<" NUMEROS ENTEROS\n";
	for(int i=0;i<n;i++){
		cin>>a[i];
	}
}
void cambio(int& a,int& b){
	int c=a;
	a=b;
	b=c;
}
void ordenar(int a[],int tope){
	int ordenado=tope;
	if(ordenado<max){
		while((tope>0)&&(a[tope-1]>a[tope])){
			cambio(a[tope-1],a[tope]);
			tope-=1;
		}
		ordenar(a,ordenado+1);
	}
	else
		cout<<"FIN ORDENADO";
}
void main(){
	 clrscr();
	 int arreglo[max];
		 int nro;
	 cargar(arreglo,max);
	 ordenar(arreglo,1);
	 for(int i=0;i<max;i++)
		 cout<<"-"<<arreglo[i];
	 cout<<"\nINGRESE NUMERO ENTERO A BUSCAR \n";
	 cin>>nro;
	 if(binaria(arreglo,0,max-1,nro))
		  cout<<"ESTA\n";
	 else
		 cout<<"NO ESTA\n";
	 cout<<"FIN PROGRAMA...";
	 getchar();
}
