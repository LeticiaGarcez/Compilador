













/*Compilador FOCA*/
#include <iostream> 
#include <string.h> 
#include <stdio.h>
using namespace std;


// Escopo: 0 do nivel: 1
	int _temp_0;  // nivel_escopo:1  __TEMP__
	int _temp_1;  // nivel_escopo:1  __TEMP__
	int _temp_2;  // nivel_escopo:1  a

// Escopo: 1 do nivel: 1
	int _temp_3;  // nivel_escopo:1  __TEMP__
	int _temp_4;  // nivel_escopo:1  __TEMP__
	int _temp_5;  // nivel_escopo:1  d

// Escopo: 2 do nivel: 1
	int _temp_6;  // nivel_escopo:1  __TEMP__
	int _temp_7;  // nivel_escopo:1  __TEMP__
	int _temp_8;  // nivel_escopo:1  __TEMP__
	int _temp_9;  // nivel_escopo:1  __TEMP__
	int _temp_10;  // nivel_escopo:1  d

// Escopo: 3 do nivel: 1
	int _temp_11;  // nivel_escopo:1  __TEMP__
	int _temp_12;  // nivel_escopo:1  d

// Escopo: 0 do nivel: 0
#define true 1 
#define false 0 
int main(void)
{



	_temp_0 = true;

	if (!(_temp_0)) goto _LabelFinal_1;
	_temp_1 = 4;
	_temp_2 = _temp_1;


	 goto _label_fim_condicoes_0;

_LabelFinal_1:
	_temp_3 = false;

	if (!(_temp_3)) goto _LabelFinal_2;
	_temp_4 = 4;
	_temp_5 = _temp_4;


	 goto _label_fim_condicoes_0;

_LabelFinal_2:

	_temp_6 = 4;
	_temp_7 = 5;
	_temp_8 = _temp_6 == _temp_7;

	if (!(_temp_8)) goto _LabelFinal_3;
	_temp_9 = 4;
	_temp_10 = _temp_9;


	 goto _label_fim_condicoes_0;

_LabelFinal_3:


	_temp_11 = 5;
	_temp_12 = _temp_11;


_label_fim_condicoes_0:




	return 0;
}
