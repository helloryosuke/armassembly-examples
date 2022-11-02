All: PrimeNumberMain
LIB=
CC=gcc

PrimeNumberMain: PrimeNumberMain.o $(LIB)
	$(CC) $@.o $(LIB) -g -o $@

.s.o:
	$(CC) $(@:.o=.s) -g -c -o $@
