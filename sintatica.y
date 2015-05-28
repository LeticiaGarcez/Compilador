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
	string tipo;
};


struct atributos
{
	string tipoReal;
	string tipo;
	string label;
	string traducao;
};

struct operacao
{
	string tipoEsquerda;
	string tipoDireita;
	string tipoResultante;
	string tipoReal;
	string operacao;
};

string geraVar();
string get_meta_var(string);
void printList();
pair<bool, int> isIn(string, vector<meta_variavel>);
string use_meta_var(string, string);
pair<bool, int> isIn(string, vector<meta_variavel>);
void adicionaOperacoes();
operacao getTipoResultante(string, string, string);

int yylex(void);
void yyerror(string);

%}

//Operacoes Aritimeticas
%token TK_MAIS TK_MENOS TK_MULT TK_RAZAO TK_POTENCIA
//Operacoes logica
%token TK_AND TK_OR
//Operacores relacionais
%token TK_MAIOR TK_MENOR TK_DIFERENTE TK_IGUAL
//ATRIBUICAO
%token TK_ATRIB
//TIPOS
%token TK_TIPO_STRING TK_TIPO_FLOAT TK_TIPO_CHAR TK_TIPO_BOOL TK_TIPO_INT
//VALORES
%token TK_NUM TK_VAR TK_REAL TK_CHAR TK_BOOL 
//Condicionais
%token TK_WHILE TK_FOR TK_SWITCH TK_CASE TK_IF TK_ELSE 

//
%token TK_MAIN TK_ID 
%token TK_FIM TK_ERROR TK_END_E TK_FIMLINHA

%start S

%left '-'
%left '+'
%left '*'
%left '/'

%%

S 			: TK_TIPO_INT TK_MAIN '(' ')' BLOCO
			{
				 cout << "/*Compilador FOCA*/\n" << "#include <iostream> \n#include <string.h> \n#include <stdio.h>\n#define true 1 \n#define false 0 \nint main(void)\n{\n" << $5.traducao << "\treturn 0;\n}" << endl;  
			}
			;

BLOCO		: '{' COMANDOS '}'
			{
				$$.traducao = $2.traducao;
			}
			;

COMANDOS	: COMANDO ';' COMANDOS
			{ 
				$$.traducao = $1.traducao + $3.traducao;		
			}
			| COMANDO ';'
			{
				$$.traducao = $1.traducao;
			}
			;

COMANDO 	: ATRIB
			| OPERACAO
			;

OPERACAO 	: ARITMETICO
			| LOGICO
			| RELACIONAL
			//| '(' OPERACAO ')'
			//{
			//	$$.traducao = $2.traducao;
			//}
			;

ARITMETICO	: ARITMETICO TK_MAIS ARITMETICO
			{
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "ARITMETICO");
				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;
				
				$$.label = geraVar();
				$$.traducao = $1.traducao + $3.traducao + "\t"+ $$.tipo + " " + $$.label +" = " + $1.label + " "+$2.traducao+" " + $3.label+ ";\n";
			
			}
			| ARITMETICO TK_MENOR ARITMETICO
			{
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "ARITMETICO");
				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;
				
				$$.label = geraVar();	
				$$.traducao = $1.traducao + $3.traducao + "\t"+ $$.tipo + " "+ $$.label +" = " + $1.label + " "+$2.traducao+" " + $3.label+ ";\n";
			}
			
			| ARITMETICO TK_MULT ARITMETICO
			{	
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "ARITMETICO");
				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;
				
				$$.label = geraVar();
				$$.traducao = $1.traducao + $3.traducao + "\t"+ $$.tipo + " "+ $$.label +" = " + $1.label + " "+$2.traducao+" " + $3.label+ ";\n";
			}
			| ARITMETICO TK_RAZAO ARITMETICO
			{
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "ARITMETICO");
				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;
				
				$$.label = geraVar();
				$$.traducao = $1.traducao + $3.traducao + "\t"+ $$.tipo + " "+ $$.label +" = " + $1.label + " "+$2.traducao+" " + $3.label+ ";\n";
			}
			|OP
			;


RELACIONAL	: RELACIONAL TK_MAIOR RELACIONAL
			{
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "relacional");
				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;
				
				$$.label = geraVar();
				
				$$.traducao = $1.traducao + $3.traducao + "\t"+ $$.tipo + " "+ $$.label +" = " + $1.label + " " + $2.traducao + " " + $3.label+ ";\n";
			}
			| RELACIONAL TK_MENOR RELACIONAL
			{
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "relacional");
				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;
				
				$$.label = geraVar();
				$$.traducao = $1.traducao + $3.traducao + "\t"+ $$.tipo + " "+ $$.label +" = " + $1.label + " " + $2.traducao + " " + $3.label+ ";\n";
			}
			| RELACIONAL TK_IGUAL RELACIONAL
			{
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "relacional");
				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;
				$$.label = geraVar();	
				$$.traducao = $1.traducao + $3.traducao + "\t"+ $$.tipo + " "+ $$.label +" = " + $1.label + " " + $2.traducao + " " + $3.label+ ";\n";
			}
			| RELACIONAL TK_DIFERENTE RELACIONAL
			{ 
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "relacional");
				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;
				
				$$.label = geraVar();	
				$$.traducao = $1.traducao + $3.traducao + "\t"+ $$.tipo + " "+ $$.label +" = " + $1.label + " " + $2.traducao + " " + $3.label+ ";\n";
			}
			|OP
			;


LOGICO		: LOGICO TK_AND LOGICO
			{ 
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "logico");
				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;

				$$.label = geraVar();	
				$$.traducao = $1.traducao + $3.traducao + "\t"+ $$.tipo + " "+ $$.label +" = " + $1.label + " " + $2.traducao + " " + $3.label+ ";\n";
			}	
			| LOGICO TK_OR LOGICO
			{ 
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "logico");
				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;

				$$.label = geraVar();	
				$$.traducao = $1.traducao + $3.traducao + "\t"+ $$.tipo + " "+ $$.label +" = " + $1.label + " " + $2.traducao + " " + $3.label+ ";\n";
			}
			| RELACIONAL TK_OR RELACIONAL
			{ 
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "logico");
				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;

				$$.label = geraVar();	
				$$.traducao = $1.traducao + $3.traducao + "\t"+ $$.tipo + " "+ $$.label +" = " + $1.label + " " + $2.traducao + " " + $3.label+ ";\n";
			}
			| RELACIONAL TK_AND RELACIONAL
			{ 
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "logico");
				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;

				$$.label = geraVar();	
				$$.traducao = $1.traducao + $3.traducao + "\t"+ $$.tipo + " "+ $$.label +" = " + $1.label + " " + $2.traducao + " " + $3.label+ ";\n";
			}
			|OP
			;


OP			: TK_NUM
			{
				$$.label =  geraVar();
				$$.traducao = "\t" + $1.tipo + " " + $$.label + " = " + $1.traducao + ";\n";			
			}
			| TK_ID
			{
				$$.label =  use_meta_var($$.label, " ");
				$$.traducao = "";
			}
			| TK_BOOL
			{
				$$.label =  geraVar();
				$$.traducao = "\t" + $1.tipo + " " + $$.label + " = " + $1.traducao + ";\n";			
			}
			| TK_REAL
			{
				$$.label =  geraVar();
				$$.traducao = "\t" + $1.tipo + " " + $$.label + " = " + $1.traducao + ";\n";			
			}
			;


ATRIB 		: TK_VAR TK_ID TK_ATRIB ATRIB
			{
				$$.traducao = "\t" + $4.tipo +" "+ use_meta_var($2.label, $4.tipo) + " = " + $4.traducao+ ";\n";
			}
			| TK_VAR TK_ID TK_ATRIB OPERACAO
			{
			 	$$.traducao = $4.traducao+ "\t"+ $4.tipo + " " + use_meta_var($2.label, $4.tipo) + " = " + $4.label+ ";\n";
			}
			| TK_VAR ATRIB TK_ID
			{
				$$.traducao = "\t " + $2.tipo +" " + use_meta_var($3.label, $2.tipo) +";\n";
 			}
 			| TK_ID TK_ATRIB ATRIB
 			{
				$$.traducao = "\t" + use_meta_var($1.label, $3.tipo) + " = " + $3.traducao+ ";\n";
 			}
 			| TK_ID TK_ATRIB OPERACAO
 			{
			 	$$.traducao = $3.traducao+ "\t"+ " " + use_meta_var($1.label, $3.tipo) + " = " + $3.label+ ";\n";
 			}
 			| TK_TIPO_INT
			| TK_TIPO_BOOL
 			| TK_TIPO_FLOAT
 			| TK_TIPO_CHAR
 			| TK_NUM
 			| TK_REAL
			| TK_CHAR
			| TK_BOOL
 

%%

#include "lex.yy.c"
			
int temp_counter = 0;
vector<meta_variavel> list_meta_var;
vector<operacao> list_op;

int yyparse();
string geraVar();

int main( int argc, char* argv[] )
{
	adicionaOperacoes();
	
	yyparse();

	printList();
	return 0;
}

void yyerror( string MSG )
{
	cout << MSG << endl;
	exit (0);
}

void adicionaOperacoes(){
	operacao op; 
	//ARITMETICOs
	op.tipoDireita = "int";		op.tipoEsquerda = "int";	op.tipoResultante = "int";		op.tipoReal = "int";	op.operacao = "ARITMETICO";
	list_op.push_back(op);
	op.tipoDireita = "int";		op.tipoEsquerda = "float";	op.tipoResultante = "float";	op.tipoReal = "float";	op.operacao = "ARITMETICO";
	list_op.push_back(op);
	op.tipoDireita = "float";	op.tipoEsquerda = "float";	op.tipoResultante = "float";	op.tipoReal = "float";	op.operacao = "ARITMETICO";
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
	operacao operacaoErrada;
	operacaoErrada.tipoReal = " "; 
	return operacaoErrada;
}


string use_meta_var(string var, string tipo) //Usado na atribuição
{
	pair<bool, int> position = isIn(var, list_meta_var);
	if(position.first)
	{
		return list_meta_var[position.second].temp_name;
	}
	else
	{
		meta_variavel nova_meta_var;
		nova_meta_var.temp_name = geraVar();
		nova_meta_var.orig_name = var;
		nova_meta_var.tipo = tipo;

		list_meta_var.push_back(nova_meta_var);
		return nova_meta_var.temp_name;
	}
}

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

void printList(){
	int i;
	for (i = 0; i < list_meta_var.size(); i++)
	{
		cout << list_meta_var[i].orig_name << " temp: " << list_meta_var[i].temp_name  << endl;
		
	}
}

/// * Usado para gerar nome de variaveis. Usado na atribuição, e operações * ///

string geraVar()
{
	stringstream tempGerator;
	tempGerator << "_temp_" << temp_counter;

	temp_counter ++;
	return tempGerator.str();
}				
