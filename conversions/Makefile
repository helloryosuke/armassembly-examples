All: mph2KphMain CToF_InchesToFt_TestMain
LIB=libConversions.o
CC=gcc

mph2KphMain: mph2KphMain.o $(LIB)
	$(CC) $@.o $(LIB) -g -o $@

CToF_InchesToFt_TestMain: CToF_InchesToFt_TestMain.o $(LIB)
	$(CC) $@.o $(LIB) -g -o $@

.s.o:
	$(CC) $(@:.o=.s) -g -c -o $@
