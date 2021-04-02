	.code16
	.globl init
	
init:
	mov $msg, %si
	call print
	call reset_disk
	jnc print_success
	jc print_error
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

print_success:
	mov $success_msg, %si
	call print
	ret
	
print_error:
	mov $error_msg, %si
	call print
	ret

reset_disk:
	mov $0x00, %ah
	mov $0x00, %dl
	int $0x13
	ret

done:
	hlt
	
msg:
	.asciz "Hello, World!\n\r"

success_msg:
	.asciz "Success to reset disk!\n\r"

error_msg:
	.asciz "Error to reset disk!\n\r"
	
.fill 510-(.-init), 1, 0
.word 0xaa55
