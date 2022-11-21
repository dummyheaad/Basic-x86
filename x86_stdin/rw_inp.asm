; Program untuk membaca byte/string dengan panjang X byte dan mencetak semua byte-nya.
; syscall read              -> mov eax, 3
; read from stdin           -> mov ebx, 0
; buffer                    -> register ecx
; max total byte to-read    -> register edx
; 
; jumlah byte yang telah dibaca saat ini        -> register eax


global _start

section .bss
    inp resb 100
    buff resb 100
    len resb 1

section .data
    slash_n equ 0x0a
    maks equ 100

section .text
_start:
    call in

    call process

    call out

    call newline

    jmp end

in:
    ; membaca input dari stdin
    mov eax, 3                      ; syscall read
    mov ebx, 0                      ; read from stdin
    mov ecx, buff                   ; place readed byte into buff 
    mov edx, maks                   ; set max byte to be read
    int 0x80
    ret

process:
    ; memproses input dari buff ke inp
    mov esi, 0
    ; ambil panjang byte yang dibaca (panjang <= 100 byte)
    mov [len], eax
    ; lakukan jump agar 2 perintah di atas tidak dieksekusi tiap loop
    jmp looping

looping:
    ; pindahkan tiap byte pada buff ke inp
    mov edi, [buff+esi]
    mov [inp+esi], edi
    inc esi
    cmp esi, [len]
    jl looping
    ret

out:
    ; cetak output byte sepanjang [len] byte
    mov eax, 4
    mov ebx, 1
    mov ecx, inp
    mov edx, [len]
    int 0x80
    ret

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

