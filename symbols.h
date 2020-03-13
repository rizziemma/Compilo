#ifndef SYMBOLS_H
#define SYMBOLS_H

//type symbole
typedef struct _symbol {
    char * id;
    int constant;
    int depth;
    int memory;
} symbol;

//table des symboles
symbol[200] table;

int depth;
int index;
int mem;

void add_symbol(symbol s);

void depth_incr();

void depth_decr();

int get_addr(symbol s);

#endif
