#ifndef ASM_H
#define ASM_H


//le numero de la prochaine ligne d'asm
int get_next_line();

//ajout d'une instruction : code operateur, nb doperante, et tableau contenant les operandes
void add(char code[4], int nb_op, int op[]);

//patch la ligne line avec l'operande op en position pos (numero de l'operande)
void patch(int line, int op, int pos);

//print le code sur la console
void print_code();

//print le code dans output.s
void print_to_file();

#endif
