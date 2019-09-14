%{
#include <stdio.h>
#include <string.h>

#define YYSTYPE char *

int yydebug=0;

void yyerror(const char *str) {
  fprintf(stderr, "error: %s\n",str);
}

int yywrap() {
  return 1;
}

int main() {
  yyparse();
}

%}

%define api.value.type {char *}

%token REG NUMBER SEMI ASGN PLUS MINUS

%%

statements: /* empty */
          | statements statement
          ;

statement: REG op REG SEMI
            { printf ("%s %s %s\n", $2, $1, $3); }
         | REG op NUMBER SEMI
            { printf ("%s %s %s\n", $2, $1, $3); }
         ;

op: PLUS
      { $$=$1; };
  | MINUS
      { $$=$1; };
  | ASGN
      { $$=$1; };
  ;

