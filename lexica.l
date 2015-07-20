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
STRING \"(\\.|[^"])*\"

ID {LETRA}({LETRA}|{NUM})*
BOOL "true"|"false"



%%

"switch" 						{return TK_SWITCH; }
"case" 							{return TK_CASE; }
"defaut"						{return TK_DEFAUT; }

"main"							{return TK_MAIN;}

"int" 							{yylval.tipo = "int"; yylval.tipoReal = "int";  return TK_TIPO_INT; }
"float" 						{yylval.tipo = "float"; yylval.tipoReal = "float";  return TK_TIPO_FLOAT;}
"char"       					{yylval.tipo = "char"; yylval.tipoReal = "char";  return TK_TIPO_CHAR;}
"string"						{yylval.tipo = "char"; yylval.tipoReal = "string";  return TK_TIPO_STRING; }
"bool"       					{yylval.tipo = "int"; yylval.tipoReal = "bool";  return TK_TIPO_BOOL;}

"while" 						{return TK_WHILE; }
"for" 							{return TK_FOR; }
"do"							{return TK_DO; }
"continue"						{return TK_CONTINUE; }
"break"							{return TK_BREAK; }

"if"							{return TK_IF; }
"else" 							{return TK_ELSE; }
"elif"							{return TK_ELIF; }

"func"							{return TK_FUNC;}
"->"							{return TK_RETORNA;}
"return"						{return TK_RETURN;}

"var"							{return TK_VAR;}
"global"						{return TK_GLOBAL;}

"read"							{return TK_READ;}
"write"							{return TK_WRITE;}

"super"							{return TK_SUPER;}

[=] 							{return TK_ATRIB;}

[<] 							{yylval.traducao = yytext; return TK_MENOR;}
[>] 							{yylval.traducao = yytext; return TK_MAIOR;}
"=!"							{yylval.traducao = yytext; return TK_DIFERENTE; }
"=="							{yylval.traducao = yytext; return TK_IGUAL; }

"and" 							{yylval.traducao = yytext; return TK_AND;}
"or" 							{yylval.traducao = yytext; return TK_OR;}


[+] 							{yylval.traducao = yytext; return TK_MAIS;}
[-] 							{yylval.traducao = yytext; return TK_MENOS;}
[*] 							{yylval.traducao = yytext; return TK_MULT;}
[/] 							{yylval.traducao = yytext; return TK_RAZAO;}

"\.\."							{ yylval.traducao = yytext;return TK_CONCAT;}

[{]								{return TK_ABRE; }
[}]								{return TK_FECHA; }




{DELIM} 	{}


[(){}[\];,]	{return *yytext; }
[+\-*/]		{return *yytext; }

{NUM}		{yylval.traducao = yytext; yylval.tipo = "int"; yylval.tipoReal = "int"; return TK_NUM; }
{REAL}		{yylval.traducao = yytext; yylval.tipo = "float"; yylval.tipoReal = "float"; return TK_REAL; }
{CHAR}		{yylval.traducao = yytext; yylval.tipo = "char"; yylval.tipoReal = "char"; return TK_CHAR; }
{BOOL}		{yylval.traducao = yytext; yylval.tipo = "int"; yylval.tipoReal = "bool"; return TK_BOOL; } 
{STRING} 	{yylval.traducao = yytext; yylval.tipo = "char"; yylval.tipoReal = "string"; return TK_STR; }
{ID}		{yylval.label = yytext; return TK_ID; }



.			{*yytext; }

%%
