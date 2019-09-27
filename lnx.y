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
%define parse.error verbose

%token REG NUMBER SEMI ASGN PLUS MINUS ROL ROR SHR SHL
%token IDIV DIV IMUL MUL XOR AND WS

%%

statements: /* empty */
          | statements statement
          ;

statement: dep_exp SEMI
            { free($1); }
         | idp_exp SEMI
            { free($1); }
         ;

dep_exp: dep_exp WS op0 WS REG
          { $$=$1;
            fprintf (yyout, "%s %s, %s\n", $3, $1, $5);
            free($5); }
       | dep_exp WS op0 WS NUMBER
          { $$=$1;
            fprintf (yyout, "%s %s, %s\n", $3, $1, $5);
            free($5); }
       | dep_exp WS op1 WS NUMBER
          { $$=$1;
            fprintf (yyout, "%s %s, %s\n", $3, $1, $5);
            free($5); }
       | REG WS op0 WS REG
          { $$=$1;
            fprintf (yyout, "%s %s, %s\n", $3, $1, $5);
            free($5); }
       | REG WS op0 WS NUMBER
          { $$=$1;
            fprintf (yyout, "%s %s, %s\n", $3, $1, $5);
            free($5); }
       | REG WS op1 WS NUMBER
          { $$=$1;
            fprintf (yyout, "%s %s, %s\n", $3, $1, $5);
            free($5); }
       ;

idp_exp: idp_exp WS op4 REG
          { if (strcmp($1,"clr") == 0)
              fprintf (yyout, "%s %s, %s\n", "xor", $4, $4);
            else
              fprintf (yyout, "%s %s\n", $3, $4);
            $$=$1; }
       | idp_exp WS REG op5
          { fprintf (yyout, "%s %s\n", $4, $3);
            $$=$1; }
       | idp_exp op5
          { fprintf (yyout, "%s %s\n", $2, $1);
            $$=$1; }
       | op4 REG
          { if (strcmp($1,"clr") == 0)
              fprintf (yyout, "%s %s, %s\n", "xor", $2, $2);
            else
              fprintf (yyout, "%s %s\n", $1, $2);
            $$=$2; }
       | REG op5
          { fprintf (yyout, "%s %s\n", $2, $1);
            $$=$1; }
       ;

/* operations where rhs -> REG | NUMBER
      can be chained in dependent expressions */
op0:
   PLUS
      { $$="add"; };
   | MINUS
      { $$="sub"; };
   | ASGN
      { $$="mov"; };
   | XOR
      { $$="xor"; };
   | AND
      { $$="and"; };
   ;

/* operations where rhs -> NUMBER
      can be chained in dependent expressions*/
op1: ROL
      { $$="rol"; };
   | ROR
      { $$="ror"; };
   | SHR
      { $$="shr"; };
   | SHL
      { $$="shl"; };
   ;

/* operations that take only a register
      can be chained in independent expressions */
op4: IDIV
      { $$="idiv"; };
   | IMUL
      { $$="imul"; };
   | DIV
      { $$="div"; };
   | MUL
      { $$="mul"; };
   | ASGN
      { $$="push"; };
   | PLUS
      { $$="inc"; };
   | MINUS
      { $$="neg"; };
   | XOR
      { $$="not"; };
   | AND
      { $$="clr"; };
   ;

/* post register operations
      can be chained in independent expressions */
op5: ASGN
      { $$="pop"; };
   | PLUS
      { $$="inc"; };
   | MINUS
      { $$="dec"; };
   ;
