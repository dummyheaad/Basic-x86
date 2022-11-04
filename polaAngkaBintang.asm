; Program untuk mencetak pola angka dan bintang sebanyak 10 baris
; Output:
; 0*********
; 01********
; 012*******
; 0123******
; 01234*****
; 012345****
; 0123456***
; 01234567**
; 012345678*
; 0123456789

global _start

section .bss                                ; berisi data yang belum diinisialisasi dengan suatu nilai (baru alokasi memori saja)
    outBuff resb 1                          ; buat variabel outBuff kemudian berikan uninitialized memory resb (reserve byte) sebanyak 1 byte
                                            ; variabel ini digunakan untuk menyimpan nilai ascii dari suatu karakter.
                                            ; Kemudian alamat dari outBuff akan diakses oleh register sehingga nilai dari outBuff bisa dicetak
                                            ; Ini adalah bagian paling penting pada saat mencetak integer ke layar (disini contoh sederhanaya 0-9)

section .data
    batas equ 11                            ; variabel untuk membatasi looping, yaitu 11 (hanya ada 10 kali looping karena pada saat nilai pembatas sudah 11 fungsi tidak akan loop melainkan masuk ke fungsi end)
    newline db 0x0a                         ; karakter newline (\n) dengan nilai ascii 10 dalam biner atau 0x0a dalam heksadesimal
    bintang db "*"                          ; karakter bintang

section .text
_start:
    mov esi, 0                              ; variabel untuk loop angka dan bintang
    mov edi, 1                              ; variabel untuk loop baris

looping:
    call loop_angka                         
    call loop_bintang
    call cetak_newline

    ; Pada kondisi ini, baris sudah berpindah sehingga nilai esi diinisialisasi ulang sedangkan nilai edi ditambah 1
    mov esi, 0
    inc edi

    ; bandingkan nilai edi dengan batas
    cmp edi, batas
    ; lanjutkan jika masih <= batas
    jne looping

    ; berhenti jika > batas dan masuk ke fungsi end
    jmp end

loop_angka:
    call cetak_angka
    inc esi
    cmp esi, edi
    jne loop_angka
    ret

loop_bintang:
    call cetak_bintang
    inc esi
    cmp esi, batas
    jne loop_bintang
    ret

cetak_bintang:
    mov eax, 4
    mov ebx, 1
    mov ecx, bintang
    mov edx, 1
    int 0x80
    ret

cetak_newline:
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    ret

cetak_angka:
    mov [outBuff], byte 0x30        ; move nilai 0x30 ke variabel outBuff (jangan lupa spesifikasi size nya)
    add [outBuff], esi              ; tambah nilai variabel outBuff dengan nilai yang disimpan di register esi. Spesifikasi byte tidak diperlukan karena operasi nya melibatkan register, bukan immediate value maupun variabel di section .data / section .bss
    lea ecx, outBuff                ; load memori outBuff agar bisa kontennya bisa dicetak
    mov eax, 4
    mov ebx, 1
    mov edx, 1
    int 0x80
    ret    

end:
    mov eax, 1
    mov ebx, 0
    int 0x80    
