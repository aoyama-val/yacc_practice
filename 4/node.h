#ifndef NODE_H_INCLUDED
#define NODE_H_INCLUDED

typedef enum Node_Type {
    Stmt_List_Node,
    Print_Val_Node,
    Print_String_Node,
    If_Node,
    While_Node,
    Assign_Node,
    VAR_Node,
    NUM_Node,
    ADD_Node = '+',
    SUB_Node = '-',
    LESS_Node = '<',
    EQ_Node,
    NOT_Node = '!',
} Node_Type;


typedef struct Node {
    Node_Type type;
    struct Node* cond;
    struct Node* left;
    struct Node* right;
} Node;

Node* make_node();

int run();



#endif   /* NODE_H_INCLUDED */
