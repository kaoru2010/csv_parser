%option noyywrap nounput noinput nodefault
%x quoted

%{
#include <stdio.h>

int row = 0, col = 0;
%}

%%

\" BEGIN(quoted);
, col++;
\n col=0; row++;
[^,\n"]+ printf("[%d,%d] %s\n", row, col, yytext);

<quoted>{
    ([^"]|\"\")+ printf("[%d,%d] %s\n", row, col, yytext);
    \" BEGIN(INITIAL);
}

%%

int main()
{
    yylex();
    return 0;
}
