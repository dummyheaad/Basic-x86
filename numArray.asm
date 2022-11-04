; Program untuk mengimplementasikan struktur data array pada x86
; Array dapat dibuat dengan membuat variabel di section .bss
; Variabel yang diperoleh akan berjenis uninitialized variable
;       Format: nama_array ukuran_elemen banyak_elemen
; Contoh: arr resb 10 => buat array 10 elemen dengan tipe data byte
; Perintah [arr] digunakan untuk mengakses elemen arr di index-0
; Perintah [arr+x] digunakan untuk mengakses elemen arr di index-x
; Elemen array kemudian dicetak via non-iteratif dengan menspesifikasikan total byte dari seluruh elemen array

global _start

section .bss
    numArray resb 10                ; Deklarasi array dengan tipe data byte sebanyak 10 elemen

section .data
    batas equ 10                    ; batas = 10

section .text
_start:
    mov esi, 0                          ; pointer ke elemen numArray
    call init

    mov esi, 0
    call looping

    call print

    call end

init:                                   ; inisialisasi semua elemen dengan nilai ascii dari 0, yaitu 0x30 / 48d
    mov [numArray+esi], byte 0x30
    inc esi
    cmp esi, batas
    jl init
    ret

looping:                                ; tambahkan nilai elemen array agar diperoleh nilai ascii dari 0, 1, 2, 3, .., 9
    add [numArray+esi], esi
    inc esi
    cmp esi, batas
    jl looping
    ret

print:                                  ; cetak elemen array (disini digunakan metode langsung / non-iteratif)
    mov eax, 4                          ; syscall write
    mov ebx, 1                          ; stdout
    mov ecx, numArray                   ; pointer ke numArray
    mov edx, 10                         ; jml data yang akan dicetak, yaitu 10 * 1 byte = 10 byte
    int 0x80                            ; panggil syscall

    ret

end:
    mov eax, 1
    mov ebx, 0
    int 0x80
