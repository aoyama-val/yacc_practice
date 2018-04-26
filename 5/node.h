#ifndef NODE_H_INCLUDED
#define NODE_H_INCLUDED

typedef enum Node_Type {
    Stmt_List_Node,	    // 0
    Print_Val_Node,	    // 1
    Print_String_Node,	    // 2
    If_Node,		    // 3
    While_Node,		    // 4
    Assign_Node,	    // 5
    VAR_Node,		    // 6
    NUM_Node,		    // 7
    ADD_Node = '+',
    SUB_Node = '-',
    LESS_Node = '<',
    EQ_Node,
    NOT_Node = '!',
    OR_Node,
    AND_Node,
    Call_Node,
    Unless_Node,
    Def_Node,
} Node_Type;


typedef struct Node {
    Node_Type type;
    struct Node* cond;
    struct Node* left;
    struct Node* right;
} Node;

Node* make_node();

int eval();



#endif   /* NODE_H_INCLUDED */
