; Signed Division (IDIV)
; Ada 2 bentuk umum idiv (sisa nya ada di dokumentasi):
; idiv r32
; idiv byte_size mem

global _start

section .bss
    result dd ?

section .data
    slash_n db 0x0a
    pembagi dd 0xaaa2
    normalize dd 0x0a

section .text
_start:
    xor edx, edx
    mov eax, 0xabcd
   
    idiv dword [pembagi]
    ; edx = 0x0000012b
    ; eax = 0x00000001

    mov eax, edx
    xor edx, edx
    ; edx = 0x00000000
    ; eax = 0x0000012b

    idiv dword [normalize]
    ; edx = 0x00000009
    ; eax = 0x0000001d

    add edx, 0x30           ; convert to ASCII agar bisa dicetak

    mov [result], edx
    
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 1
    int 0x80

    call newline
    jmp end

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

