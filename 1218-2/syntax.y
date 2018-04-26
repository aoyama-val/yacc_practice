%{
#include <stdio.h>
#include <stdlib.h>

#include "node.h"

struct node* make_node(int type, struct node* cond, struct node* left, struct node* right)
{
    struct node* n = (struct node*)malloc(sizeof(struct node));
    n->type = type;
    n->cond = cond;
    n->left = left;
    n->right = right;
    return n;
}

int eval(struct node* n);

%}

%union {
    int i;
    double d;
    struct node* node;
}

%token  <i> NUMBER
%token NL

%left '+' '-'

%type <node> expr 
%type <node> program 
%type <node> stmt_list 
%type <node> stmt 
%%

program :
	stmt_list
	;

stmt_list :
	  stmt_list stmt
	  | { $$ = NULL; }
	  ;

stmt :
     expr NL { printf("-> %d\n", eval($1)); $$ = $1; }
     | NL { $$ = NULL; }
     ;

expr :
     NUMBER { $$ = make_node(NT_NUMBER, (struct node*)$1, NULL, NULL); }
     | expr '+' expr  { $$ = make_node(NT_PLUS, NULL, $1, $3); }
     | expr '-' expr  { $$ = make_node(NT_MINUS, NULL, $1, $3); }
     | '(' expr ')' { $$ = $2; }
     ;

%%

int yyerror(char* msg)
{
    fprintf(stderr, "%s\n", msg);
    return 0;
}

int main()
{
    yyparse();
    return 0;
}

#include "lex.yy.c"
