; BSWAP --> Swap byte khusus untuk register 32-bit


global _start

section .bss
    tmp resb 1

section .data
    slash_n db 0x0a
    mesg1 db "Nilai yang disimpan di register ah: ", 0x00
    len1 equ $ - mesg1
    mesg2 db "Nilai yang disimpan di register al: ", 0x00
    len2 equ $ - mesg2
    
section .text
_start:
    ; Convert Little Endian to Big Endian via BSWAP

    ; Example Data (ingat!! register harus 32-bit)
    mov eax, 0xafc80000
    
    bswap eax
    ; eax = 0x0000c8af
    ; ax = 0xc8af
    ; ah = c8
    ; al = af

    sub ah, 100
    ; ah = 0x64
    sub al, 100
    ; al = 0x4b

    mov esi, eax

    call format_1

    mov eax, esi    
    call print_ah
    call newline

    call format_2

    mov eax, esi
    call print_al
    call newline
    
    call end

print_ah:
    mov [tmp], ah
    mov eax, 4
    mov ebx, 1
    lea ecx, [tmp]
    mov edx, 1
    int 0x80
    ret

print_al:
    mov [tmp], al
    mov eax, 4
    mov ebx, 1
    lea ecx, [tmp]
    mov edx, 1
    int 0x80
    ret

format_1:
    mov eax, 4
    mov ebx, 1
    mov ecx, mesg1
    mov edx, len1
    int 0x80
    ret

format_2:
    mov eax, 4
    mov ebx, 1
    mov ecx, mesg2
    mov edx, len2
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
