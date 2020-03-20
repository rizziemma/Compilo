//imports
#include <stdio.h>
#include <string.h>

extern void yyerror(char * str);


//type symbole
typedef struct _symbol {
    char * id;
    int constant;
    int init;
    int depth;
} symbol;

//table des symboles
symbol table[200];

int depth = 0;
int symbol_index = -1;
int mem = 0;

//retourne l'addr du symbole a la profondeur la plus basse
//parcours de symbol_index a 0 pour trouver la plus basse profondeur
int addr(char * id){
    int i = symbol_index;
    while((i>=0) &&(table[i].depth >= 0)){
    	if(strcmp(table[i].id, id) == 0){ 
    		return i; //symbole trouvé
    	}
    	i--;
    }
	yyerror("Erreur, le symbole n'existe pas");
    return -1;
}

//check si l'id existe à cette profondeur a cette profondeur
int exists(char * id, int d) {
	int i = symbol_index;
    while((i>=0) &&(table[i].depth >= d)){
    	if(strcmp(table[i].id, id)==0){ 
    		return 1; //symbole trouvé
    	}
    	i--;
    }
    return 0;
}



void add_symbol(char * id, int constant, int init){
	if(!exists(id, depth)){
		symbol_index ++;
		
        table[symbol_index].id = id;
        table[symbol_index].constant = constant;
        table[symbol_index].init = init;
        table[symbol_index].depth = depth;
    
        mem +=2;
    }else{
        yyerror("Erreur, le symbole existe deja");
    }
    
}

void init(char * id){
	int i = addr(id);
	if(i>=0){
		if(table[i].init == 1 && table[i].constant == 1){
			yyerror("Erreur, symbole déjà init");
		}else{
			table[i].init = 1;
			printf("Symbole %s init, depth = %d, i = %d\n", id, depth, symbol_index);
		}	
	}
}


void depth_incr(){
    depth ++;
    printf("Depth ++, depth = %d, i = %d\n", depth, symbol_index);
}

//cherche l'index du tableau correspondant au dernier symbole de niveau d-1 
void depth_decr(){
	int i = symbol_index;
	depth --;
	while((i>=0) &&(table[i].depth > depth)){ 
		i--;
    }
    symbol_index = i;
    printf("Depth --, depth = %d, i = %d\n", depth, symbol_index);
}




