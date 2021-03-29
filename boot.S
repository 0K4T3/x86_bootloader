	.code16
	.globl init
	
init:
	mov $msg, %si
	jmp print
	
print:
	mov $0xe, %ah
	call print_loop
	
print_loop:
	lodsb
	cmp $0, %al
	je done
	int $0x10
	jmp print_loop

done:
	hlt
	
msg:
	.asciz "Hello, World!"
	
.fill 510-(.-init), 1, 0
.word 0xaa55
