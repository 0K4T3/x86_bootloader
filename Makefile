build:
	nasm -f bin -o boot.o boot.S
	# as -o kernel.o kernel.S
	# ld --script boot.ld --output boot.img boot.o
	# ld --script boot.ld --output kernel.img boot.o kernel.o

start:
	qemu-system-i386 -boot a -fda boot.o

build-kernel:
	as -o boot.o boot-kernel.S
	ld -o boot.bin --oformat binary -e init -Ttext 0x7c00 -o boot.bin boot.o
	gcc -m32 -nostdlib -fPIE -pie -O1 kernel.c -o kernel.img

