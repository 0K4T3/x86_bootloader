build:
	as -o boot.o boot.S
	ld -o boot.bin --oformat binary -e init -Ttext 0x7c00 -o boot.bin boot.o

start:
	qemu-system-i386 -boot a -fda boot.bin
