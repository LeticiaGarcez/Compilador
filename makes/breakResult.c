




/*Compilador FOCA*/
#include <iostream> 
#include <string.h> 
#include <stdio.h>
using namespace std;


// Escopo: 0 do nivel: 1
	int _temp_0;  // nivel_escopo:1  __TEMP__
	int _temp_1;  // nivel_escopo:1  __TEMP__
	int _temp_2;  // nivel_escopo:1  ola

// Escopo: 0 do nivel: 0
#define true 1 
#define false 0 
int main(void)
{




_LabelInicio_1:
	_temp_0 = true;

	if (!(_temp_0)) goto _LabelFinal_1;
	_temp_1 = 4;
	_temp_2 = _temp_1;
	goto _LabelFinal_1;

	 goto _LabelInicio_1;
_LabelFinal_1:




	return 0;
}
