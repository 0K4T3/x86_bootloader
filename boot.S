	.code16
	.globl init
	
init:
	mov $msg, %si
	call print
	call jump_to_kernel

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

jump_to_kernel:
	mov $jump_msg, %si
	call print
        mov $0x02, %ah      /* DISK - READ SECTOR(S) INTO MEMORY */
        mov $0x01, %al      /* number of sectors to read (must be nonzero) */
        mov $0x00, %ch      /* low eight bits of cylinder number */
        mov $0x02, %cl      /* sector number 1-63 (bits 0-5) */
        mov $0x00, %dh      /* head number */
        mov $0x00, %dl      /* drive number (bit 7 set for hard disk) */
        mov $0x0000, %bx    /* ES:BX -> data buffer */
        mov %bx, %es
        mov $0x8000, %bx
        int $0x13
	jc load_failure
	mov $0x8000, %ax
	jmp %es,%ax

load_failure:
	call print_error
        cli
        hlt
	
msg:
	.asciz "Hello, World!\n\r"

jump_msg:
	.asciz "Jump to kernel...\n\r"

success_msg:
	.asciz "Success to reset disk!\n\r"

error_msg:
	.asciz "Error to reset disk!\n\r"
	
.fill 510-(.-init), 1, 0
.word 0xaa55
