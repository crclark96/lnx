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
"<<"                        yylval=strdup("rol"); return ROL;
">>"                        yylval=strdup("ror"); return ROR;
">"                         yylval=strdup("shr"); return SHR;
"<"                         yylval=strdup("shl"); return SHL;
"*"                         yylval=strdup("imul"); return IMUL;
"**"                        yylval=strdup("mul"); return MUL;
"/"                         yylval=strdup("idiv"); return IDIV;
"//"                        yylval=strdup("div"); return DIV;
"^"                         yylval=strdup("xor"); return XOR;
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

