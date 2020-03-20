#ifndef SYMBOLS_H
#define SYMBOLS_H

//type symbole
typedef struct _symbol {
    char * id;
    int constant;
    int init;
    int depth;
} symbol;

//table des symboles
symbol table[200];

int depth;
int next;
int mem;

void add_symbol(char * id, int constant, int init);

void init(char * id);

void depth_incr();

void depth_decr();

int addr(char * id);

#endif
