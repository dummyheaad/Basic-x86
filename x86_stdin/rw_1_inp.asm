; Program untuk membaca dan mencetak sebuah input dalam Printable ASCII
; Contoh: 0-9,A-Z,+,-,(,) dll

global _start

section .bss
    buff resb 1             ; Variabel untuk menyimpan buffer
    inp resb 1              ; Variabel untuk menyimpan input
    
section .data
    slash_n db 0x0a

section .text
_start:
    call in                 ; Baca Input (Read)

    mov esi, [buff]         ; Pindahkan data
    mov [inp], esi

    call out                ; Cetak Input yang telah dibaca (Write)

    call newline
    jmp end

in:
    mov eax, 3              ; sycall read
    mov ebx, 0              ; read to stdin
    mov ecx, buff           ; save input to buff
    mov edx, 1              ; input data size, 1 byte
    int 0x80                ; call kernel
    ret                     ; return to _start

out:
    mov eax, 4              ; syscall write
    mov ebx, 1              ; write to stdout
    mov ecx, inp            ; load address inp
    mov edx, 1              ; output size, 1 byte
    int 0x80                ; call kernel
    ret                     ; return to _start

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

