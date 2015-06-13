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
string geraVar();
string get_meta_var(string);
pair<bool, int> isIn(string, vector<meta_variavel>);
string use_meta_var(string, string);
void adicionaOperacoes();
operacao getTipoResultante(string, string, string);
string nova_meta_var(string, string);
string nova_temp_meta_var(string);
string procura_meta_var(string, vector<vector<meta_variavel> >);
string aritimeticoTraducao(atributos, atributos, atributos, atributos);
void printDeclaracoes();
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
				cout << "/*Compilador FOCA*/\n" << "#include <iostream> \n#include <string.h> \n#include <stdio.h>\n#define true 1 \n#define false 0 \nint main(void)\n{\n" << endl;
				printDeclaracoes();
				cout <<"\n\n\n"<< $5.traducao << "\treturn 0;\n}" << endl;  
			}
			;
BLOCO		: '{' COMANDOS '}'
			{
				//desceEscopo();
				$$.traducao = $2.traducao;
				//sobeEscopo();
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
			| TK_IF '(' RELACIONAL ')' BLOCO
			{
				cout << "asda" << endl;
				$$.traducao = $3.traducao + "\n \t" + "if(" +$3.label+ "){ \n" + $5.traducao +"\n\t}\n"; 
			}
			| BLOCO
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
				$$.traducao = aritimeticoTraducao($$, $1, $2, $3);
				
			}
			| ARITMETICO TK_MENOR ARITMETICO
			{
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "ARITMETICO");
				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;
				
				$$.label = nova_temp_meta_var( $$.tipo);	
				$$.traducao = aritimeticoTraducao($$, $1, $2, $3);
			}
			
			| ARITMETICO TK_MULT ARITMETICO
			{	
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "ARITMETICO");
				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;
				
				$$.label = nova_temp_meta_var( $$.tipo);
				$$.traducao = aritimeticoTraducao($$, $1, $2, $3);
			}
			| ARITMETICO TK_RAZAO ARITMETICO
			{
				operacao op = getTipoResultante($1.tipoReal, $3.tipoReal, "ARITMETICO");
				$$.tipo = op.tipoResultante;
				$$.tipoReal = op.tipoReal;
				
				$$.label = nova_temp_meta_var( $$.tipo);
				$$.traducao = aritimeticoTraducao($$, $1, $2, $3);
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
			;
ATRIB 		: TK_VAR TK_ID TK_ATRIB ATRIB
			{
				$$.traducao = "\t"+ nova_meta_var($2.label, $4.tipo) + " = " + $4.traducao+ ";\n";
			}
			| TK_VAR TK_ID TK_ATRIB OPERACAO
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
 			| TK_ID TK_ATRIB ATRIB
 			{
				$$.traducao = "\t" + use_meta_var($1.label, $3.tipo) + " = " + $3.traducao+ ";\n";
 			}
 			| TK_ID TK_ATRIB OPERACAO
 			{
			 	$$.traducao = $3.traducao+ "\t"+ " " + use_meta_var($1.label, $3.tipo) + " = " + $3.label+ ";\n";
 			}
 			| TK_TIPO_INT
			{
				$$.label = $1.label + " ";
			}
			| TK_TIPO_FLOAT
			{
				$$.label = $1.label + " ";
			}
			| TK_TIPO_CHAR
			{
				$$.label = $1.label + " ";
			}
			| TK_TIPO_BOOL
			{
				$$.label = $1.label + " ";
			}

			| TK_NUM
			{
				$$.traducao = $1.traducao + " ";
				$$.label = $1.label + " ";
			}
			| TK_REAL
			{
				$$.traducao = $1.traducao + " ";
				$$.label = $1.label + " ";
			}
			| TK_CHAR
			{
				$$.traducao = $1.traducao + " ";
				$$.label = $1.label + " ";
			}
			| TK_BOOL
			{
				$$.traducao = $1.traducao + " ";
				$$.label = $1.label + " ";
			}

 
%%
#include "lex.yy.c"
			
int temp_counter = 0;
//vector<meta_variavel> list_meta_var;
vector< vector<meta_variavel> > escopo_list;
vector<operacao> list_op;
int yyparse();
string geraVar();
int main( int argc, char* argv[] )
{
	adicionaOperacoes();
	desceEscopo();
	yyparse();
	return 0;
}
void yyerror( string MSG )
{
	cout << MSG << endl;
	exit (0);
}
void desceEscopo()
{
	vector<meta_variavel> list_meta_var;
	escopo_list.push_back(list_meta_var);
}
void sobeEscopo()
{
	escopo_list.pop_back();
}
string nova_temp_meta_var(string tipo) //cria uma nova variavel temporaria
{
		meta_variavel nova_meta_var;
		nova_meta_var.temp_name = geraVar();
		nova_meta_var.orig_name = "__TEMP__";
		nova_meta_var.tipo = tipo;
		escopo_list.back().push_back(nova_meta_var);
		return nova_meta_var.temp_name;
}
string use_meta_var(string var, string tipo) //Usado no uso de uma variavel ja existente!
{	
	vector<vector<meta_variavel> > copia_escopo_list = escopo_list;
	return procura_meta_var(var, copia_escopo_list);
}
string procura_meta_var(string var, vector<vector<meta_variavel> > copia_escopo_list)
{
	cout << "copia" << copia_escopo_list.size() << "orig "<< escopo_list.size() << endl;
	if(copia_escopo_list.empty())
	{
		yyerror("Variavel não inicializada");
	}
	else
	{
		vector<meta_variavel> list_meta_var = copia_escopo_list.back();	
		copia_escopo_list.pop_back();	
		pair<bool, int> position = isIn(var, list_meta_var);
		if(position.first)
		{
			return list_meta_var[position.second].temp_name;
		}
		else
		{	
			return procura_meta_var(var, copia_escopo_list);
		}
	}
}
string nova_meta_var(string var, string tipo)
{
	vector<meta_variavel> escopo = escopo_list.back();
	pair<bool, int> returno = isIn(var, escopo);
	if(returno.first)
	{
		yyerror("Ja existe uma variavel com esse nome");
	}
	else
	{	
		meta_variavel nova_meta_var;
		nova_meta_var.temp_name = geraVar();
		nova_meta_var.orig_name = var;
		nova_meta_var.tipo = tipo;
		escopo_list.back().push_back(nova_meta_var);
		return nova_meta_var.temp_name;
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
		vector<meta_variavel> list_meta_var = escopo_list[i];
		int j;
		for (j = 0; j < list_meta_var.size(); j++)
		{
			cout <<"\t"<< list_meta_var[j].tipo << " " << list_meta_var[j].temp_name  << ";" << "  // "<< "nivel_escopo:" << i <<"  "<< list_meta_var[j].orig_name << endl;
		}		
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
//Funções que são usadas na tradução. 
////Servem para não precisar repetir codigo e juntar todo o teste de tipos no mesmo lugar
string aritimeticoTraducao(atributos $$, atributos $1, atributos $2, atributos $3){
	
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
//Funções que manipulam as operações
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