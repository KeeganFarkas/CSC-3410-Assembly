all: backandforth

functions.o: functions.asm
	nasm -g -f elf32 -F dwarf -o functions.o functions.asm

backandforth: backandforth.c functions.o
	gcc -g -Wall -static -m32 -o backandforth backandforth.c functions.o

run: backandforth
	./backandforth

clean:
	rm -f *.o backandforth