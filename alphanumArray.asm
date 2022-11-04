; Program untuk mengimplementasikan array di x86
; Pada program ini, proses print dilakukan secara iteratif
; Artinya akan terdapat looping untuk mencetak satu per satu elemen pada array.
; Output: ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789

global _start

section .bss
    alphanumArray resb 62

section .data
    batas equ 62
    batas_upper equ 26
    batas_lower equ 52

section .text
_start:

    mov esi, 0
    call init

    mov esi, 0
    call looping

    mov esi, 0
    call print

    call end

init:
    call init_upper
    call init_lower
    call init_number
    ret

init_upper:
    mov [alphanumArray+esi], byte 0x41
    inc esi
    cmp esi, batas_upper
    jl init_upper
    ret

init_lower:
    mov [alphanumArray+esi], byte 0x61
    inc esi
    cmp esi, batas_lower
    jl init_lower
    ret

init_number:
    mov [alphanumArray+esi], byte 0x30
    inc esi
    cmp esi, batas
    jl init_number
    ret

looping:
    call looping_upper
    call looping_lower
    call looping_number
    ret

looping_upper:
    add [alphanumArray+esi], esi
    inc esi
    cmp esi, batas_upper
    jl looping_upper
    ret

looping_lower:
    add [alphanumArray+esi], esi
    sub [alphanumArray+esi], byte batas_upper
    inc esi
    cmp esi, batas_lower
    jl looping_lower
    ret

looping_number:
    add [alphanumArray+esi], esi
    sub [alphanumArray+esi], byte batas_lower
    inc esi
    cmp esi, batas
    jl looping_number
    ret

print:
    lea edi, [alphanumArray+esi]            ; Ambil alamat dari elemen pada index ke-esi pada array alphanumArray kemudian simpan ke edi

    mov eax, 4
    mov ebx, 1
    mov ecx, edi                            ; Move nilai yang disimpan edi, yaitu alamat dari elemen pada index ke-esi dari alphanumArray menuju ecx. Sehingga ecx akan berlaku sebagai pointer ke edi dan edi juga berlaku sebagai pointer ke elemen pada index ke-esi di alphanumArray
    mov edx, 1
    int 0x80
    
    inc esi
    cmp esi, batas
    jl print
    ret

end:
    mov eax, 1
    mov ebx, 0
    int 0x80
