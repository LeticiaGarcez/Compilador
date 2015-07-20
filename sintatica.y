%{
#include <iostream>
#include <string>
#include <sstream>
#include <vector>
#include <utility>
#define YYSTYPE atributos
using namespace std;
struct variavel
{
	string temp_name;
	string orig_name;
	string tipo;
	string tipoReal;
	bool isVet;
	//Usado em string
	int tamanho;
	//Usado para Vetor
	vector<string> colTamanhosLabels;
};
struct funcao
{
	vector<variavel> parametros;
	vector<variavel> retornos;
	string traducao;
	string assinatura;
	string temp_name;

};
struct Escopo
{
	int nivel;
	string inicio;
	string fim;
	bool isIf;
	vector<variavel> variaveis;
	vector<funcao> funcoes;
};
struct atributos
{
	string tipoReal; // Tipo no lule
	string tipo; // Tipo no C
	string label;
	string traducao;
	int tamanho;
	vector<string> colLabels;
	vector<int> tamanhos;	
	bool isVet;
};
struct operacao
{
	string tipoEsquerda;
	string tipoDireita;
	string tipoResultante;
	string tipoReal; // Tipo lule
	string operacao;
};
/** 
Manipula Operações
**/
	void adicionaOperacoes();
	operacao getTipoResultante(string, string, string);
		//Traduções
		string aritmeticoTraducao(atributos, atributos, atributos, atributos);
		string relacionalTraducao(atributos, atributos, atributos, atributos);
		string logicoTraducao(atributos, atributos, atributos, atributos);

/**
manipula label de escopo
**/
pair<string,string> geraLabelEscopo();
	//Pega Labels de Escopo
	string getLabelEscopoInicio();
	string getLabelEscopoFim();
	//Continues
	string getLabelContinue();
	string getLabelContinue(int); //Para a recursão
	string getSuperLabelContinue(); 
	string getSuperLabelContinue(int); //Para a recursão
	//Breaks
	string getLabelBreak();
	string getLabelBreak(int); //Para a recursão
	string getSuperLabelBreak();
	string getSuperLabelBreak(int); // Para a recursão
/**
manipula labels Condicao
**/
	void criaLabelCondicao();
	string getLabelCondicaoInicio();
	string getLabelCondicaoFim();
	void criaLabelFimCondicoes(); // Cria a label do fim de TODAS as condições
	string getLabelFimCondicoes(); //Pega a label do fim de TODAS as condições
/**
Manipula variaveis
**/
	//Criação de variaveis temporarias
	string nova_temp_var(string);
	variavel nova_temp_var_string(int);
	//Uso de Variaveis
	variavel use_var(string, string);
	variavel procura_var(string, int);
		//Auxilia no uso de Variaveis
		variavel useVarPorTempName(string);
		variavel procuraVarPorTempName(string, int);	
		pair<bool, int> isIn(string, vector<variavel>); //Verifica se uma variavel esta nessa lista de variaveis
	//Cria Variaveis
	string nova_var(string, string);
	string nova_var_string(string, int);
	string nova_var_vector(string, string, vector<string> );
		//Globais
		string nova_global_var(string, string);
		string nova_global_var_string(string, int); //Cria uma nova variavel (não-temp)
	//Auxilia no uso de Strings e Vetores
	void resetaString(string, int);
	void procura_e_reseta_string(string , int, int );
	void resetaVector(string, string , vector<string>);
	void procura_e_reseta_vector(string, int  , string , vector<string>);
/**
Manipula funcoes
**/
	funcao usaFuncao(string);
	funcao novaFuncao(string, vector<string>);
	//Auxilia na criação de uma nova funcao
	void atualizaFuncTraducao(string, string);
	void atualizaFuncRetorno(vector<string>);
	//Auxilia no todo funcionamento de funcoes
	funcao procuraFuncao(string, int);
	int procuraFuncPorTempName(string);
	//Criação de variaveis do parametro
	string nova_var_param_vet(string , string , vector<string> );
	string nova_var_param_string(string , int); //Cria uma nova variavel string(não-temp)
	string nova_var_param(string , string );

string geraFunc();
string geraVar();

//*Manipula Escopo*//
void desceEscopo(bool);
void sobeEscopo();

//Printa as traduções;
void printDeclaracoes(); // declarações
void printAssinaturas(); // assinaturas de funções
void printFuncoes();	 // tradução das funções

//Erros


int yylex(void);
void yyerror(string);

//Variaveis globais que ajudam na tradução de vetores...
string vet_label_flag;
string label_acesso;
int vet_posicao_atual;

%}
//Operacoes Aritimeticas
%token TK_MAIS TK_MENOS TK_MULT TK_RAZAO TK_POTENCIA TK_CONCAT
//Operacoes logica
%token TK_AND TK_OR
//Operacores relacionais
%token TK_MAIOR TK_MENOR TK_DIFERENTE TK_IGUAL
//ATRIBUICAO
%token TK_ATRIB TK_VAR TK_GLOBAL
//TIPOS
%token TK_TIPO_STRING TK_TIPO_FLOAT TK_TIPO_CHAR TK_TIPO_BOOL TK_TIPO_INT
//VALORES
%token TK_NUM TK_REAL TK_CHAR TK_BOOL TK_STR
//Condicionais e loops
%token TK_WHILE TK_FOR TK_SWITCH TK_CASE TK_IF TK_ELSE TK_ELIF
%token TK_BREAK TK_CONTINUE TK_DO TK_DEFAUT
//Bloco
%token TK_ABRE TK_FECHA
//func + do
%token TK_FUNC TK_RETORNA TK_RETURN
//read write
%token TK_READ TK_WRITE 

%token TK_SUPER
%token TK_MAIN TK_ID 
%token TK_FIM TK_ERROR TK_END_E TK_FIMLINHA
%start S

%nonassoc TK_AND TK_OR 
%left TK_MAIS TK_MENOS
%left TK_MULT TK_RAZAO

%%

S 			: DESCE_ESCOPO COMANDOS SOBE_ESCOPO
			{
				cout << "/*Compilador FOCA*/\n" << "#include <iostream> \n#include <string.h> \n#include <stdio.h>\nusing namespace std;\n" << endl;
				printAssinaturas();
				printDeclaracoes();
				cout << "#define true 1 \n#define false 0 \nint main(void)\n{\n" << endl;
				cout <<"\n\n"<< $2.traducao << endl;
				cout <<"\n\n\treturn 0;\n}" << endl; 
				printFuncoes();
			
			}
			;


BLOCO		: TK_ABRE COMANDOS TK_FECHA SOBE_ESCOPO
			{
				$$.traducao = $2.traducao;
			}
			;
BLOCO_EXP	: TK_ABRE DESCE_ESCOPO COMANDOS TK_FECHA SOBE_ESCOPO
			{
				$$.traducao = $3.traducao;
			}
			;

BLOCO_ALTER: TK_ABRE COMANDOS TK_FECHA
			{
				$$.traducao = $2.traducao;
			}
			;

SOBE_ESCOPO : {sobeEscopo();}
DESCE_ESCOPO : {desceEscopo(false);}

COMANDOS	: COMANDO COMANDOS
			{ 
				$$.traducao = $1.traducao + $2.traducao;		
			}
			| COMANDO 
			{
				$$.traducao = $1.traducao;
			}
			;

COMANDO 	: ATRIB ';'
			| OPERACAO ';'
			| OP ';'
			| FUNCAO
			| BREAK ';'
			| CONTINUE ';'
			| SUPERBREAK ';'
			| SUPERCONTINUE ';'
			| DECLARA ';'
			| CMD_COUT ';'
			| CMD_CIN ';'
			| CONDICIONAIS
			| COMANDO_LOOPS
			| BLOCO_EXP
			;

CONDICIONAIS : CMD_ELIF //if com elseifs
			 {
				$$.traducao = $1.traducao + "\n" + getLabelFimCondicoes()+":\n\n"; // Label Final
			 }
			 | CMD_ELSE //if com elseifs e else ou if sem elsif com else
			 {
				$$.traducao = $1.traducao + "\n" + getLabelFimCondicoes()+":\n\n"; // Label Final
			 }
			 | COMANDO_IF //if PURO sem else e sem elseifs
			 | WHITCHCASE
			 ;

COMANDO_LOOPS:
			| COMANDO_FOR
			| COMANDO_WHILE
			| COMANDO_DOWHILE
			;

/* *******
	** CONDICIONAIS *********
							****/ 
COMANDO_IF	: IF '(' CONDICAO ')' BLOCO //if PURO sem else e sem elseifs
			{
				$$.traducao = $3.traducao; //traducao da condicao
				$$.traducao += "\n\tif (!("+ $3.label +")) goto " + getLabelEscopoFim() +";"; //if (condicao) goto labelFinal
				$$.traducao += "\n" + $5.traducao +"\n";
				$$.traducao += "\n" + getLabelEscopoFim()+":"; // Label Final
			}
			;
//Exatamente igual ao CMD_IF, mas não tem a LABEL para o fim de TODAS as condições
CMD_IF_ALTER : IF '(' CONDICAO ')' BLOCO //if para ter ELIFs ou ELSEs ( Esse if tem um goto para o final de TODOS elifs/elses)
			{
				$$.traducao = $3.traducao; //traducao da condicao
				$$.traducao += "\n\tif (!("+ $3.label +")) goto " + getLabelEscopoFim() +";"; //if (condicao) goto labelFinal
				$$.traducao += "\n" + $5.traducao +"\n";
				$$.traducao += "\n\t goto " + getLabelFimCondicoes() +";\n";
				$$.traducao += "\n" + getLabelEscopoFim()+":\n"; // Label Final
			}
			;

CMD_ELIF	: CMD_IF_ALTER CMD_ELIF_ALTER //if com elseifs
			{
				$$.traducao = $1.traducao + $2.traducao; //IF + quantos ELIFs tiverem	
			}
			;

CMD_ELIF_ALTER : CMD_ELIF_ALTER CMD_ELIF_ALTER
			{
				$$.traducao = $1.traducao + $2.traducao; // Quantos elifs tiverem
			}
			| ELIF '(' CONDICAO ')' BLOCO// tradução do ELIF
			{
				$$.traducao = $3.traducao; //traducao da condicao
				$$.traducao += "\n\tif (!("+ $3.label +")) goto " + getLabelEscopoFim() +";"; //if (condicao) goto labelFinal
				$$.traducao += "\n" + $5.traducao +"\n"; // Bloco
				$$.traducao += "\n\t goto " + getLabelFimCondicoes() +";\n"; //Go para o final de TODAS as condições
				$$.traducao += "\n" + getLabelEscopoFim()+":\n\n"; // Label Final
			} 
			;

CMD_ELSE	: CMD_IF_ALTER ELSE BLOCO // ELSE depois de ELIFs
			{
				$$.traducao = $1.traducao; // IF
				$$.traducao += "\n" + $3.traducao +"\n"; // Bloco do ELSE
			}
			| CMD_IF_ALTER CMD_ELIF_ALTER ELSE BLOCO // ELSE depois de IF
			{
				$$.traducao = $1.traducao + $2.traducao; //IF + Quantos ELIFs tiverem
				$$.traducao += "\n" + $4.traducao +"\n"; // Bloco do ELSE
			}
			;

ELIF 		: TK_ELIF {	desceEscopo(true); };

IF 			: TK_IF { desceEscopo(true); criaLabelFimCondicoes();};

ELSE 		: TK_ELSE {	desceEscopo(true); };

WHITCHCASE 	: SWITCH TK_ABRE CASES TK_FECHA
			{
				$$.traducao = $1.traducao;
				$$.traducao +=$3.traducao;
				$$.traducao +=getLabelFimCondicoes()+":\n";
			}
			| SWITCH TK_ABRE CASES DEFAUT TK_FECHA
			{
				$$.traducao = $1.traducao;
				$$.traducao +=$3.traducao;
				$$.traducao +=$4.traducao;
				$$.traducao +=getLabelFimCondicoes()+":\n";
			};

SWITCH 		: TK_SWITCH '(' OPERACAO ')'
			{
				criaLabelFimCondicoes();
				label_acesso = $3.label;
				$$.traducao = $3.traducao;
			};

CASES		: CASES CASES 
			{
				$$.traducao = $1.traducao;
				$$.traducao += $2.traducao;
			}
			| CASE
			;

CASE 		: TK_CASE '(' OPERACAO ')' BLOCO_EXP
			{
				$$.traducao = $3.traducao; //traducao da condicao
				$$.traducao += "\n\tif ("+ label_acesso +"!="+$3.label+") goto " + getLabelEscopoFim() +";"; //if (condicao) goto labelFinal
				$$.traducao += "\n" + $5.traducao +"\n"; // Bloco
				$$.traducao += "\n\t goto " + getLabelFimCondicoes() +";\n"; //Go para o final de TODAS as condições
				$$.traducao += "\n" + getLabelEscopoFim()+":\n\n"; // Label Final
	
			};
DEFAUT		: TK_DEFAUT BLOCO_EXP
			{
				$$.traducao = "\n" + $2.traducao +"\n"; // Bloco
			}
/* *******
	** COMANDOS LOOP *********
							****/ 
COMANDO_FOR : FOR '(' CONDICAO ')' BLOCO
			{
				$$.traducao = "\n" + getLabelEscopoInicio()+":\n"; // label Inicial Do Bloco
				$$.traducao += $3.traducao; //traducao da condicao
				$$.traducao += "\n\tif (!("+ $3.label +")) goto " + getLabelEscopoFim() +";"; //if (condicao) goto labelFinal
				$$.traducao += "\n" + $5.traducao; //BLOCO
				$$.traducao += "\n\t goto " + getLabelEscopoInicio()+";"; //goto LabelInicio
				$$.traducao += "\n" + getLabelEscopoFim()+":\n\n"; // Label Final
			}
			|FOR '(' CONDICAO ')' COMANDO SOBE_ESCOPO

			{
				$$.traducao = "\n" + getLabelEscopoInicio()+":\n"; // label Inicial Do Bloco
				$$.traducao += $3.traducao; //traducao da condicao
				$$.traducao += "\n\tif (!("+ $3.label +")) goto " + getLabelEscopoFim() +";"; //if (condicao) goto labelFinal
				$$.traducao += "\n" + $5.traducao; //BLOCO
				$$.traducao += "\n\t goto " + getLabelEscopoInicio()+";"; //goto LabelInicio
				$$.traducao += "\n" + getLabelEscopoFim()+":\n\n"; // Label Final
			}
			| FOR '(' ATRIB ';' CONDICAO ';' ATRIB ')' BLOCO
			{
				$$.traducao = $3.traducao; //traducao do ponto de partida
				$$.traducao += "\n" + getLabelEscopoInicio()+":\n"; // Label Inicial Do Bloco
				$$.traducao += $5.traducao; //traducao da condicao
				$$.traducao += "\n\tif (!("+ $5.label +")) goto " + getLabelEscopoFim() +";"; //if (condicao) goto Label Final
				$$.traducao += "\n" + $9.traducao; //BLOCO
				$$.traducao += "\n" + $7.traducao; //incremento ou decremento
				$$.traducao += "\n\t goto " + getLabelEscopoInicio()+";"; //goto Label Inicio
				$$.traducao += "\n" + getLabelEscopoFim()+":\n\n"; // Label Final
			}
			| FOR '(' ATRIB ';' CONDICAO ';' ATRIB ')' COMANDO SOBE_ESCOPO
			{
				$$.traducao = $3.traducao; //traducao do ponto de partida
				$$.traducao += "\n" + getLabelEscopoInicio()+":\n"; // Label Inicial Do Bloco
				$$.traducao += $5.traducao; //traducao da condicao
				$$.traducao += "\n\tif (!("+ $5.label +")) goto " + getLabelEscopoFim() +";"; //if (condicao) goto Label Final
				$$.traducao += "\n" + $9.traducao; //BLOCO
				$$.traducao += "\n" + $7.traducao; //incremento ou decremento
				$$.traducao += "\n\t goto " + getLabelEscopoInicio()+";"; //goto Label Inicio
				$$.traducao += "\n" + getLabelEscopoFim()+":\n\n"; // Label Final
			}
			;

FOR 		: TK_FOR
			{	
				desceEscopo(false);
			}
			;

COMANDO_WHILE : WHILE '(' CONDICAO ')' BLOCO
				{
					$$.traducao = "\n" + getLabelEscopoInicio()+":\n"; // label Inicial Do Bloco
					$$.traducao += $3.traducao; //traducao da condicao
					$$.traducao += "\n\tif (!("+ $3.label +")) goto " + getLabelEscopoFim() +";"; //if (condicao) goto labelFinal
					$$.traducao += "\n" + $5.traducao; //BLOCO
					$$.traducao += "\n\t goto " + getLabelEscopoInicio()+";"; //goto LabelInicio
					$$.traducao += "\n" + getLabelEscopoFim()+":\n\n"; // Label Final
				}
				;

WHILE		: TK_WHILE
			{
				desceEscopo(false);
			}
			;


/* Bloco do Dowhile é especial pois nao pode subir o escopo antes da condição*/
COMANDO_DOWHILE : DO BLOCO_ALTER TK_WHILE '(' CONDICAO ')' FIM_DOWHILE
			{
				$$.traducao = "\n" + getLabelEscopoInicio()+":\n"; // label Inicial Do Bloco
				$$.traducao += "\n" + $2.traducao; //BLOCO
				$$.traducao +=  "\n" + $5.traducao; //traducao da condicao
				$$.traducao += "\n\tif ("+ $5.label +") goto " + getLabelEscopoInicio() +";\n"; //if (condicao) goto labelFinal
			}
			;

DO 			: TK_DO
			{
				desceEscopo(false);
			}
			;
FIM_DOWHILE : ';'
			{
				sobeEscopo();
			}

/* *******
	** CONDICOES *********
							****/ 

CONDICAO 	: LOGICO
			| RELACIONAL
			;

/* *******
	** OPERACOES *********
							****/ 

OPERACAO 	: ARITMETICO
			| LOGICO
			| RELACIONAL
			| CONCATENACAO
			;

/* *******
	** ARITIMETICAS *********
							****/ 
ARITMETICO	: ARITMETICO OP_ARITMETICO ARITMETICO
			{ 

				variavel var;
				if($1.colLabels.size() > 0)
				{
					var = useVarPorTempName($1.colLabels[0]);
					$1.label = var.temp_name;
					$1.tipo = var.tipo;
					$1.tipoReal = var.tipoReal;
					$1.isVet = var.isVet;
				}
				if($3.colLabels.size() > 0)
				{
					var = useVarPorTempName($3.colLabels[0]);
					$3.label = var.temp_name;
					$3.tipo = var.tipo;
					$3.tipoReal = var.tipoReal;
					$3.isVet = var.isVet;
				}
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "ARITMETICO");
				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;
				
				$$.label = nova_temp_var( $$.tipo);
				$$.traducao = aritmeticoTraducao($$, $1, $2, $3);
				
			}
			|ARITMETICO2
			| '('ARITMETICO')' { $$.traducao = $2.traducao; $$.label = $2.label; $$.tipo = $2.tipo; $$.tipoReal = $2.tipoReal;}
			|OP 
			;


ARITMETICO2	: ARITs OP_ARITMETICO2 ARITs
			{

				variavel var;
				if($1.colLabels.size() > 0)
				{
					var = useVarPorTempName($1.colLabels[0]);
					$1.label = var.temp_name;
					$1.tipo = var.tipo;
					$1.tipoReal = var.tipoReal;
					$1.isVet = var.isVet;
				}
				if($3.colLabels.size() > 0)
				{
					var = useVarPorTempName($3.colLabels[0]);
					$3.label = var.temp_name;
					$3.tipo = var.tipo;
					$3.tipoReal = var.tipoReal;
					$3.isVet = var.isVet;
				}

				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "ARITMETICO");
				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;
				
				$$.label = nova_temp_var( $$.tipo);
				$$.traducao = aritmeticoTraducao($$, $1, $2, $3);
				
			} 
			| '(' ARITMETICO2 ')' { $$.traducao = $2.traducao; $$.label = $2.label; $$.tipo = $2.tipo; $$.tipoReal = $2.tipoReal;}
			|OP 
			;

ARITs 		: ARITMETICO2
			| '(' ARITMETICO ')'  { $$.traducao = $2.traducao; $$.label = $2.label;}
			;


/* *******
	** CONCATENACOES *********
							****/ 

CONCATENACAO: CONCATENACAO OP_CONCAT CONCATENACAO
			{

				variavel varOp;
				if($1.colLabels.size() > 0)
				{
					varOp = useVarPorTempName($1.colLabels[0]);
					$1.label = varOp.temp_name;
					$1.tipo = varOp.tipo;
					$1.tipoReal = varOp.tipoReal;
					$1.tamanho = varOp.tamanho;
				}if($3.colLabels.size() > 0)
				{
					varOp = useVarPorTempName($3.colLabels[0]);
					$3.label = varOp.temp_name;
					$3.tipo = varOp.tipo;
					$3.tipoReal = varOp.tipoReal;
					$3.tamanho = varOp.tamanho;
				}

				$$.tipo = "char[]";
				$$.tipoReal = "string";
				variavel var = nova_temp_var_string( $1.tamanho + $3.tamanho); 
				$$.label = var.temp_name; 
				$$.tamanho = $1.tamanho + $3.tamanho;
				if($1.tipoReal == "string" & $3.tipoReal == "string")
					$$.traducao = $1.traducao + $3.traducao +"\n\t strcat("+$$.label+","+$1.label+");\n\t strcat("+$$.label+","+$3.label+");\n"; 
				else
					yyerror("Não, Braida, ainda não fiz isso");
				//$$.label = nova_var_string()
			}
			|OP 
			;

/* *******
	** RELACIONAIS *********
							****/ 
RELACIONAL	: RELs OP_RELACIONAL RELs	
			{

				variavel var;
				if($1.colLabels.size() > 0)
				{
					var = useVarPorTempName($1.colLabels[0]);
					$1.label = var.temp_name;
					$1.tipo = var.tipo;
					$1.tipoReal = var.tipoReal;
					$1.tamanho = var.tamanho;
				}if($3.colLabels.size() > 0)
				{
					var = useVarPorTempName($3.colLabels[0]);
					$3.label = var.temp_name;
					$3.tipo = var.tipo;
					$3.tipoReal = var.tipoReal;
					$3.tamanho = var.tamanho;
				}

				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "relacional");

				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;				
				$$.label = nova_temp_var($$.tipo);
				
				$$.traducao = relacionalTraducao($$, $1, $2, $3);
			}
			| '(' RELACIONAL ')' {  $$.traducao = $2.traducao; $$.label = $2.label; $$.tipo = $2.tipo; $$.tipoReal = $2.tipoReal;}
			| OP 
			| ARITMETICO;
			;

RELs 		: RELACIONAL;

/* *******
	** LOGICAS *********
							****/ 

LOGICO		: LOGs OP_LOGICO LOGs
			{ 

				variavel var;
				if($1.colLabels.size() > 0)
				{
					var = useVarPorTempName($1.colLabels[0]);
					$1.label = var.temp_name;
					$1.tipo = var.tipo;
					$1.tipoReal = var.tipoReal;
					$1.tamanho = var.tamanho;
				}if($3.colLabels.size() > 0)
				{
					var = useVarPorTempName($3.colLabels[0]);
					$3.label = var.temp_name;
					$3.tipo = var.tipo;
					$3.tipoReal = var.tipoReal;
					$3.tamanho = var.tamanho;
				}
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "logico");

				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;
				$$.label = nova_temp_var( $$.tipo);

				$$.traducao = logicoTraducao($$, $1, $2, $3);
			}
			| '(' LOGICO ')' { $$.traducao = $2.traducao; $$.label = $2.label; $$.tipo = $2.tipo; $$.tipoReal = $2.tipoReal;}
			;

LOGs 		: LOGICO | RELACIONAL ;

/* *******
	** OPERADORES *********
							****/ 
OP_CONCAT 		: TK_CONCAT;

OP_LOGICO		: TK_AND | TK_OR ;

OP_RELACIONAL 	: TK_DIFERENTE | TK_IGUAL | TK_MENOR | TK_MAIOR ;

OP_ARITMETICO 	: TK_MAIS | TK_MENOS ;

OP_ARITMETICO2 	: TK_RAZAO | TK_MULT ;

/* *******
	** OPERANDOS *********
							****/ 

OP			: TK_NUM
			{
				$$.label =  nova_temp_var( $1.tipo);
				$$.traducao = "\t" + $$.label + " = " + $1.traducao + ";\n";	
			}
			| TK_STR
			{
				variavel temp;
				temp =  nova_temp_var_string($1.traducao.size()-2);
				$$.label = temp.temp_name;
				$$.tipo = temp.tipo;
				$$.tamanho = temp.tamanho;
				$$.traducao = "\t strcpy(" + $$.label + "," + $1.traducao + ");\n";				
			}
			| TK_ID
			{	
				variavel var = use_var($$.label, " ");
				$$.label =  var.temp_name;
				$$.tamanho = var.tamanho;
				$$.tipo = var.tipo;
				$$.tipoReal = var.tipoReal;
				$$.colLabels = var.colTamanhosLabels;
				$$.traducao = "";
			}
			| ID_VET INDEXs
			{
				//Posso verificar se a quantidade de indices que andei é o tamanho do vetor...
				//Se não for, pode montar um novo vetor, salvar como vetor temporario e retornar...
				$$.traducao = $2.traducao;
				variavel var = use_var($1.label, " ");
				if(var.tipoReal =="string"){
					variavel varTemp = nova_temp_var_string(1024); 
					$$.label = varTemp.temp_name;
					$$.traducao += "\tstrcpy("+ $$.label +"," +var.temp_name + "["+ $2.label +"]);\n";
					$$.tamanho = 1024;
					$$.tipo = var.tipo;
					$$.tipoReal = var.tipoReal;	
				}else{
					$$.label = nova_temp_var(var.tipo);
					$$.traducao = $2.traducao;
					$$.traducao += "\t"+ $$.label +" = " +var.temp_name + "["+ $2.label +"];\n";
					$$.tamanho = var.tamanho;
					$$.tipo = var.tipoReal;
					$$.tipoReal = var.tipoReal;
				}
			}
			| TK_BOOL
			{
				$$.label =  nova_temp_var( $1.tipo);
				$$.traducao = "\t" + $$.label + " = " + $1.traducao + ";\n";
				$$.tipo = "int"; 
				$$.tipoReal = "bool"; 
						
			}
			| TK_REAL
			{
				$$.tamanho = $$.traducao.size();
				$$.label =  nova_temp_var( $1.tipo);
				$$.traducao = "\t" + $$.label + " = " + $1.traducao + ";\n";			
			}
			| TK_CHAR
			{
				$$.tamanho = $$.traducao.size()-2;
				$$.label =  nova_temp_var( $1.tipo);
				$$.traducao = "\t" + $$.label + " = " + $1.traducao + ";\n";			
			}
			| CHAMA_FUNCAO
			;

CHAMA_FUNCAO
			: TK_ID '(' OPs ')'
			{
				$$.traducao = $3.traducao;
				funcao func = usaFuncao($1.label);

				if(func.parametros.size() != $3.colLabels.size())
					yyerror("Funcao espera quantidade de parametros diferentes");
				//verificaChamadaFunc(func, colLabels)

				for (int i = 0; i < func.parametros.size() && i < $3.colLabels.size(); i++)
				{
					variavel temp = useVarPorTempName($3.colLabels[i]);
					if(func.parametros[i].tipoReal != temp.tipoReal)
						yyerror("Passe o parametro corretamente, vei");
					$$.traducao += "\t" + func.parametros[i].temp_name +" = "+ $3.colLabels[i]+";\n";
				}
				$$.traducao += "\t"+ func.temp_name+"();\n";
				for (int j = 0; j < func.retornos.size(); j++)
				{
					$$.colLabels.push_back(func.retornos[j].temp_name);
				}
				$$.label = "";
			}

/* *******
	** DECLARAÇÕES *********
							****/ 
DECLARA 	: TK_VAR TIPO TK_ID // var int a
			{

				if($2.tipoReal == "string"){
					$$.label = nova_var_string($3.label, 0);
					$$.traducao = " ";
					$$.tipoReal = $2.tipoReal;
					$$.tipo = $2.tipo;
				}else
				{
	 				$$.traducao = " ";
	 				$$.label = nova_var($3.label, $2.tipo);
	 			}
 			}
 			| DECLARA_VETOR
			| DECLARA_GLOBAL
 			;

//DECLARACAO GLOBAL
DECLARA_GLOBAL
			:TK_GLOBAL TK_VAR TIPO TK_ID // global var int a;
			{
				$$.traducao = " ";
				$$.label = nova_global_var($4.label, $3.tipo);
 			}
 			;
//DECLARACAO DE VETOR
DECLARA_VETOR
 			:TK_VAR TIPO TK_ID DIMENCAO 
 			{
 				$$.tipoReal = $2.tipoReal;
 				$$.tipo = $2.tipo;
 				$$.colLabels = $4.colLabels;

 				$$.label = nova_var_vector($3.label, $2.tipo, $$.colLabels);

 				$$.traducao = $4.traducao;
 				$$.traducao += "\t" + $$.tipo + " " +  $$.label +"["+ $4.label + "];\n";
 			}
 			;
//Auxilia na declaração do vetor
DIMENCAO 	: '['ARITMETICO']'
			{
				if ($2.tipoReal	== "int")
 				{
 					$$.traducao = $2.traducao;
 					$$.colLabels.push_back($2.label);
 					$$.label = $2.label;
 				}
 				else
 				{
 					yyerror("Esse tipo não é aceito para dimencionar um vetor");
 				}
 			
			}	
			| DIMENCAO DIMENCAO
			{
				$$.label = nova_temp_var("int");
				$$.traducao = $1.traducao; 
				$$.traducao += $2.traducao + "\t"+ $$.label +" = "+ $1.label +" * " + $2.label+";\n" ;

				int i;
				for (i = 0 ; i < $2.colLabels.size(); i++)
				{
					$1.colLabels.push_back($2.colLabels[i]);
				}
				$$.colLabels = $1.colLabels;
			}
			;
/* *******
	** ATRIBUIÇÕES *********
							****/ 
ATRIB 		:IDs TK_ATRIB OPs // a = 4;
 			{
 				$$.traducao = $3.traducao;
 				for (int i = 0; (i < $1.colLabels.size()) && (i < $3.colLabels.size() ) ; i++)
				{	
					variavel varOp = useVarPorTempName($3.colLabels[i]);
					variavel varId = use_var($1.colLabels[i], " ");
					if(varOp.isVet && varId.isVet) {
			 			resetaVector($1.colLabels[i], varOp.tipo ,varOp.colTamanhosLabels);
						variavel var = use_var($1.colLabels[i], varOp.tipo);
						$$.traducao += "\t"+ var.temp_name + " = " + varOp.temp_name+ ";\n"; 
				 	}
					else if(varOp.tipoReal == "string" && varId.tipoReal == "string"){
						resetaString($1.colLabels[i], varOp.tamanho);
						variavel var = use_var($1.colLabels[i], varOp.tipo);				
						$$.traducao +="\t strcpy(" + var.temp_name + "," + varOp.temp_name+ ");\n";
					}
				 	else if(varOp.tipoReal == varId.tipoReal) {
						variavel var = use_var($1.colLabels[i], varOp.tipo);
						$$.traducao +="\t" + var.temp_name + " = " + varOp.temp_name+ ";\n";
					}
					else
						yyerror("usa essa merda direito");
				}

 			}
 			| ATRIB_VETOR
 			| DECLARA_ATRIB 
  			| DECLARA_ATRIB_GLOBAL
 			| DECLARA_ATRIB_VETOR
 			| INCREMENTO
 			| DECREMENTO
 			;
//ATRIBUICAO EM VETOR
ATRIB_VETOR : ID_VET INDEXs TK_ATRIB OPERACAO
			{
				$$.traducao = $2.traducao;
				$$.traducao += $4.traducao;
				if($4.tipoReal == "string"){
 					resetaString($1.label, $4.tamanho);
 					variavel var = use_var($1.label, $4.tipo);				
 					$$.traducao += "\t strcpy(" + var.temp_name + "["+ $2.label +"] ," + $4.label+ ");\n";
 				}else{
 					variavel var = use_var($1.label, $4.tipo);
 					$$.traducao +="\t" + var.temp_name + "["+ $2.label +"] = " + $3.label+ ";\n";
 				}

			}
			;

/***
	 DECLARACAOS COM ATRIBUIÇÃO
	 				****/

DECLARA_ATRIB
			:TK_VAR IDs TK_ATRIB OPs // var a = 4
			{
				$$.traducao = $4.traducao;
				for (int i = 0; (i < $2.colLabels.size()) && (i < $4.colLabels.size() ) ; i++)
				{	
					variavel var = useVarPorTempName($4.colLabels[i]);
					if($4.isVet) {
				 		$$.label  = nova_var_vector($2.colLabels[i], var.tipo, var.colTamanhosLabels);
				 		$$.traducao += "\t"+ $$.label + " = " + var.temp_name+ ";\n"; 
			 		}
			 		else if(var.tipoReal == "string"){
				 		$$.traducao += "\t strcpy("+ nova_var_string($2.colLabels[i], var.tamanho) + ", "+ var.temp_name+ ");\n";
			 		}
				 	else
				 	{
				 		$$.traducao += "\t"+ nova_var($2.colLabels[i], var.tipo) + " = " + var.temp_name+ ";\n";
					}
				}
				
			}
			| TK_VAR TIPO IDs TK_ATRIB OPs // var int a = 4
			{
				$$.tipoReal = $2.tipoReal;
				$$.tipo = $2.tipo;
				$$.traducao = $5.traducao;
				for (int i = 0; (i < $3.colLabels.size()) && (i < $5.colLabels.size() ) ; i++)
				{		
					variavel var = useVarPorTempName($5.colLabels[i]);
					if($2.tipoReal == "string" && var.tipoReal == "string")
					{
						$$.traducao += "\t strcpy("+ nova_var_string($3.colLabels[i], var.tamanho) + ", " +var.temp_name+ ");\n";	
					}
					else if( ($2.tipoReal == "string" && var.tipoReal != "string")||($2.tipoReal != "string" && var.tipoReal == "string"))
					{
						yyerror("Não é possivel fazer essa atribuição");
					}
					else
					{
				 		$$.traducao += "\t"+ nova_var($3.colLabels[i], $2.tipo) + " = " + "("+$2.tipo+")"+var.temp_name+ ";\n";
					}
				}
			}
			;

//DECLARACAO COM ATRIBUIÇÃO GLOBAL
DECLARA_ATRIB_GLOBAL
			:TK_GLOBAL TK_VAR IDs TK_ATRIB OPs //global var a = 4
			{
				$$.traducao = $5.traducao;
				for (int i = 0; (i < $3.colLabels.size()) && (i < $5.colLabels.size() ) ; i++)
				{		
					variavel var = useVarPorTempName($5.colLabels[i]);
					if(var.tipoReal == "string")
					{
						$$.traducao += "\t strcpy("+ nova_global_var_string($3.colLabels[i], var.tamanho) + ", " +var.temp_name+ ");\n";	
					}
					else
					{
				 		$$.traducao += "\t"+ nova_global_var($3.colLabels[i], var.tipo) + " = " + var.temp_name+ ";\n";
					}
			 	}
			 }
			| TK_GLOBAL TK_VAR TIPO IDs TK_ATRIB OPs //global var int a = 4
			{
				$$.traducao = $6.traducao;
				for (int i = 0; (i < $4.colLabels.size()) && (i < $6.colLabels.size() ) ; i++)
				{		
					variavel var = useVarPorTempName($6.colLabels[i]);
					
					if($3.tipoReal == "string" && $6.tipoReal == "string")
					{
						$$.traducao += "\t strcpy("+ nova_global_var_string($4.colLabels[i], var.tamanho) + ", " +var.temp_name+ ");\n";	
					}
					else if( ($3.tipoReal == "string" && var.tipoReal != "string")||($3.tipoReal != "string" && var.tipoReal == "string"))
					{
						yyerror("Não é possivel fazer essa atribuição");
					}
					else
					{
				 		$$.traducao +="\t"+ nova_global_var($4.colLabels[i], var.tipo) + " = " + "("+$3.tipo+")"+var.temp_name+ ";\n";
					}
				}
			 }
			 ;

//DECLARACAO COM ATRIBUIÇÃO DE VETOR
DECLARA_ATRIB_VETOR
			: TK_VAR TIPO TK_ID TK_ATRIB VETORES // var int a = 4
			{
				$$.tipoReal = $2.tipoReal;
				$$.tipo = $2.tipo;
				
				stringstream tamanho_str;				

				$$.traducao = "";
				int j;
				for (j = $5.tamanhos.size()-1 ; j >= 0 ; j--){
					stringstream tamanho_str;
					tamanho_str << $5.tamanhos[j];
					string tamanho = nova_temp_var("int");
					$$.traducao += "\t"+ tamanho + " = " + tamanho_str.str() +";// tamanho do vetor\n" ;
					$$.colLabels.push_back(tamanho);
				}

				$$.label = nova_var_vector($3.label, $2.tipoReal, $$.colLabels);

				tamanho_str << $5.colLabels.size();

				string tamanho = nova_temp_var("int");
				$$.traducao += $5.traducao;

				$$.traducao += "\n\t" + tamanho +" = "+ tamanho_str.str() +";\n";
 				$$.traducao += "\t" + $$.tipo + " " +  $$.label +"["+ tamanho + "];\n";
 				int i;
 				for (i = 0; i < $5.colLabels.size(); i++)
 				{

					stringstream i_string;
					i_string << i;
 					$$.traducao += "\t"+ $$.label +"["+ i_string.str() + "] = " + $5.colLabels[i] +";\n";
 				}
			}



/***
	Usados para fazer passagem de parametro/atrbuição multipla
		***/

IDs 		: IDs ',' TK_ID 
			{
				$$.colLabels = $1.colLabels;
				$$.colLabels.push_back($3.label);
			}
			| TK_ID 
			{ 
				$$.colLabels.push_back($1.label); 
			}


OPs 		: OPs ',' OPERACAO  
			{	
				$$.traducao = $1.traducao + $3.traducao;
				$$.colLabels = $1.colLabels;
				$$.colLabels.push_back($3.label);
			}
			| OPERACAO
			{	
				vector<string> vazio;
				$$.colLabels = vazio;
				if ($1.label != "")
					$$.colLabels.push_back($$.label);
				else{
					if($1.colLabels.size() > 0){
						for (int i = 0; i < $1.colLabels.size(); i++)
						{
							$$.colLabels.push_back($1.colLabels[i]);
						}
					}
					else
						yyerror("Esta operando com o que, vei?");
				}
			}




INCREMENTO  :TK_ID TK_MAIS TK_MAIS // a++
 			{
 				 variavel var = use_var($1.label, $1.tipo);
 				$$.traducao = "\t" + var.temp_name + " = " + var.temp_name + "+ 1;\n";
 			}
 			;
DECREMENTO  : TK_ID TK_MENOS TK_MENOS // a--
 			{
 				variavel var = use_var($1.label, $1.tipo);
 				$$.traducao = "\t" + var.temp_name + " = " + var.temp_name + "- 1;\n";
 			}
 			;

/* *******
	** AUXILIA NA DECLARACAO DE VETOR COM ATRIBUICAO *********
															****/ 
VETORES		: TK_ABRE VETOR TK_FECHA
			{
				$$.traducao = $2.traducao;
				$$.tamanho = $2.tamanho;
				$$.tamanhos = $2.tamanhos;
				$$.colLabels = $2.colLabels;
				$$.tamanhos.push_back($2.tamanho);
			}
			;

VETOR 		: '[' VALORES ']'
			{
				$$.tamanho = 1;
				$$.traducao = $2.traducao;
				$$.colLabels = $2.colLabels;
				$$.tamanhos.push_back($2.tamanho);
			}
			| '[' VETOR ']'
			{
				$$.tamanho = 1;
				$$.traducao = $2.traducao;
				$$.colLabels = $2.colLabels;
				$$.tamanhos = $2.tamanhos;
				$$.tamanhos.push_back($2.tamanho);
			}
			| VETOR VETOR
			{
				$$.traducao = $1.traducao + $2.traducao;
				$$.colLabels = $1.colLabels;
				int i;
				for (i = 0 ; i < $2.colLabels.size(); i++)
				{
					$$.colLabels.push_back($2.colLabels[i]);
				}
				if($1.tamanhos == $2.tamanhos)
					$$.tamanhos = $1.tamanhos;
				else
					yyerror("Não foi possivel declarar o vetor... \n Vetor é regular e você está tentando declarar um irregular");

				$$.tamanho = $1.tamanho + $2.tamanho;
			}
			;

VALORES		: OPERACAO
			{	
				$$.tamanho = 1;
				$$.traducao = $1.traducao;
				$$.colLabels.push_back($1.label);
			}
			| VALORES ',' VALORES
			{
				$$.traducao = $1.traducao + $3.traducao;
				$$.tamanho = $1.tamanho + $3.tamanho;
				$$.colLabels = $1.colLabels;	
				int i;
				for (i = 0 ; i < $3.colLabels.size(); i++)
				{   
					$$.colLabels.push_back($3.colLabels[i]);
				}
			
			}
			;

/* *******
	** TIPOS PRIMITIVOS *********
								****/ 

TIPO 		: TK_TIPO_BOOL
 			| TK_TIPO_FLOAT
 			| TK_TIPO_CHAR
 			| TK_TIPO_INT
 			| TK_TIPO_STRING
 			;

/* *******
	** FUNCAO *********
								****/ 

FUNCAO 		: DESCE_ESCOPO DECLARA_FUNC SOBE_ESCOPO
			{

				$$.traducao = "";
			}
			;
DECLARA_FUNC
			:ASSINATURA BLOCO_FUNC 
			{
				$$.traducao =  $2.traducao;
				atualizaFuncRetorno($2.colLabels);
				atualizaFuncTraducao($1.label, $$.traducao);
			}
			|ASSINATURA TK_RETORNA TIPOS_RETORNO BLOCO_FUNC 
			{
				$$.traducao =  $4.traducao;

				if($4.colLabels.size() != $3.colLabels.size())
					yyerror("Esperando um numero diferente de retornos");
				for (int i = 0; i < $3.colLabels.size(); ++i)
				{		
					$$.traducao += "\t"+$3.colLabels[i]+" = "+ $4.colLabels[i]+";\n";
				}

				atualizaFuncTraducao($1.label, $$.traducao);
			}

TIPOS_RETORNO
			: TIPOS
			{
				atualizaFuncRetorno($1.colLabels);
			}

TIPOS 		: TIPOS ',' TIPO
			{
				$$.colLabels = $1.colLabels;
				$$.colLabels.push_back(nova_temp_var($3.tipoReal));
			}
			| TIPO
			{
				vector<string> vazio;
				$$.colLabels = vazio;
				$$.colLabels.push_back(nova_temp_var($1.tipoReal));
			}


ASSINATURA
			: TK_FUNC TK_ID '(' PARAMETROS ')'
			{
				$$.traducao = "\tvoid" + $3.label +"()\n";
				$$.label = $3.label;
				$$.colLabels = $4.colLabels;
				novaFuncao($$.label, $$.colLabels);

			}
			| TK_FUNC TK_ID '(' ')'
			{
				$$.traducao = "\tvoid" + $3.label +"()\n";
				$$.label = $3.label;

				vector<string> vazio;
				$$.colLabels = vazio;
				novaFuncao($$.label, $$.colLabels);
			};
			// |  TK_FUNC TK_ID '(' PARAMETROS ')' TK_RETORNA TIPO
			// {
			// 	$$.traducao = "\tvoid" + $3.label +"()\n";
			// 	$$.label = $3.label;
			// 	$$.tipoReal = $7.tipoReal;
			// 	$$.tipo = $7.tipo;
			// 	$$.colLabels = $4.colLabels;
			// }

PARAMETROS 	: PARAMETROS ',' DECLARA_PARAM
			{
				$$.colLabels = $1.colLabels;
				$$.colLabels.push_back($3.label);
			}
			| DECLARA_PARAM
			{
				vector<string> vazio;
				$$.colLabels = vazio;
				$$.colLabels.push_back($1.label);
			}

DECLARA_PARAM
			: TIPO TK_ID // var int a
			{
				if($2.tipoReal == "string"){
					$$.label = nova_var_param_string($2.label, 1024);
					$$.traducao = " ";
					$$.tipoReal = $1.tipoReal;
					$$.tipo = $1.tipo;
				}else
				{
	 				$$.traducao = " ";
	 				$$.label = nova_var_param($2.label, $1.tipo);
	 			}
 			}



BLOCO_FUNC 	: TK_ABRE COMANDOS RETORNO TK_FECHA 
			{
				$$.traducao = $2.traducao;
				$$.traducao += $3.traducao;
				$$.colLabels = $3.colLabels;
			}
			| TK_ABRE RETORNO TK_FECHA 
			{
				$$.traducao = $2.traducao;
				$$.colLabels = $2.colLabels;
			}
			| TK_ABRE COMANDOS TK_FECHA 
			{
				$$.traducao = $2.traducao;
				vector<string> vazio;
				$$.colLabels = vazio;
			}
			
RETORNO 	: TK_RETURN RETORNOS ';'
			{
				$$.traducao  = $2.traducao;
				$$.colLabels = $2.colLabels;
			}

RETORNOS 	: RETORNOS ',' OPERACAO
			{
				$$.traducao = $1.traducao;
				$$.traducao += $3.traducao;
				$$.colLabels = $1.colLabels;
				$$.colLabels.push_back($3.label);
			}
			| OPERACAO
			{
				$$.traducao = $1.traducao;
				$$.colLabels.push_back($1.label);
			}

/* *******
	** I/O *********
					****/ 


CMD_CIN 	:  TK_VAR TIPO TK_ID TK_ATRIB TK_READ 
			{

				if($2.tipoReal == "string"){
					nova_var_string($3.label, 0);
 					resetaString($3.label, 1024);
 					variavel var = use_var($3.label, $3.tipo);
					$$.traducao = "\t cin << " + var.temp_name + " ;\n";
				}
				else
				{
	 				$$.label = nova_var($3.label, $2.tipo);
					$$.traducao = "\t cin << " + $$.label + " ;\n";
				}
			}
			| TK_GLOBAL TK_VAR TIPO TK_ID TK_ATRIB TK_READ// global var int a;
			{
				if($3.tipoReal == "string"){
					nova_var_string($4.label, 0);
 					resetaString($4.label, 1024);
 					variavel var = use_var($4.label, $4.tipo);
					$$.traducao = "\tcin << " + var.temp_name + " ;\n";	
				}else
				{
	 				$$.label = nova_var($4.label, $3.tipo);
					$$.traducao = "\tcin << " + $$.label + " ;\n";
				}
 			}
			| TK_READ '('TK_ID')'
			{
				if($3.tipoReal == "string"){
 					resetaString($3.label, 1024);
 					variavel var = use_var($3.label, $3.tipo);
					$$.traducao = "\t cin << " + var.temp_name + " ;\n";	
				}
				else{
					$$.traducao = "\t cin << " + $3.label + " ;\n";	
				}
			}
			;

CMD_COUT 	: TK_WRITE '(' OPERACAO ')'
			{	
				$$.traducao = $3.traducao;
				$$.traducao += "\t cout <<" + $3.label + " ;\n";
			}
			;

/* *******
	** 	COMANDOS UTEIS *********
								****/ 


BREAK 		: TK_BREAK { $$.traducao = "\tgoto " + getLabelBreak()+";\n";} ;

CONTINUE	: TK_CONTINUE {	$$.traducao = "\tgoto " + getLabelContinue()+";\n";} ;

SUPERBREAK 	: TK_SUPER TK_BREAK	{ $$.traducao = "\tgoto " + getSuperLabelBreak()+";\n";	} ;

SUPERCONTINUE : TK_SUPER TK_CONTINUE { $$.traducao = "\tgoto " + getSuperLabelContinue()+";\n"; }	;


/* *******
	** AUXILIARES PARA O USO DE VETOR ********* usado em: OPERANDO vetor e ATRIBUICAO em um vetor
												****/ 

ID_VET 		: TK_ID
			{
				variavel var = use_var($1.label, " ");
				vet_label_flag = var.orig_name;
			}

INDEXs		: INDEXs '['ARITMETICO']'  
			{
				vet_posicao_atual++;
				variavel var = use_var(vet_label_flag, " ");
				string label = nova_temp_var("int");
				$$.label = nova_temp_var("int");	

				$$.traducao = $1.traducao;
				$$.traducao += $3.traducao;

				$$.traducao += "\t"+ label +" = "+ $1.label +" + "+ $3.label + ";\n";
				if(vet_posicao_atual != var.colTamanhosLabels.size())
					$$.traducao += "\t"+ $$.label +" = "+ var.colTamanhosLabels[vet_posicao_atual] +" * "+ label + ";\n";
				else
					$$.label = label;
			}
			| '['ARITMETICO']'
			{ 
				variavel var = use_var(vet_label_flag, " ");
				vet_posicao_atual = 1;
				$$.label = nova_temp_var("int");
				$$.traducao = $2.traducao; 
				$$.traducao += "\t"+ $$.label +" = "+ var.colTamanhosLabels[vet_posicao_atual] +" * "+ $2.label + "\n";
			} 
			;


%%
#include "lex.yy.c"


int temp_counter = 0;
int label_counter = 0;
int nivel_escopo = -1;
int label_fim_condicoes_counter = 0;
int condicao_counter = 0;
int temp_func_counter = 0;

string condicaoLabel;
string label_fim_condicoes;
vector< vector<Escopo> > escopo_list;
vector<operacao> list_op;
int yyparse();
string geraVar();
int main( int argc, char* argv[] )
{
	adicionaOperacoes();
	yyparse();
	return 0;
}
void yyerror( string MSG )
{
	cout << MSG << endl;
	exit (0);
}
///* Funções que manipulam Escopo *///
void desceEscopo(bool isIf)
{	
	nivel_escopo++;
	Escopo escopo;
	escopo.nivel = nivel_escopo;
	pair<string, string> label = geraLabelEscopo();
	escopo.inicio = label.first;
	escopo.fim = label.second;
	escopo.isIf = isIf;
	vector<variavel> list_var;	
	escopo.variaveis = list_var;
	if (escopo_list.size() > nivel_escopo)
	{
		escopo_list[nivel_escopo].push_back(escopo);
	}
	else
	{
		vector<Escopo> tempVet;
		tempVet.push_back(escopo);
		escopo_list.push_back(tempVet);
	}
}
void sobeEscopo()
{
	nivel_escopo--;
}
/// * Funções que manipulam label do escopo */// 
pair<string,string> geraLabelEscopo()
{
	stringstream labelInicialGerator;
	labelInicialGerator << "_LabelInicio_" << label_counter;
	
	stringstream labelFinalGerator;
	labelFinalGerator << "_LabelFinal_" << label_counter;
	label_counter = label_counter + 1;
	pair<string, string> retorno;
	retorno.first = labelInicialGerator.str();
	retorno.second = labelFinalGerator.str();
	return retorno;
}


void criaLabelFimCondicoes()
{
	stringstream labelFimCondicoesGerator;
	labelFimCondicoesGerator << "_label_fim_condicoes_" << label_fim_condicoes_counter;
	label_fim_condicoes_counter++ ;
	label_fim_condicoes = labelFimCondicoesGerator.str();
}


string getLabelFimCondicoes()
{
	return label_fim_condicoes;
}

// void criaLabelCondicao()
// {
// 	stringstream labelFinalGerator;
// 	labelFinalGerator << "_LabelCondicao_" << condicao_counter;
// 	condicao_counter++;

// 	condicaoLabel = labelFinalGerator.str(); 

// }
// string getLabelCondicaoFim()
// {
// 	return condicaoLabel;
// }

string getLabelEscopoInicio()
{
	if(nivel_escopo != escopo_list[nivel_escopo].back().nivel)
		yyerror("Bug ao compilar");
	return escopo_list[nivel_escopo+1].back().inicio;
}
string getLabelEscopoFim()
{
	if(nivel_escopo != escopo_list[nivel_escopo].back().nivel)
		yyerror("Bug ao compilar");
	return escopo_list[nivel_escopo+1].back().fim;
}
string getLabelContinue()
{
	if(nivel_escopo != escopo_list[nivel_escopo].back().nivel)
		yyerror("Bug ao compilar");
	if(escopo_list[nivel_escopo].back().isIf == false)
		return escopo_list[nivel_escopo].back().inicio;
	else
		return getLabelContinue(nivel_escopo);
}
string getLabelContinue(int nivel)
{
	if(escopo_list[nivel].back().isIf == false)
		return escopo_list[nivel].back().inicio;
	else{
		nivel--;
		return getLabelContinue(nivel);
	}
}
string getLabelBreak()
{
	if(nivel_escopo != escopo_list[nivel_escopo].back().nivel)
		yyerror("Bug ao compilar");
	if(escopo_list[nivel_escopo].back().isIf == false)
		return escopo_list[nivel_escopo].back().fim;
	else
		return getLabelBreak(nivel_escopo);
}
string getLabelBreak(int nivel)
{
	if(escopo_list[nivel].back().isIf == false)
		return escopo_list[nivel].back().fim;
	else{		
		nivel--;
		return getLabelBreak(nivel);
	}
}
string getSuperLabelContinue()	
{
	if(escopo_list[1].back().isIf == false)
		return escopo_list[1].back().inicio;
	else
		return getSuperLabelContinue(1);
}
string getSuperLabelContinue(int nivel)
{
	if(escopo_list[nivel].back().isIf == false)
		return escopo_list[nivel].back().inicio;
	else{
		nivel++;
		return getSuperLabelContinue(nivel);
	}
}
string getSuperLabelBreak()
{
	if(escopo_list[1].back().isIf == false)
		return escopo_list[1].back().fim;
	else
		return getSuperLabelBreak(1);
}
string getSuperLabelBreak(int nivel)
{
	if(escopo_list[nivel].back().isIf == false)
		return escopo_list[nivel].back().fim;
	else{		
		nivel++;
		return getSuperLabelBreak(nivel);
	}
}

//Ve se uma variavel esta dentro de um Escopo
// Retorno: first -> true (se tem ela no escopo); false -> Se não tem
//			second -> A posição que encontra a variavel
pair<bool, int> isIn(string var, vector<variavel> L)
{
	pair<bool, int> values;
	int i;
		for (i = 0; i < L.size(); i++)
		{
			if(var == L[i].orig_name)
			{
			values.first = true;
			values.second = i;
			return values;
			}
		}
	values.first = false;
	values.second = 0;		
	return values;
}

/// * Funções que manipulam as variaveis temporarias *///
string geraVar() //Gera um nome para variavel Temporaria
{
	stringstream tempGerator;
	tempGerator << "_temp_" << temp_counter;
	temp_counter++ ;
	return tempGerator.str();
}		
string nova_temp_var(string tipo) //cria uma nova variavel temporaria
{
		variavel nova_var;
		nova_var.temp_name = geraVar();
		nova_var.orig_name = "__TEMP__";
		nova_var.tipo = tipo;
		nova_var.tipoReal = tipo;
		nova_var.isVet = false;
		escopo_list[nivel_escopo].back().variaveis.push_back(nova_var);
		return nova_var.temp_name;
}
variavel nova_temp_var_string(int tamanho) //cria uma nova variavel temporaria string
{
		variavel nova_var;
		nova_var.temp_name = geraVar();
		nova_var.orig_name = "__TEMP__";
		nova_var.tipo = "char";
		nova_var.tipoReal = "string";
		nova_var.isVet = false;
		nova_var.tamanho = tamanho;

		escopo_list[nivel_escopo].back().variaveis.push_back(nova_var);
		return nova_var;
}

variavel use_var(string var, string tipo) //Usado no uso de uma variavel ja existente!
{	
	return  procura_var(var, nivel_escopo);
}
variavel procura_var(string var, int nivel)
{ 
	if(nivel == -1)
	{
		yyerror("Variavel não inicializada");
	}
	else
	{
		vector<variavel> list_var = escopo_list[nivel].back().variaveis;	
		pair<bool, int> position = isIn(var, list_var);
		if(position.first)
		{
			return list_var[position.second];
		}
		else
		{	
			nivel--;
			return procura_var(var,nivel );
		}
	}
}

variavel useVarPorTempName(string var)
{
	return procuraVarPorTempName(var, escopo_list.size()-1);
}
variavel procuraVarPorTempName(string var, int nivel)
{


	if(nivel == -1)
	{
		printDeclaracoes();
		yyerror("Variavel não inicializada");
	}
	else
	{
		for (int j = 0; j < escopo_list[nivel].size(); j++)
		{
			vector<variavel> list_var = escopo_list[nivel][j].variaveis;	
			int i;
			for (i = 0; i < list_var.size(); i++)
			{
				if(var == list_var[i].temp_name)
				{	
					return list_var[i];
				}
			}
		}
		nivel--;
		return procuraVarPorTempName(var, nivel);

	}	
}

void resetaString(string var, int tamanho )
{
	procura_e_reseta_string(var, nivel_escopo,tamanho );
}

void procura_e_reseta_string(string var, int nivel, int tamanho )
{
	if(nivel == -1)
	{
		yyerror("Variavel não inicializada");
	}
	else
	{
		vector<variavel> list_var = escopo_list[nivel].back().variaveis;	
		pair<bool, int> position = isIn(var, list_var);
		if(position.first)
		{	
			escopo_list[nivel].back().variaveis[position.second].orig_name = "__TEMP__";
			nova_var_string(var, tamanho);
		}
		else
		{	
			nivel--;
			procura_e_reseta_string(var,nivel, tamanho );
		}
	}
}

void resetaVector(string var, string tipo, vector<string> tamanhos )
{
	procura_e_reseta_vector(var, nivel_escopo ,tipo , tamanhos );
}

void procura_e_reseta_vector(string var, int nivel , string tipo, vector<string> tamanhos)
{
	if(nivel == -1)
	{
		yyerror("Variavel não inicializada");
	}
	else
	{
		vector<variavel> list_var = escopo_list[nivel].back().variaveis;	
		pair<bool, int> position = isIn(var, list_var);
		if(position.first)
		{	
    		variavel v = escopo_list[nivel].back().variaveis[position.second];
			if(v.tipo != tipo)
				yyerror("Não é possivel atribuir um vetor a uma variavel de outro tipo");

			escopo_list[nivel].back().variaveis[position.second].orig_name = "__TEMP__";
			nova_var_vector(var, tipo, tamanhos);
		}
		else
		{	
			nivel--;
			procura_e_reseta_vector( var, nivel, tipo, tamanhos );
		}
	}
}


string nova_var(string var, string tipo) //Cria uma nova variavel (não-temp)
{

	Escopo escopo = escopo_list[nivel_escopo].back();
	pair<bool, int> retorno = isIn(var, escopo.variaveis);
	if(retorno.first)
	{
		yyerror("Ja existe uma variavel com esse nome");
	}
	else{

		variavel nova_var;
		nova_var.temp_name = geraVar();
		nova_var.orig_name = var;
		nova_var.tipo = tipo;
		nova_var.tipoReal = tipo;
		nova_var.isVet = false;
		escopo_list[nivel_escopo].back().variaveis.push_back(nova_var);
		return nova_var.temp_name;

	}
}
string nova_var_vector(string var, string tipo, vector<string> tamanhos)
{
	Escopo escopo = escopo_list[nivel_escopo].back();
	pair<bool, int> retorno = isIn(var, escopo.variaveis);
	if(retorno.first)
	{
		yyerror("Ja existe uma variavel com esse nome");
	}
	else
	{	
		variavel nova_var;
		nova_var.temp_name = geraVar();
		nova_var.orig_name = var;
		nova_var.tipo = tipo;
		nova_var.tipoReal = tipo;
		nova_var.isVet = true;	
		nova_var.colTamanhosLabels = tamanhos; 
		escopo_list[nivel_escopo].back().variaveis.push_back(nova_var);
		return nova_var.temp_name;
	}
}

string nova_var_string(string var, int tamanho) //Cria uma nova variavel string(não-temp)
{
	Escopo escopo = escopo_list[nivel_escopo].back();
	pair<bool, int> retorno = isIn(var, escopo.variaveis);
	if(retorno.first)
	{
		yyerror("Ja existe uma variavel com esse nome");
	}
	else
	{	
		variavel nova_var;
		nova_var.temp_name = geraVar();
		nova_var.orig_name = var;
		nova_var.tipo = "char";
		nova_var.tipoReal = "string";
		nova_var.isVet = false;
		nova_var.tamanho = tamanho;
		escopo_list[nivel_escopo].back().variaveis.push_back(nova_var);
		return nova_var.temp_name;
	}
}
string nova_global_var(string var, string tipo) //Cria uma nova variavel (não-temp)
{
	Escopo escopo = escopo_list[0].back();
	pair<bool, int> retorno = isIn(var, escopo.variaveis);
	if(retorno.first)
	{
		yyerror("Ja existe uma variavel no escopo global com esse nome");
	}
	else
	{	
		variavel nova_var;
		nova_var.temp_name = geraVar();
		nova_var.orig_name = var;
		nova_var.isVet = false;
		nova_var.tipoReal = tipo;
		nova_var.tipo = tipo;
		escopo_list[0].back().variaveis.push_back(nova_var);
		return nova_var.temp_name;
	}
}
string nova_global_var_string(string var, int tamanho) //Cria uma nova variavel (não-temp)
{
	Escopo escopo = escopo_list[0].back();
	pair<bool, int> retorno = isIn(var, escopo.variaveis);
	if(retorno.first)
	{
		yyerror("Ja existe uma variavel com esse nome");
	}
	else
	{	
		variavel nova_var;
		nova_var.temp_name = geraVar();
		nova_var.orig_name = var;
		nova_var.tipo = "char";
		nova_var.tipoReal = "string";
		nova_var.isVet = false;
		nova_var.tamanho = tamanho;
		escopo_list[0].back().variaveis.push_back(nova_var);
		return nova_var.temp_name;
	}
}

string nova_var_param(string var, string tipo) //Cria uma nova variavel (não-temp)
{

	Escopo escopo = escopo_list[nivel_escopo].back();
	variavel nova_var;
	nova_var.temp_name = geraVar();
	nova_var.orig_name = var;
	nova_var.tipo = tipo;
	nova_var.tipoReal = tipo;
	nova_var.isVet = false;
	escopo_list[nivel_escopo].back().variaveis.push_back(nova_var);
	
	nova_var.orig_name = "__TEMP__";
	escopo_list[0].back().variaveis.push_back(nova_var);
	return nova_var.temp_name;
}

string nova_var_param_string(string var, int tamanho) //Cria uma nova variavel string(não-temp)
{
	variavel nova_var;
	nova_var.temp_name = geraVar();
	nova_var.orig_name = var;
	nova_var.tipo = "char";
	nova_var.tipoReal = "string";
	nova_var.tamanho = tamanho;
	nova_var.isVet = false;
	escopo_list[nivel_escopo].back().variaveis.push_back(nova_var);
	nova_var.orig_name= "__TEMP__";
	escopo_list[0].back().variaveis.push_back(nova_var);
	return nova_var.temp_name;

}
string nova_var_param_vet(string var, string tipo, vector<string> tamanhos) //Cria uma nova variavel string(não-temp)
{

	variavel nova_var;
	nova_var.temp_name = geraVar();
	nova_var.orig_name = var;
	nova_var.tipo = tipo;
	nova_var.tipoReal = tipo;
	nova_var.isVet = true;	
	nova_var.colTamanhosLabels = tamanhos; 
	escopo_list[nivel_escopo].back().variaveis.push_back(nova_var);
	nova_var.orig_name= "__TEMP__";
	escopo_list[0].back().variaveis.push_back(nova_var);
	return nova_var.temp_name;

}

//Manipula funcao
funcao usaFuncao(string assinatura)
{
	return procuraFuncao(assinatura, nivel_escopo+1);	
}

pair<bool, int> isInFuncao(string assinatura, vector<funcao> L)
{
	pair<bool, int> values;
	int i;
	for (i = 0; i < L.size(); i++)
	{
		if(assinatura == L[i].assinatura)
		{
			values.first = true;
			values.second = i;
			return values;
		}
	}
	values.first = false;
	values.second = 0;		
	return values;
}

funcao procuraFuncao(string assinatura, int nivel)
{
	
	if(nivel < 0)
		yyerror("Funcao nao foi declarada");
	if(escopo_list.size() <= nivel){
		nivel--;
		procuraFuncao(assinatura, nivel);
	}		

	vector<funcao> list_func = escopo_list[nivel].back().funcoes;	
	pair<bool, int> retorno = isInFuncao(assinatura, list_func);
	if(retorno.first)
	{
		return escopo_list[nivel].back().funcoes[retorno.second];
	}
	else
	{
		nivel--;
		procuraFuncao(assinatura, nivel);
	}

}
funcao novaFuncao(string assinatura, vector<string> parametros)
{
	vector<variavel> colParametros;

	vector<funcao> list_func = escopo_list[nivel_escopo].back().funcoes;
	pair<bool, int> par = isInFuncao(assinatura, list_func);
	funcao nova_funcao;

	if(par.first){
		yyerror("Funcao ja foi declarada no escopo");
	}
	else
	{
		for (int i = 0; i < parametros.size(); i++)
		{
			colParametros.push_back(procuraVarPorTempName(parametros[i], nivel_escopo));
		}

		nova_funcao.parametros = colParametros;
		nova_funcao.assinatura = assinatura;
		nova_funcao.temp_name = geraFunc();
		escopo_list[nivel_escopo].back().funcoes.push_back(nova_funcao);
		return nova_funcao;
	}
}

string geraFunc()
{
	stringstream tempGerator;
	tempGerator << "funcao_temp" << temp_func_counter;
	temp_func_counter++ ;
	return tempGerator.str();
}

void atualizaFuncTraducao(string var, string traducao)
{
	int posicao = procuraFuncPorTempName(var);
	escopo_list[nivel_escopo].back().funcoes[posicao].traducao = traducao;
}
void atualizaFuncRetorno(vector<string> retorno)
{
	vector<variavel> colRetornos;	
	for (int j = 0; j < retorno.size(); j++)
	{
		colRetornos.push_back(procuraVarPorTempName(retorno[j], nivel_escopo));
	}

	escopo_list[nivel_escopo].back().funcoes.back().retornos = colRetornos;
}


int procuraFuncPorTempName(string var)
{
	vector<funcao> L = escopo_list[nivel_escopo].back().funcoes;
	int i;
	for (i = 0; i < L.size(); i++)
	{
		if(var == L[i].temp_name)
		{
			return  i;
		}
	}	
	return 0;

}

//Funções que são usadas na tradução. 
////Servem para não precisar repetir codigo e juntar todo o teste de tipos no mesmo lugar
string aritmeticoTraducao(atributos $$, atributos $1, atributos $2, atributos $3){	
	stringstream traducao;
	if(($1.tipo == "int") & ($3.tipo == "float"))
	{
		traducao << $1.traducao << $3.traducao;
		
		string a = nova_temp_var( "float");
		
		traducao << "\t" << a << " = (float)" << $1.label << ";\n"; 
		traducao << "\t" << $$.label <<" = " << a << " "<<$2.traducao<<" " << $3.label<< ";\n";
		return traducao.str();
	}
	if(($1.tipo == "float") & ($3.tipo == "int"))
	{
		traducao << $1.traducao << $3.traducao;
		
		string a = nova_temp_var( "float");
		
		traducao << "\t" << a << " = (float)" << $3.label << ";\n"; 
		traducao << "\t" << $$.label <<" = " << $1.label << " "<<$2.traducao<<" " << a<< ";\n";
		return traducao.str();
	}
	traducao << $1.traducao << $3.traducao << "\t" << $$.label <<" = " << $1.label << " "<<$2.traducao<<" " << $3.label<< ";\n";
	
	return traducao.str();
}

string relacionalTraducao(atributos $$, atributos $1, atributos $2, atributos $3){	
	stringstream traducao;
	if(($1.tipo == "int") & ($3.tipo == "float"))
	{
		traducao << $1.traducao << $3.traducao;
		
		string a = nova_temp_var("int");
		
		traducao << "\t" << a << " = (int)" << $3.label << ";\n"; 
		traducao << "\t" << $$.label <<" = " << a << " "<<$2.traducao<<" " << $3.label<< ";\n";
		return traducao.str();
	}
	if(($1.tipo == "float") & ($3.tipo == "int"))
	{
		traducao << $1.traducao << $3.traducao;
		
		string a = nova_temp_var("int");
		
		traducao << "\t" << a << " = (int)" << $1.label << ";\n"; 
		traducao << "\t" << $$.label <<" = " << $1.label << " "<<$2.traducao<<" " << a<< ";\n";
		return traducao.str();
	}
	traducao << $1.traducao << $3.traducao << "\t" << $$.label <<" = " << $1.label << " "<<$2.traducao<<" " << $3.label<< ";\n";
	
	return traducao.str();
}
string logicoTraducao(atributos $$, atributos $1, atributos $2, atributos $3){	
	stringstream traducao;
	traducao << $1.traducao << $3.traducao << "\t" << $$.label <<" = " << $1.label << " "<<$2.traducao<<" " << $3.label<< ";\n";
	return traducao.str();
}
///* Funções que manipulam as operações *///
void adicionaOperacoes(){
	operacao op; 
	//ARITMETICOs
	op.tipoDireita = "int";		op.tipoEsquerda = "int";	op.tipoResultante = "int";		op.tipoReal = "int";	op.operacao = "ARITMETICO";
	list_op.push_back(op);
	op.tipoDireita = "int";		op.tipoEsquerda = "float";	op.tipoResultante = "float";	op.tipoReal = "float";	op.operacao = "ARITMETICO";
	list_op.push_back(op);
	op.tipoDireita = "float";	op.tipoEsquerda = "float";	op.tipoResultante = "float";	op.tipoReal = "float";	op.operacao = "ARITMETICO";
	list_op.push_back(op);
	op.tipoDireita = "string";	op.tipoEsquerda = "string";	op.tipoResultante = "char[]";	op.tipoReal = "string";	op.operacao = "ARITMETICO";
	list_op.push_back(op);
	//relacionais
	op.tipoDireita = "int";		op.tipoEsquerda = "int";	op.tipoResultante = "int";		op.tipoReal = "bool";	op.operacao = "relacional";
	list_op.push_back(op);
	op.tipoDireita = "int";		op.tipoEsquerda = "float";	op.tipoResultante = "int";		op.tipoReal = "bool";	op.operacao = "relacional";
	list_op.push_back(op);
	op.tipoDireita = "float";	op.tipoEsquerda = "float";	op.tipoResultante = "int"; 		op.tipoReal = "bool";	op.operacao = "relacional";
	list_op.push_back(op);
	op.tipoDireita = "char";	op.tipoEsquerda = "char";	op.tipoResultante = "int"; 		op.tipoReal = "bool";	op.operacao = "relacional";
	list_op.push_back(op);
	op.tipoDireita = "bool";	op.tipoEsquerda = "bool";	op.tipoResultante = "int"; 		op.tipoReal = "bool";	op.operacao = "relacional";
	list_op.push_back(op);
	//logicos
	op.tipoDireita = "bool";	op.tipoEsquerda = "bool";	op.tipoResultante = "int"; 		op.tipoReal = "bool";	op.operacao = "logico";
	list_op.push_back(op);
}
operacao getTipoResultante(string tipoDireita, string tipoEsquerda, string op){
	int i;
	for (i = 0; i < list_op.size(); i++)
	{
		if(list_op[i].tipoDireita == tipoDireita and list_op[i].tipoEsquerda == tipoEsquerda and list_op[i].operacao == op )
		{
			return list_op[i];
		}
		if(list_op[i].tipoEsquerda == tipoDireita and list_op[i].tipoDireita == tipoEsquerda and list_op[i].operacao == op )
		{
			return list_op[i];
		}
	}
	yyerror("operação nao realizavel");
	operacao operacaoErrada;
	operacaoErrada.tipoReal = " "; 
	return operacaoErrada;
}

// Varre todas as variaveis e printa a declaração
void printDeclaracoes(){
	int i;
	for (i = escopo_list.size()-1 ; i >= 0; i--)
	{
		vector<Escopo> list_escopos = escopo_list[i];
		int h;
		for (h = 0; h < list_escopos.size(); h++)
		{
			vector<variavel> list_var = list_escopos[h].variaveis;
			cout << "\n// Escopo: " <<  h << " do nivel: " << i << endl;
			int j;
			for (j = 0; j < list_var.size(); j++)
			{
				if(list_var[j].tipo == "char" & list_var[j].tamanho > 0)
					cout <<"\t"<< list_var[j].tipo << " " << list_var[j].temp_name<<'['<< list_var[j].tamanho<<']' << ";" << "  // "<< "nivel_escopo:" << i <<"  "<< list_var[j].orig_name << endl;
				else if (list_var[j].isVet)
					cout <<"\t//"<< list_var[j].tipo << " " << list_var[j].temp_name << ";" << "  // "<< "nivel_escopo:" << i <<"  "<< list_var[j].orig_name << endl;	
				else
					cout <<"\t"<< list_var[j].tipo << " " << list_var[j].temp_name  << ";" << "  // "<< "nivel_escopo:" << i <<"  "<< list_var[j].orig_name << endl;
			}
		}		
	}
}
void printAssinaturas(){
	int i;
	for (i = escopo_list.size()-1 ; i >= 0; i--)
	{
		vector<Escopo> list_escopos = escopo_list[i];
		int h;
		for (h = 0; h < list_escopos.size(); h++)
		{
			vector<funcao> lista_funcao = list_escopos[h].funcoes;
			int j;
			for (j = 0; j < lista_funcao.size(); j++)
			{
				cout <<"\tvoid "<< lista_funcao[j].temp_name << "();\n";
			}
		}		
	}
}
void printFuncoes(){
	int i;
	for (i = escopo_list.size()-1 ; i >= 0; i--)
	{
		vector<Escopo> list_escopos = escopo_list[i];
		int h;
		for (h = 0; h < list_escopos.size(); h++)
		{
			vector<funcao> lista_funcao = list_escopos[h].funcoes;
			int j;
			for (j = 0; j < lista_funcao.size(); j++)
			{
				cout <<"void "<< lista_funcao[j].temp_name << "()\n";
				cout <<"{\n" << lista_funcao[j].traducao << "\n}\n"; 
			}
		}		
	}
}