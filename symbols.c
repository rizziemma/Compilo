//type symbole
typedef struct _symbol {
    char * id;
    int constant;
    int depth;
    int memory;
} symbol;

//table des symboles
symbol[200] table;

int depth = 0;
int index = 0
int mem = 0;



void add_symbol(char * id, int constant){
    if(!exists(id, depth)){
        table[index].id = id;
        table[index].constant = constant;
        table[index].depth = depth;
        table[index].memory = mem;
    
        index ++;
        mem +=2;
    }else{
        //ERR symbole deja declare a cette profondeur
    }
}


void depth_incr(){
    depth ++;
}


void depth_decr(){

}

//retourne l'addr du symbole a la profondeur la plus basse
int get_addr(char * id){
    return 0;
}


//check si l'id n'est pas déjà utilisé a cette profondeur
int exists(char * id, int d) {
    return 0;
}
