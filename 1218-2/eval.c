#include "node.h"
#include <stdio.h>

int eval(struct node* n)
{
    if (n == NULL)
	return 0;

    switch (n->type) {
    case NT_NUMBER:
	return (int)(n->cond);
	break;
    case NT_PLUS:
	return eval(n->left) + eval(n->right);
	break;
    case NT_MINUS:
	return eval(n->left) - eval(n->right);
	break;
    default:
	return n->type;
	break;
    } 
}
