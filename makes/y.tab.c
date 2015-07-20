/* A Bison parser, made by GNU Bison 3.0.2.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2013 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.0.2"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* Copy the first part of user declarations.  */
#line 1 "../sintatica.y" /* yacc.c:339  */

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


#line 224 "y.tab.c" /* yacc.c:339  */

# ifndef YY_NULLPTR
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULLPTR nullptr
#  else
#   define YY_NULLPTR 0
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* In a future release of Bison, this section will be replaced
   by #include "y.tab.h".  */
#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    TK_MAIS = 258,
    TK_MENOS = 259,
    TK_MULT = 260,
    TK_RAZAO = 261,
    TK_POTENCIA = 262,
    TK_CONCAT = 263,
    TK_AND = 264,
    TK_OR = 265,
    TK_MAIOR = 266,
    TK_MENOR = 267,
    TK_DIFERENTE = 268,
    TK_IGUAL = 269,
    TK_ATRIB = 270,
    TK_VAR = 271,
    TK_GLOBAL = 272,
    TK_TIPO_STRING = 273,
    TK_TIPO_FLOAT = 274,
    TK_TIPO_CHAR = 275,
    TK_TIPO_BOOL = 276,
    TK_TIPO_INT = 277,
    TK_NUM = 278,
    TK_REAL = 279,
    TK_CHAR = 280,
    TK_BOOL = 281,
    TK_STR = 282,
    TK_WHILE = 283,
    TK_FOR = 284,
    TK_SWITCH = 285,
    TK_CASE = 286,
    TK_IF = 287,
    TK_ELSE = 288,
    TK_ELIF = 289,
    TK_BREAK = 290,
    TK_CONTINUE = 291,
    TK_DO = 292,
    TK_DEFAUT = 293,
    TK_ABRE = 294,
    TK_FECHA = 295,
    TK_FUNC = 296,
    TK_RETORNA = 297,
    TK_RETURN = 298,
    TK_READ = 299,
    TK_WRITE = 300,
    TK_SUPER = 301,
    TK_MAIN = 302,
    TK_ID = 303,
    TK_FIM = 304,
    TK_ERROR = 305,
    TK_END_E = 306,
    TK_FIMLINHA = 307
  };
#endif
/* Tokens.  */
#define TK_MAIS 258
#define TK_MENOS 259
#define TK_MULT 260
#define TK_RAZAO 261
#define TK_POTENCIA 262
#define TK_CONCAT 263
#define TK_AND 264
#define TK_OR 265
#define TK_MAIOR 266
#define TK_MENOR 267
#define TK_DIFERENTE 268
#define TK_IGUAL 269
#define TK_ATRIB 270
#define TK_VAR 271
#define TK_GLOBAL 272
#define TK_TIPO_STRING 273
#define TK_TIPO_FLOAT 274
#define TK_TIPO_CHAR 275
#define TK_TIPO_BOOL 276
#define TK_TIPO_INT 277
#define TK_NUM 278
#define TK_REAL 279
#define TK_CHAR 280
#define TK_BOOL 281
#define TK_STR 282
#define TK_WHILE 283
#define TK_FOR 284
#define TK_SWITCH 285
#define TK_CASE 286
#define TK_IF 287
#define TK_ELSE 288
#define TK_ELIF 289
#define TK_BREAK 290
#define TK_CONTINUE 291
#define TK_DO 292
#define TK_DEFAUT 293
#define TK_ABRE 294
#define TK_FECHA 295
#define TK_FUNC 296
#define TK_RETORNA 297
#define TK_RETURN 298
#define TK_READ 299
#define TK_WRITE 300
#define TK_SUPER 301
#define TK_MAIN 302
#define TK_ID 303
#define TK_FIM 304
#define TK_ERROR 305
#define TK_END_E 306
#define TK_FIMLINHA 307

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */

/* Copy the second part of user declarations.  */

#line 379 "y.tab.c" /* yacc.c:358  */

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE
# if (defined __GNUC__                                               \
      && (2 < __GNUC__ || (__GNUC__ == 2 && 96 <= __GNUC_MINOR__)))  \
     || defined __SUNPRO_C && 0x5110 <= __SUNPRO_C
#  define YY_ATTRIBUTE(Spec) __attribute__(Spec)
# else
#  define YY_ATTRIBUTE(Spec) /* empty */
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# define YY_ATTRIBUTE_PURE   YY_ATTRIBUTE ((__pure__))
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# define YY_ATTRIBUTE_UNUSED YY_ATTRIBUTE ((__unused__))
#endif

#if !defined _Noreturn \
     && (!defined __STDC_VERSION__ || __STDC_VERSION__ < 201112)
# if defined _MSC_VER && 1200 <= _MSC_VER
#  define _Noreturn __declspec (noreturn)
# else
#  define _Noreturn YY_ATTRIBUTE ((__noreturn__))
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN \
    _Pragma ("GCC diagnostic push") \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")\
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif


#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYSIZE_T yynewbytes;                                            \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / sizeof (*yyptr);                          \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYSIZE_T yyi;                         \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  3
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   598

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  59
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  83
/* YYNRULES -- Number of rules.  */
#define YYNRULES  168
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  328

/* YYTRANSLATE[YYX] -- Symbol number corresponding to YYX as returned
   by yylex, with out-of-bounds checking.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   307

#define YYTRANSLATE(YYX)                                                \
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, without out-of-bounds checking.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
      54,    55,     2,     2,    58,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,    53,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    56,     2,    57,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48,    49,    50,    51,    52
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   191,   191,   205,   210,   216,   222,   223,   225,   229,
     235,   236,   237,   238,   239,   240,   241,   242,   243,   244,
     245,   246,   247,   248,   251,   255,   259,   260,   263,   264,
     265,   266,   272,   281,   291,   297,   301,   311,   316,   323,
     325,   327,   329,   335,   343,   350,   355,   358,   367,   374,
     383,   393,   404,   417,   423,   434,   442,   451,   456,   465,
     466,   473,   474,   475,   476,   482,   510,   511,   512,   516,
     545,   546,   549,   550,   558,   589,   595,   623,   624,   625,
     628,   634,   661,   664,   664,   669,   671,   671,   673,   673,
     673,   673,   675,   675,   677,   677,   683,   688,   697,   707,
     729,   737,   743,   749,   753,   776,   790,   791,   796,   804,
     817,   831,   848,   871,   872,   873,   874,   875,   876,   879,
     900,   920,   946,   962,   987,  1029,  1034,  1040,  1046,  1067,
    1073,  1083,  1093,  1100,  1108,  1126,  1132,  1150,  1151,  1152,
    1153,  1154,  1161,  1168,  1174,  1189,  1194,  1199,  1208,  1216,
    1234,  1239,  1247,  1263,  1269,  1276,  1282,  1289,  1300,  1315,
    1328,  1341,  1353,  1355,  1357,  1359,  1366,  1372,  1388
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "TK_MAIS", "TK_MENOS", "TK_MULT",
  "TK_RAZAO", "TK_POTENCIA", "TK_CONCAT", "TK_AND", "TK_OR", "TK_MAIOR",
  "TK_MENOR", "TK_DIFERENTE", "TK_IGUAL", "TK_ATRIB", "TK_VAR",
  "TK_GLOBAL", "TK_TIPO_STRING", "TK_TIPO_FLOAT", "TK_TIPO_CHAR",
  "TK_TIPO_BOOL", "TK_TIPO_INT", "TK_NUM", "TK_REAL", "TK_CHAR", "TK_BOOL",
  "TK_STR", "TK_WHILE", "TK_FOR", "TK_SWITCH", "TK_CASE", "TK_IF",
  "TK_ELSE", "TK_ELIF", "TK_BREAK", "TK_CONTINUE", "TK_DO", "TK_DEFAUT",
  "TK_ABRE", "TK_FECHA", "TK_FUNC", "TK_RETORNA", "TK_RETURN", "TK_READ",
  "TK_WRITE", "TK_SUPER", "TK_MAIN", "TK_ID", "TK_FIM", "TK_ERROR",
  "TK_END_E", "TK_FIMLINHA", "';'", "'('", "')'", "'['", "']'", "','",
  "$accept", "S", "BLOCO", "BLOCO_EXP", "BLOCO_ALTER", "SOBE_ESCOPO",
  "DESCE_ESCOPO", "COMANDOS", "COMANDO", "CONDICIONAIS", "COMANDO_LOOPS",
  "COMANDO_IF", "CMD_IF_ALTER", "CMD_ELIF", "CMD_ELIF_ALTER", "CMD_ELSE",
  "ELIF", "IF", "ELSE", "WHITCHCASE", "SWITCH", "CASES", "CASE", "DEFAUT",
  "COMANDO_FOR", "FOR", "COMANDO_WHILE", "WHILE", "COMANDO_DOWHILE", "DO",
  "FIM_DOWHILE", "CONDICAO", "OPERACAO", "ARITMETICO", "ARITMETICO2",
  "ARITs", "CONCATENACAO", "RELACIONAL", "RELs", "LOGICO", "LOGs",
  "OP_CONCAT", "OP_LOGICO", "OP_RELACIONAL", "OP_ARITMETICO",
  "OP_ARITMETICO2", "OP", "CHAMA_FUNCAO", "DECLARA", "DECLARA_GLOBAL",
  "DECLARA_VETOR", "DIMENCAO", "ATRIB", "ATRIB_VETOR", "DECLARA_ATRIB",
  "DECLARA_ATRIB_GLOBAL", "DECLARA_ATRIB_VETOR", "IDs", "OPs",
  "INCREMENTO", "DECREMENTO", "VETORES", "VETOR", "VALORES", "TIPO",
  "FUNCAO", "DECLARA_FUNC", "TIPOS_RETORNO", "TIPOS", "ASSINATURA",
  "PARAMETROS", "DECLARA_PARAM", "BLOCO_FUNC", "RETORNO", "RETORNOS",
  "CMD_CIN", "CMD_COUT", "BREAK", "CONTINUE", "SUPERBREAK",
  "SUPERCONTINUE", "ID_VET", "INDEXs", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301,   302,   303,   304,
     305,   306,   307,    59,    40,    41,    91,    93,    44
};
# endif

#define YYPACT_NINF -229

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-229)))

#define YYTABLE_NINF -167

#define yytable_value_is_error(Yytable_value) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
    -229,    37,   316,  -229,   222,    53,  -229,  -229,  -229,  -229,
    -229,  -229,  -229,    11,  -229,  -229,  -229,  -229,  -229,    69,
      73,   189,    47,   518,  -229,    34,  -229,   360,  -229,  -229,
    -229,   195,  -229,  -229,    75,  -229,    10,  -229,    88,  -229,
      97,  -229,   119,   107,   158,   242,   256,   157,   584,   208,
     275,   279,    49,  -229,   118,  -229,  -229,   120,  -229,  -229,
    -229,  -229,    -5,  -229,  -229,  -229,   133,   138,   142,   146,
     148,   153,   128,  -229,  -229,  -229,  -229,  -229,  -229,    28,
     161,   222,   518,   393,   164,   518,  -229,  -229,   211,   213,
     518,   -37,    38,    33,   125,   171,   274,   128,   186,  -229,
     139,  -229,  -229,  -229,  -229,   195,   196,   220,   518,   238,
     270,   518,   393,   245,  -229,  -229,  -229,   525,  -229,  -229,
     530,  -229,   544,  -229,  -229,  -229,  -229,   535,  -229,  -229,
     518,  -229,  -229,  -229,   518,   227,  -229,  -229,  -229,  -229,
    -229,  -229,   525,    51,   518,     0,    58,    64,   234,   247,
     149,   264,   255,   257,  -229,  -229,  -229,    16,   286,  -229,
    -229,  -229,   259,   263,  -229,   360,   347,  -229,   285,   220,
     518,   393,  -229,   272,   296,    86,   275,   281,    21,  -229,
     222,   313,   294,   301,   302,   318,   305,   525,   296,   274,
     525,  -229,   256,  -229,   157,  -229,   535,  -229,   208,   253,
    -229,   279,   276,  -229,    23,   518,   525,   276,    24,   525,
     300,   518,   518,   109,   129,  -229,  -229,  -229,  -229,  -229,
     518,   235,   160,  -229,   324,   314,  -229,   319,   331,   220,
     518,   334,  -229,   238,   335,   330,   222,   426,   518,   220,
    -229,   518,    38,    43,   325,  -229,  -229,    30,   337,  -229,
    -229,    32,   300,   276,   276,   350,   518,  -229,  -229,  -229,
     333,   150,  -229,  -229,   518,   351,  -229,   347,   220,  -229,
     280,   343,  -229,  -229,   385,   354,   492,  -229,  -229,   358,
    -229,   348,  -229,  -229,   282,     8,  -229,  -229,   276,  -229,
    -229,   347,  -229,    14,  -229,  -229,  -229,  -229,   334,   368,
     459,  -229,   131,   359,  -229,   265,   268,  -229,   337,  -229,
    -229,   518,  -229,    27,   369,   128,  -229,  -229,  -229,  -229,
     518,  -229,   426,    51,   355,  -229,  -229,  -229
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       7,     0,     7,     1,     0,     0,    96,   101,   102,   100,
      97,    55,    53,     0,    40,   162,   163,    57,     7,     0,
       0,     0,    98,     0,    23,     0,     6,     9,    21,    22,
      26,     0,    24,    25,     0,    27,     0,    29,     0,    30,
       0,    31,     0,     0,    79,    66,     0,    64,    63,     0,
      62,     0,    68,   103,     0,   107,   106,     0,   113,   114,
     115,   116,     0,   117,   118,    13,     0,     0,     0,     0,
       0,     0,     0,   141,   138,   139,   137,   140,   126,     0,
       0,     0,     0,     7,     0,     0,   164,   165,     0,     0,
       0,    98,    79,    66,    80,    83,    68,     0,     0,     6,
       0,     2,     8,    41,    39,    34,     0,     0,     0,     0,
       0,     0,     7,     0,    11,    92,    93,     0,    95,    94,
       0,    85,     0,    91,    90,    88,    89,     0,    86,    87,
       0,    12,    18,    10,     0,     0,    20,    19,    14,    15,
      16,    17,     0,    99,     0,   105,     0,     0,     0,     0,
      68,     0,     0,     0,   129,   130,   128,     0,    67,    70,
      77,    82,    99,     0,   142,    28,     0,   143,    35,     0,
       0,     7,    37,     0,    79,    80,    59,     0,     0,    46,
       0,     0,     0,     0,     0,     0,     0,     0,    65,    68,
       0,    72,    69,    71,    74,    75,     0,    80,    76,    84,
      83,    81,   112,   125,     0,     0,     0,   120,     0,     0,
     109,     0,     0,   108,     0,    44,     6,   160,   161,   104,
       0,     0,     0,   147,     0,   145,    38,     0,     0,     0,
       0,     0,    42,    45,     0,     0,     0,    28,     0,     0,
       5,     0,     0,     0,    80,   168,   119,     0,     0,   158,
     124,     0,   111,   121,   122,     0,     0,     4,   127,   149,
       0,     0,   151,   154,     0,     0,   144,     0,     0,     6,
      32,     0,    48,    43,   126,     0,     7,    49,     6,     0,
      54,     0,    73,   167,     0,     0,   110,   159,   123,   152,
     148,     0,   157,     0,   153,   146,    36,     3,     0,     0,
      28,    50,     0,     0,   135,     0,     0,   131,   134,   150,
     155,     0,    47,   126,     0,     0,    58,    56,   133,   132,
       0,   156,    28,     0,   136,    51,     6,    52
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -229,  -229,  -125,  -213,  -229,   -95,     2,     5,  -228,  -229,
    -229,  -229,  -229,  -229,   384,  -229,  -229,  -229,   321,  -229,
    -229,   322,  -229,  -229,  -229,  -229,  -229,  -229,  -229,  -229,
    -229,   -88,   -74,   141,     6,   307,   312,    22,   308,   -11,
     306,  -229,  -229,  -229,  -229,  -229,    -2,  -229,  -229,  -229,
    -229,   295,  -104,  -229,  -229,  -229,  -229,    -3,  -120,  -229,
    -229,  -229,  -208,   124,     9,  -229,  -229,  -229,  -229,  -229,
    -229,   154,   224,  -229,  -229,  -229,  -229,  -229,  -229,  -229,
    -229,     1,   -92
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     1,   172,    24,   113,   101,    25,   151,    27,    28,
      29,    30,    31,    32,   168,    33,   106,    34,   107,    35,
      36,   233,   179,   234,    37,    38,    39,    40,    41,    42,
     317,   173,    43,    44,    45,    46,    47,    48,    49,    50,
      51,   122,   130,   127,   117,   120,   150,    53,    54,    55,
      56,   252,    57,    58,    59,    60,    61,    62,   157,    63,
      64,   250,   308,   306,   260,    65,    99,   224,   225,   100,
     261,   262,   167,   265,   293,    66,    67,    68,    69,    70,
      71,    97,   143
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int16 yytable[] =
{
      52,    79,     2,    72,   164,   162,   183,    26,   149,   278,
     134,   153,    95,    80,   202,   208,   156,    90,   272,  -166,
      83,    96,   182,   184,   207,    52,   115,   116,    72,    93,
      88,    89,   102,   115,   116,   115,   116,     3,   -72,   -72,
     285,   115,   116,   144,   226,    94,   115,   116,   307,   109,
      88,    89,   177,   135,   -71,   -71,   209,   -75,  -126,   231,
     156,   232,  -126,   248,   284,    82,   205,   310,   249,    81,
     156,   219,   311,   211,   220,    98,   305,   146,   147,   212,
     245,    52,   227,  -166,    72,   312,   135,   283,   159,   286,
     148,   253,   254,   158,   326,   -84,   -84,   176,   282,   176,
     176,    90,   131,  -166,   270,  -126,    96,   206,    96,    96,
      52,    72,   277,    72,   280,   189,   135,   185,   193,   200,
     195,   257,   135,    84,   255,    96,   191,    85,    96,   108,
     175,   246,   175,   175,   -84,   -84,   288,   156,   156,   -60,
     189,   -60,   110,   296,   256,   214,   258,   180,   181,   197,
     279,   111,   199,   281,   -71,   -71,   271,   -75,   112,   176,
     114,   115,   116,    52,    92,   121,    72,  -126,    96,    52,
     222,   132,    72,   133,   297,   223,   228,    79,   165,   313,
     160,   166,   156,   301,   142,   189,   136,   135,   189,   235,
     292,   137,   175,    93,    96,   138,    93,   325,   314,   139,
     263,   140,    93,   264,   189,   290,   141,   189,   291,   145,
     304,   -61,   152,   -61,   154,   -61,   -61,   155,   244,   123,
     124,   125,   126,   323,    86,    87,   161,   176,   103,   104,
     176,   327,   146,   147,   163,    52,    96,   321,    72,    96,
      73,    74,    75,    76,    77,   275,   304,   -72,   -72,   174,
     170,   174,   174,    73,    74,    75,    76,    77,   188,   171,
     175,   118,   119,   175,   -80,   -80,   -80,   -80,   174,   177,
      78,   174,   214,   186,    52,   203,   295,    72,   300,   -71,
     -71,   228,   213,   204,   -83,   -83,   180,   181,   128,   129,
     259,   -73,   -73,     6,     7,     8,     9,    10,    52,   115,
     116,    72,   215,   315,   216,     6,     7,     8,     9,    10,
     217,   174,   218,   -33,   -33,   206,   -28,   221,    22,   104,
      52,   284,   318,    72,    23,   319,   320,   229,   242,   236,
      91,   243,     4,     5,   220,   230,    23,    92,   284,     6,
       7,     8,     9,    10,    11,    12,    13,   247,    14,   237,
     251,    15,    16,    17,   238,    18,   209,   239,   240,   241,
      19,    20,    21,   165,    22,    73,    74,    75,    76,    77,
      23,   269,   267,    18,   268,   273,     4,     5,   274,   174,
     160,   289,   174,     6,     7,     8,     9,    10,    11,    12,
      13,   294,    14,   284,   287,    15,    16,    17,   298,    18,
     299,    -7,    78,   303,    19,    20,    21,   248,    22,     4,
       5,   302,   316,   320,    23,   105,     6,     7,     8,     9,
      10,    11,    12,    13,   322,    14,   169,   192,    15,    16,
      17,   178,    18,   -28,   194,   198,   201,    19,    20,    21,
     210,    22,     4,     5,   324,   309,     0,    23,   266,     6,
       7,     8,     9,    10,    11,    12,    13,     0,    14,     0,
       0,    15,    16,    17,     0,   276,     0,    -7,     0,     0,
      19,    20,    21,     0,    22,     4,     5,     0,     0,     0,
      23,     0,     6,     7,     8,     9,    10,    11,    12,    13,
       0,    14,     0,     0,    15,    16,    17,     0,    18,     0,
      98,     0,     0,    19,    20,    21,     0,    22,     4,     5,
       0,     0,     0,    23,     0,     6,     7,     8,     9,    10,
      11,    12,    13,     0,    14,     0,     0,    15,    16,    17,
       0,    18,     0,     0,     0,     0,    19,    20,    21,     0,
      22,     6,     7,     8,     9,    10,    23,     0,     6,     7,
       8,     9,    10,     6,     7,     8,     9,    10,     6,     7,
       8,     9,    10,     0,     0,     0,    91,     6,     7,     8,
       9,    10,    23,    91,     0,     0,     0,     0,    91,   187,
       0,     0,     0,    91,   190,     0,     0,     0,     0,   196,
       0,     0,    91,   -84,   -84,   -80,   -80,   -80,   -80
};

static const yytype_int16 yycheck[] =
{
       2,     4,     0,     2,    99,    97,   110,     2,    82,   237,
      15,    85,    23,     4,   134,    15,    90,    54,   231,    56,
      18,    23,   110,   111,   144,    27,     3,     4,    27,    23,
       3,     4,    27,     3,     4,     3,     4,     0,     5,     6,
     248,     3,     4,    15,   169,    23,     3,     4,    40,    39,
       3,     4,    31,    58,     5,     6,    56,     8,    58,    38,
     134,    40,    15,    39,    56,    54,    15,    53,    44,    16,
     144,    55,    58,    15,    58,    41,   284,    80,    81,    15,
      57,    83,   170,    56,    83,   298,    58,    57,    55,    57,
      81,   211,   212,    55,   322,     9,    10,   108,    55,   110,
     111,    54,    53,    56,   229,    58,   108,    56,   110,   111,
     112,   110,   237,   112,   239,   117,    58,   112,   120,   130,
     122,   216,    58,    54,    15,   127,   120,    54,   130,    54,
     108,   205,   110,   111,     9,    10,   256,   211,   212,    53,
     142,    55,    54,   268,    15,   148,   220,    16,    17,   127,
     238,    54,   130,   241,     5,     6,   230,     8,    39,   170,
      53,     3,     4,   165,    23,     8,   165,    58,   170,   171,
     165,    53,   171,    53,   269,   166,   171,   180,    39,    48,
      55,    42,   256,   278,    56,   187,    53,    58,   190,   180,
     264,    53,   170,   187,   196,    53,   190,   322,   302,    53,
      40,    53,   196,    43,   206,    55,    53,   209,    58,    48,
     284,    53,    48,    55,     3,    57,    58,     4,   196,    11,
      12,    13,    14,   315,    35,    36,    55,   238,    33,    34,
     241,   326,   235,   236,    48,   237,   238,   311,   237,   241,
      18,    19,    20,    21,    22,   236,   320,     5,     6,   108,
      54,   110,   111,    18,    19,    20,    21,    22,   117,    39,
     238,     5,     6,   241,    11,    12,    13,    14,   127,    31,
      48,   130,   275,    28,   276,    48,   267,   276,   276,     5,
       6,   276,    48,   142,     9,    10,    16,    17,     9,    10,
      55,     5,     6,    23,    24,    25,    26,    27,   300,     3,
       4,   300,    55,   302,    40,    23,    24,    25,    26,    27,
      55,   170,    55,    33,    34,    56,     0,    54,    48,    34,
     322,    56,    57,   322,    54,    57,    58,    55,   187,    16,
      48,   190,    16,    17,    58,    54,    54,   196,    56,    23,
      24,    25,    26,    27,    28,    29,    30,   206,    32,    55,
     209,    35,    36,    37,    53,    39,    56,    55,    40,    54,
      44,    45,    46,    39,    48,    18,    19,    20,    21,    22,
      54,    40,    58,    39,    55,    40,    16,    17,    48,   238,
      55,    48,   241,    23,    24,    25,    26,    27,    28,    29,
      30,    40,    32,    56,    44,    35,    36,    37,    55,    39,
      15,    41,    48,    55,    44,    45,    46,    39,    48,    16,
      17,    53,    53,    58,    54,    31,    23,    24,    25,    26,
      27,    28,    29,    30,    55,    32,   105,   120,    35,    36,
      37,   109,    39,    40,   122,   127,   130,    44,    45,    46,
     145,    48,    16,    17,   320,   291,    -1,    54,   224,    23,
      24,    25,    26,    27,    28,    29,    30,    -1,    32,    -1,
      -1,    35,    36,    37,    -1,    39,    -1,    41,    -1,    -1,
      44,    45,    46,    -1,    48,    16,    17,    -1,    -1,    -1,
      54,    -1,    23,    24,    25,    26,    27,    28,    29,    30,
      -1,    32,    -1,    -1,    35,    36,    37,    -1,    39,    -1,
      41,    -1,    -1,    44,    45,    46,    -1,    48,    16,    17,
      -1,    -1,    -1,    54,    -1,    23,    24,    25,    26,    27,
      28,    29,    30,    -1,    32,    -1,    -1,    35,    36,    37,
      -1,    39,    -1,    -1,    -1,    -1,    44,    45,    46,    -1,
      48,    23,    24,    25,    26,    27,    54,    -1,    23,    24,
      25,    26,    27,    23,    24,    25,    26,    27,    23,    24,
      25,    26,    27,    -1,    -1,    -1,    48,    23,    24,    25,
      26,    27,    54,    48,    -1,    -1,    -1,    -1,    48,    54,
      -1,    -1,    -1,    48,    54,    -1,    -1,    -1,    -1,    54,
      -1,    -1,    48,     9,    10,    11,    12,    13,    14
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,    60,    65,     0,    16,    17,    23,    24,    25,    26,
      27,    28,    29,    30,    32,    35,    36,    37,    39,    44,
      45,    46,    48,    54,    62,    65,    66,    67,    68,    69,
      70,    71,    72,    74,    76,    78,    79,    83,    84,    85,
      86,    87,    88,    91,    92,    93,    94,    95,    96,    97,
      98,    99,   105,   106,   107,   108,   109,   111,   112,   113,
     114,   115,   116,   118,   119,   124,   134,   135,   136,   137,
     138,   139,   140,    18,    19,    20,    21,    22,    48,   116,
     123,    16,    54,    65,    54,    54,    35,    36,     3,     4,
      54,    48,    92,    93,    96,    98,   105,   140,    41,   125,
     128,    64,    66,    33,    34,    73,    75,    77,    54,    39,
      54,    54,    39,    63,    53,     3,     4,   103,     5,     6,
     104,     8,   100,    11,    12,    13,    14,   102,     9,    10,
     101,    53,    53,    53,    15,    58,    53,    53,    53,    53,
      53,    53,    56,   141,    15,    48,   116,   116,   123,    91,
     105,    66,    48,    91,     3,     4,    91,   117,    55,    55,
      55,    55,   141,    48,    64,    39,    42,   131,    73,    77,
      54,    39,    61,    90,    92,    96,    98,    31,    80,    81,
      16,    17,    90,   111,    90,    66,    28,    54,    92,   105,
      54,    93,    94,   105,    95,   105,    54,    96,    97,    96,
      98,    99,   117,    48,    92,    15,    56,   117,    15,    56,
     110,    15,    15,    48,   116,    55,    40,    55,    55,    55,
      58,    54,    66,   123,   126,   127,    61,    90,    66,    55,
      54,    38,    40,    80,    82,   123,    16,    55,    53,    55,
      40,    54,    92,    92,    96,    57,    91,    92,    39,    44,
     120,    92,   110,   117,   117,    15,    15,    64,    91,    55,
     123,   129,   130,    40,    43,   132,   131,    58,    55,    40,
      61,    91,    62,    40,    48,   123,    39,    61,    67,    90,
      61,    90,    55,    57,    56,   121,    57,    44,   117,    48,
      55,    58,    91,   133,    40,   123,    61,    64,    55,    15,
      65,    64,    53,    55,    91,   121,   122,    40,   121,   130,
      53,    58,    62,    48,   111,   140,    53,    89,    57,    57,
      58,    91,    55,   141,   122,    61,    67,    64
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    59,    60,    61,    62,    63,    64,    65,    66,    66,
      67,    67,    67,    67,    67,    67,    67,    67,    67,    67,
      67,    67,    67,    67,    68,    68,    68,    68,    69,    69,
      69,    69,    70,    71,    72,    73,    73,    74,    74,    75,
      76,    77,    78,    78,    79,    80,    80,    81,    82,    83,
      83,    83,    83,    84,    85,    86,    87,    88,    89,    90,
      90,    91,    91,    91,    91,    92,    92,    92,    92,    93,
      93,    93,    94,    94,    95,    95,    96,    96,    96,    96,
      97,    98,    98,    99,    99,   100,   101,   101,   102,   102,
     102,   102,   103,   103,   104,   104,   105,   105,   105,   105,
     105,   105,   105,   105,   106,   107,   107,   107,   108,   109,
     110,   110,   111,   111,   111,   111,   111,   111,   111,   112,
     113,   113,   114,   114,   115,   116,   116,   117,   117,   118,
     119,   120,   121,   121,   121,   122,   122,   123,   123,   123,
     123,   123,   124,   125,   125,   126,   127,   127,   128,   128,
     129,   129,   130,   131,   131,   132,   133,   133,   134,   134,
     134,   135,   136,   137,   138,   139,   140,   141,   141
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     3,     4,     5,     3,     0,     0,     2,     1,
       2,     2,     2,     1,     2,     2,     2,     2,     2,     2,
       2,     1,     1,     1,     1,     1,     1,     1,     0,     1,
       1,     1,     5,     5,     2,     2,     5,     3,     4,     1,
       1,     1,     4,     5,     4,     2,     1,     5,     2,     5,
       6,     9,    10,     1,     5,     1,     7,     1,     1,     1,
       1,     1,     1,     1,     1,     3,     1,     3,     1,     3,
       3,     1,     1,     3,     3,     1,     3,     3,     1,     1,
       1,     3,     3,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     2,
       1,     1,     1,     1,     4,     3,     1,     1,     4,     4,
       3,     2,     3,     1,     1,     1,     1,     1,     1,     4,
       4,     5,     5,     6,     5,     3,     1,     3,     1,     3,
       3,     3,     3,     3,     2,     1,     3,     1,     1,     1,
       1,     1,     3,     2,     4,     1,     3,     1,     5,     4,
       3,     1,     2,     4,     3,     3,     3,     1,     5,     6,
       4,     4,     1,     1,     2,     2,     1,     4,     3
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                  \
do                                                              \
  if (yychar == YYEMPTY)                                        \
    {                                                           \
      yychar = (Token);                                         \
      yylval = (Value);                                         \
      YYPOPSTACK (yylen);                                       \
      yystate = *yyssp;                                         \
      goto yybackup;                                            \
    }                                                           \
  else                                                          \
    {                                                           \
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;                                                  \
    }                                                           \
while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*----------------------------------------.
| Print this symbol's value on YYOUTPUT.  |
`----------------------------------------*/

static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyo = yyoutput;
  YYUSE (yyo);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# endif
  YYUSE (yytype);
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyoutput, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yytype_int16 *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  unsigned long int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[yyssp[yyi + 1 - yynrhs]],
                       &(yyvsp[(yyi + 1) - (yynrhs)])
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
static YYSIZE_T
yystrlen (const char *yystr)
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            /* Fall through.  */
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                yytype_int16 *yyssp, int yytoken)
{
  YYSIZE_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
  YYSIZE_T yysize = yysize0;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat. */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Number of reported tokens (one for the "unexpected", one per
     "expected"). */
  int yycount = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[*yyssp];
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (! (yysize <= yysize1
                         && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
                    return 2;
                  yysize = yysize1;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
    if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
      return 2;
    yysize = yysize1;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          yyp++;
          yyformat++;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        YYSTYPE *yyvs1 = yyvs;
        yytype_int16 *yyss1 = yyss;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * sizeof (*yyssp),
                    &yyvs1, yysize * sizeof (*yyvsp),
                    &yystacksize);

        yyss = yyss1;
        yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yytype_int16 *yyss1 = yyss;
        union yyalloc *yyptr =
          (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
                  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 192 "../sintatica.y" /* yacc.c:1646  */
    {
				cout << "/*Compilador FOCA*/\n" << "#include <iostream> \n#include <string.h> \n#include <stdio.h>\nusing namespace std;\n" << endl;
				printAssinaturas();
				printDeclaracoes();
				cout << "#define true 1 \n#define false 0 \nint main(void)\n{\n" << endl;
				cout <<"\n\n"<< (yyvsp[-1]).traducao << endl;
				cout <<"\n\n\treturn 0;\n}" << endl; 
				printFuncoes();
			
			}
#line 1765 "y.tab.c" /* yacc.c:1646  */
    break;

  case 3:
#line 206 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = (yyvsp[-2]).traducao;
			}
#line 1773 "y.tab.c" /* yacc.c:1646  */
    break;

  case 4:
#line 211 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = (yyvsp[-2]).traducao;
			}
#line 1781 "y.tab.c" /* yacc.c:1646  */
    break;

  case 5:
#line 217 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = (yyvsp[-1]).traducao;
			}
#line 1789 "y.tab.c" /* yacc.c:1646  */
    break;

  case 6:
#line 222 "../sintatica.y" /* yacc.c:1646  */
    {sobeEscopo();}
#line 1795 "y.tab.c" /* yacc.c:1646  */
    break;

  case 7:
#line 223 "../sintatica.y" /* yacc.c:1646  */
    {desceEscopo(false);}
#line 1801 "y.tab.c" /* yacc.c:1646  */
    break;

  case 8:
#line 226 "../sintatica.y" /* yacc.c:1646  */
    { 
				(yyval).traducao = (yyvsp[-1]).traducao + (yyvsp[0]).traducao;		
			}
#line 1809 "y.tab.c" /* yacc.c:1646  */
    break;

  case 9:
#line 230 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = (yyvsp[0]).traducao;
			}
#line 1817 "y.tab.c" /* yacc.c:1646  */
    break;

  case 24:
#line 252 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = (yyvsp[0]).traducao + "\n" + getLabelFimCondicoes()+":\n\n"; // Label Final
			 }
#line 1825 "y.tab.c" /* yacc.c:1646  */
    break;

  case 25:
#line 256 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = (yyvsp[0]).traducao + "\n" + getLabelFimCondicoes()+":\n\n"; // Label Final
			 }
#line 1833 "y.tab.c" /* yacc.c:1646  */
    break;

  case 32:
#line 273 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = (yyvsp[-2]).traducao; //traducao da condicao
				(yyval).traducao += "\n\tif (!("+ (yyvsp[-2]).label +")) goto " + getLabelEscopoFim() +";"; //if (condicao) goto labelFinal
				(yyval).traducao += "\n" + (yyvsp[0]).traducao +"\n";
				(yyval).traducao += "\n" + getLabelEscopoFim()+":"; // Label Final
			}
#line 1844 "y.tab.c" /* yacc.c:1646  */
    break;

  case 33:
#line 282 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = (yyvsp[-2]).traducao; //traducao da condicao
				(yyval).traducao += "\n\tif (!("+ (yyvsp[-2]).label +")) goto " + getLabelEscopoFim() +";"; //if (condicao) goto labelFinal
				(yyval).traducao += "\n" + (yyvsp[0]).traducao +"\n";
				(yyval).traducao += "\n\t goto " + getLabelFimCondicoes() +";\n";
				(yyval).traducao += "\n" + getLabelEscopoFim()+":\n"; // Label Final
			}
#line 1856 "y.tab.c" /* yacc.c:1646  */
    break;

  case 34:
#line 292 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = (yyvsp[-1]).traducao + (yyvsp[0]).traducao; //IF + quantos ELIFs tiverem	
			}
#line 1864 "y.tab.c" /* yacc.c:1646  */
    break;

  case 35:
#line 298 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = (yyvsp[-1]).traducao + (yyvsp[0]).traducao; // Quantos elifs tiverem
			}
#line 1872 "y.tab.c" /* yacc.c:1646  */
    break;

  case 36:
#line 302 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = (yyvsp[-2]).traducao; //traducao da condicao
				(yyval).traducao += "\n\tif (!("+ (yyvsp[-2]).label +")) goto " + getLabelEscopoFim() +";"; //if (condicao) goto labelFinal
				(yyval).traducao += "\n" + (yyvsp[0]).traducao +"\n"; // Bloco
				(yyval).traducao += "\n\t goto " + getLabelFimCondicoes() +";\n"; //Go para o final de TODAS as condições
				(yyval).traducao += "\n" + getLabelEscopoFim()+":\n\n"; // Label Final
			}
#line 1884 "y.tab.c" /* yacc.c:1646  */
    break;

  case 37:
#line 312 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = (yyvsp[-2]).traducao; // IF
				(yyval).traducao += "\n" + (yyvsp[0]).traducao +"\n"; // Bloco do ELSE
			}
#line 1893 "y.tab.c" /* yacc.c:1646  */
    break;

  case 38:
#line 317 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = (yyvsp[-3]).traducao + (yyvsp[-2]).traducao; //IF + Quantos ELIFs tiverem
				(yyval).traducao += "\n" + (yyvsp[0]).traducao +"\n"; // Bloco do ELSE
			}
#line 1902 "y.tab.c" /* yacc.c:1646  */
    break;

  case 39:
#line 323 "../sintatica.y" /* yacc.c:1646  */
    {	desceEscopo(true); }
#line 1908 "y.tab.c" /* yacc.c:1646  */
    break;

  case 40:
#line 325 "../sintatica.y" /* yacc.c:1646  */
    { desceEscopo(true); criaLabelFimCondicoes();}
#line 1914 "y.tab.c" /* yacc.c:1646  */
    break;

  case 41:
#line 327 "../sintatica.y" /* yacc.c:1646  */
    {	desceEscopo(true); }
#line 1920 "y.tab.c" /* yacc.c:1646  */
    break;

  case 42:
#line 330 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = (yyvsp[-3]).traducao;
				(yyval).traducao +=(yyvsp[-1]).traducao;
				(yyval).traducao +=getLabelFimCondicoes()+":\n";
			}
#line 1930 "y.tab.c" /* yacc.c:1646  */
    break;

  case 43:
#line 336 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = (yyvsp[-4]).traducao;
				(yyval).traducao +=(yyvsp[-2]).traducao;
				(yyval).traducao +=(yyvsp[-1]).traducao;
				(yyval).traducao +=getLabelFimCondicoes()+":\n";
			}
#line 1941 "y.tab.c" /* yacc.c:1646  */
    break;

  case 44:
#line 344 "../sintatica.y" /* yacc.c:1646  */
    {
				criaLabelFimCondicoes();
				label_acesso = (yyvsp[-1]).label;
				(yyval).traducao = (yyvsp[-1]).traducao;
			}
#line 1951 "y.tab.c" /* yacc.c:1646  */
    break;

  case 45:
#line 351 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = (yyvsp[-1]).traducao;
				(yyval).traducao += (yyvsp[0]).traducao;
			}
#line 1960 "y.tab.c" /* yacc.c:1646  */
    break;

  case 47:
#line 359 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = (yyvsp[-2]).traducao; //traducao da condicao
				(yyval).traducao += "\n\tif ("+ label_acesso +"!="+(yyvsp[-2]).label+") goto " + getLabelEscopoFim() +";"; //if (condicao) goto labelFinal
				(yyval).traducao += "\n" + (yyvsp[0]).traducao +"\n"; // Bloco
				(yyval).traducao += "\n\t goto " + getLabelFimCondicoes() +";\n"; //Go para o final de TODAS as condições
				(yyval).traducao += "\n" + getLabelEscopoFim()+":\n\n"; // Label Final
	
			}
#line 1973 "y.tab.c" /* yacc.c:1646  */
    break;

  case 48:
#line 368 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = "\n" + (yyvsp[0]).traducao +"\n"; // Bloco
			}
#line 1981 "y.tab.c" /* yacc.c:1646  */
    break;

  case 49:
#line 375 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = "\n" + getLabelEscopoInicio()+":\n"; // label Inicial Do Bloco
				(yyval).traducao += (yyvsp[-2]).traducao; //traducao da condicao
				(yyval).traducao += "\n\tif (!("+ (yyvsp[-2]).label +")) goto " + getLabelEscopoFim() +";"; //if (condicao) goto labelFinal
				(yyval).traducao += "\n" + (yyvsp[0]).traducao; //BLOCO
				(yyval).traducao += "\n\t goto " + getLabelEscopoInicio()+";"; //goto LabelInicio
				(yyval).traducao += "\n" + getLabelEscopoFim()+":\n\n"; // Label Final
			}
#line 1994 "y.tab.c" /* yacc.c:1646  */
    break;

  case 50:
#line 385 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = "\n" + getLabelEscopoInicio()+":\n"; // label Inicial Do Bloco
				(yyval).traducao += (yyvsp[-3]).traducao; //traducao da condicao
				(yyval).traducao += "\n\tif (!("+ (yyvsp[-3]).label +")) goto " + getLabelEscopoFim() +";"; //if (condicao) goto labelFinal
				(yyval).traducao += "\n" + (yyvsp[-1]).traducao; //BLOCO
				(yyval).traducao += "\n\t goto " + getLabelEscopoInicio()+";"; //goto LabelInicio
				(yyval).traducao += "\n" + getLabelEscopoFim()+":\n\n"; // Label Final
			}
#line 2007 "y.tab.c" /* yacc.c:1646  */
    break;

  case 51:
#line 394 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = (yyvsp[-6]).traducao; //traducao do ponto de partida
				(yyval).traducao += "\n" + getLabelEscopoInicio()+":\n"; // Label Inicial Do Bloco
				(yyval).traducao += (yyvsp[-4]).traducao; //traducao da condicao
				(yyval).traducao += "\n\tif (!("+ (yyvsp[-4]).label +")) goto " + getLabelEscopoFim() +";"; //if (condicao) goto Label Final
				(yyval).traducao += "\n" + (yyvsp[0]).traducao; //BLOCO
				(yyval).traducao += "\n" + (yyvsp[-2]).traducao; //incremento ou decremento
				(yyval).traducao += "\n\t goto " + getLabelEscopoInicio()+";"; //goto Label Inicio
				(yyval).traducao += "\n" + getLabelEscopoFim()+":\n\n"; // Label Final
			}
#line 2022 "y.tab.c" /* yacc.c:1646  */
    break;

  case 52:
#line 405 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = (yyvsp[-7]).traducao; //traducao do ponto de partida
				(yyval).traducao += "\n" + getLabelEscopoInicio()+":\n"; // Label Inicial Do Bloco
				(yyval).traducao += (yyvsp[-5]).traducao; //traducao da condicao
				(yyval).traducao += "\n\tif (!("+ (yyvsp[-5]).label +")) goto " + getLabelEscopoFim() +";"; //if (condicao) goto Label Final
				(yyval).traducao += "\n" + (yyvsp[-1]).traducao; //BLOCO
				(yyval).traducao += "\n" + (yyvsp[-3]).traducao; //incremento ou decremento
				(yyval).traducao += "\n\t goto " + getLabelEscopoInicio()+";"; //goto Label Inicio
				(yyval).traducao += "\n" + getLabelEscopoFim()+":\n\n"; // Label Final
			}
#line 2037 "y.tab.c" /* yacc.c:1646  */
    break;

  case 53:
#line 418 "../sintatica.y" /* yacc.c:1646  */
    {	
				desceEscopo(false);
			}
#line 2045 "y.tab.c" /* yacc.c:1646  */
    break;

  case 54:
#line 424 "../sintatica.y" /* yacc.c:1646  */
    {
					(yyval).traducao = "\n" + getLabelEscopoInicio()+":\n"; // label Inicial Do Bloco
					(yyval).traducao += (yyvsp[-2]).traducao; //traducao da condicao
					(yyval).traducao += "\n\tif (!("+ (yyvsp[-2]).label +")) goto " + getLabelEscopoFim() +";"; //if (condicao) goto labelFinal
					(yyval).traducao += "\n" + (yyvsp[0]).traducao; //BLOCO
					(yyval).traducao += "\n\t goto " + getLabelEscopoInicio()+";"; //goto LabelInicio
					(yyval).traducao += "\n" + getLabelEscopoFim()+":\n\n"; // Label Final
				}
#line 2058 "y.tab.c" /* yacc.c:1646  */
    break;

  case 55:
#line 435 "../sintatica.y" /* yacc.c:1646  */
    {
				desceEscopo(false);
			}
#line 2066 "y.tab.c" /* yacc.c:1646  */
    break;

  case 56:
#line 443 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = "\n" + getLabelEscopoInicio()+":\n"; // label Inicial Do Bloco
				(yyval).traducao += "\n" + (yyvsp[-5]).traducao; //BLOCO
				(yyval).traducao +=  "\n" + (yyvsp[-2]).traducao; //traducao da condicao
				(yyval).traducao += "\n\tif ("+ (yyvsp[-2]).label +") goto " + getLabelEscopoInicio() +";\n"; //if (condicao) goto labelFinal
			}
#line 2077 "y.tab.c" /* yacc.c:1646  */
    break;

  case 57:
#line 452 "../sintatica.y" /* yacc.c:1646  */
    {
				desceEscopo(false);
			}
#line 2085 "y.tab.c" /* yacc.c:1646  */
    break;

  case 58:
#line 457 "../sintatica.y" /* yacc.c:1646  */
    {
				sobeEscopo();
			}
#line 2093 "y.tab.c" /* yacc.c:1646  */
    break;

  case 65:
#line 483 "../sintatica.y" /* yacc.c:1646  */
    { 

				variavel var;
				if((yyvsp[-2]).colLabels.size() > 0)
				{
					var = useVarPorTempName((yyvsp[-2]).colLabels[0]);
					(yyvsp[-2]).label = var.temp_name;
					(yyvsp[-2]).tipo = var.tipo;
					(yyvsp[-2]).tipoReal = var.tipoReal;
					(yyvsp[-2]).isVet = var.isVet;
				}
				if((yyvsp[0]).colLabels.size() > 0)
				{
					var = useVarPorTempName((yyvsp[0]).colLabels[0]);
					(yyvsp[0]).label = var.temp_name;
					(yyvsp[0]).tipo = var.tipo;
					(yyvsp[0]).tipoReal = var.tipoReal;
					(yyvsp[0]).isVet = var.isVet;
				}
				operacao op = getTipoResultante((yyvsp[-2]).tipoReal, (yyvsp[0]).tipoReal, "ARITMETICO");
				(yyval).tipo = op.tipoResultante;
				(yyval).tipoReal = op.tipoReal;
				
				(yyval).label = nova_temp_var( (yyval).tipo);
				(yyval).traducao = aritmeticoTraducao((yyval), (yyvsp[-2]), (yyvsp[-1]), (yyvsp[0]));
				
			}
#line 2125 "y.tab.c" /* yacc.c:1646  */
    break;

  case 67:
#line 511 "../sintatica.y" /* yacc.c:1646  */
    { (yyval).traducao = (yyvsp[-1]).traducao; (yyval).label = (yyvsp[-1]).label; (yyval).tipo = (yyvsp[-1]).tipo; (yyval).tipoReal = (yyvsp[-1]).tipoReal;}
#line 2131 "y.tab.c" /* yacc.c:1646  */
    break;

  case 69:
#line 517 "../sintatica.y" /* yacc.c:1646  */
    {

				variavel var;
				if((yyvsp[-2]).colLabels.size() > 0)
				{
					var = useVarPorTempName((yyvsp[-2]).colLabels[0]);
					(yyvsp[-2]).label = var.temp_name;
					(yyvsp[-2]).tipo = var.tipo;
					(yyvsp[-2]).tipoReal = var.tipoReal;
					(yyvsp[-2]).isVet = var.isVet;
				}
				if((yyvsp[0]).colLabels.size() > 0)
				{
					var = useVarPorTempName((yyvsp[0]).colLabels[0]);
					(yyvsp[0]).label = var.temp_name;
					(yyvsp[0]).tipo = var.tipo;
					(yyvsp[0]).tipoReal = var.tipoReal;
					(yyvsp[0]).isVet = var.isVet;
				}

				operacao op = getTipoResultante((yyvsp[-2]).tipoReal, (yyvsp[0]).tipoReal, "ARITMETICO");
				(yyval).tipo = op.tipoResultante;
				(yyval).tipoReal = op.tipoReal;
				
				(yyval).label = nova_temp_var( (yyval).tipo);
				(yyval).traducao = aritmeticoTraducao((yyval), (yyvsp[-2]), (yyvsp[-1]), (yyvsp[0]));
				
			}
#line 2164 "y.tab.c" /* yacc.c:1646  */
    break;

  case 70:
#line 545 "../sintatica.y" /* yacc.c:1646  */
    { (yyval).traducao = (yyvsp[-1]).traducao; (yyval).label = (yyvsp[-1]).label; (yyval).tipo = (yyvsp[-1]).tipo; (yyval).tipoReal = (yyvsp[-1]).tipoReal;}
#line 2170 "y.tab.c" /* yacc.c:1646  */
    break;

  case 73:
#line 550 "../sintatica.y" /* yacc.c:1646  */
    { (yyval).traducao = (yyvsp[-1]).traducao; (yyval).label = (yyvsp[-1]).label;}
#line 2176 "y.tab.c" /* yacc.c:1646  */
    break;

  case 74:
#line 559 "../sintatica.y" /* yacc.c:1646  */
    {

				variavel varOp;
				if((yyvsp[-2]).colLabels.size() > 0)
				{
					varOp = useVarPorTempName((yyvsp[-2]).colLabels[0]);
					(yyvsp[-2]).label = varOp.temp_name;
					(yyvsp[-2]).tipo = varOp.tipo;
					(yyvsp[-2]).tipoReal = varOp.tipoReal;
					(yyvsp[-2]).tamanho = varOp.tamanho;
				}if((yyvsp[0]).colLabels.size() > 0)
				{
					varOp = useVarPorTempName((yyvsp[0]).colLabels[0]);
					(yyvsp[0]).label = varOp.temp_name;
					(yyvsp[0]).tipo = varOp.tipo;
					(yyvsp[0]).tipoReal = varOp.tipoReal;
					(yyvsp[0]).tamanho = varOp.tamanho;
				}

				(yyval).tipo = "char[]";
				(yyval).tipoReal = "string";
				variavel var = nova_temp_var_string( (yyvsp[-2]).tamanho + (yyvsp[0]).tamanho); 
				(yyval).label = var.temp_name; 
				(yyval).tamanho = (yyvsp[-2]).tamanho + (yyvsp[0]).tamanho;
				if((yyvsp[-2]).tipoReal == "string" & (yyvsp[0]).tipoReal == "string")
					(yyval).traducao = (yyvsp[-2]).traducao + (yyvsp[0]).traducao +"\n\t strcat("+(yyval).label+","+(yyvsp[-2]).label+");\n\t strcat("+(yyval).label+","+(yyvsp[0]).label+");\n"; 
				else
					yyerror("Não, Braida, ainda não fiz isso");
				//$$.label = nova_var_string()
			}
#line 2211 "y.tab.c" /* yacc.c:1646  */
    break;

  case 76:
#line 596 "../sintatica.y" /* yacc.c:1646  */
    {

				variavel var;
				if((yyvsp[-2]).colLabels.size() > 0)
				{
					var = useVarPorTempName((yyvsp[-2]).colLabels[0]);
					(yyvsp[-2]).label = var.temp_name;
					(yyvsp[-2]).tipo = var.tipo;
					(yyvsp[-2]).tipoReal = var.tipoReal;
					(yyvsp[-2]).tamanho = var.tamanho;
				}if((yyvsp[0]).colLabels.size() > 0)
				{
					var = useVarPorTempName((yyvsp[0]).colLabels[0]);
					(yyvsp[0]).label = var.temp_name;
					(yyvsp[0]).tipo = var.tipo;
					(yyvsp[0]).tipoReal = var.tipoReal;
					(yyvsp[0]).tamanho = var.tamanho;
				}

				operacao op = getTipoResultante((yyvsp[-2]).tipoReal, (yyvsp[0]).tipoReal, "relacional");

				(yyval).tipo = op.tipoResultante;
				(yyval).tipoReal = op.tipoReal;				
				(yyval).label = nova_temp_var((yyval).tipo);
				
				(yyval).traducao = relacionalTraducao((yyval), (yyvsp[-2]), (yyvsp[-1]), (yyvsp[0]));
			}
#line 2243 "y.tab.c" /* yacc.c:1646  */
    break;

  case 77:
#line 623 "../sintatica.y" /* yacc.c:1646  */
    {  (yyval).traducao = (yyvsp[-1]).traducao; (yyval).label = (yyvsp[-1]).label; (yyval).tipo = (yyvsp[-1]).tipo; (yyval).tipoReal = (yyvsp[-1]).tipoReal;}
#line 2249 "y.tab.c" /* yacc.c:1646  */
    break;

  case 81:
#line 635 "../sintatica.y" /* yacc.c:1646  */
    { 

				variavel var;
				if((yyvsp[-2]).colLabels.size() > 0)
				{
					var = useVarPorTempName((yyvsp[-2]).colLabels[0]);
					(yyvsp[-2]).label = var.temp_name;
					(yyvsp[-2]).tipo = var.tipo;
					(yyvsp[-2]).tipoReal = var.tipoReal;
					(yyvsp[-2]).tamanho = var.tamanho;
				}if((yyvsp[0]).colLabels.size() > 0)
				{
					var = useVarPorTempName((yyvsp[0]).colLabels[0]);
					(yyvsp[0]).label = var.temp_name;
					(yyvsp[0]).tipo = var.tipo;
					(yyvsp[0]).tipoReal = var.tipoReal;
					(yyvsp[0]).tamanho = var.tamanho;
				}
				operacao op = getTipoResultante((yyvsp[-2]).tipoReal, (yyvsp[0]).tipoReal, "logico");

				(yyval).tipo = op.tipoResultante;
				(yyval).tipoReal = op.tipoReal;
				(yyval).label = nova_temp_var( (yyval).tipo);

				(yyval).traducao = logicoTraducao((yyval), (yyvsp[-2]), (yyvsp[-1]), (yyvsp[0]));
			}
#line 2280 "y.tab.c" /* yacc.c:1646  */
    break;

  case 82:
#line 661 "../sintatica.y" /* yacc.c:1646  */
    { (yyval).traducao = (yyvsp[-1]).traducao; (yyval).label = (yyvsp[-1]).label; (yyval).tipo = (yyvsp[-1]).tipo; (yyval).tipoReal = (yyvsp[-1]).tipoReal;}
#line 2286 "y.tab.c" /* yacc.c:1646  */
    break;

  case 96:
#line 684 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).label =  nova_temp_var( (yyvsp[0]).tipo);
				(yyval).traducao = "\t" + (yyval).label + " = " + (yyvsp[0]).traducao + ";\n";	
			}
#line 2295 "y.tab.c" /* yacc.c:1646  */
    break;

  case 97:
#line 689 "../sintatica.y" /* yacc.c:1646  */
    {
				variavel temp;
				temp =  nova_temp_var_string((yyvsp[0]).traducao.size()-2);
				(yyval).label = temp.temp_name;
				(yyval).tipo = temp.tipo;
				(yyval).tamanho = temp.tamanho;
				(yyval).traducao = "\t strcpy(" + (yyval).label + "," + (yyvsp[0]).traducao + ");\n";				
			}
#line 2308 "y.tab.c" /* yacc.c:1646  */
    break;

  case 98:
#line 698 "../sintatica.y" /* yacc.c:1646  */
    {	
				variavel var = use_var((yyval).label, " ");
				(yyval).label =  var.temp_name;
				(yyval).tamanho = var.tamanho;
				(yyval).tipo = var.tipo;
				(yyval).tipoReal = var.tipoReal;
				(yyval).colLabels = var.colTamanhosLabels;
				(yyval).traducao = "";
			}
#line 2322 "y.tab.c" /* yacc.c:1646  */
    break;

  case 99:
#line 708 "../sintatica.y" /* yacc.c:1646  */
    {
				//Posso verificar se a quantidade de indices que andei é o tamanho do vetor...
				//Se não for, pode montar um novo vetor, salvar como vetor temporario e retornar...
				(yyval).traducao = (yyvsp[0]).traducao;
				variavel var = use_var((yyvsp[-1]).label, " ");
				if(var.tipoReal =="string"){
					variavel varTemp = nova_temp_var_string(1024); 
					(yyval).label = varTemp.temp_name;
					(yyval).traducao += "\tstrcpy("+ (yyval).label +"," +var.temp_name + "["+ (yyvsp[0]).label +"]);\n";
					(yyval).tamanho = 1024;
					(yyval).tipo = var.tipo;
					(yyval).tipoReal = var.tipoReal;	
				}else{
					(yyval).label = nova_temp_var(var.tipo);
					(yyval).traducao = (yyvsp[0]).traducao;
					(yyval).traducao += "\t"+ (yyval).label +" = " +var.temp_name + "["+ (yyvsp[0]).label +"];\n";
					(yyval).tamanho = var.tamanho;
					(yyval).tipo = var.tipoReal;
					(yyval).tipoReal = var.tipoReal;
				}
			}
#line 2348 "y.tab.c" /* yacc.c:1646  */
    break;

  case 100:
#line 730 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).label =  nova_temp_var( (yyvsp[0]).tipo);
				(yyval).traducao = "\t" + (yyval).label + " = " + (yyvsp[0]).traducao + ";\n";
				(yyval).tipo = "int"; 
				(yyval).tipoReal = "bool"; 
						
			}
#line 2360 "y.tab.c" /* yacc.c:1646  */
    break;

  case 101:
#line 738 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).tamanho = (yyval).traducao.size();
				(yyval).label =  nova_temp_var( (yyvsp[0]).tipo);
				(yyval).traducao = "\t" + (yyval).label + " = " + (yyvsp[0]).traducao + ";\n";			
			}
#line 2370 "y.tab.c" /* yacc.c:1646  */
    break;

  case 102:
#line 744 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).tamanho = (yyval).traducao.size()-2;
				(yyval).label =  nova_temp_var( (yyvsp[0]).tipo);
				(yyval).traducao = "\t" + (yyval).label + " = " + (yyvsp[0]).traducao + ";\n";			
			}
#line 2380 "y.tab.c" /* yacc.c:1646  */
    break;

  case 104:
#line 754 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = (yyvsp[-1]).traducao;
				funcao func = usaFuncao((yyvsp[-3]).label);

				if(func.parametros.size() != (yyvsp[-1]).colLabels.size())
					yyerror("Funcao espera quantidade de parametros diferentes");

				for (int i = 0; i < func.parametros.size() && i < (yyvsp[-1]).colLabels.size(); i++)
				{
					(yyval).traducao += "\t" + func.parametros[i].temp_name +" = "+ (yyvsp[-1]).colLabels[i]+";\n";
				}
				(yyval).traducao += "\t"+ func.temp_name+"();\n";
				for (int j = 0; j < func.retornos.size(); j++)
				{
					(yyval).colLabels.push_back(func.retornos[j].temp_name);
				}
				(yyval).label = "";
			}
#line 2403 "y.tab.c" /* yacc.c:1646  */
    break;

  case 105:
#line 777 "../sintatica.y" /* yacc.c:1646  */
    {

				if((yyvsp[-1]).tipoReal == "string"){
					(yyval).label = nova_var_string((yyvsp[0]).label, 0);
					(yyval).traducao = " ";
					(yyval).tipoReal = (yyvsp[-1]).tipoReal;
					(yyval).tipo = (yyvsp[-1]).tipo;
				}else
				{
	 				(yyval).traducao = " ";
	 				(yyval).label = nova_var((yyvsp[0]).label, (yyvsp[-1]).tipo);
	 			}
 			}
#line 2421 "y.tab.c" /* yacc.c:1646  */
    break;

  case 108:
#line 797 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = " ";
				(yyval).label = nova_global_var((yyvsp[0]).label, (yyvsp[-1]).tipo);
 			}
#line 2430 "y.tab.c" /* yacc.c:1646  */
    break;

  case 109:
#line 805 "../sintatica.y" /* yacc.c:1646  */
    {
 				(yyval).tipoReal = (yyvsp[-2]).tipoReal;
 				(yyval).tipo = (yyvsp[-2]).tipo;
 				(yyval).colLabels = (yyvsp[0]).colLabels;

 				(yyval).label = nova_var_vector((yyvsp[-1]).label, (yyvsp[-2]).tipo, (yyval).colLabels);

 				(yyval).traducao = (yyvsp[0]).traducao;
 				(yyval).traducao += "\t" + (yyval).tipo + " " +  (yyval).label +"["+ (yyvsp[0]).label + "];\n";
 			}
#line 2445 "y.tab.c" /* yacc.c:1646  */
    break;

  case 110:
#line 818 "../sintatica.y" /* yacc.c:1646  */
    {
				if ((yyvsp[-1]).tipoReal	== "int")
 				{
 					(yyval).traducao = (yyvsp[-1]).traducao;
 					(yyval).colLabels.push_back((yyvsp[-1]).label);
 					(yyval).label = (yyvsp[-1]).label;
 				}
 				else
 				{
 					yyerror("Esse tipo não é aceito para dimencionar um vetor");
 				}
 			
			}
#line 2463 "y.tab.c" /* yacc.c:1646  */
    break;

  case 111:
#line 832 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).label = nova_temp_var("int");
				(yyval).traducao = (yyvsp[-1]).traducao; 
				(yyval).traducao += (yyvsp[0]).traducao + "\t"+ (yyval).label +" = "+ (yyvsp[-1]).label +" * " + (yyvsp[0]).label+";\n" ;

				int i;
				for (i = 0 ; i < (yyvsp[0]).colLabels.size(); i++)
				{
					(yyvsp[-1]).colLabels.push_back((yyvsp[0]).colLabels[i]);
				}
				(yyval).colLabels = (yyvsp[-1]).colLabels;
			}
#line 2480 "y.tab.c" /* yacc.c:1646  */
    break;

  case 112:
#line 849 "../sintatica.y" /* yacc.c:1646  */
    {
 				(yyval).traducao = (yyvsp[0]).traducao;
 				for (int i = 0; (i < (yyvsp[-2]).colLabels.size()) && (i < (yyvsp[0]).colLabels.size() ) ; i++)
				{	
					variavel varOp = useVarPorTempName((yyvsp[0]).colLabels[i]);
					if(varOp.isVet) {
			 			resetaVector((yyvsp[-2]).colLabels[i], varOp.tipo ,varOp.colTamanhosLabels);
						variavel var = use_var((yyvsp[-2]).colLabels[i], varOp.tipo);
						(yyval).traducao += "\t"+ var.temp_name + " = " + varOp.temp_name+ ";\n"; 
				 	}
					else if(varOp.tipoReal == "string"){
						resetaString((yyvsp[-2]).colLabels[i], varOp.tamanho);
						variavel var = use_var((yyvsp[-2]).colLabels[i], varOp.tipo);				
						(yyval).traducao +="\t strcpy(" + var.temp_name + "," + varOp.temp_name+ ");\n";
					}
				 	else{
						variavel var = use_var((yyvsp[-2]).colLabels[i], varOp.tipo);
						(yyval).traducao +="\t" + var.temp_name + " = " + varOp.temp_name+ ";\n";
					}
				}

 			}
#line 2507 "y.tab.c" /* yacc.c:1646  */
    break;

  case 119:
#line 880 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = (yyvsp[-2]).traducao;
				(yyval).traducao += (yyvsp[0]).traducao;
				if((yyvsp[0]).tipoReal == "string"){
 					resetaString((yyvsp[-3]).label, (yyvsp[0]).tamanho);
 					variavel var = use_var((yyvsp[-3]).label, (yyvsp[0]).tipo);				
 					(yyval).traducao += "\t strcpy(" + var.temp_name + "["+ (yyvsp[-2]).label +"] ," + (yyvsp[0]).label+ ");\n";
 				}else{
 					variavel var = use_var((yyvsp[-3]).label, (yyvsp[0]).tipo);
 					(yyval).traducao +="\t" + var.temp_name + "["+ (yyvsp[-2]).label +"] = " + (yyvsp[-1]).label+ ";\n";
 				}

			}
#line 2525 "y.tab.c" /* yacc.c:1646  */
    break;

  case 120:
#line 901 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = (yyvsp[0]).traducao;
				for (int i = 0; (i < (yyvsp[-2]).colLabels.size()) && (i < (yyvsp[0]).colLabels.size() ) ; i++)
				{	
					variavel var = useVarPorTempName((yyvsp[0]).colLabels[i]);
					if((yyvsp[0]).isVet) {
				 		(yyval).label  = nova_var_vector((yyvsp[-2]).colLabels[i], var.tipo, var.colTamanhosLabels);
				 		(yyval).traducao += "\t"+ (yyval).label + " = " + var.temp_name+ ";\n"; 
			 		}
			 		else if(var.tipoReal == "string"){
				 		(yyval).traducao += "\t strcpy("+ nova_var_string((yyvsp[-2]).colLabels[i], var.tamanho) + ", "+ var.temp_name+ ");\n";
			 		}
				 	else
				 	{
				 		(yyval).traducao += "\t"+ nova_var((yyvsp[-2]).colLabels[i], var.tipo) + " = " + var.temp_name+ ";\n";
					}
				}
				
			}
#line 2549 "y.tab.c" /* yacc.c:1646  */
    break;

  case 121:
#line 921 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).tipoReal = (yyvsp[-3]).tipoReal;
				(yyval).tipo = (yyvsp[-3]).tipo;
				(yyval).traducao = (yyvsp[0]).traducao;
				for (int i = 0; (i < (yyvsp[-2]).colLabels.size()) && (i < (yyvsp[0]).colLabels.size() ) ; i++)
				{		
					variavel var = useVarPorTempName((yyvsp[0]).colLabels[i]);
					if((yyvsp[-3]).tipoReal == "string" && var.tipoReal == "string")
					{
						(yyval).traducao += "\t strcpy("+ nova_var_string((yyvsp[-2]).colLabels[i], var.tamanho) + ", " +var.temp_name+ ");\n";	
					}
					else if( ((yyvsp[-3]).tipoReal == "string" && var.tipoReal != "string")||((yyvsp[-3]).tipoReal != "string" && var.tipoReal == "string"))
					{
						yyerror("Não é possivel fazer essa atribuição");
					}
					else
					{
				 		(yyval).traducao += "\t"+ nova_var((yyvsp[-2]).colLabels[i], (yyvsp[-3]).tipo) + " = " + "("+(yyvsp[-3]).tipo+")"+var.temp_name+ ";\n";
					}
				}
			}
#line 2575 "y.tab.c" /* yacc.c:1646  */
    break;

  case 122:
#line 947 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = (yyvsp[0]).traducao;
				for (int i = 0; (i < (yyvsp[-2]).colLabels.size()) && (i < (yyvsp[0]).colLabels.size() ) ; i++)
				{		
					variavel var = useVarPorTempName((yyvsp[0]).colLabels[i]);
					if(var.tipoReal == "string")
					{
						(yyval).traducao += "\t strcpy("+ nova_global_var_string((yyvsp[-2]).colLabels[i], var.tamanho) + ", " +var.temp_name+ ");\n";	
					}
					else
					{
				 		(yyval).traducao += "\t"+ nova_global_var((yyvsp[-2]).colLabels[i], var.tipo) + " = " + var.temp_name+ ";\n";
					}
			 	}
			 }
#line 2595 "y.tab.c" /* yacc.c:1646  */
    break;

  case 123:
#line 963 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = (yyvsp[0]).traducao;
				for (int i = 0; (i < (yyvsp[-2]).colLabels.size()) && (i < (yyvsp[0]).colLabels.size() ) ; i++)
				{		
					variavel var = useVarPorTempName((yyvsp[0]).colLabels[i]);
					
					if((yyvsp[-3]).tipoReal == "string" && (yyvsp[0]).tipoReal == "string")
					{
						(yyval).traducao += "\t strcpy("+ nova_global_var_string((yyvsp[-2]).colLabels[i], var.tamanho) + ", " +var.temp_name+ ");\n";	
					}
					else if( ((yyvsp[-3]).tipoReal == "string" && var.tipoReal != "string")||((yyvsp[-3]).tipoReal != "string" && var.tipoReal == "string"))
					{
						yyerror("Não é possivel fazer essa atribuição");
					}
					else
					{
				 		(yyval).traducao +="\t"+ nova_global_var((yyvsp[-2]).colLabels[i], var.tipo) + " = " + "("+(yyvsp[-3]).tipo+")"+var.temp_name+ ";\n";
					}
				}
			 }
#line 2620 "y.tab.c" /* yacc.c:1646  */
    break;

  case 124:
#line 988 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).tipoReal = (yyvsp[-3]).tipoReal;
				(yyval).tipo = (yyvsp[-3]).tipo;
				
				stringstream tamanho_str;				

				(yyval).traducao = "";
				int j;
				for (j = (yyvsp[0]).tamanhos.size()-1 ; j >= 0 ; j--){
					stringstream tamanho_str;
					tamanho_str << (yyvsp[0]).tamanhos[j];
					string tamanho = nova_temp_var("int");
					(yyval).traducao += "\t"+ tamanho + " = " + tamanho_str.str() +";// tamanho do vetor\n" ;
					(yyval).colLabels.push_back(tamanho);
				}

				(yyval).label = nova_var_vector((yyvsp[-2]).label, (yyvsp[-3]).tipoReal, (yyval).colLabels);

				tamanho_str << (yyvsp[0]).colLabels.size();

				string tamanho = nova_temp_var("int");
				(yyval).traducao += (yyvsp[0]).traducao;

				(yyval).traducao += "\n\t" + tamanho +" = "+ tamanho_str.str() +";\n";
 				(yyval).traducao += "\t" + (yyval).tipo + " " +  (yyval).label +"["+ tamanho + "];\n";
 				int i;
 				for (i = 0; i < (yyvsp[0]).colLabels.size(); i++)
 				{

					stringstream i_string;
					i_string << i;
 					(yyval).traducao += "\t"+ (yyval).label +"["+ i_string.str() + "] = " + (yyvsp[0]).colLabels[i] +";\n";
 				}
			}
#line 2659 "y.tab.c" /* yacc.c:1646  */
    break;

  case 125:
#line 1030 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).colLabels = (yyvsp[-2]).colLabels;
				(yyval).colLabels.push_back((yyvsp[0]).label);
			}
#line 2668 "y.tab.c" /* yacc.c:1646  */
    break;

  case 126:
#line 1035 "../sintatica.y" /* yacc.c:1646  */
    { 
				(yyval).colLabels.push_back((yyvsp[0]).label); 
			}
#line 2676 "y.tab.c" /* yacc.c:1646  */
    break;

  case 127:
#line 1041 "../sintatica.y" /* yacc.c:1646  */
    {	
				(yyval).traducao = (yyvsp[-2]).traducao + (yyvsp[0]).traducao;
				(yyval).colLabels = (yyvsp[-2]).colLabels;
				(yyval).colLabels.push_back((yyvsp[0]).label);
			}
#line 2686 "y.tab.c" /* yacc.c:1646  */
    break;

  case 128:
#line 1047 "../sintatica.y" /* yacc.c:1646  */
    {	
				vector<string> vazio;
				(yyval).colLabels = vazio;
				if ((yyvsp[0]).label != "")
					(yyval).colLabels.push_back((yyval).label);
				else{
					if((yyvsp[0]).colLabels.size() > 0){
						for (int i = 0; i < (yyvsp[0]).colLabels.size(); i++)
						{
							(yyval).colLabels.push_back((yyvsp[0]).colLabels[i]);
						}
					}
					else
						yyerror("Esta operando com o que, vei?");
				}
			}
#line 2707 "y.tab.c" /* yacc.c:1646  */
    break;

  case 129:
#line 1068 "../sintatica.y" /* yacc.c:1646  */
    {
 				 variavel var = use_var((yyvsp[-2]).label, (yyvsp[-2]).tipo);
 				(yyval).traducao = "\t" + var.temp_name + " = " + var.temp_name + "+ 1;\n";
 			}
#line 2716 "y.tab.c" /* yacc.c:1646  */
    break;

  case 130:
#line 1074 "../sintatica.y" /* yacc.c:1646  */
    {
 				variavel var = use_var((yyvsp[-2]).label, (yyvsp[-2]).tipo);
 				(yyval).traducao = "\t" + var.temp_name + " = " + var.temp_name + "- 1;\n";
 			}
#line 2725 "y.tab.c" /* yacc.c:1646  */
    break;

  case 131:
#line 1084 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = (yyvsp[-1]).traducao;
				(yyval).tamanho = (yyvsp[-1]).tamanho;
				(yyval).tamanhos = (yyvsp[-1]).tamanhos;
				(yyval).colLabels = (yyvsp[-1]).colLabels;
				(yyval).tamanhos.push_back((yyvsp[-1]).tamanho);
			}
#line 2737 "y.tab.c" /* yacc.c:1646  */
    break;

  case 132:
#line 1094 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).tamanho = 1;
				(yyval).traducao = (yyvsp[-1]).traducao;
				(yyval).colLabels = (yyvsp[-1]).colLabels;
				(yyval).tamanhos.push_back((yyvsp[-1]).tamanho);
			}
#line 2748 "y.tab.c" /* yacc.c:1646  */
    break;

  case 133:
#line 1101 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).tamanho = 1;
				(yyval).traducao = (yyvsp[-1]).traducao;
				(yyval).colLabels = (yyvsp[-1]).colLabels;
				(yyval).tamanhos = (yyvsp[-1]).tamanhos;
				(yyval).tamanhos.push_back((yyvsp[-1]).tamanho);
			}
#line 2760 "y.tab.c" /* yacc.c:1646  */
    break;

  case 134:
#line 1109 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = (yyvsp[-1]).traducao + (yyvsp[0]).traducao;
				(yyval).colLabels = (yyvsp[-1]).colLabels;
				int i;
				for (i = 0 ; i < (yyvsp[0]).colLabels.size(); i++)
				{
					(yyval).colLabels.push_back((yyvsp[0]).colLabels[i]);
				}
				if((yyvsp[-1]).tamanhos == (yyvsp[0]).tamanhos)
					(yyval).tamanhos = (yyvsp[-1]).tamanhos;
				else
					yyerror("Não foi possivel declarar o vetor... \n Vetor é regular e você está tentando declarar um irregular");

				(yyval).tamanho = (yyvsp[-1]).tamanho + (yyvsp[0]).tamanho;
			}
#line 2780 "y.tab.c" /* yacc.c:1646  */
    break;

  case 135:
#line 1127 "../sintatica.y" /* yacc.c:1646  */
    {	
				(yyval).tamanho = 1;
				(yyval).traducao = (yyvsp[0]).traducao;
				(yyval).colLabels.push_back((yyvsp[0]).label);
			}
#line 2790 "y.tab.c" /* yacc.c:1646  */
    break;

  case 136:
#line 1133 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = (yyvsp[-2]).traducao + (yyvsp[0]).traducao;
				(yyval).tamanho = (yyvsp[-2]).tamanho + (yyvsp[0]).tamanho;
				(yyval).colLabels = (yyvsp[-2]).colLabels;	
				int i;
				for (i = 0 ; i < (yyvsp[0]).colLabels.size(); i++)
				{   
					(yyval).colLabels.push_back((yyvsp[0]).colLabels[i]);
				}
			
			}
#line 2806 "y.tab.c" /* yacc.c:1646  */
    break;

  case 142:
#line 1162 "../sintatica.y" /* yacc.c:1646  */
    {

				(yyval).traducao = "";
			}
#line 2815 "y.tab.c" /* yacc.c:1646  */
    break;

  case 143:
#line 1169 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao =  (yyvsp[0]).traducao;
				atualizaFuncRetorno((yyvsp[0]).colLabels);
				atualizaFuncTraducao((yyvsp[-1]).label, (yyval).traducao);
			}
#line 2825 "y.tab.c" /* yacc.c:1646  */
    break;

  case 144:
#line 1175 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao =  (yyvsp[0]).traducao;

				if((yyvsp[0]).colLabels.size() != (yyvsp[-1]).colLabels.size())
					yyerror("Esperando um numero diferente de retornos");
				for (int i = 0; i < (yyvsp[-1]).colLabels.size(); ++i)
				{		
					(yyval).traducao += "\t"+(yyvsp[-1]).colLabels[i]+" = "+ (yyvsp[0]).colLabels[i]+";\n";
				}

				atualizaFuncTraducao((yyvsp[-3]).label, (yyval).traducao);
			}
#line 2842 "y.tab.c" /* yacc.c:1646  */
    break;

  case 145:
#line 1190 "../sintatica.y" /* yacc.c:1646  */
    {
				atualizaFuncRetorno((yyvsp[0]).colLabels);
			}
#line 2850 "y.tab.c" /* yacc.c:1646  */
    break;

  case 146:
#line 1195 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).colLabels = (yyvsp[-2]).colLabels;
				(yyval).colLabels.push_back(nova_temp_var((yyvsp[0]).tipoReal));
			}
#line 2859 "y.tab.c" /* yacc.c:1646  */
    break;

  case 147:
#line 1200 "../sintatica.y" /* yacc.c:1646  */
    {
				vector<string> vazio;
				(yyval).colLabels = vazio;
				(yyval).colLabels.push_back(nova_temp_var((yyvsp[0]).tipoReal));
			}
#line 2869 "y.tab.c" /* yacc.c:1646  */
    break;

  case 148:
#line 1209 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = "\tvoid" + (yyvsp[-2]).label +"()\n";
				(yyval).label = (yyvsp[-2]).label;
				(yyval).colLabels = (yyvsp[-1]).colLabels;
				novaFuncao((yyval).label, (yyval).colLabels);

			}
#line 2881 "y.tab.c" /* yacc.c:1646  */
    break;

  case 149:
#line 1217 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = "\tvoid" + (yyvsp[-1]).label +"()\n";
				(yyval).label = (yyvsp[-1]).label;

				vector<string> vazio;
				(yyval).colLabels = vazio;
				novaFuncao((yyval).label, (yyval).colLabels);
			}
#line 2894 "y.tab.c" /* yacc.c:1646  */
    break;

  case 150:
#line 1235 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).colLabels = (yyvsp[-2]).colLabels;
				(yyval).colLabels.push_back((yyvsp[0]).label);
			}
#line 2903 "y.tab.c" /* yacc.c:1646  */
    break;

  case 151:
#line 1240 "../sintatica.y" /* yacc.c:1646  */
    {
				vector<string> vazio;
				(yyval).colLabels = vazio;
				(yyval).colLabels.push_back((yyvsp[0]).label);
			}
#line 2913 "y.tab.c" /* yacc.c:1646  */
    break;

  case 152:
#line 1248 "../sintatica.y" /* yacc.c:1646  */
    {
				if((yyvsp[0]).tipoReal == "string"){
					(yyval).label = nova_var_param_string((yyvsp[0]).label, 1024);
					(yyval).traducao = " ";
					(yyval).tipoReal = (yyvsp[-1]).tipoReal;
					(yyval).tipo = (yyvsp[-1]).tipo;
				}else
				{
	 				(yyval).traducao = " ";
	 				(yyval).label = nova_var_param((yyvsp[0]).label, (yyvsp[-1]).tipo);
	 			}
 			}
#line 2930 "y.tab.c" /* yacc.c:1646  */
    break;

  case 153:
#line 1264 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = (yyvsp[-2]).traducao;
				(yyval).traducao += (yyvsp[-1]).traducao;
				(yyval).colLabels = (yyvsp[-1]).colLabels;
			}
#line 2940 "y.tab.c" /* yacc.c:1646  */
    break;

  case 154:
#line 1270 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = (yyvsp[-1]).traducao;
				vector<string> vazio;
				(yyval).colLabels = vazio;
			}
#line 2950 "y.tab.c" /* yacc.c:1646  */
    break;

  case 155:
#line 1277 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao  = (yyvsp[-1]).traducao;
				(yyval).colLabels = (yyvsp[-1]).colLabels;
			}
#line 2959 "y.tab.c" /* yacc.c:1646  */
    break;

  case 156:
#line 1283 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = (yyvsp[-2]).traducao;
				(yyval).traducao += (yyvsp[0]).traducao;
				(yyval).colLabels = (yyvsp[-2]).colLabels;
				(yyval).colLabels.push_back((yyvsp[0]).label);
			}
#line 2970 "y.tab.c" /* yacc.c:1646  */
    break;

  case 157:
#line 1290 "../sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = (yyvsp[0]).traducao;
				(yyval).colLabels.push_back((yyvsp[0]).label);
			}
#line 2979 "y.tab.c" /* yacc.c:1646  */
    break;

  case 158:
#line 1301 "../sintatica.y" /* yacc.c:1646  */
    {

				if((yyvsp[-3]).tipoReal == "string"){
					nova_var_string((yyvsp[-2]).label, 0);
 					resetaString((yyvsp[-2]).label, 1024);
 					variavel var = use_var((yyvsp[-2]).label, (yyvsp[-2]).tipo);
					(yyval).traducao = "\t cin << " + var.temp_name + " ;\n";
				}
				else
				{
	 				(yyval).label = nova_var((yyvsp[-2]).label, (yyvsp[-3]).tipo);
					(yyval).traducao = "\t cin << " + (yyval).label + " ;\n";
				}
			}
#line 2998 "y.tab.c" /* yacc.c:1646  */
    break;

  case 159:
#line 1316 "../sintatica.y" /* yacc.c:1646  */
    {
				if((yyvsp[-3]).tipoReal == "string"){
					nova_var_string((yyvsp[-2]).label, 0);
 					resetaString((yyvsp[-2]).label, 1024);
 					variavel var = use_var((yyvsp[-2]).label, (yyvsp[-2]).tipo);
					(yyval).traducao = "\tcin << " + var.temp_name + " ;\n";	
				}else
				{
	 				(yyval).label = nova_var((yyvsp[-2]).label, (yyvsp[-3]).tipo);
					(yyval).traducao = "\tcin << " + (yyval).label + " ;\n";
				}
 			}
#line 3015 "y.tab.c" /* yacc.c:1646  */
    break;

  case 160:
#line 1329 "../sintatica.y" /* yacc.c:1646  */
    {
				if((yyvsp[-1]).tipoReal == "string"){
 					resetaString((yyvsp[-1]).label, 1024);
 					variavel var = use_var((yyvsp[-1]).label, (yyvsp[-1]).tipo);
					(yyval).traducao = "\t cin << " + var.temp_name + " ;\n";	
				}
				else{
					(yyval).traducao = "\t cin << " + (yyvsp[-1]).label + " ;\n";	
				}
			}
#line 3030 "y.tab.c" /* yacc.c:1646  */
    break;

  case 161:
#line 1342 "../sintatica.y" /* yacc.c:1646  */
    {	
				(yyval).traducao = (yyvsp[-1]).traducao;
				(yyval).traducao += "\t cout <<" + (yyvsp[-1]).label + " ;\n";
			}
#line 3039 "y.tab.c" /* yacc.c:1646  */
    break;

  case 162:
#line 1353 "../sintatica.y" /* yacc.c:1646  */
    { (yyval).traducao = "\tgoto " + getLabelBreak()+";\n";}
#line 3045 "y.tab.c" /* yacc.c:1646  */
    break;

  case 163:
#line 1355 "../sintatica.y" /* yacc.c:1646  */
    {	(yyval).traducao = "\tgoto " + getLabelContinue()+";\n";}
#line 3051 "y.tab.c" /* yacc.c:1646  */
    break;

  case 164:
#line 1357 "../sintatica.y" /* yacc.c:1646  */
    { (yyval).traducao = "\tgoto " + getSuperLabelBreak()+";\n";	}
#line 3057 "y.tab.c" /* yacc.c:1646  */
    break;

  case 165:
#line 1359 "../sintatica.y" /* yacc.c:1646  */
    { (yyval).traducao = "\tgoto " + getSuperLabelContinue()+";\n"; }
#line 3063 "y.tab.c" /* yacc.c:1646  */
    break;

  case 166:
#line 1367 "../sintatica.y" /* yacc.c:1646  */
    {
				variavel var = use_var((yyvsp[0]).label, " ");
				vet_label_flag = var.orig_name;
			}
#line 3072 "y.tab.c" /* yacc.c:1646  */
    break;

  case 167:
#line 1373 "../sintatica.y" /* yacc.c:1646  */
    {
				vet_posicao_atual++;
				variavel var = use_var(vet_label_flag, " ");
				string label = nova_temp_var("int");
				(yyval).label = nova_temp_var("int");	

				(yyval).traducao = (yyvsp[-3]).traducao;
				(yyval).traducao += (yyvsp[-1]).traducao;

				(yyval).traducao += "\t"+ label +" = "+ (yyvsp[-3]).label +" + "+ (yyvsp[-1]).label + ";\n";
				if(vet_posicao_atual != var.colTamanhosLabels.size())
					(yyval).traducao += "\t"+ (yyval).label +" = "+ var.colTamanhosLabels[vet_posicao_atual] +" * "+ label + ";\n";
				else
					(yyval).label = label;
			}
#line 3092 "y.tab.c" /* yacc.c:1646  */
    break;

  case 168:
#line 1389 "../sintatica.y" /* yacc.c:1646  */
    { 
				variavel var = use_var(vet_label_flag, " ");
				vet_posicao_atual = 1;
				(yyval).label = nova_temp_var("int");
				(yyval).traducao = (yyvsp[-1]).traducao; 
				(yyval).traducao += "\t"+ (yyval).label +" = "+ var.colTamanhosLabels[vet_posicao_atual] +" * "+ (yyvsp[-1]).label + "\n";
			}
#line 3104 "y.tab.c" /* yacc.c:1646  */
    break;


#line 3108 "y.tab.c" /* yacc.c:1646  */
      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 1399 "../sintatica.y" /* yacc.c:1906  */

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
