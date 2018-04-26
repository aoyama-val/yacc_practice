%{
#include <stdio.h>
#include <ctype.h>
#include "node.h"
%}

%union {
    int val;	// 数値
    int var;	// 変数のインデクス
    char *str;	// 文字列
    Node *node;	// ノード
}

%token <var> VAR
%token <val> NUM
%token <str> STRING
%token PRINT IF ELSE ENDIF WHILE END EQ OR AND DEF UNLESS

%type <node> statement_list statement else_part exp

%nonassoc '<' EQ
%left OR AND
%left '+' '-'
%right '!'

%start program

%%

program
    : statement_list
	{ eval($1); }
    ;

statement_list
    : statement_list statement ';'
	{ 
	    // if (0 < (int)$1 && (int)$1 < 0x200)
	// 	printf("DEBUG: statement_list %p\n", (int)$1);
	    $$ = make_node(Stmt_List_Node, NULL, $1, $2); }
    |   { $$ = NULL; }
    ;

statement :
    PRINT exp { $$ = make_node(Print_Val_Node, NULL, $2, NULL); }
    | IF '(' exp ')'
	statement_list
	else_part
      ENDIF
	{ $$ = make_node(If_Node, $3, $5, $6); }
    | VAR '=' exp { $$ = make_node(Assign_Node, NULL, $1, $3); }
    | exp { ; }
    | DEF VAR '(' ')' 
	statement_list
	END
	{ printf("\033[0;32mdefined %c %p\033[m\n", $2, $5); $$ = make_node(Def_Node, NULL, $2, $5); }
    | statement UNLESS '(' exp ')' { 
	    $$ = make_node(Unless_Node, $4, $1, NULL);
	}
    | { $$ = NULL; }	//  空文
    ;

else_part :
	ELSE
	    statement_list
	    { $$ = $2; }
	|   { $$ = NULL; }
	;

exp
    : VAR { $$ = make_node(VAR_Node, NULL, $1, NULL); }
    | NUM { $$ = make_node(NUM_Node, NULL, $1, NULL); }	// $1 = int
    | '(' exp ')' { $$ = $2; }	// node = node
    | exp '+' exp { $$ = make_node(ADD_Node, NULL, $1, $3); }
    | exp '-' exp { $$ = make_node(SUB_Node, NULL, $1, $3); }
    | exp '<' exp { $$ = make_node('<', NULL, $1, $3); }
    | exp EQ exp { $$ = make_node(EQ_Node, NULL, $1, $3); }
    | '!' exp { $$ = make_node(NOT_Node, NULL, $2); }
    |  WHILE '(' exp ')'
	statement_list
      END   { $$ = make_node(While_Node, $3, $5, NULL); } 
    | VAR '=' exp { $$ = make_node(Assign_Node, NULL, $1, $3); }
    | PRINT STRING { $$ = make_node(Print_String_Node, NULL, $2, NULL); }
    | STRING { $$ = make_node(NUM_Node, NULL, $1, NULL); }
    | exp OR exp { $$ = make_node(OR_Node, NULL, $1, $3); }
    | exp AND exp { $$ = make_node(AND_Node, NULL, $1, $3); }
    | VAR '(' ')' { $$ = make_node(Call_Node, NULL, $1, NULL); }
    ;

%%

int yydebug = 0;
int main()
{
//#ifdef YYDEBUG
    //extern int yydebug;

    //yydebug = 1;
//#endif
    yyparse();
    return 0;
}

#include "lex.yy.c"
