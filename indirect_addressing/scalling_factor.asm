; Scalling Factor
; Digunakan dalam pengaksesan elemen array
; Scalling Factor bertujuan untuk mengambil offset dari elemen array di sembarang index
; Terdapat beberapa nilai scalling factor, yaitu:
; a. 1 untuk data byte  (1 byte)
; b. 2 untuk data word  (2 byte)
; c. 4 untuk data dword (4 byte)
; d. 8 untuk data qword (8 byte)
; 
; Bentuk umum addressing via scalling factor adalah sebagai berikut:
; a.        [base + (index * scale) + disp.]
; b.        base[index*scale + disp.]
; 
; Keterangan:
; base  -> base address                 (mem / reg32)
; index -> index ke elemen array        (reg)
; scale -> scalling factor 1, 2, 4, 8   (imm)
; disp. -> displacement (opsional)      (imm)
; pemakaian displacement umumnya tidak diperlukan karena setiap elemen
; array bisa diakses via base + (index * scale) saja.


global _start

section .bss

section .data
    myarr dd 9, 8, 20, 35, 87, 68, 123, 240, 255, 213
    slash_n db 0x0a
    sf equ 4                ; scalling factor 4 karena array yang dipakai bertipe double word (4-byte masing-masing elemen)
    disp equ 8              ; displacement

section .text
_start:
    lea esi, [myarr]
    mov edi, 3

    mov ebx, [esi + sf*edi + disp]
    ; (sf * edi) + disp = 4 * 3 + 8 = 20 / 4 = 5
    ; maka ebx akan menyimpan elemen array di-index kelima, yaitu 68

    ; bentuk lain
;    mov ebx, esi[sf*edi + disp]
    mov eax, 1
    int 0x80

