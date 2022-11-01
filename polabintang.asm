; Program untuk mencetak pola bintang sebanyak 10 baris
; Contoh Output:
; *
; **
; ***
; ****
; *****
; ******
; *******
; ********
; *********
; **********



global _start

section .text
_start:

inisialisasi:                   ; fungsi untuk inisialisasi
    mov esi, 1                  ; menyatakan posisi baris sekarang
    mov edi, 1                  ; menyatakan posisi bintang sekarang

looping:                        ; fungsi looping pencetakan bintang
    call cetak_bintang          ; cetak satu bintang
    inc edi                     ; update posisi bintang
    cmp edi, esi                ; bandingkan dengan posisi barais
    jle looping                 ; jika masih <= maka lanjutkan looping

    call cetak_newline          ; jika > maka cetak newline

    inc esi                     ; pindah ke baris baru
    cmp esi, 10                 ; cek apakah sudah mencapai batas baris
    je end                      ; jika iya, akhiri program

    mov edi, 1                  ; jika tidak, ulang proses mencetak
    jmp looping                 ; kembali lagi ke fungsi pencetakan
    
cetak_bintang:                  ; fungsi untuk mencetak satu bintang
    mov eax, 4                  ; berikan syscall write
    mov ebx, 1                  ; stdout
    mov ecx, star               ; byte yang akan dicetak, yaitu *
    mov edx, 1                  ; jumlah byte, yaitu 1
    int 0x80                    ; panggil kernel dengan syscall write

    ret                         ; kembali ke fungsi pemanggil

cetak_newline:                  ; fungsi untuk mencetak \n
    mov eax, 4                  ; berikan syscall write
    mov ebx, 1                  ; stdout
    mov ecx, newline            ; byte yang akan dicetak, yaitu \n
    mov edx, 1                  ; jumlah byte, yaitu 1
    int 0x80                    ; panggil kernel dengan syscall write
    
    ret                         ; kembali ke fungsi pemanggil

end:
    mov eax, 1                  ; berikan syscall exit
    mov ebx, 0                  ; exit status success
    int 0x80                    ; panggil kernel dengan syscall exit

section .data       
    star db '*'                 ; variabel untuk menyimpan byte *
    newline db 10               ; variabel untuk menyimpan newline
                                ; disini digunakan nilai 10 karena
                                ; nilai 10 adalah representasi desimal
                                ; dari nilai ASCII \n
