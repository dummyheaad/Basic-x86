; Program untuk mengimplementasikan instruksi MOVSX dan MOVZX
; MOVSX     -> move + sign-extended -> append bit 1 / hexdigit F -> diperlakukan sebagai signed value. Artinya menghasilkan 2's complement dari suatu bilangan
; MOVZX     -> move + zero-extended -> append bit 0 / hexdigit 0 -> diperlakukan sebagai unsigned value. Artinya menghasilkan bilangan yang sama dengan awal hanya saja bit diappend agar muat ke tipe data yang lebih besar

global _start

section .bss

section .data

section .text
_start:
    mov dl, 0xfa        ; 250   -> 8-bit / 1 byte / 2 hexdigit
    ; zero-extended dl ke dx
    movzx dx, dl        ; dx -> 0x00ff -> 250 (unsigned/positive signed)

    mov cl, 0xf4        ; 244   -> 8-bit / 1 byte / 2 hexdigit
    ; signed-extended cl ke cx
    movsx cx, cl        ; cx -> 0xfff4 -> 244 -> -12
    ; terlihat ada 2 buah representasi desimal dari nilai hex
    ; Pada kondisi ini yang dipakai adalah -12 karena kita menggunakan instruksi movsx sehingga 0xfff4 diperlakukan sebagai signed value, dalam hal ini 2's complement dari 12 (-12)
    
    add dx, cx          ; dx = dx + cx
                        ; dx = 250 + (-12)
                        ; dx = 238
                        ; dx = 0x00ec

    movzx edx, dx       ; edx -> 0x000000ec -> 238
    call end

end:
    mov eax, 1
    mov ebx, edx        ; ebx = 238
    int 0x80

