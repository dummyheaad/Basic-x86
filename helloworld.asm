; helloworld.asm
;
; Aysuka Ansari
; G6401201087
;
; Date: 30 Oct 2022

global _start

section .text:

_start:
	mov eax, 0x4			; gunakan syscall 'write'
	mov ebx, 1				; gunakan stdout sebagai file descriptor
	mov ecx, message		; ambil message pada stack sebagai buffer
	mov edx, message_length	; berikan panjang dari message
	int 0x80				; interrupt
	
	; keluar dari program
	
	mov eax, 0x1			;
	mov ebx, 0				; return value
	int 0x80				; interrupt

section .data:
    message db "Hello World", 0x0a
    message_length equ $ - message

; makna $ => alamat / offset yang sekarang ditunjuk oleh assembler pada section .data
; Berikut contoh representasi nya di memori:
; 00000000                       .data
; 00000000  48 65 6c 6c 6f 20 57 6f 72 6c 64 0a                                      message db 'H','e','l','l','o',' ','W','o','r','l','d','\n'
; 0000000c  
; Pada awalnya $ bernilai 00000000 dan message bernilai 00000000 (berada di awal data section)
; Kemudian saat message db "Hello World", 0x0a dieksekusi, maka $ bergeser sampai offset kosong pertama yang ditemui, yaitu 0x0c = 12 (desimal)
; Maka panjang string bisa diperoleh dengan mengurangi nilai $ sekarang, dengan nilai message (base address dari message)
; Diperoleh nilai 0x0000000c - 0x00000000 = 0x0000000c = 12
; Maka panjang string message adalah 12
