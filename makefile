LEX = flex
YACC = bison

TESTS_SRC = $(wildcard tests/*.lnx)
TESTS = $(TESTS_SRC:.lnx=.asm)

.PHONY:all
all: lnx

.PHONY:clean
clean:
	rm -f lex.yy.c lnx.tab.c lnx $(TESTS)

.PHONY:test
test: lnx $(TESTS)

.PHONY:$(TESTS)
$(TESTS):tests/%.asm:
	@echo "#### testing $@ ####"
	@./lnx tests/$*.lnx
	@diff tests/$*.out $@
	@echo "> passed"

lnx: lex.yy.c lnx.tab.c
	$(CC) $^ -o $@ -ll

lnx.tab.c: lnx.y
	$(YACC) -d $^

lex.yy.c: lnx.l
	$(LEX) $^
