
















/*Compilador FOCA*/
#include <iostream> 
#include <string.h> 
#include <stdio.h>
using namespace std;


// Escopo: 0 do nivel: 1
	int _temp_9;  // nivel_escopo:1  __TEMP__

// Escopo: 1 do nivel: 1
	int _temp_11;  // nivel_escopo:1  __TEMP__

// Escopo: 2 do nivel: 1
	int _temp_12;  // nivel_escopo:1  __TEMP__

// Escopo: 0 do nivel: 0
	int _temp_0;  // nivel_escopo:0  __TEMP__
	int _temp_1;  // nivel_escopo:0  b
	int _temp_2;  // nivel_escopo:0  __TEMP__
	int _temp_3;  // nivel_escopo:0  __TEMP__
	int _temp_4;  // nivel_escopo:0  __TEMP__
	int _temp_5;  // nivel_escopo:0  __TEMP__
	int _temp_6;  // nivel_escopo:0  __TEMP__
	int _temp_7;  // nivel_escopo:0  __TEMP__
	int _temp_8;  // nivel_escopo:0  __TEMP__
	int _temp_10;  // nivel_escopo:0  __TEMP__
#define true 1 
#define false 0 
int main(void)
{



	_temp_0 = 3;
	_temp_1 = _temp_0;
	_temp_2 = 5;
	_temp_3 = 1;
	_temp_4 = _temp_2 - _temp_3;
	_temp_5 = _temp_1 + _temp_4;
	_temp_6 = 34;
	_temp_7 = 1;
	_temp_8 = _temp_6 + _temp_7;

	if (_temp_5!=_temp_8) goto _LabelFinal_1;
	_temp_9 = 4;
	_temp_1 = _temp_9;


	 goto _label_fim_condicoes_0;

_LabelFinal_1:

	_temp_10 = 4;

	if (_temp_5!=_temp_10) goto _LabelFinal_2;
	_temp_11 = 5;
	_temp_1 = _temp_11;


	 goto _label_fim_condicoes_0;

_LabelFinal_2:


	_temp_12 = 5;
	_temp_1 = _temp_12;

_label_fim_condicoes_0:



	return 0;
}
