%{
	#include <stdio.h>
	#include "symbols.h"
	#include "temp.h"
	#include "asm.h"
	int yylex();
	void yyerror(char * str);
	char code [16];
%}

%union {
    int nb;
    char * str;
}

%token tMAIN tOB tCB tOP tCP tRET tPRI tCST tINT tADD tSUB tMUL tDIV tEQ tINF tSUP tEQU tOR tAND tC tEI tELS 

%token <nb> tVAL
%token <str> tID
%token <nb> tIF
%token <nb> tWHL
%token <nb> tFOR

%type <nb> Expr
%type <nb> Then
%type <nb> CondFor
%type <nb> AffectFor1
%right tEQ

//moins prioritaire
%left tADD tSUB
%left tDIV
%left tMUL

//plus prioritaire


%%
%start File;

File : 
	Main;

Main :
	tINT tMAIN tOP tCP BodyMain;

BodyMain :
	tOB inBody Return tCB ;
	
Return :
	tRET Expr tEI;
	
Body : 
    tOB {depth_incr();} inBody tCB {depth_decr();};

inBody : 
	//null
	| Def inBody
	| Affect inBody
	| Print inBody
    | If inBody
    | For inBody
    | While inBody
    ;

/***********************
Definitions affectations
***********************/

Def :
	 tINT tID {add_symbol($2, 0, 0);} DefN tEI  		//int a, b, c;
	|tCST tINT tID {add_symbol($3, 1, 0);} DefNC tEI		//cst a, b, c;
    |tINT tID {add_symbol($2, 0, 1);} tEQ Expr tEI {int op[2]={addr($2), pop()}; 
    												add("COP", 2, op);}	//int a = 1;
	|tCST tINT tID {add_symbol($3, 1, 1);} tEQ Expr tEI {int op[2]={addr($3), pop()};
														 add("COP", 2, op);}//cst a = 1;
	; 
	
DefN :
	//null
	| tC tID {add_symbol($2, 0, 0);} DefN;

DefNC :
	//null
	| tC tID {add_symbol($2, 1, 0);} DefNC;

Affect :
	tID tEQ Expr {init($1);
				  int op[2] = {addr($1), pop()};
				  add("COP",2,op);} 
		tEI;

/***********************
Expression arithmetiques
***********************/
Expr :
	tVAL    {int op[2]={push(), $1}; add("AFC", 2, op);}  //push la valeur de tVAL
	|tID    {int op[2]={push(), addr($1)}; add("COP", 2, op);} //push la valeur de la var tID
	|tOP Expr tCP   {$$ = $2;}
	|Expr tADD Expr {int v2=pop(); 
					 int v1=pop();
					 int op[3] = {push(), v1, v2};
					 add("ADD", 3, op);}
	|Expr tSUB Expr {int v2=pop(); 
					 int v1=pop(); 
					 int op[3] = {push(), v1, v2};
					 add("SOU", 3, op);}
	|Expr tMUL Expr {int v2=pop(); 
					 int v1=pop(); 
					 int op[3] = {push(), v1, v2};
					 add("MUL", 3, op);}
	|Expr tDIV Expr {int v2=pop(); 
					 int v1=pop(); 
					 int op[3] = {push(), v1, v2};
					 add("DIV", 3, op);}
    |Expr tOR Expr  {$$ = $1 || $3;} //NIY
    |Expr tAND Expr {$$ = $1 && $3;} //NIY
    |Expr tSUP Expr {int v2=pop(); 
					 int v1=pop(); 
					 int op[3] = {push(), v1, v2};
					 add("SUP", 3, op);}
	|Expr tINF Expr {int v2=pop(); 
					 int v1=pop();
					 int op[3] = {push(), v1, v2}; 
					 add("INF", 3, op);}
	|Expr tEQU Expr {int v2=pop(); 
					 int v1=pop(); 
					 int op[3] = {push(), v1, v2};
					 add("EQU", 3, op);}
    ;

    
/******************
	  Printf
*******************/

Print : 
	 tPRI tOP tID tCP tEI {int op[1] = {addr($3)}; //print une var
						   add("PRI", 1, op);}
						  
	|tPRI tOP Expr tCP tEI {int op[1] = {pop()}; //print une expression
						    add("PRI", 1, op);}					  
	;


/*************************
Structures conditionnelles
*************************/

If : 
    tIF Cond Then
    	Body {patch($3, get_next_line(), 1);} 
    
    | tIF Cond Then
    	Body 
    	tELS {patch($3, get_next_line()+1, 1); //+1 car ligne du JMP apres
    		  int op[1]={-1}; //-1 temporaire
    		  $1 = get_next_line();  //save quelle ligne il faudra patcher
    		  add("JMP", 1, op);} 
    	Body {patch($1, get_next_line(), 0);}
    ;
    

Cond :
    tOP Expr tCP;

Then :
	{int op[2]={pop(), -1}; //-1 temporaire
     $$ = get_next_line();  //save quelle ligne il faudra patcher
     add("JMF", 2, op);}
    ;
    
    
/******************
	  Boucles
*******************/
While :
	tWHL {$1 = get_next_line();} 
		Cond 
		Then
		Body {int op[1]={$1}; 
			  add("JMP", 1, op);
			  patch($4, get_next_line(), 1);}
	;

For :
	tFOR tOP AffectFor1 {$3 = get_next_line();} //1
		CondFor  	{$1 = get_next_line();	//2
					 int op [2] = {pop(), -1};
					 add("JMF", 2, op);
					 
					 int op2[1] = {-1};		//3
					 add("JMP", 1, op);}
		AffectFor2 {int op[1] = {$3};		//1
					add("JMP", 1, op);}
		tCP 		{patch($1+1, get_next_line(), 0);}	//3
		Body		
					{int op[1] = {$1+2};
					add("JMP", 1, op);}
					{patch($1, get_next_line(), 1);}	//2
	;	  
    
    
CondFor :
	Expr tEI
	;
	
AffectFor1 :
	Affect {$$=0;}		//var deja declaree
	|tINT tID {add_symbol($2, 0, 1);} tEQ Expr tEI {int op[2]={addr($2), pop()}; 
    												add("COP", 2, op);}	//int a = 1;
	;
	
AffectFor2 :
	tID tEQ Expr {init($1);
				  int op[2] = {addr($1), pop()};
				  add("COP",2,op);} 
	|tID tADD tADD  											//i++
		{int op[2]={push(), 1}; 
		 add("AFC", 2, op); 									//push 1
		 int op2[3] = {addr($1), addr($1), pop()};				//add
		 add("ADD", 3, op2);}							
	|tID tSUB tSUB												//i--
		{int op[2]={push(), 1}; 
		 add("AFC", 2, op); 									//push 1
		 int op2[3] = {addr($1), addr($1), pop()};				//sub
		 add("SUB", 3, op2);}
	;

%%
void yyerror(char * str){printf("%s\n", str);}
int main(){yyparse(); /*print_code();*/ print_to_file(); return 0;}

