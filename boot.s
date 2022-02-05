	.code16
	.text
	.global _start

_start:
	mov $boot_msg, %si
	call print
	jmp load_second_sector_to_memory
	jmp jump_to_stage_2

.include "./print.s"

load_second_sector_to_memory:
	# interrupt vector for reading sector into memory
	mov $0x02, %ah
	mov $0x01, %al       # number of sectors to read
	mov $0x00, %ch       #
	mov $0x02, %cl       # sector number 1-63
	mov $0x00, %dh       # header number
	mov $0x00, %dl       # drive number
	mov $0x0000, %bx
	mov %bx, %es
	mov $0x8000, %bx
	int $0x13
	jc load_failure

jump_to_stage_2:
	mov $0x0000, %ax
	mov %ax, %es
	mov $0x8000, %ax
	jmp $0x0000, $0x8000

load_failure:
	mov %ah, %dl
	call print_load_result
	mov $load_failed_msg, %si
	call print
	hlt

print_load_result:
	mov $result_code_msg, %si
	call print
	mov $0x0000, %cx
	jmp print_loop_for
	ret

print_loop_for:
	mov $dot, %si
	call print
	inc %cx
	cmp %dx, %cx
        jle print_loop_for

dot:
	.ascii "."

boot_msg:
	.ascii "Hello, World!\r\n"

load_failed_msg:
	.ascii "Load failed\r\n"

result_code_msg:
	.ascii "Load result: "

boot_padding:
	. = _start + 510     # mov to 510th byte from 0 pos

boot_signature:
	.byte 0x55           # append boot signature
	.byte 0xaa           # append boot signature
