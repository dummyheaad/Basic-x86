; Pada program ini, proses push dilakukan dengan menggunakan register dx
; Sehingga terjadi perbedaan ukuran stack frame dimana
; data yang di-push akan memiliki ukuran stack frame sebesar 2 byte
; sedangkan data ebp dan return address (eip) akan memiliki ukuran stack frame default, yaitu 4 byte

global _start

section .bss

section .data
    data db 73
    pembagi equ 10

section .text
_start:
    
    call flip

    call print_flip

    call end

flip:
    push ebp
    mov ebp, esp

    xor dx, dx      ; dx = 0x0000
    mov ax, [data]  ; ax = 0x0049
                    ; dx:ax = 0000:0049 = 73

    mov si, pembagi ; si = 10
    div si          ; dx = 3, ax = 7
    add dx, 0x30
    push dx         ; esp - 2, bukan esp - 4 karena dx berukuran 2 byte

    xor dx, dx      ; dx:ax = 0000:0007
    div si          ; dx = 7, ax = 0
    add dx, 0x30    
    push dx         ; esp - 2, bukan esp - 4 karena dx berukuran 2 byte

    mov esp, ebp
    pop ebp
    ret

print_flip:
    push ebp
    mov ebp, esp
    
    sub esp, 2*2                ; esp - 4 dikarenakan kita ingin pindah dari address_ebp ke data '7'
                                ; kemudian dilakukan push sehingga return address akan berada di bawah stack frame data '7' dengan ukuran 4 bytes

    call print
    
    mov esp, ebp
    pop ebp
    ret

print:
    mov eax, 4
    mov ebx, 1
    lea ecx, [esp + 4]          ; esp + 4 karena esp sekarang menunjuk ke return address fungsi print
                                ; dikarenakan return address 4 byte maka data '7' berada 4 byte di atas return address
    mov edx, 1
    int 0x80
    
    mov eax, 4
    mov ebx, 1
    lea ecx, [esp + 6]          ; esp + 6 karena esp sekarang menunjuk ke return address fungsi print
                                ; kemudian pada esp + 4 terdapat data '7'
                                ; dikarenakan data '3' berada satu stack frame di atas data '7' yang berukuran 2 byte
                                ; maka data '3' akan berada pada esp + 6
    mov edx, 1
    int 0x80

    ret

end:
    mov eax, 1
    mov ebx, 0
    int 0x80

