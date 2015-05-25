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


"main"							{ return TK_MAIN;}
"if"							{ return TK_IF; }
"else" 							{ return TK_ELSE; }
"int" 							{ yylval.tipo = "int"; return TK_TIPO_INT; }
"float" 						{ yylval.tipo = "float"; return TK_TIPO_FLOAT;}
"string"						{ yylval.tipo = "string"; return TK_TIPO_STRING; }
"char"       					{ yylval.tipo = "char"; return TK_TIPO_CHAR;}
"bool"       					{ yylval.tipo = "int"; return TK_TIPO_BOOL;}
"while" 						{ return TK_WHILE; }
"for" 							{ return TK_FOR; }
"switch" 						{ return TK_SWITCH; }
"case" 							{ return TK_CASE; }

"var"							{return TK_VAR;}

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

{NUM}		{ yylval.tipo = "int"; yylval.traducao = yytext; return TK_NUM; }
{REAL}		{ yylval.tipo = "float"; yylval.traducao = yytext; return TK_REAL; }
{BOOL}		{ yylval.tipo = "int"; yylval.traducao = yytext; return TK_BOOL; }
{CHAR}		{ yylval.tipo = "char";yylval.traducao = yytext; return TK_CHAR; }

{ID}		{ yylval.label = yytext; return TK_ID; }

.			{ *yytext; }

%%
