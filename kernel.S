	.code16
	.globl _start

_start:
	mov $msg, %si
	call print
	call done

print:	
	mov $0x0e, %ah
	jmp print_loop
	ret
	
print_loop:
	lodsb
	cmp $0, %al
	je print_end
	int $0x10
	jmp print_loop

print_end:
	ret

msg:
	.asciz "Hello from kernel code!\n\r"
	
done:
	hlt

.fill 512-(.-_start), 1, 0
