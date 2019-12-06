#ifndef _NODE_H
#define _NODE_H

// A typedef to save us keystrokes
// typedef <known type. <new alias>
typedef struct _node node_t;
typedef struct _node {
    
    node_t *left;
    node_t *right;
    node_t *anc;
    int    tip; // to indicate if the node is a tip and if it is which number it is
    int    mem_index;
    char   *label;

} node_t;

#endif