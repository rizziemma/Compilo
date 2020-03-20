%{
    #include "y.tab.h"
%}

vID [a-zA-Z][a-zA-Z0-9_]*
int [0-9]+
/*
float [0-9]+[\.][0-9]+ --> USE ATOF
exp {float}[e][\+]{int}
*/

%%



"{" {return tOB;}
"}" {return tCB;}

"(" {return tOP;}
")" {return tCP;}


"main" {return tMAIN;}
"return" {return tRET;}
"printf" {return tPRI;}
"if" {return tIF;}
"else" {return tELS;}

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

{int} { yylval.nb = atoi(yytext);
        return tVAL; }
{vID} { yylval.str = strdup(yytext);
        return tID;}


%%

int yywrap(void) { return 1;}
//int main() { while (yylex() != 0); return 0;}
