all:
	nasm -f elf64 hardware/cpu/functions.asm
	nasm -f elf64 hardware/cpu/cpu.asm
	gcc -no-pie -ggdb -O0 -o tester main.c hardware/cpu/cpu_reg.c hardware/cpu/cpu.c hardware/cpu/functions.o hardware/cpu/cpu.o
	./tester
