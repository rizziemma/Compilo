#include <stdio.h> 
#include <malloc.h>
#include <string.h>

typedef struct _instruction{
	char code[4];
	int nb_op;
	int op[3];
} instruction;

instruction table_code[500];
int index_code = 0;

int get_next_line(){
	return index_code;
}

void add (char code[4], int nb_op, int op[]){
	strcpy(table_code[index_code].code, code);
	table_code[index_code].nb_op = nb_op;
	for(int i = 0; i< nb_op; i++){
		table_code[index_code].op[i] = op[i];
	}
	index_code ++;
}


int patch(int line, int op, int pos){
	table_code[line].op[pos] = op;
}




void print_code(){
	printf("Generated asm : \n");
	for(int j = 0; j<index_code; j++){
		switch(table_code[j].nb_op){
			case 0 :
				printf("%s\n", table_code[j].code);
				break;
			case 1 : 
				printf("%s %d\n", table_code[j].code, table_code[j].op[0]);
				break;
			case 2 :
				printf("%s %d %d\n", table_code[j].code, table_code[j].op[0], table_code[j].op[1]);
				break;
			case 3 :
				printf("%s %d %d %d\n", table_code[j].code, table_code[j].op[0], table_code[j].op[1], table_code[j].op[2]);
				break;
		}
	} 
}


void print_to_file(){
	FILE * f = fopen("output.s", "w");
	for(int j = 0; j<index_code; j++){
		switch(table_code[j].nb_op){
			case 0 :
				fprintf(f, "%s\n", table_code[j].code);
				break;
			case 1 : 
				fprintf(f, "%s %d\n", table_code[j].code, table_code[j].op[0]);
				break;
			case 2 :
				fprintf(f, "%s %d %d\n", table_code[j].code, table_code[j].op[0], table_code[j].op[1]);
				break;
			case 3 :
				fprintf(f, "%s %d %d %d\n", table_code[j].code, table_code[j].op[0], table_code[j].op[1], table_code[j].op[2]);
				break;
		}
	} 
	fclose(f);
}
