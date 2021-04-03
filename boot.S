	[BITS 16]
	[org 0x7c00]
	
init:
	mov si, msg
	call print
	jmp done
	;; call jump_to_kernel

print:
	mov ah, 0x0e
	jmp print_loop
	ret
	
print_loop:
	lodsb
	cmp al, 0x00
	je print_end
	int 0x10
	jmp print_loop

print_end:
	ret

print_success:
	mov si, success_msg
	call print
	ret
	
print_error:
	mov si, error_msg
	call print
	ret

reset_disk:
	mov ah, 0x00
	mov dl, 0x00
	int 0x13
	ret

;; jump_to_kernel:
;; 	mov jump_msg, %si
;; 	call print
;;         mov 0x02, %ah      /* DISK - READ SECTOR(S) INTO MEMORY */
;;         mov 0x01, %al      /* number of sectors to read (must be nonzero) */
;;         mov 0x00, %ch      /* low eight bits of cylinder number */
;;         mov 0x02, %cl      /* sector number 1-63 (bits 0-5) */
;;         mov 0x00, %dh      /* head number */
;;         mov 0x00, %dl      /* drive number (bit 7 set for hard disk) */
;;         mov 0x0000, %bx    /* ES:BX -> data buffer */
;;         mov %bx, %es
;;         mov $0x8000, %bx
;;         int $0x13
;; 	jc load_failure
;; 	mov $0x8000, %ax
;; 	jmp %es:ax

load_failure:
	call print_error
        cli
        hlt

done:
	hlt

msg:
	db 'Hello, World!', 0
	
jump_msg:
	db 'Jump to kernel...', 0
	
success_msg:
	db 'Success to reset disk!', 0
	
error_msg:
	db 'Error to reset disk!', 0

times 510-($-$$) db 0
dw 0xaa55
