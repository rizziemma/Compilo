vID [a-zA-Z][a-zA-Z0-9_]*
int [0-9]+
/*
float [0-9]+[\.][0-9]+
exp {float}[e][\+]{int}
*/

%%

"main()" {printf("tMAIN\n");}
"{" {printf("tOB\n");}
"}" {printf("tCB\n");}
"return" {printf("tRET\n");}
"printf" {printf("tPRINT\n");}

"const" {printf("tCONST\n");}
"int" {printf("tINT\n");}

"+" {printf("tADD\n");}
"-" {printf("tSUB\n");}
"*" {printf("tMUL\n");}
"/" {printf("tDIV\n");}
"=" {printf("tEQ\n");}

"(" {printf("tOP\n");}
")" {printf("tCP\n");}

[ \t\n] {printf("tSEP\n");}
"," {printf("tCOMMA\n");}
";" {printf("tEI\n");}

{int} {printf("tINTVAR\n");}
{vID} {printf("tVARNAME\n");}


%%

int yywrap(void) { return 1;}
int main() { while (yylex() != 0); return 0;}
