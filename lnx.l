%{
#include <stdio.h>
#include "lnx.tab.h"
%}

%%
[re]?[abcd]x|[abcd][hl]     yylval=strdup(yytext); return REG;
[0-9]+|0x[0-9a-fA-F]+       yylval=strdup(yytext); return NUMBER;
";"                         return SEMI;
"="                         return ASGN;
"+"                         return PLUS;
"-"                         return MINUS;
"<<"                        return ROL;
">>"                        return ROR;
">"                         return SHR;
"<"                         return SHL;
"*"                         return IMUL;
"**"                        return MUL;
"/"                         return IDIV;
"//"                        return DIV;
"^"                         return XOR;
"<>"                        printf("neq\n");
"++"                        printf("adc\n");
"'"                         printf("db\n");
"\""                        printf("dw\n");
"\"\""                      printf("dd\n");
"["                         printf("open bracket\n");
"]"                         printf("close bracket\n");
"!"                         printf("interrupt\n");
"{"                         printf("open brace\n");
"}"                         printf("close brace\n");
"-."                        printf("loop\n");
"=."                        printf("call\n");
".="                        printf("ret\n");
"&"                         printf("and\n");
\n                          /* ignore EOL */
[\s\t ]+                    /* ignore whitespace */
%%

