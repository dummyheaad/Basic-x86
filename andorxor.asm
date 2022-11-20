; Bitwise Logical
; -> and, or dan xor
; Terdapat 5 tipe:
; and/or/xor r, r
; and/or/xor r, mem
; and/or/xor mem, r
; and/or/xor r, imm
; and/or/xor mem, imm
; *imm tidak bisa dijadikan first operand karena imm tidak memiliki address
;
; bitwise xor bisa digunakan untuk clear all bytes (set semua bytes menjadi 0)
; contoh: xor edx, edx -> edx = 0
; perintah ini lebih cepat dibanding menggunakan sub edx, edx
;
; bitwise and bisa digunakan untuk clear some bytes (set 0 ke beberapa bytes)
; gunakan 0 untuk set byte menjadi 0
; gunakan f untuk mempertahankan byte
; contoh: mov eax, 0xabcd
;         and eax, 0xf      -> 0xf == 0x000f
;         -> perintah ini berarti set 3 most significant byte menjadi 0 dan pertahankan byte terakhir
;         -> eax = 0x000d
;
;         mov eax, 0xbacd
;         and eax, 0xf00f
;         -> set byte a dan c menjadi 0
;         -> eax = 0xb00d

global _start

section .bss
    hasil db ?

section .data
    slash_n db 0x0a

section .text
_start:
    mov eax, 0xdeadbeef
    and eax, 0x0000ffff
    ; eax  = 0x0000beef

    mov eax, 0xdeadbeef
    and eax, 0xffff0000
    ; eax  = 0xdead0000

    xor eax, eax
    ; eax  = 0x00000000

    mov al, 32
    or al, 25

    mov [hasil], byte al

    mov eax, 4
    mov ecx, hasil
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

