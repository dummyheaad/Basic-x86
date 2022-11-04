; Program yang mengimplementasikan directive dup untuk inisialisasi array

global _start

section .data
    arrAngka dd 10 dup (0x30)           ; pesan 10 buah memori berukuran 4 bytes kemudian pada masing-masing alamat diberi nilai ascii '0' atau 0x30. Variabel diberi nama arrAngka. Keyword arrAngka merujuk pada base address dari arrAngka sedangkan keyword [arrAngka] merujuk pada nilai yang terdapat di base address arrAngka.

section .text
_start:
    mov eax, 4
    mov ebx, 1
    lea ecx, [arrAngka]
    mov edx, 40                 ; kenapa 40 bytes ? karena ada 10 elemen yang masing-masing nya berukuran 4 bytes
    int 0x80
    
    mov eax, 1
    mov ebx, 0
    int 0x80
