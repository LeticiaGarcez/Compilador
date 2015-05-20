%{
#include <string>

%}

ESPACO [ \t]
DIGITO [0-9]
LETRA [A-Za-z_]

DELIM {ESPACO}+
NUM {DIGITO}+
REAL {NUM}+("."{NUM}+)?
CHAR \'({LETRA}|{NUM})\'
ID {LETRA}({LETRA}|{NUM})*

%%

"\n"		{}


"main"							{ return TK_MAIN;}
"if"							{ return TK_IF; }
"else" 							{ return TK_ELSE; }
"int" 							{ return TK_TIPO_INT; }
"float" 						{ return TK_TIPO_STRING;}
"string"						{ return TK_TIPO_FLOAT; }
"char"       {return TK_TIPO_CHAR;}
"while" 						{ return TK_WHILE; }
"for" 							{ return TK_FOR; }
"switch" 						{ return TK_SWITCH; }
"case" 							{ return TK_CASE; }
 							
[=] 							{ return TK_ATRIB;}
[<] 							{ return TK_MENOR;}
[>] 							{ return TK_MAIOR;}
"=!"							{ return TK_DIFERENTE; }
"=="							{ return TK_IGUAL; }
"and" 							{ return TK_AND;}
"or" 							{ return TK_OR;}




{DELIM} 	{}


[(){}[\];,]	{ return *yytext; }
[+\-*/]		{ return *yytext; }

{NUM}		{ yylval.traducao = yytext; return TK_NUM; }
{ID}		{ yylval.label = yytext; return TK_ID; }

.			{ *yytext; }

%%
