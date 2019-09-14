LEX = flex
YACC = bison

all: lnx

clean:
	rm -f lex.yy.c lnx.tab.c lnx

lnx: lex.yy.c lnx.tab.c
	$(CC) $^ -o $@ -ll

lnx.tab.c: lnx.y
	$(YACC) -d $^

lex.yy.c: lnx.l
	$(LEX) $^
