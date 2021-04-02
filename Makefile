build:
	as -o boot.o boot.S
	ld --oformat binary --entry init -Ttext 0x7c00 --output boot.img boot.o

start:
	qemu-system-i386 -boot a -fda boot.img

build-kernel:
	as -o boot.o boot-kernel.S
	ld -o boot.bin --oformat binary -e init -Ttext 0x7c00 -o boot.bin boot.o
	gcc -m32 -nostdlib -fPIE -pie -O1 kernel.c -o kernel.img

