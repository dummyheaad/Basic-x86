; XCHG -> menukar konten dari dua operand
; Bentuk:
; xchg reg, reg
; xchg reg, mem
; xchg mem, reg
; XCHG tidak bisa dilakukan jika kedua operand adalah memory
; Jika ingin menukar dua data pada memory maka gunakan intermediate reg
; XCHG tidak menerima operand berupa immediate value (constant)
; Hal ini dikarenakan immediate value tidak memiliki address
; Gunakan register dengan tipe data yang sama dengan variabel
; jika ingin menukar data antar variabel

global _start

section .bss
    var_c resb 1
    newline resb 1

section .data
    var_a db 65
    var_b db 68

section .text
_start:
    ; Instruksi: tukar data a dengan b, tukar data b dengan c, cetak data b, tukar nilai ebx dengan c, cetak ebx

    mov al, 0               ; gunakan register yang sesuai dengan tipe data variabel (1 byte) yaitu gpr dengan ukuran 8-bit. Disini digunakan register al yang berukuran 8-bit / 1 byte
    mov ebx, 31             ; permisalan untuk mengecek apakah penukaran nilai ebx nantinya berjalan dengan lancar

    ; inisialisasi variabel pada section .bss
    mov [var_c], byte 70    
    mov [newline], byte 0x0a

    ; tukar data a dengan b
    mov al, [var_a]         ; esi = 65, var_a = 65
    xchg al, [var_b]        ; var_b = 65, esi = 68
    mov [var_a], al         ; esi = 68, var_a = 68
    ; var_a = 68, var_b = 65

    ; tukar data b dengan c
    xchg al, [var_b]       ; esi = 65, var_b = 0
    xchg [var_c], al       ; esi = 67, var_c = 65
    xchg al, [var_b]       ; esi = 0, var_b = 67
    ; var_b = 67, var_c = 65

    ; cetak data b
    mov eax, 4
    mov ebx, 1
    lea ecx, [var_b]
    mov edx, 1
    int 0x80

    ; cetak newline \n
    mov eax, 4
    mov ebx, 1
    lea ecx, [newline]
    mov edx, 1
    int 0x80

    ; cetak ebx sebagai exit status
    mov eax, 1
    mov ebx, [var_c]       ; ebx = 65, var_c = 31
    int 0x80

; Output dari ./xchg ; echo $?
; F
; 65
