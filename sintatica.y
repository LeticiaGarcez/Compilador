%{
#include <iostream>
#include <string>
#include <sstream>
#include <vector>
#include <utility>
#define YYSTYPE atributos
using namespace std;
struct meta_variavel
{
	string temp_name;
	string orig_name;
	int tamanho;
	string tipo;
	string tipoReal;
};
struct Escopo
{
	int nivel;
	string inicio;
	string fim;
	bool isIf;
	vector<meta_variavel> variaveis;
};
struct atributos
{
	string tipoReal; // Tipo no lule
	string tipo; // Tipo no C
	string label;
	string traducao;
	int tamanho;
};
struct operacao
{
	string tipoEsquerda;
	string tipoDireita;
	string tipoResultante;
	string tipoReal; // Tipo lule
	string operacao;
};
//Manipula Operações
void adicionaOperacoes();
operacao getTipoResultante(string, string, string);
//usefull methods
pair<bool, int> isIn(string, vector<meta_variavel>);
void printDeclaracoes();
//manipula label de escopo
pair<string,string> geraLabelEscopo();
string getLabelEscopoInicio();
string getLabelEscopoFim();
string getLabelContinue();
string getLabelBreak();
string getLabelContinue(int);
string getLabelBreak(int);
string getSuperLabelContinue();
string getSuperLabelBreak();
string getSuperLabelContinue(int);
string getSuperLabelBreak(int);
//manipula labels Condicao
void criaLabelCondicao();
string getLabelCondicaoInicio();
string getLabelCondicaoFim();
void criaLabelFimCondicoes(); // Cria a label do fim de TODAS as condições
string getLabelFimCondicoes(); //Pega a label do fim de TODAS as condições
//manipula variaveis
string geraVar();
string nova_temp_meta_var(string);
meta_variavel nova_temp_meta_var_string(int);
meta_variavel use_meta_var(string, string);
meta_variavel procura_meta_var(string, int);
string nova_meta_var(string, string);
string nova_meta_var_string(string, int);
string nova_global_meta_var(string, string);
string nova_global_meta_var_string(string, int); //Cria uma nova variavel (não-temp)
void resetaString(string, int);
void procura_e_reseta(string , int, int );

//Traduções
string aritmeticoTraducao(atributos, atributos, atributos, atributos);
string relacionalTraducao(atributos, atributos, atributos, atributos);
string logicoTraducao(atributos, atributos, atributos, atributos);
//Manipula Escopo
void desceEscopo(bool);
void sobeEscopo();
int yylex(void);
void yyerror(string);
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
%token TK_BREAK TK_CONTINUE
//Bloco
%token TK_ABRE TK_FECHA
//func + do
%token TK_FUNC TK_DO
//read write
%token TK_READ TK_WRITE 

%token TK_SUPER
%token TK_MAIN TK_ID 
%token TK_FIM TK_ERROR TK_END_E TK_FIMLINHA
%start S
%left '-'
%left '+'
%left '*'
%left '/'
%%
S 			: FUNC TK_MAIN '(' ')' BLOCO
			{
				cout << "/*Compilador FOCA*/\n" << "#include <iostream> \n#include <string.h> \n#include <stdio.h>\nusing namespace std;\n#define true 1 \n#define false 0 \nint main(void)\n{\n" << endl;
				printDeclaracoes();
				cout <<"\n\n\n"<< $5.traducao << "\treturn 0;\n}" << endl;  
			}
			;
FUNC		: TK_FUNC
			{
				desceEscopo(false);
			}
			;

BLOCO		: TK_ABRE COMANDOS FECHA
			{
				$$.traducao = $2.traducao;
			}
			;
BLOCO_EXP	: ABRE COMANDOS FECHA
			{
				$$.traducao = $2.traducao;
			}
			;

BLOCO_ALTER: TK_ABRE COMANDOS TK_FECHA
			{
				$$.traducao = $2.traducao;
			}
			;

ABRE 		: TK_ABRE
			{
				desceEscopo(false);	
			}
			;

FECHA 		: TK_FECHA
			{
				sobeEscopo();	
			}
			;
VOLTA_ESCOPO : {sobeEscopo();}
COMANDOS	: COMANDO ';' COMANDOS
			{ 
				$$.traducao = $1.traducao + $3.traducao;		
			}
			| COMANDO ';'
			{
				$$.traducao = $1.traducao;
			}
			| BLOCO_EXP
			| CONDICIONAIS COMANDOS
			{ 
				$$.traducao = $1.traducao + $2.traducao;		
			}
			| COMANDO_LOOPS COMANDOS
			{
				$$.traducao = $1.traducao + $2.traducao;	
			}
			| CONDICIONAIS
			| COMANDO_LOOPS
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
			 ;
// Condicionais e Traduções 
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

IF 			: TK_IF { desceEscopo(true); criaLabelFimCondicoes();	};

ELSE 		: TK_ELSE {	desceEscopo(true); };

// Loops e Traduções
COMANDO_LOOPS:
			| COMANDO_FOR
			| COMANDO_WHILE
			| COMANDO_DOWHILE
			;

COMANDO_FOR : FOR '(' CONDICAO ')' BLOCO
			{
				$$.traducao = "\n" + getLabelEscopoInicio()+":\n"; // label Inicial Do Bloco
				$$.traducao += $3.traducao; //traducao da condicao
				$$.traducao += "\n\tif (!("+ $3.label +")) goto " + getLabelEscopoFim() +";"; //if (condicao) goto labelFinal
				$$.traducao += "\n" + $5.traducao; //BLOCO
				$$.traducao += "\n\t goto " + getLabelEscopoInicio()+";"; //goto LabelInicio
				$$.traducao += "\n" + getLabelEscopoFim()+":\n\n"; // Label Final
			}
			|FOR '(' CONDICAO ')' COMANDO ';' VOLTA_ESCOPO
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
			| FOR '(' ATRIB ';' CONDICAO ';' ATRIB ')' COMANDO ';' VOLTA_ESCOPO
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

CONDICAO 	: RELACIONAL
			| LOGICO
			;

BREAK 		: TK_BREAK
			{
				$$.traducao = "\tgoto " + getLabelBreak()+";\n";
			}
			;

CONTINUE	: TK_CONTINUE
			{
				$$.traducao = "\tgoto " + getLabelContinue()+";\n";
			}
			;
SUPERBREAK 		: TK_SUPER TK_BREAK
			{
				$$.traducao = "\tgoto " + getSuperLabelBreak()+";\n";
			}
			;

SUPERCONTINUE	: TK_SUPER TK_CONTINUE
			{
				$$.traducao = "\tgoto " + getSuperLabelContinue()+";\n";
			}
			;

COMANDO 	: ATRIB
			| OPERACAO
			| BREAK
			| CONTINUE
			| SUPERBREAK
			| SUPERCONTINUE
			| DECLARA
			| CMD_COUT
			| CMD_CIN
			;
OPERACAO 	: ARITMETICO
			| LOGICO
			| RELACIONAL
			| CONCATENACAO
			;

ARITMETICO	: ARITMETICO OP_ARITMETICO ARITMETICO
			{
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "ARITMETICO");
				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;
				
				$$.label = nova_temp_meta_var( $$.tipo);
				$$.traducao = aritmeticoTraducao($$, $1, $2, $3);
				
			}
			|OP
			;

OP_ARITMETICO: TK_RAZAO | TK_MAIS | TK_MENOS | TK_MULT ;

CONCATENACAO: CONCATENACAO TK_CONCAT CONCATENACAO
			{
				$$.tipo = "char[]";
				$$.tipoReal = "string";
				meta_variavel var = nova_temp_meta_var_string( $1.tamanho + $3.tamanho); 
				$$.label = var.temp_name; 
				$$.tamanho = $1.tamanho + $3.tamanho;
				if($1.tipoReal == "string" & $3.tipoReal == "string")
					$$.traducao = $1.traducao + $3.traducao +"\n\t strcat("+$$.label+","+$1.label+");\n\t strcat("+$$.label+","+$3.label+");\n"; 
				else
					yyerror("Não, Braida, ainda não fiz isso");
				//$$.label = nova_meta_var_string()
			}
			|OP
			;


RELACIONAL	: RELACIONAL OP_RELACIONAL RELACIONAL
			{
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "relacional");

				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;				
				$$.label = nova_temp_meta_var( $$.tipo);
				
				$$.traducao = relacionalTraducao($$, $1, $2, $3);
			}
			|OP
			;

OP_RELACIONAL : TK_DIFERENTE | TK_IGUAL | TK_MENOR | TK_MAIOR ;

LOGICO		: LOGICO OP_LOGICO LOGICO
			{ 
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "logico");

				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;
				$$.label = nova_temp_meta_var( $$.tipo);

				$$.traducao = logicoTraducao($$, $1, $2, $3);
			}	
			| RELACIONAL OP_LOGICO RELACIONAL
			{ 
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "logico");

				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;
				$$.label = nova_temp_meta_var( $$.tipo);

				$$.traducao = logicoTraducao($$, $1, $2, $3);
			}	
			| LOGICO OP_LOGICO RELACIONAL
			{ 
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "logico");

				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;
				$$.label = nova_temp_meta_var( $$.tipo);

				$$.traducao = logicoTraducao($$, $1, $2, $3);
			}	
			| RELACIONAL OP_LOGICO LOGICO
			{ 
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "logico");

				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;
				$$.label = nova_temp_meta_var( $$.tipo);

				$$.traducao = logicoTraducao($$, $1, $2, $3);
			}
			|OP
			;

OP_LOGICO	: TK_AND | TK_OR ;


OP			: TK_NUM
			{
				$$.label =  nova_temp_meta_var( $1.tipo);
				$$.traducao = "\t" + $$.label + " = " + $1.traducao + ";\n";	
				$$.tamanho = $$.traducao.size();		
			}
			| TK_STR
			{
				meta_variavel temp;
				temp =  nova_temp_meta_var_string($1.traducao.size()-2);
				$$.label = temp.temp_name;
				$$.tipo = temp.tipo;
				$$.tamanho = temp.tamanho;
				$$.traducao = "\t strcpy(" + $$.label + "," + $1.traducao + ");\n";				
			}
			| TK_ID
			{	
				meta_variavel var = use_meta_var($$.label, " ");
				$$.label =  var.temp_name;
				$$.tamanho = var.tamanho;
				$$.tipo = var.tipo;
				$$.tipoReal = var.tipoReal;
				$$.traducao = "";
			}
			| TK_BOOL
			{
				$$.label =  nova_temp_meta_var( $1.tipo);
				$$.traducao = "\t" + $$.label + " = " + $1.traducao + ";\n";			
			}
			| TK_REAL
			{
				$$.tamanho = $$.traducao.size();
				$$.label =  nova_temp_meta_var( $1.tipo);
				$$.traducao = "\t" + $$.label + " = " + $1.traducao + ";\n";			
			}
			| TK_CHAR
			{
				$$.tamanho = $$.traducao.size()-2;
				$$.label =  nova_temp_meta_var( $1.tipo);
				$$.traducao = "\t" + $$.label + " = " + $1.traducao + ";\n";			
			}
			;

DECLARA 	: TK_VAR TIPO TK_ID // var int a
			{
				if($2.tipoReal == "string"){
					$$.label = nova_meta_var_string($3.label, 0);
					$$.traducao = " ";
					$$.tipoReal = $2.tipoReal;
					$$.tipo = $2.tipo;
				}else
				{
	 				$$.traducao = " ";
	 				$$.label = nova_meta_var($3.label, $2.tipo);
	 			}
 			}
			| TK_GLOBAL TK_VAR TIPO TK_ID // global var int a;
			{
				$$.traducao = " ";
				$$.label = nova_global_meta_var($4.label, $3.tipo);
 			}
 			;

ATRIB 		: TK_VAR TK_ID TK_ATRIB OPERACAO // var a = 4
			{
				if($4.tipoReal == "string"){
			 		//faço uma parada especial
			 		$$.traducao = $4.traducao+ "\t strcpy("+ nova_meta_var_string($2.label, $4.tamanho) + ", " +$4.label+ ");\n";
			 	}else
			 	{
			 		$$.traducao = $4.traducao+ "\t"+ nova_meta_var($2.label, $4.tipo) + " = " + $4.label+ ";\n";
			 	}
			}
			| TK_VAR TIPO TK_ID TK_ATRIB OPERACAO // var int a = 4
			{

				if($2.tipoReal == "string" && $5.tipoReal == "string")
				{
					$$.traducao = $5.traducao+ "\t strcpy("+ nova_meta_var_string($3.label, $5.tamanho) + ", " +$5.label+ ");\n";	
				}
				else if( ($2.tipoReal == "string" && $5.tipoReal != "string")||($2.tipoReal != "string" && $5.tipoReal == "string"))
				{
					yyerror("Não é possivel fazer essa atribuição");
				}
				else
				{
			 		$$.traducao = $5.traducao+ "\t"+ nova_meta_var($3.label, $2.tipo) + " = " + "("+$2.tipo+")"+$5.label+ ";\n";
				}
			}
			//Globais
 			| TK_GLOBAL TK_VAR TK_ID TK_ATRIB OPERACAO //global var a = 4
			{
			 	
				if($5.tipoReal == "string")
				{
					$$.traducao = $5.traducao+ "\t strcpy("+ nova_global_meta_var_string($3.label, $5.tamanho) + ", " +$5.label+ ");\n";	
				}
				else
				{
			 		$$.traducao = $5.traducao+ "\t"+ nova_global_meta_var($3.label, $5.tipo) + " = " + $5.label+ ";\n";
				}
			 }
			| TK_GLOBAL TK_VAR TIPO TK_ID TK_ATRIB OPERACAO //global var int a = 4
			{
				if($3.tipoReal == "string" && $6.tipoReal == "string")
				{
					$$.traducao = $6.traducao+ "\t strcpy("+ nova_global_meta_var_string($4.label, $6.tamanho) + ", " +$6.label+ ");\n";	
				}
				else if( ($3.tipoReal == "string" && $6.tipoReal != "string")||($3.tipoReal != "string" && $6.tipoReal == "string"))
				{
					yyerror("Não é possivel fazer essa atribuição");
				}
				else
				{
			 		$$.traducao = $6.traducao+ "\t"+ nova_global_meta_var($4.label, $3.tipo) + " = " + "("+$3.tipo+")"+$6.label+ ";\n";
				}
			 }
 			| TK_ID TK_ATRIB OPERACAO // a = 4;
 			{
 				if($3.tipoReal == "string"){
 					resetaString($1.label, $3.tamanho);
 					meta_variavel var = use_meta_var($1.label, $3.tipo);				
 					$$.traducao = $3.traducao+"\t strcpy(" + var.temp_name + "," + $3.label+ ");\n";
 				}else{
 					meta_variavel var = use_meta_var($1.label, $3.tipo);
 					$$.traducao = $3.traducao+"\t" + var.temp_name + " = " + $3.label+ ";\n";
 				}

 			}
 			| TK_ID TK_MAIS TK_MAIS // a++
 			{
 				 meta_variavel var = use_meta_var($1.label, $1.tipo);
 				$$.traducao = "\t" + var.temp_name + " = " + var.temp_name + "+ 1;\n";
 			}
 			| TK_ID TK_MENOS TK_MENOS // a--
 			{
 				meta_variavel var = use_meta_var($1.label, $1.tipo);
 				$$.traducao = "\t" + var.temp_name + " = " + var.temp_name + "- 1;\n";
 			}
 			;	

TIPO 		: TK_TIPO_BOOL
 			| TK_TIPO_FLOAT
 			| TK_TIPO_CHAR
 			| TK_TIPO_INT
 			| TK_TIPO_STRING
 			;

CMD_CIN 	:  TK_VAR TIPO TK_ID TK_ATRIB TK_READ 
			{

				if($2.tipoReal == "string"){
					nova_meta_var_string($3.label, 0);
 					resetaString($3.label, 1024);
 					meta_variavel var = use_meta_var($3.label, $3.tipo);
					$$.traducao = "\t cin << " + var.temp_name + " ;\n";	
				}else
				{
	 				$$.label = nova_meta_var($3.label, $2.tipo);
					$$.traducao = "\t cin << " + $$.label + " ;\n";
				}
			}
			| TK_GLOBAL TK_VAR TIPO TK_ID TK_ATRIB TK_READ// global var int a;
			{
				if($3.tipoReal == "string"){
					nova_meta_var_string($4.label, 0);
 					resetaString($4.label, 1024);
 					meta_variavel var = use_meta_var($4.label, $4.tipo);
					$$.traducao = "\tcin << " + var.temp_name + " ;\n";	
				}else
				{
	 				$$.label = nova_meta_var($4.label, $3.tipo);
					$$.traducao = "\tcin << " + $$.label + " ;\n";
				}
 			}
			| TK_READ '('TK_ID')'
			{
				if($3.tipoReal == "string"){
 					resetaString($3.label, 1024);
 					meta_variavel var = use_meta_var($3.label, $3.tipo);
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

%%
#include "lex.yy.c"
			
int temp_counter = 0;
int label_counter = 0;
int nivel_escopo = -1;
int label_fim_condicoes_counter = 0;
int condicao_counter = 0;

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
	vector<meta_variavel> list_meta_var;	
	escopo.variaveis = list_meta_var;
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
pair<bool, int> isIn(string var, vector<meta_variavel> L)
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
// Varre todas as variaveis e printa a declaração
void printDeclaracoes(){
	int i;
	for (i = escopo_list.size()-1 ; i >= 0; i--)
	{
		vector<Escopo> list_escopos = escopo_list[i];
		int h;
		for (h = 0; h < list_escopos.size(); h++)
		{
			vector<meta_variavel> list_meta_var = list_escopos[h].variaveis;
			cout << "// " <<  list_escopos[h].inicio << " " << h << endl;
			int j;
			for (j = 0; j < list_meta_var.size(); j++)
			{
				if(list_meta_var[j].tipo == "char" & list_meta_var[j].tamanho > 0)
					cout <<"\t"<< list_meta_var[j].tipo << " " << list_meta_var[j].temp_name<<'['<< list_meta_var[j].tamanho<<']' << ";" << "  // "<< "nivel_escopo:" << i <<"  "<< list_meta_var[j].orig_name << endl;
				else
					cout <<"\t"<< list_meta_var[j].tipo << " " << list_meta_var[j].temp_name  << ";" << "  // "<< "nivel_escopo:" << i <<"  "<< list_meta_var[j].orig_name << endl;
			}
		}		
	}
}
/// * Funções que manipulam as variaveis temporarias *///
string geraVar() //Gera um nome para variavel Temporaria
{
	stringstream tempGerator;
	tempGerator << "_temp_" << temp_counter;
	temp_counter++ ;
	return tempGerator.str();
}		
string nova_temp_meta_var(string tipo) //cria uma nova variavel temporaria
{
		meta_variavel nova_meta_var;
		nova_meta_var.temp_name = geraVar();
		nova_meta_var.orig_name = "__TEMP__";
		nova_meta_var.tipo = tipo;
		escopo_list[nivel_escopo].back().variaveis.push_back(nova_meta_var);
		return nova_meta_var.temp_name;
}
meta_variavel nova_temp_meta_var_string(int tamanho) //cria uma nova variavel temporaria string
{
		meta_variavel nova_meta_var;
		nova_meta_var.temp_name = geraVar();
		nova_meta_var.orig_name = "__TEMP__";
		nova_meta_var.tipo = "char";
		nova_meta_var.tamanho = tamanho;

		escopo_list[nivel_escopo].back().variaveis.push_back(nova_meta_var);
		return nova_meta_var;
}

meta_variavel use_meta_var(string var, string tipo) //Usado no uso de uma variavel ja existente!
{	
	 
	return  procura_meta_var(var, nivel_escopo);
}
meta_variavel procura_meta_var(string var, int nivel)
{
	if(nivel == -1)
	{
		yyerror("Variavel não inicializada");
	}
	else
	{
		vector<meta_variavel> list_meta_var = escopo_list[nivel].back().variaveis;	
		pair<bool, int> position = isIn(var, list_meta_var);
		if(position.first)
		{
			return list_meta_var[position.second];
		}
		else
		{	
			nivel--;
			return procura_meta_var(var,nivel );
		}
	}
}
void resetaString(string var, int tamanho )
{
	procura_e_reseta(var, nivel_escopo,tamanho );
}

void procura_e_reseta(string var, int nivel, int tamanho )
{
	if(nivel == -1)
	{
		yyerror("Variavel não inicializada");
	}
	else
	{
		vector<meta_variavel> list_meta_var = escopo_list[nivel].back().variaveis;	
		pair<bool, int> position = isIn(var, list_meta_var);
		if(position.first)
		{	
			escopo_list[nivel].back().variaveis[position.second].orig_name = "__TEMP__";
			nova_meta_var_string(var, tamanho);
		}
		else
		{	
			nivel--;
			procura_e_reseta(var,nivel, tamanho );
		}
	}
}
string nova_meta_var(string var, string tipo) //Cria uma nova variavel (não-temp)
{
	Escopo escopo = escopo_list[nivel_escopo].back();
	pair<bool, int> retorno = isIn(var, escopo.variaveis);
	if(retorno.first)
	{
		yyerror("Ja existe uma variavel com esse nome");
	}
	else
	{	
		if(tipo == "char[]"){
			
			meta_variavel nova_meta_var;
			nova_meta_var.temp_name = geraVar();
			nova_meta_var.orig_name = var;
			nova_meta_var.tamanho = 0;
			nova_meta_var.tipo = "char";
			nova_meta_var.tipoReal = "string";
			escopo_list[nivel_escopo].back().variaveis.push_back(nova_meta_var);
			return nova_meta_var.temp_name;

		}
		else{
			meta_variavel nova_meta_var;
			nova_meta_var.temp_name = geraVar();
			nova_meta_var.orig_name = var;
			nova_meta_var.tipo = tipo;
			escopo_list[nivel_escopo].back().variaveis.push_back(nova_meta_var);
			return nova_meta_var.temp_name;
		}
	}
}
string nova_meta_var_string(string var, int tamanho) //Cria uma nova variavel string(não-temp)
{
	Escopo escopo = escopo_list[nivel_escopo].back();
	pair<bool, int> retorno = isIn(var, escopo.variaveis);
	if(retorno.first)
	{
		yyerror("Ja existe uma variavel com esse nome");
	}
	else
	{	
		meta_variavel nova_meta_var;
		nova_meta_var.temp_name = geraVar();
		nova_meta_var.orig_name = var;
		nova_meta_var.tipo = "char";
		nova_meta_var.tipoReal = "string";
		nova_meta_var.tamanho = tamanho;
		escopo_list[nivel_escopo].back().variaveis.push_back(nova_meta_var);
		return nova_meta_var.temp_name;
	}
}
string nova_global_meta_var(string var, string tipo) //Cria uma nova variavel (não-temp)
{
	Escopo escopo = escopo_list[0].back();
	pair<bool, int> retorno = isIn(var, escopo.variaveis);
	if(retorno.first)
	{
		yyerror("Ja existe uma variavel no escopo global com esse nome");
	}
	else
	{	
		meta_variavel nova_meta_var;
		nova_meta_var.temp_name = geraVar();
		nova_meta_var.orig_name = var;
		nova_meta_var.tipo = tipo;
		escopo_list[0].back().variaveis.push_back(nova_meta_var);
		return nova_meta_var.temp_name;
	}
}
string nova_global_meta_var_string(string var, int tamanho) //Cria uma nova variavel (não-temp)
{
	Escopo escopo = escopo_list[0].back();
	pair<bool, int> retorno = isIn(var, escopo.variaveis);
	if(retorno.first)
	{
		yyerror("Ja existe uma variavel com esse nome");
	}
	else
	{	
		meta_variavel nova_meta_var;
		nova_meta_var.temp_name = geraVar();
		nova_meta_var.orig_name = var;
		nova_meta_var.tipo = "char";
		nova_meta_var.tipoReal = "string";
		nova_meta_var.tamanho = tamanho;
		escopo_list[0].back().variaveis.push_back(nova_meta_var);
		return nova_meta_var.temp_name;
	}
}
//Funções que são usadas na tradução. 
////Servem para não precisar repetir codigo e juntar todo o teste de tipos no mesmo lugar
string aritmeticoTraducao(atributos $$, atributos $1, atributos $2, atributos $3){	
	stringstream traducao;
	if(($1.tipo == "int") & ($3.tipo == "float"))
	{
		traducao << $1.traducao << $3.traducao;
		
		string a = nova_temp_meta_var( "float");
		
		traducao << "\t" << a << " = (float)" << $1.label << ";\n"; 
		traducao << "\t" << $$.label <<" = " << a << " "<<$2.traducao<<" " << $3.label<< ";\n";
		return traducao.str();
	}
	if(($1.tipo == "float") & ($3.tipo == "int"))
	{
		traducao << $1.traducao << $3.traducao;
		
		string a = nova_temp_meta_var( "float");
		
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
		
		string a = nova_temp_meta_var("int");
		
		traducao << "\t" << a << " = (int)" << $3.label << ";\n"; 
		traducao << "\t" << $$.label <<" = " << a << " "<<$2.traducao<<" " << $3.label<< ";\n";
		return traducao.str();
	}
	if(($1.tipo == "float") & ($3.tipo == "int"))
	{
		traducao << $1.traducao << $3.traducao;
		
		string a = nova_temp_meta_var("int");
		
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
