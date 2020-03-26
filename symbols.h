#ifndef SYMBOLS_H
#define SYMBOLS_H

void add_symbol(char * id, int constant, int init);

void init(char * id);

void depth_incr();

void depth_decr();

int addr(char * id);

int exists_depth(char * id, int d);

int exists(char * id);

#endif
