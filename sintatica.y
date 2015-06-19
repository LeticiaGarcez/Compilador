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

struct Escopo
{
	int nivel;
	string inicio;
	string fim;
	vector<meta_variavel> variaveis;
};
struct atributos
{
	string tipoReal; // Tipo no lule
	string tipo; // Tipo no C
	string label;
	string traducao;
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

//manipula variaveis
string geraVar();
string nova_temp_meta_var(string);
string use_meta_var(string, string);
string procura_meta_var(string, int);
string nova_meta_var(string, string);

//Traduções
string aritmeticoTraducao(atributos, atributos, atributos, atributos);

//Manipula Escopo
void desceEscopo();
void sobeEscopo();

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
//Condicionais e loops
%token TK_WHILE TK_FOR TK_SWITCH TK_CASE TK_IF TK_ELSE TK_ELIF
//Bloco
%token TK_ABRE TK_FECHA
//func
%token TK_FUNC

//
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
				cout << "/*Compilador FOCA*/\n" << "#include <iostream> \n#include <string.h> \n#include <stdio.h>\n#define true 1 \n#define false 0 \nint main(void)\n{\n" << endl;
				printDeclaracoes();
				cout <<"\n\n\n"<< $5.traducao << "\treturn 0;\n}" << endl;  
			}
			;
FUNC		: TK_FUNC
			{
				desceEscopo();
			}
			;

ABRE 		: TK_ABRE
			;

FECHA 		: TK_FECHA
			{
				sobeEscopo();	
			}
			;

BLOCO		: ABRE COMANDOS FECHA
			{
				//ABRE >> desceEscopo();
				$$.traducao = $2.traducao;
				//FECHA >> sobeEscopo();
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
			| COMANDO_IF COMANDOS
			{ 
				$$.traducao = $1.traducao + $2.traducao;		
			}
			| COMANDO_FOR COMANDOS
			{ 
				$$.traducao = $1.traducao + $2.traducao;		
			}
			| COMANDO_IF
			| COMANDO_FOR
			;

COMANDO_IF	:IF '(' RELACIONAL ')' BLOCO
			{
				$$.traducao = $3.traducao + "\n \t" + "if(" +$3.label+ ")\n\t{ \n" + $5.traducao +"\n\t}\n"; 
			}
			|IF '(' RELACIONAL ')' BLOCO ELSE BLOCO
			{	
				$$.traducao = $3.traducao + "\n \t" + "if(" +$3.label+ ")\n\t{ \n" + $5.traducao +"\n\t}\n"; 
				$$.traducao += "\telse\n\t{ \n" + $7.traducao +"\n\t}\n"; 
			}
			|IF '(' RELACIONAL ')' BLOCO ELSEIF
			{
				$$.traducao = $3.traducao + "\n \t" + "if(" +$3.label+ ")\n\t{ \n" + $5.traducao +"\n\t}\n"; 
				$$.traducao += $6.traducao;
			}
			;

ELSEIF		: ELIF '(' RELACIONAL ')' BLOCO
			{
				$$.traducao =  "\n \telse{ \n" + $3.traducao + "\n\tif(" +$3.label+ ")\n\t{ \n" + $5.traducao +"\n\t}\n\t}\n"; 	
			}
			| ELIF '(' RELACIONAL ')' BLOCO ELSEIF
			{
				$$.traducao =  "\n \telse{ \n" + $3.traducao + "\n\tif(" +$3.label+ ")\n\t{ \n" + $5.traducao +"\n\t}"; 	
				$$.traducao += $6.traducao + "\n\t}\n";
			}
			| ELIF '(' RELACIONAL ')' BLOCO ELSE BLOCO
			{
				$$.traducao =  "\n \telse{ \n" + $3.traducao + "\n\tif(" +$3.label+ ")\n\t{ \n" + $5.traducao +"\n\t}"; 	
				$$.traducao += "\n\telse\n\t{ \n" + $7.traducao +"\n\t}\n \n\t}\n"; 
			}
			;

ELIF 		: TK_ELIF
			{
				desceEscopo();
			}
IF 			: TK_IF
			{
				desceEscopo();
			}
			;
ELSE 		: TK_ELSE
			{
				desceEscopo();
			}
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
			;
FOR 		: TK_FOR
			{
				desceEscopo();
			}
			;


CONDICAO 	: RELACIONAL
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
				
				$$.label = nova_temp_meta_var( $$.tipo);
				$$.traducao = aritmeticoTraducao($$, $1, $2, $3);
				
			}
			| ARITMETICO TK_MENOR ARITMETICO
			{
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "ARITMETICO");
				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;
				
				$$.label = nova_temp_meta_var( $$.tipo);	
				$$.traducao = aritmeticoTraducao($$, $1, $2, $3);
			}
			
			| ARITMETICO TK_MULT ARITMETICO
			{	
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "ARITMETICO");
				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;
				
				$$.label = nova_temp_meta_var( $$.tipo);
				$$.traducao = aritmeticoTraducao($$, $1, $2, $3);
			}
			| ARITMETICO TK_RAZAO ARITMETICO
			{
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "ARITMETICO");
				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;
				
				$$.label = nova_temp_meta_var( $$.tipo);
				$$.traducao = aritmeticoTraducao($$, $1, $2, $3);
			}
			|OP
			;
				
RELACIONAL	: RELACIONAL TK_MAIOR RELACIONAL
			{
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "relacional");
				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;
				
				$$.label = nova_temp_meta_var( $$.tipo);
				
				$$.traducao = $1.traducao + $3.traducao + "\t"+ $$.label +" = " + $1.label + " " + $2.traducao + " " + $3.label+ ";\n";
			}
			| RELACIONAL TK_MENOR RELACIONAL	
			{
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "relacional");
				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;
				
				$$.label = nova_temp_meta_var( $$.tipo);
				$$.traducao = $1.traducao + $3.traducao + "\t"+ $$.label +" = " + $1.label + " " + $2.traducao + " " + $3.label+ ";\n";
			}
			| RELACIONAL TK_IGUAL RELACIONAL
			{
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "relacional");
				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;
				$$.label = nova_temp_meta_var( $$.tipo);	
				$$.traducao = $1.traducao + $3.traducao + "\t"+ $$.label +" = " + $1.label + " " + $2.traducao + " " + $3.label+ ";\n";
			}
			| RELACIONAL TK_DIFERENTE RELACIONAL
			{ 
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "relacional");
				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;
				
				$$.label = nova_temp_meta_var( $$.tipo);	
				$$.traducao = $1.traducao + $3.traducao + "\t"+ $$.label +" = " + $1.label + " " + $2.traducao + " " + $3.label+ ";\n";
			}
			|OP
			;
LOGICO		: LOGICO TK_AND LOGICO
			{ 
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "logico");
				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;
				$$.label = nova_temp_meta_var( $$.tipo);	
				$$.traducao = $1.traducao + $3.traducao + "\t"+ $$.label +" = " + $1.label + " " + $2.traducao + " " + $3.label+ ";\n";
			}	
			| LOGICO TK_OR LOGICO
			{ 
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "logico");
				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;
				$$.label = nova_temp_meta_var( $$.tipo);	
				$$.traducao = $1.traducao + $3.traducao + "\t"+ $$.label +" = " + $1.label + " " + $2.traducao + " " + $3.label+ ";\n";
			}
			| RELACIONAL TK_OR RELACIONAL
			{ 
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "logico");
				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;
				$$.label = nova_temp_meta_var( $$.tipo);	
				$$.traducao = $1.traducao + $3.traducao + "\t"+ $$.label +" = " + $1.label + " " + $2.traducao + " " + $3.label+ ";\n";
			}
			| RELACIONAL TK_AND RELACIONAL
			{ 
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "logico");
				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;
				$$.label = nova_temp_meta_var( $$.tipo);	
				$$.traducao = $1.traducao + $3.traducao + "\t"+ $$.label +" = " + $1.label + " " + $2.traducao + " " + $3.label+ ";\n";
			}
			|OP
			;
OP			: TK_NUM
			{
				$$.label =  nova_temp_meta_var( $1.tipo);
				$$.traducao = "\t" + $$.label + " = " + $1.traducao + ";\n";			
			}
			| TK_ID
			{
				$$.label =  use_meta_var($$.label, " ");
				$$.traducao = "";
			}
			| TK_BOOL
			{
				$$.label =  nova_temp_meta_var( $1.tipo);
				$$.traducao = "\t" + $$.label + " = " + $1.traducao + ";\n";			
			}
			| TK_REAL
			{
				$$.label =  nova_temp_meta_var( $1.tipo);
				$$.traducao = "\t" + $$.label + " = " + $1.traducao + ";\n";			
			}
			| TK_CHAR
			{
				$$.label =  nova_temp_meta_var( $1.tipo);
				$$.traducao = "\t" + $$.label + " = " + $1.traducao + ";\n";			
			}
			;

ATRIB 		: TK_VAR TK_ID TK_ATRIB OPERACAO
			{
			 	$$.traducao = $4.traducao+ "\t"+ nova_meta_var($2.label, $4.tipo) + " = " + $4.label+ ";\n";
			}
			| TK_VAR ATRIB TK_ID TK_ATRIB OPERACAO
			{
			 	$$.traducao = $5.traducao+ "\t"+ nova_meta_var($3.label, $2.tipo) + " = " + "("+$2.tipo+")"+$5.label+ ";\n";
			}
			| TK_VAR ATRIB TK_ID
			{
				$$.traducao = "\t " + nova_meta_var($3.label, $2.tipo) +";\n";
 			}
 			| TK_ID TK_ATRIB OPERACAO
 			{
				$$.traducao = $3.traducao+"\t" + use_meta_var($1.label, $3.tipo) + " = " + $3.label+ ";\n";
 			}
 			| TK_TIPO_BOOL
 			| TK_TIPO_FLOAT
 			| TK_TIPO_CHAR
 
%%
#include "lex.yy.c"
			
int temp_counter = 0;
int label_counter = 0;
int nivel_escopo = -1;
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
void desceEscopo()
{	
	nivel_escopo++;

	Escopo escopo;
	escopo.nivel = nivel_escopo;

	pair<string, string> label = geraLabelEscopo();
	escopo.inicio = label.first;
	escopo.fim = label.second;
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
string use_meta_var(string var, string tipo) //Usado no uso de uma variavel ja existente!
{	
	return procura_meta_var(var, nivel_escopo);
}

string procura_meta_var(string var, int nivel)
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
			return list_meta_var[position.second].temp_name;
		}
		else
		{	
			nivel--;
			return procura_meta_var(var,nivel );

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
		meta_variavel nova_meta_var;
		nova_meta_var.temp_name = geraVar();
		nova_meta_var.orig_name = var;
		nova_meta_var.tipo = tipo;
		escopo_list[nivel_escopo].back().variaveis.push_back(nova_meta_var);
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