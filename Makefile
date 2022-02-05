build:
	as boot.s -o boot.o
	as kernel.s -o kernel.o
	ld --script disk.ld

clean:
	rm boot.o kernel.o

start:
	qemu-system-i386 -boot a -fda disk.img

dump:
	xxd -g 1 -c 16 ./disk.img
