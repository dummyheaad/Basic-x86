; Address Displacement
; Merupakan penambahan suatu nilai konstan ke nilai alamat tertentu (effective address).
; Address Displacement dapat diterapkan untuk indexing array.
; Displacement juga dapat diberikan kepada base address suatu array.
; Terdapat 3 jenis addresss displacement:
; (Direct Addressing)
; a. [mem + sf*imm/reg32]
; b. mem[sf*imm/reg32]
; c. mem[imm]
; Displacement: mem dan imm (pada bentuk c)

; (Indirect Addressing)
; a. [reg32 + sf*imm/reg32]
; b. reg32[sf*imm/reg32]
; c. reg32[imm]
; Displacement: reg32 (indirect) dan imm (pada bentuk c)
; dimana esi adalah register yang mengandung nilai konstan
; sf adalah scalling factor untuk multiple bytes data (word, dword qword, etc)


global _start

section .bss

section .data
    myarr dw 1, 6, 10, 13, 14, 5    ; tiap angka adalah word (2 byte)
    slash_n db 0x0a
    sf equ 2                        ; scalling factor

section .text
_start:
    ; Dimisalkan ingin diambil elemen array pada index ke-3
    ; Maka offset untuk elemen tersebut adalah 2*3 = 6
    ; Karena tiap data adalah word sehingga digunakan scalling factor 2
    
    lea esi, [myarr]                ; load effective address dari myarr
;   mov esi, myarr                  ; alternatif lain untuk load effective address myarr
    mov edx, 3                      ; index disimpan di register edx (harus 32-bit)
    xor ebx, ebx                    ; clear bit pada register ebx
    mov bx, esi[sf*edx]             ; pindahkan data pada index ke-3 ke register bx (jangan lupa scalling factor karena data multi-byte)
    ;mov bx, [esi + sf*edx]         ; bentuk lain, ekuivalen dengan kode di atas nya
    mov eax, 1                      ; syscall exit
    int 0x80                        ; panggil kernel
