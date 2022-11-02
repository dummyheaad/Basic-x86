; Program untuk membandingkan n karakter pertama dari 2 buah string

global main
extern strncmp, printf

segment .data
    str1 db "Helloo", 0x00              ; string pertama yang akan dibandingkan
    len_str1 equ $ - str1                   ; panjang string pertama
    str2 db "Helloe", 0x00                   ; string kedua yang akan dibandingkan
    len_str2 equ $ - str2                   ; panjang string kedua
    res db "Comparison 3 first character between %s and %s = %d", 0x0a, 0x00
    len_res equ $ - res
    tc dd 2                                ; jumlah karakter yang akan dibandingkan
    len_tc equ $ - tc

segment .text
main:
    push ebp                                ; Prologue
    mov ebp, esp                            
    sub esp, len_str1                       
    sub esp, len_str2                       
    sub esp, len_res            
    sub esp, len_tc                         ; dd = 4 bytes                       
    
    ; Parameter fungsi akan diambil dengan urutan kanan - kiri
    ; Prototype strncmp: int strncmp(const char* str1, const char* str2, size_t num)
    ; Maka kita harus input parameter dengan urutan tc, str2, dan str1
    mov ecx, [tc]
    push ecx                                
    push str2                               
    push str1                               
    call strncmp                            ; panggil fungsi strncmp

    ; return value dari strncmp disimpan pada register eax
    
    push eax                                ; push retval strncmp ke stack
    push str2                               ; push str1
    push str1                               ; push str2
    push res                                ; push res / format output
    call printf                             ; panggil fungsi printf

    xor eax, eax                            ; = mov eax, 0 --> retval fungsi main

    leave                                   ; Epilogue
    ret
