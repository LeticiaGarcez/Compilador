%{
#define MAIN	300
#define O	301
#define H	302
#define F	303
#define B	304
#define X	399
#define ANY 400

%}

%%

main							{ return MAIN; }
[(]								{ printf("achei ( \n"); }
[)]								{ printf("achei ) \n"); }
[0-9]*	 						{ printf("achei numero \n"); }
[{]								{ printf("achei { \n"); }
[}]								{ printf("achei } \n"); }
if								{ printf("achei if \n"); }
else							{ printf("achei else \n"); }
int								{ printf("achei declaracao int \n"); }
string							{ printf("achei declaracao string \n"); }
[=]								{ printf("achei atr \n");}
[==]							{ printf("achei comparacao \n");}
[<]								{ printf("achei menor \n");}
[>]								{ printf("achei maior \n");}
and								{ printf("achei and \n");}
or								{ printf("achei or \n");}
not								{ printf("achei not \n");}
[\n]							{ printf("achei barra ENE \n"); }
[*]								{ printf("achei * \n"); }
[+]								{ printf("achei + \n"); }
[-]								{ printf("achei - \n"); }
[/]								{ printf("achei / \n"); }
[<--]							{ printf("achei abrir comentario \n"); }
[-->]							{ printf("achei fechar comentario \n"); }
[+]								{ printf("achei + \n"); }
[a-zA-Z]+						{ printf("achei Uma string \n");}
[ \t]							{ return;} //ignore
.								{ return ANY; }
<<EOF>>							{ return X; }

%%

int main(int argc, char *argv[])
{
	FILE *f_in;
	int tipoToken;
	int totalDec = 0,
		totalOct = 0,
		totalHex = 0,
		totalFlt = 0;

	if(argc == 2)
	{
		if(f_in == fopen(argv[1], "r"))
		{
			yyin = f_in;
		}
		else
		{
			perror(argv[0]);
		}
	}
	else
	{
		yyin = stdin;
	}

	while((tipoToken = yylex()) != X)
	{
		switch (tipoToken)
		{
			case MAIN:
				printf("Encontrei main \n");;
				break;
			case O:
				++totalOct;
				break;
			case H:
				++totalHex;
				break;
			case F:
				++totalFlt;
				break;
			case ANY:
				printf("ACHEI ANY \n");
				break;

		}
	}
}