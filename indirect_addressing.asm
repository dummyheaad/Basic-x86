; Indirect Addressing di x86
; Perhatikan ukuran register pada saat menyimpan address. Supaya aman gunakan extended 32-bit register

global _start

section .data
    myvar db 250

section .text
_start:
;   mov ecx, [myvar]  Direct Addressing
    mov ecx, myvar  ; move address dari myvar ke register ecx
                    ; ecx sekarang mengandung address dari myvar
                    ; register ecx digunakan agar address tidak terpotong karena ukuran register yang tidak memenuhi
    mov ebx, [ecx]  ; Indirect Addressing.
                    ; move value yang disimpan oleh address yang ditunjuk oleh ecx ke ebx, yaitu nilai dari myvar ke ebx
                    ; ebx sekarang mengandung nilai dari myvar, yaitu 250
                    ; analogi nya mirip seperti dereferencing pada c menggunakan *
                    ; mov ebx, [ecx] -> ebx = *ecx = 250
    mov eax, 1      ; syscall exit
    int 0x80        ; panggil kernel untuk menjalankan syscall
    ; exit status: 250
