%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define YYSTYPE char *

int yylex();
int yyparse();
void yyerror(const char *s);
int yydebug=0;

extern FILE *yyin;
extern FILE *yyout;

void yyerror(const char *str) {
  fprintf(stderr, "error: %s\n",str);
}

int yywrap() {
  return 1;
}

int main(int argc, char **argv) {
  char *outname, *ext;

  if (argc != 2) {
    printf("usage: %s <file>\n", argv[0]);
    exit(1);
  }

  yyin = fopen(argv[1], "r");

  if (yyin == NULL) {
    printf("error reading file: %s\n", argv[1]);
    exit(1);
  }
  outname = malloc(strlen(argv[1] + 5)); // ".lnx" + \0
  strcpy(outname, argv[1]);
  strcpy(strrchr(outname,'.'),".asm");

  yyout = fopen(outname, "w");

  if (yyout == NULL) {
    printf("error creating file: %s\n", outname);
    exit(1);
  }

  yyparse();

  fclose(yyin);
  fclose(yyout);
}

%}

%define api.value.type {char *}

%token REG NUMBER SEMI ASGN PLUS MINUS

%%

statements: /* empty */
          | statements statement
          ;

statement: REG op REG SEMI
            { fprintf (yyout, "%s %s %s\n", $2, $1, $3); }
         | REG op NUMBER SEMI
            { fprintf (yyout, "%s %s %s\n", $2, $1, $3); }
         ;

op: PLUS
      { $$=$1; };
  | MINUS
      { $$=$1; };
  | ASGN
      { $$=$1; };
  ;

