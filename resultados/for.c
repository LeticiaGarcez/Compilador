




















/*Compilador FOCA*/
#include <iostream> 
#include <string.h> 
#include <stdio.h>
using namespace std;


// Escopo: 0 do nivel: 2
	int _temp_13;  // nivel_escopo:2  __TEMP__

// Escopo: 0 do nivel: 1
	int _temp_2;  // nivel_escopo:1  __TEMP__
	int _temp_3;  // nivel_escopo:1  __TEMP__
	int _temp_4;  // nivel_escopo:1  __TEMP__

// Escopo: 1 do nivel: 1
	int _temp_5;  // nivel_escopo:1  __TEMP__
	int _temp_6;  // nivel_escopo:1  a
	int _temp_7;  // nivel_escopo:1  __TEMP__
	int _temp_8;  // nivel_escopo:1  __TEMP__
	char _temp_9[3];  // nivel_escopo:1  __TEMP__

// Escopo: 2 do nivel: 1
	int _temp_10;  // nivel_escopo:1  __TEMP__
	int _temp_11;  // nivel_escopo:1  __TEMP__

// Escopo: 3 do nivel: 1
	int _temp_12;  // nivel_escopo:1  __TEMP__

// Escopo: 4 do nivel: 1
	int _temp_14;  // nivel_escopo:1  __TEMP__

// Escopo: 0 do nivel: 0
	int _temp_0;  // nivel_escopo:0  __TEMP__
	int _temp_1;  // nivel_escopo:0  a
#define true 1 
#define false 0 
int main(void)
{



	_temp_0 = 4;
	_temp_1 = _temp_0;

_LabelInicio_1:
	_temp_2 = 4;
	_temp_3 = _temp_1 == _temp_2;

	if (!(_temp_3)) goto _LabelFinal_1;
	_temp_4 = 3;
	_temp_1 = _temp_4;

	 goto _LabelInicio_1;
_LabelFinal_1:

	_temp_5 = 0;
	_temp_6 = _temp_5;

_LabelInicio_2:
	_temp_7 = 3;
	_temp_8 = _temp_6 < _temp_7;

	if (!(_temp_8)) goto _LabelFinal_2;
	 strcpy(_temp_9,"ola");
	 cout <<_temp_9 ;

	_temp_6 = _temp_6+ 1;

	 goto _LabelInicio_2;
_LabelFinal_2:


_LabelInicio_3:
	_temp_10 = 4;
	_temp_11 = _temp_1 == _temp_10;

	if (!(_temp_11)) goto _LabelFinal_3;
	goto _LabelFinal_3;

	 goto _LabelInicio_3;
_LabelFinal_3:


_LabelInicio_4:
	_temp_12 = true;

	if (!(_temp_12)) goto _LabelFinal_4;
	_temp_13 = true;

	if (!(_temp_13)) goto _LabelFinal_5;
	goto _LabelFinal_4;


_LabelFinal_5:
	 goto _LabelInicio_4;
_LabelFinal_4:


_LabelInicio_6:
	_temp_14 = true;

	if (!(_temp_14)) goto _LabelFinal_6;
	goto _LabelInicio_6;

	 goto _LabelInicio_6;
_LabelFinal_6:




	return 0;
}
