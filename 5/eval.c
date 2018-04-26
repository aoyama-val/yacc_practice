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
static Node* func[256];	    // 変数格納用配列

void dump(Node* node)
{
    if (node == NULL)
	return;

    printf("p=0x%08x type=%d cond=0x%08x left=0x%08x right=0x%08x\n", node, node->type, node->cond, node->left, node->right);
    if (node->cond) dump(node->cond);
    if (node->left) dump(node->left);
    if (node->right) dump(node->right); 
}

int eval(Node* node)
{
    int ret;

    //if (0 < (int)node && (int)node < 0x200) {
    //if (node)
	//printf("DEBUG: eval %p %d\n", node, node->type);
    //}

    if (node == NULL)
	return 0;

    //printf("[%02x]\n", node->type);

    switch (node->type) {
    case Stmt_List_Node:
	eval(node->left);
	ret = eval(node->right);
	return ret;
	break;
    case Print_Val_Node:
	printf("%d\n", eval(node->left)); 
	return (int)node;
	break;
    case Print_String_Node:
	printf("%s\n", node->left);
	break;
    case If_Node:
	if (eval(node->cond)) {
	    eval(node->left);
	}
	else {
	    eval(node->right);
	}
	break;
    case While_Node:
	{
	    while (eval(node->cond)) {
		ret = eval(node->left);
	    }
	    return ret;
	}
	break;
    case Assign_Node:
	var[(int)node->left] = eval(node->right);
	return var[(int)node->left];
	break;
    case VAR_Node:
	return (int)var[(int)node->left]; 
	break;
    case NUM_Node:
	return (int)node->left;
	break;
    case ADD_Node:
	return eval(node->left) + eval(node->right);
	break;
    case SUB_Node:
	return eval(node->left) - eval(node->right);
	break;
    case LESS_Node:
	return (eval(node->left) < eval(node->right));
	break;
    case EQ_Node:
	return (eval(node->left) == eval(node->right));
	break;
    case NOT_Node:
	return !(eval(node->left));
	break;
    case OR_Node:
	ret = eval(node->left);
	if (ret)
	    return ret;
	ret = eval(node->right);
	if (ret)
	    return ret;
	return 0;
	break;
    case AND_Node:
	return eval(node->left) && eval(node->right);
	break;
    case Call_Node: 
	//printf("DEBUG: call %c %p\n", (int)node->left, func[(int)node->left]);
	return eval(func[(int)node->left]);
	break;
    case Unless_Node:
	if (!eval(node->cond)) {
	    eval(node->left);
	}
	break;
    case Def_Node:
	//printf("\nDEBUG: defined %c\n", (int)(node->left));
	func[(int)node->left] = node->right;
	//printf("DEBUG: defined %p\n", node->right);
	break;
    default:
	yyerror("Unknown Node type");
	break;
    }
    return 0;
}

