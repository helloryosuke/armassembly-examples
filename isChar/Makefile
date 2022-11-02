All: ValCheckMain
LIB=libValCheck.o
CC=gcc

ValCheckMain: ValCheckMain.o $(LIB)
	$(CC) $@.o $(LIB) -g -o $@

.s.o:
	$(CC) $(@:.o=.s) -g -c -o $@
