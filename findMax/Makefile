All: FindMaxMain
LIB=libMaxVal.o
CC=gcc

FindMaxMain: FindMaxMain.o $(LIB)
	$(CC) $@.o $(LIB) -g -o $@

.s.o:
	$(CC) $(@:.o=.s) -g -c -o $@
