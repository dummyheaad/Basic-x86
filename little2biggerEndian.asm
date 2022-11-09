global _start

section .bss
    tmp db ?

section .data
    slash_n db 0x0a
    mesg1 db "Nilai yang disimpan register ah: ", 0x00
    len1 equ $ - mesg1
    mesg2 db "Nilai yang disimpan register al: ", 0x00
    len2 equ $ - mesg2

section .text
_start:
    ; Convert Little Endian to Big Endian

    ; Example data
    mov ax, 0xafc8

    ; register ax
    ;|          ax          |
    ;|    ah    |     al    |           
    ; ax = 16 bit
    ; ah = 8 bit
    ; al = 8 bit
   
    ; Maka dengan perintah di atas:
    ; ah = af   = 175
    ; al = c8   = 200

    ; misal kedua data dikurangi dengan 100 agar data bisa dicetak (dalam ASCII)
    sub ah, 100
    ; maka ah sekarang bernilai 0x4b = 'K'

    sub al, 100
    ; maka al sekarang bernilai 0x64 = 'd'

    ; kemudian dilakukan konversi little endian menjadi big endian menggunakan xchg
    xchg ah, al

    ; maka sekarang ah = 0x64 = 'd', al = 0x4b = 'K'

    ; Diperoleh hasil akhir pada register ax yang sudah dikonversi menjadi big endian
    ; ax = 0x644b = 25675

    ; Dikarenakan interrupt memerlukan syscall yang diambil dari register eax maka kita harus menyimpan terlebih dahulu data eax agar tidak ditimpa oleh nilai syscall write maupun exit (4 atau 1)
    mov esi, eax

    call format_1
    ; pada kondisi ini, eax = 4 maka kita harus restore nilai eax terlebih ahulu

    mov eax, esi
    call print_ah
    call newline

    call format_2
    ; pada kondisi ini, eax = 4 maka kita harus restore nilai eax

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
    lea ecx, [slash_n]
    mov edx, 1
    int 0x80
    ret

end:
    mov eax, 1
    mov ebx, 0
    int 0x80

