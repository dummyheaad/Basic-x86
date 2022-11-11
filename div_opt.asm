; Program untuk mendemonstrasikan penggunaan operator DIV (Unsigned Div)

; Unsigned Div (DIV)
; Merupakan operator yang digunakan untuk membagi bilangan tak bertanda (unsigned)
; Terdapat 3 jenis penggunaan operator DIV pada X86, yaitu:
;   a. DIV r/m8             => Yang dibagi  : AX
;                              Pembagi      : r/m8
;                              Hasil bagi   : AL, Sisa bagi     : AH

;   b. DIV r/m16            => Yang dibagi  : DX:AX
;                              Pembagi      : r/m16
;                              Hasil bagi   : AX, Sisa bagi     : DX

;   c. DIV r/m32            => Yang dibagi  : EDX:EAX
;                              Pembagi      : r/m32
;                              Hasil bagi   : EAX, Sisa bagi    : EDX

; * r/m8 berarti register / memory dengan ukuran 8bit
; * imm  berarti immediate value (konstanta)

; PENTING!!: Untuk pemakaian div pada looping, jangan lupa untuk men-set edx dengan nilai 0 pada setiap iterasi

global _start

section .bss

section .data
    mynum dw 12345

section .text
_start:
    ; Dimisalkan dilakukan pembagian ke bilangan 16-bit
    ; Maka bisa digunakan skema DIV r/m16 maupun DIV r/m32
    ; Disini akan dicontohkan skema DIV r/m16

    mov si, 10          ; r/m16 atau pembagi = 10
    mov dx, 0           ; dx = 0, artinya kita hanya memakai ax (16-bit)
    mov ax, [mynum]     ; ax = 12345 (16-bit)
    div si              ; dx:ax dibagi si
    ; eax = 1234
    ; edx = 5

    mov dx, 0           ; set kembali dx = 0 agar pembagian hanya dilakukan pada bilangan 1234 saja
    div si              ; dx:ax dibagi si = ax dibagi si
    ; eax = 123
    ; edx = 4

    mov dx, 0           ; set kembali dx = 0, sama seperti sebelumnya
    div si              ; dx:ax dibagi si = ax dibagi si
    ; eax = 12
    ; edx = 3

    mov dx, 0           ; set kembali dx = 0
    div si              ; dx:ax dibagi si = ax dibagi si
    ; eax = 1
    ; edx = 2

    movzx ebx, dx       ; move nilai dx, yaitu 2 ke register ebx
                        ; dikarenakan terdapat perbedaan ukuran register maka digunakan perintah movzx yang akan memindahkan nilai dx ke ebx dan melakukan zero-extending terhadap nilai dx, dikarenakan dx bernilai 16 bit sedangkan ebx bernilai 32 bit
    call end

end:
    mov eax, 1
    int 0x80

; output: echo $? menghasilkan exit status yang bernilai 2

