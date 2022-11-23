; Indirect Addressing di x86
; Perhatikan ukuran register pada saat menyimpan address. Supaya aman gunakan extended 32-bit register

global _start

section .data
    myvar db 200, 30, 10, 100

section .text
_start:
;   mov ecx, [myvar]    Direct Addressing
;   lea ecx, [myvar]    ; Alternatif untuk mengambil effective address dari myvar
    mov ecx, myvar      ; move address dari myvar ke register ecx
                        ; ecx sekarang mengandung address dari myvar
                        ; register ecx digunakan agar address tidak terpotong karena ukuran register yang tidak memenuhi ukuran address

    mov ebx, [ecx]      ; Indirect Addressing.
                        ; move value yang disimpan oleh address yang ditunjuk oleh ecx ke ebx, yaitu nilai dari myvar ke ebx
                        ; ebx sekarang mengandung nilai dari myvar, yaitu 250
                        ; analogi nya mirip seperti dereferencing pada c menggunakan *. Disini register ecx dapat dianggap sebagai sebuah variabel pointer
                        ; mov ebx, [ecx] -> ebx = *ecx = 200

    add ebx, ecx[1]     ; ebx += [ecx + 1] = 200 + 30 = 230
    sub ebx, ecx[2]     ; ebx -= [ecx + 2] = 230 - 10 = 220

    sub ebx, [ecx + 3]  ; ebx <<= ecx[3] = 220 - 100 = 120

    mov eax, 1          ; syscall exit
    int 0x80            ; panggil kernel untuk menjalankan syscall
    ; exit status: 120

