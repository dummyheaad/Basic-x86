; Program untuk mendemonstrasikan cara memindahkan data di antara 2 register yang ukurannya berbeda
; Misal: memindahkan data pada register al (8-bit) ke register ecx (32-bit)
; Jenis operator yang digunakan adalah convert operator.
; Namun, operator ini hanya bekerja dengan accumulator register, yaitu eax/ax/al.
; Terdapat 4 jenis instruksi yang bisa digunakan, yaitu:
; a. CBW (Convert Byte to Word)                     ==> source: AL, dest: AX
; b. CWD (Convert Word to DoubleWord)               ==> source: AX, dest: DX:AX (2 byte MSB di DX, 2 byte LSB di AX)
; c. CWDE (Convert Word to DoubleWord Extended)     ==> source: AX, dest: EAX (4 byte di EAX)
; d. CDQ (Convert DoubleWord to QuadWord)           ==> source: EAX, dest: EDX:EAX (4 byte MSB di EDX, 4 byte LSB di EAX)

global _start

section .bss

section .data

section .text
_start:
    
    ; misal kita ingin memindahkan nilai pada register al ke register ecx
    
    ; mov ecx, al       -> perintah ini illegal dan akan memunculkan pesan error

    mov al, 255     ; al -> byte
    cbw             ; convert byte to word, hasil extended => ax
    cwde            ; convert word to double word tapi di extended register, hasil extended => eax
    mov ecx, eax    ; pindahkan data al yang sudah di-extend pada register eax ke register ecx
    call end

end:
    mov eax, 1
    mov ebx, ecx
    int 0x80

