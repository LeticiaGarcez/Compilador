%{
#include <string>

%}


ESPACO [ \t]
DIGITO [0-9]
LETRA [A-Za-z_]



DELIM {ESPACO}+
NUM {DIGITO}+
REAL {NUM}+("."{NUM}+)?
CHAR \'.\'
ID {LETRA}({LETRA}|{NUM})*
BOOL "true"|"false"


%%


"main"							{return TK_MAIN;}
"if"							{return TK_IF; }
"else" 							{return TK_ELSE; }
"int" 							{yylval.label = "int"; return TK_TIPO_INT; }
"float" 						{yylval.label = "float"; return TK_TIPO_FLOAT;}
"string"						{yylval.label = "string"; return TK_TIPO_STRING; }
"char"       					{yylval.label = "char"; return TK_TIPO_CHAR;}
"bool"       					{yylval.tipo = "int"; return TK_TIPO_BOOL;}
"while" 						{return TK_WHILE; }
"for" 							{return TK_FOR; }
"switch" 						{return TK_SWITCH; }
"case" 							{return TK_CASE; }

"var"							{return TK_VAR;}

[=] 							{return TK_ATRIB;}
[<] 							{yylval.traducao = yytext; return TK_MENOR;}
[>] 							{yylval.traducao = yytext; return TK_MAIOR;}

[+] 							{yylval.traducao = yytext; return TK_MAIS;}
[-] 							{yylval.traducao = yytext; return TK_MENOS;}
[*] 							{yylval.traducao = yytext; return TK_MULT;}
[/] 							{yylval.traducao = yytext; return TK_RAZAO;}

"=!"							{yylval.traducao = yytext; return TK_DIFERENTE; }
"=="							{yylval.traducao = yytext; return TK_IGUAL; }

"and" 							{yylval.traducao = yytext; return TK_AND;}
"or" 							{yylval.traducao = yytext; return TK_OR;}




{DELIM} 	{}


[(){}[\];,]	{return *yytext; }
[+\-*/]		{return *yytext; }

{NUM}		{yylval.traducao = yytext; yylval.tipo = "int"; return TK_NUM; }
{REAL}		{yylval.traducao = yytext; yylval.tipo = "float"; return TK_REAL; }
{CHAR}		{yylval.traducao = yytext; yylval.tipo = "char"; return TK_CHAR; }
{BOOL}		{ yylval.tipo = "int"; yylval.traducao = yytext; return TK_BOOL; } 
{ID}		{yylval.label = yytext; return TK_ID; }



.			{*yytext; }

%%
