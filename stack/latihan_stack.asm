global _start

section .data
    var1 db 21
    var2 db 7

    var3 equ 13

section .text
_start:
    mov ebp, 3                  ; Inisialisasi nilai ebp

    mov esi, 55                 ; Parameter 1 fungsi tambahkan
    mov edi, 11                 ; Parameter 2 fungsi tambahkan
    
    push esi                    ; Param 1 di-push ke stack
    push edi                    ; Param 2 di-push ke stack

    call tambahkurang              ; Panggil fungsi tambahkurang

    ; nilai ebx = 55 + 11 - 7 - 13 - 21 = 25

    add ebx, ebp                ; ebx += ebp. Nilai ebp adalah 3 karena sudah di-pop dari stack

    ; nilai ebx = 25 + 3 = 28

    ; gunakan perintah echo $? di terminal linux untuk mencetak nilai exit status dari program

    mov eax, 1
    int 0x80

tambahkurang:
    push ebp                    ; Prologue
    mov ebp, esp

    mov esi, [var1]             ; Var lokal 1
    push esi                    ; Var lokal 1 di-push
    mov esi, [var2]             ; Var lokal 2
    push esi                    ; Var lokal 2 di-push

    ; Push variabel (initialized) harus melalui register terlebih dahulu

    push var3                   ; Var lokal 3

    ; Push immediate value / konstanta bisa dilakukan secara langsung

    mov ebx, [ebp+(4*3)]            ; ebx = [esi]
    add ebx, [ebp+(4*2)]            ; ebx += [edi]
    sub ebx, [ebp-(4*1)]            ; ebx -= var1
    sub ebx, [ebp-(4*2)]            ; ebx -= var2
    sub ebx, [ebp-(4*3)]            ; ebx -= var3

    mov esp, ebp                ; Epilogue
    pop ebp                     ; Kembalikan nilai awal ebp, yaitu 3
    ret

;           x86_stack
; ebp+12    (4*3)       [esi]
; ebp+8     (4*2)       [edi]
; ebp+4     (4*1)       ret_addr
; ebp                   [ebp]
; ebp-4     (4*1)       var1
; ebp-8     (4*2)       var2
; ebp-12    (4*3)       var3        <-- esp


; [ebp+4]         => return address (kalau pakai prolog)
; [ebp-4*x]       => elemen stack di-push setelah ebp
;                 => digunakan untuk mengakses variabel lokal pada fungsi
; [ebp+4*x]       => elemen stack di-push lebih dahulu dibanding ebp
;                 => digunakan untuk mengakses parameter fungsi (x != 1)
