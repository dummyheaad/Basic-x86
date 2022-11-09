; Extend Unsigned Value
; 8 bit -> 16 bit => kosongkan 8 bit MSB, salin nilai ke 8 bit LSB
; contoh:
; var db 5 -> data 8 bit ingin disimpan dalam register 16 bit 
; mov al, var
; sub ah, ah
; ax = 0005     -> dalam 18 bit (register ax)

; x bit -> 2x bit -> kosongkan x bit MSB, salin nilai ke x bit LSB
; Gunakan gpr eax, ebx, ecx, edx (karena bisa dibagi menjadi sub register 8 bit)

global _start

section .data
    var8 db 251
    var16 dw 251

section .text
_start:
    ; var8 disimpan di register 16 bit
    ; misal dipakai register ax
    mov al, [var8]
    sub ah, ah
    ; al = 0xFB
    ; ah = 0x00
    ; ax = 0x00FB   -> 16 bit
    ; Ekuivalen dengan cbw

    ; var8 disimpan di register 32 bit
    ; misal dipakai dx:ax
    sub dx, dx
    ; dx = 0x0000
    ; ax = 0x00FB
    ; dx:ax = 0000:00FB
    ; Ekuivalen dengan cwd

    ; var16 disimpan di register 32 bit (extended)
    ; misal dipakai eax
    sub eax, eax
    mov ax, [var16]
    ; 16-bit msb eax = 0x0000
    ; ax             = 0x00FB
    ; Ekuivalen dengan cwde

    ; simpan nilai eax di esi (soalnya kita akan overwrite eax untuk manggil syscall exit)
    mov esi, eax
    
    call end

end:
    mov eax, 1
    mov ebx, esi
    int 0x80

