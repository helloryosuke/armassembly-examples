All: CalcMain
LIB=
CC=gcc

CalcMain: CalcMain.o $(LIB)
	$(CC) $@.o $(LIB) -g -o $@

.s.o:
	$(CC) $(@:.o=.s) -g -c -o $@
