	.code16
	.globl _start

_start:
	cli
	lea msg, %si
	call print

msg:
	.asciz "Test"

print:
	xor %ax, %ax
        mov $0x0e, %ah      /* VIDEO - TELETYPE OUTPUT */
        mov $0x07, %bl      /* Light Gray */
        mov $0x00, %bh
	
print_loop:
        lodsb
        test %al, %al
        jz print_end
        int $0x10
        jmp print_loop
	
print_end:
        ret
	
.fill 510-(.-_start), 1, 0 # add zeroes to make it 510 bytes long
.word 0xaa55 # magic bytes that tell BIOS that this is bootable
