all: one two

one:
	nasm -f elf32 addthenmultiply7.asm -o addthenmultiply7.o

two:
	gcc -m32 addthenmultiply7.o main.c -o main
