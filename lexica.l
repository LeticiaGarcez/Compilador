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


"main"							{ return TK_MAIN;}
"if"							{ return TK_IF; }
"else" 							{ return TK_ELSE; }
"int" 							{ yylval.label = "int"; return TK_TIPO_INT; }
"float" 						{ yylval.label = "float"; return TK_TIPO_FLOAT;}
"string"						{ yylval.label = "string"; return TK_TIPO_STRING; }
"char"       					{ yylval.label = "char"; return TK_TIPO_CHAR;}
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

{NUM}		{ yylval.traducao = yytext; yylval.label = "int"; return TK_NUM; }
{REAL}		{ yylval.traducao = yytext; yylval.label = "float"; return TK_REAL; }

{CHAR}		{ yylval.traducao = yytext; yylval.label = "char"; return TK_CHAR; }

{ID}		{ yylval.label = yytext; return TK_ID; }

.			{ *yytext; }

%%
