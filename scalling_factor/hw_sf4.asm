global _start

section .bss
    len_sf dd ?

section .data
    mesg dd "H", "e", "l", "l", "o", ",", " " , "W", "o" ,"r", "l", "d", "!", 0x0a, 0x00    ; Data tidak bisa dibuat langsung dalam bentuk "Hello, World!" karena akan menyebabkan data berukuran 1 byte
    len equ $ - mesg                                                                        ; 4 * 15 = 60 byte
    sf equ 4

section .text
_start:
    call f_length
    
    call print

    jmp end

f_length:
    xor edx, edx
    mov eax, len
    mov esi, sf
    div esi
    mov [len_sf], eax                                                                       ; [len_sf] = 15
    ret

print:
    mov esi, 0
    jmp looping

looping:
    call printchar
    add esi, 1                                                                              ; esi = 0, 1, 2, 3, .. , 14
    cmp esi, [len_sf]
    jl looping
    ret

printchar:
    mov eax, 4
    mov ebx, 1
    lea ecx, [mesg + 4*esi]                                                                 ; gunakan scalling factor 4
    mov edx, 1
    int 0x80
    ret

end:
    mov eax, 1
    mov ebx, 0
    int 0x80

; Representasi di dalam memori
; .DATA
; 00000000      48000000 65000000 6c000000 6c000000 6f000000 20000000 57000000 6f000000 72000000 6c000000 64000000 0a000000 00000000        mesg dw "H", "e", "l", "l", "o", ",", " " , "W", "o" ,"r", "l", "d", "!", 0x0a, 0x00
; 0000001e
;
; Terlihat bahwa untuk mengakses karakter selanjutnya maka diperlukan penambahan sebesar 4 byte, sehingga scalling factor nya disini adalah 4

