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
%token PRINT IF ELSE ENDIF WHILE END EQ

%type <node> statement_list statement else_part exp

%nonassoc '<' EQ
%left '+' '-'
%right '!'

%start program

%%

program
    : statement_list
	{ run($1); }
    ;

statement_list
    : statement_list statement ';'
	{ $$ = make_node(Stmt_List_Node, NULL, $1, $2); }
    |   { $$ = NULL; }
    ;

statement
    : PRINT exp { $$ = make_node(Print_Val_Node, NULL, $2, NULL); }
    | PRINT STRING { $$ = make_node(Print_String_Node, NULL, $2, NULL); }
    | IF '(' exp ')'
	statement_list
	else_part
      ENDIF
	{ $$ = make_node(If_Node, $3, $5, $6); }
    | WHILE '(' exp ')'
	statement_list
      END   { $$ = make_node(While_Node, $3, $5, NULL); }
    | VAR '=' exp { $$ = make_node(Assign_Node, NULL, $1, $3); }
    ;

else_part :
	ELSE
	    statement_list
	    { $$ = $2; }
	|   { $$ = NULL; }
	;

exp
    : VAR { $$ = make_node(VAR_Node, NULL, $1, NULL); }
    | NUM { $$ = make_node(NUM_Node, NULL, $1, NULL); }
    | '(' exp ')' { $$ = $2; }
    | exp '+' exp { $$ = make_node(ADD_Node, NULL, $1, $3); }
    | exp '-' exp { $$ = make_node(SUB_Node, NULL, $1, $3); }
    | exp '<' exp { $$ = make_node('<', NULL, $1, $3); }
    | exp EQ exp { $$ = make_node(EQ_Node, NULL, $1, $3); }
    | '!' exp { $$ = make_node(NOT_Node, NULL, $2); }
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
