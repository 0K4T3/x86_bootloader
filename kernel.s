	.code16
	.text
	.global stage_2

stage_2:
	mov $main_message, %si
	call print2
	jmp done

.include "./print.s"

print2:
	mov $0x0e, %ah
	jmp print_loop2
	ret

print_loop2:
	lodsb
	cmp $0x00, %al
	je print_end2
	int $0x10
	jmp print_loop2

print_end2:
	ret

done:
	hlt

main_message:
	.ascii "Hello from Stage 2"

main_padding:
	. = stage_2 + 510

debug_signature:
	.byte 0xff
	.byte 0xaa
