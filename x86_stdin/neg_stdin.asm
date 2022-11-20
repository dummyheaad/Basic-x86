; Program untuk mencetak negatif dari suatu angka (1 - 9)
; dengan input diambil dari stdin

global _start

section .bss
    buff resb 1
    inp resb 1
    tmp resb 1

section .data
    dash db "-"
    slash_n db 0x0a

section .text
_start:
    call in

    mov esi, [buff]
    mov [inp], esi
    mov [tmp], esi

    call out

    call newline
    jmp end

in:
    mov eax, 3
    mov ebx, 0
    mov ecx, buff
    mov edx, 1
    int 0x80
    ret

out:
    sub [tmp], byte 0x30
    neg byte [tmp]
    js print

print:
    mov eax, 4
    mov ebx, 1
    mov ecx, dash
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, inp
    mov edx, 1
    int 0x80    
    ret

newline:
    mov eax, 4
    mov ebx, 1
    mov ecx, slash_n
    mov edx, 1
    int 0x80
    ret

end:
    mov eax, 1
    mov ebx, 0
    int 0x80

