%{
#include <stdio.h>
#include "lnx.tab.h"
%}

%%
[re]?[abcd]x|[abcd][hl]     yylval=strdup(yytext); return REG;
[0-9]+|0x[0-9a-fA-F]+       yylval=strdup(yytext); return NUMBER;
[a-z][a-zA-Z0-9]*           yylval=strdup(yytext); return ID;
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
"&"                         return AND;
"'"                         return BYTE;
"\""                        return WORD;
"\"\""                      return DWORD;
"<>"                        printf("neq\n");
"["                         printf("open bracket\n");
"]"                         printf("close bracket\n");
"!"                         printf("interrupt\n");
"{"                         printf("open brace\n");
"}"                         printf("close brace\n");
"-."                        printf("loop\n");
"=."                        printf("call\n");
".="                        printf("ret\n");
[\s\t ]+                    return WS;
\n                          /* ignore EOL */
%%

