; Instruksi Loop
; Digunakan untuk melakukan looping / iterasi
; loop akan menggunakan register ecx sebagai stopping criteria
; loop berhenti jika ecx == 0
; jika belum maka di setiap iterasi, ecx dikurangi 1
; syntax:
; loop label/rel8

global _start

section .bss
    result resb 1

section .data
    myarr db 23, 78, 3, 7, 50
    len equ $ - myarr

section .text
_start:
    call total

    mov ebx, [result]
    mov eax, 1
    int 0x80

total:
    mov esi, 0
    mov ecx, len
    mov [result], byte 0
    jmp iterasi

iterasi:
    mov edx, myarr[esi]
    add [result], edx
    inc esi
    loop iterasi
    ret
   
