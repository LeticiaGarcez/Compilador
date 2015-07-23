








/*Compilador FOCA*/
#include <iostream> 
#include <string.h> 
#include <stdio.h>
using namespace std;


// Escopo: 0 do nivel: 1
	int _temp_0;  // nivel_escopo:1  __TEMP__
	int _temp_1;  // nivel_escopo:1  a
	int _temp_2;  // nivel_escopo:1  __TEMP__

// Escopo: 1 do nivel: 1
	int _temp_3;  // nivel_escopo:1  __TEMP__
	int _temp_4;  // nivel_escopo:1  __TEMP__
	int _temp_5;  // nivel_escopo:1  __TEMP__
	int _temp_6;  // nivel_escopo:1  __TEMP__
	int _temp_7;  // nivel_escopo:1  __TEMP__
	int _temp_8;  // nivel_escopo:1  __TEMP__
	int _temp_9;  // nivel_escopo:1  a

// Escopo: 0 do nivel: 0
#define true 1 
#define false 0 
int main(void)
{




_LabelInicio_1:

	_temp_0 = 4;
	_temp_1 = _temp_0;

	_temp_2 = true;

	if (_temp_2) goto _LabelInicio_1;

_LabelInicio_2:
	_temp_3 = false;
	_temp_4 = false;
	_temp_5 = true;
	_temp_6 = _temp_4 and _temp_5;
	_temp_7 = _temp_3 and _temp_6;

	if (!(_temp_7)) goto _LabelFinal_2;
	_temp_8 = 4;
	_temp_9 = _temp_8;

	 goto _LabelInicio_2;
_LabelFinal_2:




	return 0;
}
