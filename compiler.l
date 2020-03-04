%{
    #include "y.tab.h"
%}

vID [a-zA-Z][a-zA-Z0-9_]*
int [0-9]+
/*
float [0-9]+[\.][0-9]+
exp {float}[e][\+]{int}
*/

%%

"main" {return tMAIN;}

"{" {return tOB;}
"}" {return tCB;}

"(" {return tOP;}
")" {return tCP;}

"return" {return tRET;}
"printf" {return tPRI;}


"const" {return tCST;}
"int" {return tINT;}

"+" {return tADD;}
"-" {return tSUB;}
"*" {return tMUL;}
"/" {return tDIV;}
"=" {return tEQ;}

"<" {return tINF;}
">" {return tSUP;}
"==" {return tEQU;}
"||" {return tOR;}
"&&" {return tAND;}


[ \t\n] {}
"," {return tC;}
";" {return tEI;}

{int} {return tVAL;}
{vID} {return tID;}


%%

int yywrap(void) { return 1;}
//int main() { while (yylex() != 0); return 0;}
