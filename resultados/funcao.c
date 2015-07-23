




























/*Compilador FOCA*/
#include <iostream> 
#include <string.h> 
#include <stdio.h>
using namespace std;

	void funcao_temp2();// nivel/numero2/0 assinatura funcao
	void funcao_temp0();// nivel/numero1/0 assinatura funcao
	void funcao_temp1();// nivel/numero1/1 assinatura funcao2
	void funcao_temp3();// nivel/numero1/2 assinatura funcao3

// Escopo: 0 do nivel: 2
	int _temp_3;  // nivel_escopo:2  __TEMP__
	int _temp_4;  // nivel_escopo:2  __TEMP__
	int _temp_5;  // nivel_escopo:2  __TEMP__
	int _temp_6;  // nivel_escopo:2  a

// Escopo: 0 do nivel: 1
	int _temp_0;  // nivel_escopo:1  __TEMP__
	int _temp_1;  // nivel_escopo:1  __TEMP__

// Escopo: 1 do nivel: 1

// Escopo: 2 do nivel: 1
	int _temp_9;  // nivel_escopo:1  a
	int _temp_10;  // nivel_escopo:1  d
	int _temp_11;  // nivel_escopo:1  __TEMP__
	int _temp_12;  // nivel_escopo:1  __TEMP__

// Escopo: 0 do nivel: 0
	int _temp_2;  // nivel_escopo:0  a
	int _temp_7;  // nivel_escopo:0  __TEMP__
	int _temp_8;  // nivel_escopo:0  __TEMP__
	int _temp_9;  // nivel_escopo:0  __TEMP__
	int _temp_10;  // nivel_escopo:0  __TEMP__
	int _temp_13;  // nivel_escopo:0  __TEMP__
	int _temp_14;  // nivel_escopo:0  __TEMP__
#define true 1 
#define false 0 
int main(void)
{



	funcao_temp0();
	_temp_2 = _temp_0;
	funcao_temp1();
	funcao_temp0();
	_temp_7 = _temp_6 + _temp_0;
	_temp_8 = _temp_2 + _temp_6;
	_temp_2 = _temp_8;
	_temp_13 = 4;
	_temp_14 = 3;
	_temp_9 = _temp_13;
	_temp_10 = _temp_14;
	funcao_temp3();
	_temp_2 = _temp_11;



	return 0;
}
void funcao_temp2()
{
	_temp_3 = 4;
	_temp_4 = 5;
	_temp_5 = _temp_3 + _temp_4;
	_temp_6 = _temp_5;

}
void funcao_temp0()
{
	_temp_0 = 4;
	_temp_1 = 2;

}
void funcao_temp1()
{
	funcao_temp2();

}
void funcao_temp3()
{
	_temp_12 = 4;
	_temp_9 = _temp_12;
	_temp_11 = _temp_9;

}
