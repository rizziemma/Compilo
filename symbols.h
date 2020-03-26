#ifndef SYMBOLS_H
#define SYMBOLS_H


//ajoute un symbole a la table
void add_symbol(char * id, int constant, int init);

//initialise le symbole
void init(char * id);

//{
void depth_incr();

//}
void depth_decr();

//retourne l'adresse du symbole
int addr(char * id);

//retourne 1 si le symbole existe deja a cette profondeur
int exists_depth(char * id, int d);

//retourne 1 si le symbole existe dans la table
int exists(char * id);

#endif
