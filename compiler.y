%{
	#include <stdio.h>
	int yylex();
	void yyerror(char * str);
%}

%token tMAIN tOB tCB tOP tCP tRET tPRI tCST tINT tADD tSUB tMUL tDIV tEQ tINF tSUP tEQU tOR tAND tC tEI tVAL tID



%%
%start File;

File : 
	Main;

Main :
	tINT tMAIN tOP tCP tOB Body tCB;

Body : 
	//null
	|Def Body
	| Affect Body;

Def :
	tINT tID DefN tEI;  // ex : int a, b, c;
DefN :
	//null
	| tC tID DefN;

Affect :
	tID tEQ Expr tEI;
	| tID tEQ Bool tEI;

Expr :
	tVAL
	|tID
	|tOP Expr tCP
	|Expr tADD Expr
	|Expr tSUB Expr
	|Expr tMUL Expr
	|Expr tDIV Expr;

Bool :
	tVAL
	|tID
	|tOP Bool tCP
	|Bool tOR Bool
	|Bool tAND Bool
	|Expr tSUP Expr
	|Expr tINF Expr
	|Expr tEQU Expr 


%%
void yyerror(char * str){printf("%s", str);}
int main(){yyparse(); printf(" fin \n"); return 0;}

