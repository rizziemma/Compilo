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

%token tMAIN tOB tCB tOP tCP tRET tPRI tCST tINT tADD tSUB tMUL tDIV tEQ tINF tSUP tEQU tOR tAND tC tEI tIF tELS tWHL
%token <nb> tVAL
%token <str> tID

%type <nb> Expr

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
	tINT tMAIN tOP tCP Body;

Body : 
    tOB {depth_incr();} inBody tCB {depth_decr();};

inBody : 
	//null
	| Def inBody
	| Affect inBody
    | If inBody
    ;

Def :
	 tINT tID {add_symbol($2, 0, 0);} DefN tEI  		//int a, b, c;
	|tCST tINT tID {add_symbol($3, 1, 0);} DefNC tEI		//cst a, b, c;
    |tINT tID {add_symbol($2, 0, 1);} tEQ Expr tEI {int op[2]={addr($2), pop()}; 
    												add("COP", 2, op);}	//int a = 1;
	|tCST tINT tID {add_symbol($3, 1, 1);} tEQ Expr tEI {int op[2]={addr($3), pop()};
														 add("AFC", 2, op);}//cst a = 1;
	; 
	
DefN :
	//null
	| tC tID {add_symbol($2, 0, 0);} DefN;

DefNC :
	//null
	| tC tID {add_symbol($2, 1, 0);} DefNC;

Affect :
	tID tEQ Expr {//erreur de segmentation ici
				init($1);
				  int op[2] = {addr($1), pop()};
				  add("COP",2,op);} 
				  	tEI;


Expr :
	tVAL    {int op[2]={push(), $1}; add("AFC", 2, op);}  //push la valeur de tVAL
	|tID    {int op[2]={push(), addr($1)}; add("COP", 2, op);} //push la valeur de la var tID
	|tOP Expr tCP   {int v = pop(); int op[2]= {push(), v}; add("COP", 2, op);}
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
    |Expr tOR Expr  {$$ = $1 || $3;}
    |Expr tAND Expr {$$ = $1 && $3;}
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


If : 
    tIF Cond Body
    | tIF Cond Body tELS Body
    ;

Cond :
    tOP Expr tCP;

%%
void yyerror(char * str){printf("%s\n", str);}
int main(){yyparse(); print_code(); print_to_file(); return 0;}

