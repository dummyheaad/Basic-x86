global _start

section .bss
    result resb 1

section .data
    slash_n db 0x0a
    value db 30
    nilai equ 22

section .text
_start:
    ; start coding here
    mov eax, 4

    ; push function parameter (4 bytes each)
    push dword [value]
    push nilai
    push eax

    call myfunc

    ; ambil return value dan simpan di result
    mov [result], eax
    ; [result] = 56

    mov eax, 1
    mov ebx, [result]
    int 0x80

myfunc:
    ; function prologue
    push ebp
    mov ebp, esp

    ; 1 buah local variable
    sub esp, 4

    ; function body
    ; ambil nilai masing-masing parameter
    mov eax, [ebp + 8]
    mov ebx, [ebp + 12]
    mov ecx, [ebp + 16]

    ; simpan return value di register eax
    mov [ebp - 4], ebx
    add [ebp - 4], ecx
    add eax, [ebp - 4]

    ; function epilogue
    mov esp, ebp
    pop ebp
    ret
