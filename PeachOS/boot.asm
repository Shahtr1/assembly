ORG 0x7c00
BITS 16

start:
    mov si, message
    call print
    jmp $

print:
    mov bx, 0 ; paging
.loop:
    lodsb
    cmp al, 0
    je .done
    call print_char
    jmp .loop
.done: ; subroutine
    ret

print_char:
    mov ah, 0eh
    int 0x10 ; we are calling a BIOS routine which outputs the char A to screen and 0eh is the command to do that
    ret

message: db 'Hello World!', 0

times 510-($ - $$) db 0 ; $ means current address and $$ means the first address of the current section. You have to understand that the times directive only operates on numbers and the difference of address ( $-$$ ) yields a number (Offset). So $-$$ gives you the offset from start to address of the currently executed instruction. If subtract that value from 510 you will get the offset from the address of the currently executed instruction to the 510th byte. So we now know how many bytes are there from the address of the currently executed instruction to the 510th byte. The times directive will now pad that number of bytes up to 510th byte with zeros.

dw 0xAA55