#include <stdio.h>
#include <stdlib.h>
#include "node.h"

extern int line_no;

void yyerror(char* msg)
{
    fprintf(stderr, "Error %s at %d\n", msg, line_no);
    exit(1);
}

Node* make_node(Node_Type type, Node* cond, Node* left, Node* right)
{
    Node* node = (Node*)malloc(sizeof(Node));

    node->type = type;
    node->cond = cond;
    node->left = left;
    node->right = right;
    return node;
}

static int var[256];	    // 変数格納用配列

int run(Node* node)
{
    if (node == NULL)
	return 0;

    switch (node->type) {
    case Stmt_List_Node:
	run(node->left);
	run(node->right);
	break;
    case Print_Val_Node:
	printf("%d", run(node->left)); 
	break;
    case Print_String_Node:
	printf("%s", node->left);
	break;
    case If_Node:
	if (run(node->cond)) {
	    run(node->left);
	}
	else {
	    run(node->right);
	}
	break;
    case While_Node:
	while (run(node->cond)) {
	    run(node->left);
	}
	break;
    case Assign_Node:
	var[(int)node->left] = run(node->right);
	break;
    case VAR_Node:
	return (int)var[(int)node->left]; 
	break;
    case NUM_Node:
	return (int)node->left;
	break;
    case ADD_Node:
	return run(node->left) + run(node->right);
	break;
    case SUB_Node:
	return run(node->left) - run(node->right);
	break;
    case LESS_Node:
	return (run(node->left) < run(node->right));
	break;
    case EQ_Node:
	return (run(node->left) == run(node->right));
	break;
    case NOT_Node:
	return !(run(node->left));
	break;
    default:
	yyerror("Unknown Node type");
	break;
    }
    return 0;
}

