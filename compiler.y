%{
	#include <stdio.h>
	#include "symbols.h"
	int yylex();
	void yyerror(char * str);
%}

%union {
    int nb;
    char * str;
}

%token tMAIN tOB tCB tOP tCP tRET tPRI tCST tINT tADD tSUB tMUL tDIV tEQ tINF tSUP tEQU tOR tAND tC tEI tIF tELS
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
    |tINT tID {add_symbol($2, 0, 1);} tEQ Expr tEI;	//int a = 1;
	|tCST tINT tID {add_symbol($3, 1, 1);} tEQ Expr tEI; //cst a = 1;
	
DefN :
	//null
	| tC tID {add_symbol($2, 0, 0);} DefN;

DefNC :
	//null
	| tC tID {add_symbol($2, 1, 0);} DefNC;

Affect :
	tID tEQ Expr {init($1);} tEI;


Expr :
	tVAL    {$$ = $1;}  //Expr prend la valeur de tVAL
	|tID       /*{get addr de var}*/
	|tOP Expr tCP   {$$ = $2;}
	|Expr tADD Expr {$$ = $1 + $3;}
	|Expr tSUB Expr {$$ = $1 - $3;}
	|Expr tMUL Expr {$$ = $1 * $3;}
	|Expr tDIV Expr {$$ = $1 / $3;}
    |Expr tOR Expr  {$$ = $1 || $3;}
    |Expr tAND Expr {$$ = $1 && $3;}
    |Expr tSUP Expr {$$ = $1 > $3;}
	|Expr tINF Expr {$$ = $1 < $3;}
	|Expr tEQU Expr {$$ = $1 == $3;}
    ;


If : 
    tIF Cond Body
    | tIF Cond Body tELS Body
    ;

Cond :
    tOP Expr tCP;

%%
void yyerror(char * str){printf("%s\n", str);}
int main(){yyparse(); printf(" fin \n"); return 0;}

