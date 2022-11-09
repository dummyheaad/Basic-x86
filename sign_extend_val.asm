; x86 menggunakan 2's complement untuk merepresentasikan bilangan negatif
; Cara menghitung 2's complement dari bilangan x
; - Diberikan bilangan x dalam n bit
; - Cek dari LSB (bit paling kanan) ke kiri (menuju MSB) bit pertama yang memiliki angka 1. Selama belum ditemui angka satu (ditemui bit 0) maka keep nilai bit 0 tersebut
; - Setelah ditemui maka flip setiap bit setelah angka 1 tersebut
; - Diperoleh 2's complement dari x, yaitu representasi bilangan negatif dari x, ditulis -x
; Contoh:
; diberikan angka 5, 8 bit
; representasi biner dari 5 (dalam biner):
; 00000101
; flip bit setelah angka 1 pertama ditemui, dimulai dari LSB ke kiri.
; sehingga diperoleh:
; 11111011 => -5 (dalam 2's complement)
; notasi lain (misal dalam hex):
;  5     => 0x05
; -5     => 0xFB

; Extend Signed Value
; Prinsip dari Extend Signed Value adalah:
; a. Jika yang di-extend adalah bilangan positif maka append 0 di depan MSB sampai diperoleh jumlah bit yang sama dengan tipe data yang diinginkan
; b. Jika yang di-extend adalah bilangan negatif maka append 1 di depan MSB sampai diperoleh jumlah bit yang sama dengan tipe data yang diinginkan
; c. Untuk bilangan negatif yang ingin direpresentasikan dalam hexadecimal, setiap 4 bit bernilai 1 yang di-extend dapat diganti dengan satu digit hexa F (F = 1111)
; contoh:
; angka 5 dalam 8 bit
; bin(5)[8]     = 00000101
; hex(5)[8]     = 0000 0101 = 0x05 (8 bit = 2 digit hex)
; jika ingin diubah menjadi angka 5 dalam 16 bit maka hasilnya adalah
; bin(5)[16]    = 0000000000000101
; bin(5)[16]    = 0x0005 (16 bit = 4 digit hex, 0b0000 = 0x0)
;
;
; angka -5 dalam 8 bit
; bin(-5)[8]    = 11111101
; hex(-5)[8]    = 1111 1101 = 0xFB
; jika ingin diubah menjadi angka -5 dalam 16 bit maka hasilnya adalah
; bin(-5)[16]   = 1111111111111101
; hex(-5)[16]   = 1111 1111 1111 1101 = 0xFFFB

global _start

section .bss

section .data
    val8 db -5
    val16 dw +5
    val32 dw -5

section .text
_start:
    mov al, [val8]      ; move nilai val8 ke register al, yaitu -5 (0xFB) [dalam 2's complement]
    cbw                 ; convert to word (16-bit) simpan hasil di ax

    mov ax, [val16]     ; move nilai val16 ke register ax, yaitu +5 (0x0005)
    cwd                 ; convert to doubleword (32-bit) simpan hasil di dx:ax (0000:0005)
                        ; edx bernilai 0x0000
                        ; eax bernilai 0x0005
    
    mov ax, [val16]
    cwde                ; convert to doubleword (32-bit) simpan hasil di eax

    mov eax, [val32]    ; move nilai val32 ke register eax, yaitu +5 (0xFFFFFFFB)
    cdq                 ; convert to quadword (64-bit) simpan hasil di edx:eax (FFFF:FFFB)
                        ; edx bernilai 0xFFFF
                        ; eax bernilai 0xFFFB = 0xFFFFF - 0x0004 = 256 - 4 = 251

    mov esi, eax
    call end    

end:
    mov eax, 1
    mov ebx, esi
    ; maka saat echo $? hasilnya adalah 251
    int 0x80

