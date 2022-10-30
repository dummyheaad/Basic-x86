; Program mencetak teks Hello World via x86 Assembly

global _start

section .text
_start:
    mov eax, 4              ; gunakan syscall write
    mov ebx, 1              ; stdout file desciptor
    mov ecx, mesg           ; bytes yang akan dituliskan
    mov edx, len            ; panjang bytes
    int 0x80                ; lakukan syscall ke kernel

    mov eax, 1              ; gunakan syscall exit
    mov ebx, 0              ; exit value 0
    int 0x80                ; lakukan syscall ke kernel

section .data:
    mesg db "Hello, World!", 0x0a
    len equ $ - mesg
