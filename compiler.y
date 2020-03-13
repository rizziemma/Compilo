%{
	#include <stdio.h>
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
    tOB /*depth++*/ inBody tCB /*depth--*/;

inBody : 
	//null
	| Def inBody
	| Affect inBody
    | If inBody
    ;

Def :
	tINT tID DefN tEI  // ex : int a, b, c;
    |tINT tID tEQ Expr tEI;

DefN :
	//null
	| tC tID DefN;

Affect :
	tID tEQ Expr tEI;


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
void yyerror(char * str){printf("%s", str);}
int main(){yyparse(); printf(" fin \n"); return 0;}

