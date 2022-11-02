All: FibonacciMain
LIB=
CC=gcc

FibonacciMain: FibonacciMain.o $(LIB)
	$(CC) $@.o $(LIB) -g -o $@

.s.o:
	$(CC) $(@:.o=.s) -g -c -o $@
