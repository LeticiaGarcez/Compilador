






/*Compilador FOCA*/
#include <iostream> 
#include <string.h> 
#include <stdio.h>
using namespace std;


// Escopo: 0 do nivel: 1
	int _temp_2;  // nivel_escopo:1  __TEMP__
	int _temp_3;  // nivel_escopo:1  __TEMP__
	int _temp_4;  // nivel_escopo:1  __TEMP__

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

	 cout <<_temp_1 ;



	return 0;
}
