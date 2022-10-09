	.code16
	.text
	.global _start

_start:
	mov $boot_msg, %si
	call print
	###########################################################
	mov $0x02, %ah       # interrupt vector for reading sector into memory
	mov $0x01, %al       # number of sectors to read
	mov $0x00, %ch       #
	mov $0x02, %cl       # sector number 1-63
	mov $0x00, %dh       # header number
	mov $0x00, %dl       # drive number
	mov $0x0000, %bx
	mov %bx, %es
	mov $0x9c00, %bx
	int $0x13
	jc load_failure
.10L:
	mov %al, %dl
	mov $load_count_label, %si
	call print
	mov %dl, %al
	xor %cx, %cx
	mov $0x01, %cl
	and $0x0011, %ax
.11L:
	mov $atmark, %si
	call print
	inc %cx
	cmp %cx, %ax
	jle .11L

	mov $break_line, %si
	call print
	mov $load_succeeded_msg, %si
	call print
	###########################################################
	mov $0x0000, %ax
	mov %ax, %es
	mov $0x9c00, %ax
	jmp %ax

.include "./print.s"

load_failure:
	mov $load_failed_msg, %si
	call print
	hlt

boot_msg:
	.asciz "Hello, World!\r\n"

slash:
	.asciz "//\r\n"

atmark:
	.asciz "@"

load_succeeded_msg:
	.asciz "Load succeeded.\r\n"

load_failed_msg:
	.asciz "Load failed.\r\n"

load_count_label:
	.asciz "Load sectors: "

break_line:
	.asciz "\r\n"

boot_padding:
	. = _start + 510     # mov to 510th byte from 0 pos

boot_signature:
	.byte 0x55           # append boot signature
	.byte 0xaa           # append boot signature
