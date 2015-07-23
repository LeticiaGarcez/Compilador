





/*Compilador FOCA*/
#include <iostream> 
#include <string.h> 
#include <stdio.h>
using namespace std;


// Escopo: 0 do nivel: 1
	int _temp_4;  // nivel_escopo:1  __TEMP__
	int _temp_5;  // nivel_escopo:1  i
	int _temp_6;  // nivel_escopo:1  __TEMP__
	int _temp_7;  // nivel_escopo:1  __TEMP__
	int _temp_8;  // nivel_escopo:1  __TEMP__
	int _temp_9;  // nivel_escopo:1  __TEMP__
	int _temp_10;  // nivel_escopo:1  __TEMP__
	int _temp_11;  // nivel_escopo:1  __TEMP__
	int _temp_12;  // nivel_escopo:1  __TEMP__

// Escopo: 0 do nivel: 0
	int _temp_0;  // nivel_escopo:0  __TEMP__
	int _temp_1;  // nivel_escopo:0  __TEMP__
	int _temp_2;  // nivel_escopo:0  __TEMP__
	//int _temp_3;  // nivel_escopo:0  c
#define true 1 
#define false 0 
int main(void)
{



	_temp_0 = 4;
	_temp_1 = 4;
	_temp_2 = _temp_0 * _temp_1;
	int _temp_3[_temp_2];
	_temp_4 = 0;
	_temp_5 = _temp_4;

_LabelInicio_1:
	_temp_6 = 2;
	_temp_7 = _temp_5 < _temp_6;

	if (!(_temp_7)) goto _LabelFinal_1;
	_temp_8 = _temp_1 * _temp_5;
	_temp_9 = 2;
	_temp_10 = _temp_8 + _temp_9;
	_temp_12 = 4;
	_temp_3[_temp_10] = i;

	_temp_5 = _temp_5+ 1;

	 goto _LabelInicio_1;
_LabelFinal_1:




	return 0;
}
