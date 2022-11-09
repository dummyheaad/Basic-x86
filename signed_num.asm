; Signed Number di x86 NASM
; a. signed 1 byte  => db / byte (cukup cantumkan tanda + atau -)
;       range value: -128 s.d +127
; b. signed 2 byte  => dw / word (cukup cantumkan tanda + atau -)
;       range value: -32768 s.d +32767
; c. signed 4 byte  => dd / dword (cukup cantumkan tanda + atau -)
;       range value: -2147483648 s.d 2147483647
; d. signed 6 byte  => df / fword (cukup cantumkan tanda + atau -)
; e. signed 8 byte  => dq / qword (cukup cantumkan tanda + atau -)
; e. signed 10 byte => dt / tbyte (cukup cantumkan tanda + atau -)
;
; Konsep signed vs unsigned pada x86 NASM
; - data allocation directives baik untuk signed dan unsigned adalah sama untuk tipe data yang ukurannya sama (misal: unsigned byte dan signed byte sama-sama menggunakan db / byte)
; - bilangan positif (+) pada signed dan unsigned memiliki pemaknaan yang berbeda
; contoh: 142 adalah unsigned positive, sedangkan +142 adalah signed positive
; Maka range value dari unsigned positive adalah 0 - 255 sedangkan range value dari signed positif hanyalah +1 - +127
; Sehingga jika kita gunakan tipe data byte/db untuk menyimpan data +200 maka hal ini akan menyebabkan error out of bounds dikarenkan pada signed positive number batas nilai nya sampai +127
; - unsigned positive dan signed positive memiliki nilai yang sama


global _start

section .bss
    tmp resb 1

section .data
    var1 db -22
    var2 db +17
    ; var3 db +200      => menghasilkan error out of bounds
    ; var4 db -350      => menghasilkan error out of bounds
    slash_n db 0x0a

section .text
_start:    
    mov esi, [var1]
    ; esi = -22
    add esi, [var2]
    ; esi = -22 + +17
    ; esi = -5

    add esi, 70
    ; esi += 70
    ; esi = 65 => 'A'
    ; add esi, +70
    mov [tmp], esi

    mov eax, 4
    mov ebx, 1
    lea ecx, [tmp]
    mov edx, 1
    int 0x80

    call newline

    call end

newline:
    mov eax, 4
    mov ebx, 1
    mov ecx, slash_n
    mov edx, 1
    int 0x80
    ret

end:
    mov eax, 1
    mov ebx, 0
    int 0x80
