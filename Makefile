apl: src/parser.y src/scanner.l 
	cd src && \
	bison -d parser.y && \
	flex scanner.l && \
	cc -o ../$@ parser.tab.c lex.yy.c struct.c -lm
clean: 
	rm -f src/parser.tab.c src/parser.tab.h apl src/lex.yy.c
