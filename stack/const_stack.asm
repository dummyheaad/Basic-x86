global _start

section .bss

section .data
    slash_n db 0x0a

section .text
_start:
    ; ukuran stack frame untuk konstanta adalah 4 byte
    push 15
    push 30
    push 45
    push 28
   
    mov ebx, [esp + 4]
    add ebx, [esp + 8]
    mov eax, 1
    int 0x80

