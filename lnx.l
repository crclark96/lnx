%{
#include <stdio.h>
#include "lnx.tab.h"
%}

%%
[re]?[abcd]x|[abcd][hl]     yylval=strdup(yytext); return REG;
[0-9]+                      yylval=strdup(yytext); return NUMBER;
";"                         yylval=strdup(yytext); return SEMI;
"="                         yylval=strdup("mov"); return ASGN;
"+"                         yylval=strdup("add"); return PLUS;
"-"                         yylval=strdup("sub"); return MINUS;
"<<"                        printf("rol\n");
">>"                        printf("ror\n");
"<>"                        printf("neq\n");
">"                         printf("shr\n");
"<"                         printf("shl\n");
"*"                         printf("imul\n");
"**"                        printf("mul\n");
"/"                         printf("idiv\n");
"//"                        printf("div\n");
"^"                         printf("xor\n");
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
" "                         /* ignore spaces */
%%

