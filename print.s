print:
	mov $0x0e, %ah
	jmp print_loop

print_loop:
	lodsb
	cmp $0x00, %al
	je print_end
	int $0x10
	jmp print_loop

print_end:
	ret
