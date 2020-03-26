#include <stdio.h> 
#include <malloc.h>
#include <string.h>

typedef struct _instruction{
	char code[4];
	int nb_op;
	int op[3];
} instruction;

instruction table[500];
int index_code = 0;

void add (char code[4], int nb_op, int op[]){
	strcpy(table[index_code].code, code);
	for(int i = 0; i< nb_op; i++){
		table[index_code].op[i] = op[i];
	}
	printf("%s ok \n", code);
}

void print_code(){
	for(int j = 0; j<index_code; j++){
		switch(table[j].nb_op){
			case 0 :
				printf("%s\n", table[j].code);
			case 1 : 
				printf("%s %d\n", table[j].code, table[j].op[0]);
			case 2 :
				printf("%s %d %d\n", table[j].code, table[j].op[0], table[j].op[1]);
			case 3 :
				printf("%s %d %d %d\n", table[j].code, table[j].op[0], table[j].op[1], table[j].op[2]);
		}
	} 
}

void print_to_file(){
	FILE * f = fopen("output.s", "w");
	for(int j = 0; j<index_code; j++){
		switch(table[j].nb_op){
			case 0 :
				fprintf(f, "%s\n", table[j].code);
			case 1 : 
				fprintf(f, "%s %d\n", table[j].code, table[j].op[0]);
			case 2 :
				fprintf(f, "%s %d %d\n", table[j].code, table[j].op[0], table[j].op[1]);
			case 3 :
				fprintf(f, "%s %d %d %d\n", table[j].code, table[j].op[0], table[j].op[1], table[j].op[2]);
		}
	} 
	fclose(f);
}
