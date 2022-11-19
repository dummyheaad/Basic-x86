; Unsigned Multiply (MUL)
; Instruksi yang digunakan untuk mengalikan bilangan tak bertanda
; Terdapat 3 bentuk mul:
; a. mul r/m8           -> hasil perkalian disimpan di AX
;                       -> yang dikali disimpan di AL
;                       -> pengali nya adalah r/m8
;                       -> AX = AL * r/m8

; b. mul r/m16          -> hasil perkalian disimpan di DX:AX
;                       -> yang dikali disimpan di AX
;                       -> pengali nya adalah r/m16
;                       -> DX:AX = AX * r/m16

; c. mul r/m32          -> hasil perkalian disimpan di EDX:EAX
;                       -> yang dikali disimpan di EAX
;                       -> pengali nya adalah r/m32
;                       -> EDX:EAX = EAX * r/m32

; Kesimpulan: dst operand haruslah register

; Cara mengambil hasil perkalian mul
; a. mul r/m8
;    mov [mem8], byte ax
; 
; b. mul r/m16
;    mov [mem16], word ax
;    mov [mem16 + 2], word dx               // karena mem16 dan mem16 + 1 sudah diisi dengan nilai ax
;    misal: dx:ax = 2725:30a2 
;    maka
;    mov [mem16], word ax       -> mem16 -> 30 a2
;    mov [mem16 + 2], word dx   -> mem16 -> 30 a2 27 25
;
; c. mul r/m32
;    mov [mem32], dword eax
;    mov [mem32 + 4], dword edx            // karena mem32, mem32 + 1, mem32 + 2, dan mem32 + 3 sudah diisi dengan nilai eax
;    misal: edx:eax = 34855220:2355abcd
;    maka
;    mov [mem32], dword eax             -> mem32 -> 23 55 ab cd
;    mov [mem32 + 4], dword edx         -> mem32 -> 23 55 ab cd 34 85 52 20

; referensi: https://stackoverflow.com/questions/37250232/how-to-store-a-two-register-mul-result-into-memory

global _start

section .bss    
    hasil resw 1
    value dw ?                  ; Selalu gunakan ? setelah semua variabel resb/w/d dideklarasikan

section .data
    slash_n db 0x0a

section .text
_start:
    mov [value], word 13
    mov ax, 5
    mul word [value]
    mov [hasil], word ax
    mov [hasil + 2], word dx

    mov eax, 4
    mov ebx, 1
    mov ecx, hasil
    mov edx, 1
    int 0x80
    
    call newline

    jmp end

newline:
    mov eax, 4
    mov ebx, 1
    mov ecx, slash_n
    int 0x80
    ret

end:
    mov eax, 1
    mov ebx, 0
    int 0x80

