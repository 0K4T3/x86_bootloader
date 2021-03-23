bootloader:
	gcc -nostdlib -Ttext=0x7c00 boot.S
