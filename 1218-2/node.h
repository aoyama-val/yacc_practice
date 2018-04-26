#ifndef NODE_H_INCLUDED
#define NODE_H_INCLUDED

typedef enum NODE_TYPE_ {
    NT_NUMBER,
    NT_PLUS,
    NT_MINUS, 
} NODE_TYPE;

struct node {
    int type;
    struct node* cond;
    struct node* left;
    struct node* right;
};



#endif   /* NODE_H_INCLUDED */
