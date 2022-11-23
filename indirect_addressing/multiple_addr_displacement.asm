global _start

section .bss

section .data
    myarr dd 35, 73, 106, 234
    slash_n db 0x0a
    sf equ 4

section .text
_start:
    lea esi, [myarr]
    
    mov edx, 2
    mov ebx, esi[sf*edx + 4]
    ; esi dan 4 adalah displacement
    ; esi displacement karena mengandung base address dari myarr

    ; bentuk lain
    ; mov ebx, [esi + edx*sf + 4]
    ; ebx = base (displacement)
    ; edx = index
    ; sf  = scale
    ; 4   = displacement

    mov eax, 1
    int 0x80
