//imports
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

//retourne l'addr du symbole a la profondeur la plus basse
//parcours de symbol_index a 0 pour trouver la plus basse profondeur
int addr(char * id){
    int i = symbol_index;
    while(i>=0){
    	if(strcmp(table[i].id, id) == 0){ 
    		return i; //symbole trouvé
    	}
    	i--;
    }
	yyerror("Erreur, le symbole n'existe pas");
    return -1;
}

//check si l'id existe à cette profondeur a cette profondeur
int exists_depth(char * id, int d) {
	int i = symbol_index;
    while((i>=0) &&(table[i].depth >= d)){
    	if(strcmp(table[i].id, id)==0){ 
    		return 1; //symbole trouvé
    	}
    	i--;
    }
    return 0;
}

int exists(char * id) {
	int i = symbol_index;
    while((i>=0)){
    	if(strcmp(table[i].id, id)==0){ 
    		return 1; //symbole trouvé
    	}
    	i--;
    }
    return 0;
}

void add_symbol(char * id, int constant, int init){
	if(!exists_depth(id, depth)){
		symbol_index ++;
		
        table[symbol_index].id = id;
        table[symbol_index].constant = constant;
        table[symbol_index].init = init;
        table[symbol_index].depth = depth;

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
		}	
	}
}


void depth_incr(){
    depth ++;
}

//cherche l'index du tableau correspondant au dernier symbole de niveau d-1 
void depth_decr(){
	int i = symbol_index;
	depth --;
	while((i>=0) &&(table[i].depth > depth)){ 
		i--;
    }
    symbol_index = i;
}




