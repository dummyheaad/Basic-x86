; Program Bubblesort pada x86 dengan mengimpelementasikan operator XCHG
; Bubblesort digunakan untuk mengurutkan byte
; Angka yang bisa diproses adalah 0-9 dikarenakan menggunakan nilai ASCII
; Contoh data yang digunakan: 3, 7, 9, 2, 1, 4, 5
; Maka nilai ini harus dikonversi ke ASCII dengan menambahkan 48 / 0x30, yaitu nilai ASCII '0'
; Impelementasi dengan jne mengakibatkan Segfault
; Sehingga dipakai jl

global _start

section .data
    myArray db 7 DUP (0)    ; membuat array of bytes dengan 7 elemen (diinisialisasi dengan 0)
    slash_n db 0x0a         ; karakter \n
    mesg1 db "Array sebelum diurutkan: ", 0x00
    len1 equ $ - mesg1
    mesg2 db "Array sesudah diurutkan: ", 0x00
    len2 equ $ - mesg2

section .text
_start:

    call init               ; inisialisasi masing-masing elemen array

    call sebelum            ; cetak string mesg1
    call print              ; cetak array sebelum diurutkan

    mov esi, 0              ; inisialisasi pointer esi pada loop 1
    call bubblesort         ; panggil fungsi bubblesort

    call newline            ; cetak \n

    call sesudah            ; cetak string mesg2
    call print              ; cetak array yang telah diurutkan

    call newline            ; cetak \n

    call end                ; keluar dari program

sebelum:
    mov eax, 4
    mov ebx, 1
    mov ecx, mesg1
    mov edx, len1
    int 0x80
    ret

sesudah:
    mov eax, 4
    mov ebx, 1
    mov ecx, mesg2
    mov edx, len2
    int 0x80
    ret

init:
    mov [myArray], byte 48+3
    mov [myArray+1], byte 48+7
    mov [myArray+2], byte 48+9
    mov [myArray+3], byte 48+2
    mov [myArray+4], byte 48+1
    mov [myArray+5], byte 48+4
    mov [myArray+6], byte 48+5
    ret

print:
    mov eax, 4
    mov ebx, 1
    lea ecx, [myArray]
    mov edx, 7
    int 0x80
    ret

newline:
    mov eax, 4
    mov ebx, 1
    lea ecx, [slash_n]
    mov edx, 1
    int 0x80
    ret

bubblesort:
    mov edi, esi        ; set pointer edi = esi
    ;add edi, 1         ; perintah ini tidak digunakan (soalnya perlu implementasi jmp + redundansi kode). Selain itu, hasilnya juga akan tetap sama
    call sort           ; looping kedua untuk menentukan elemen terkecil pada index esi. Hal ini dilakukan dengan membandingkan setiap elemen pada pointer esi dengan elemen pada pointer edi

    inc esi             ; Jika sort sudah selesai artinya looping kedua sudah selesai mengecek setiap edi untuk esi yang diberikan maka sekarang pindah ke index esi + 1
    cmp esi, 7          ; cek apakah sudah melewati batas
    jl bubblesort       ; loop jika masih < 7
    ret

sort:
    mov ah, [myArray+esi]   ; ambil nilai di index esi
    mov bh, [myArray+edi]   ; ambil nilai di index edi

    call check              ; untuk if condition

    inc edi                 ; jika sudah selesai pindah ke elemen edi+1
    cmp edi, 7              ; cek batas
    jl sort
    ret

check:
    cmp bh, ah              ; bandingkan nilai yang sudah disimpan
    jl swap                 ; ubah jika memenuhi if statement, yaitu jika elemen di pointer edi < elemen di pointer esi
    ret

swap:
    ; Proses Swapping pakai XCHG
    mov al, [myArray+esi]
    xchg al, [myArray+edi]
    mov [myArray+esi], al

    ret

    ; Kode di bawah tidak diperlukan lagi
;    inc edi
;    cmp edi, 7
;    jl sort

;    inc esi
;    cmp esi, 7
;    jl bubblesort

;    jmp end2

end:
    mov eax, 1
    mov ebx, 0
    int 0x80

end2:
    call newline
    call print
    call end
