	.code16
	.org 0x8000
	.text

stage_2:
	mov $main_message, %si
	call print
	hlt

.include "./print.s"

main_message:
	.ascii "Hello from Stage 2"

main_padding:
	. = stage_2 + 510

debug_signature:
	.byte 0xff
	.byte 0xaa
