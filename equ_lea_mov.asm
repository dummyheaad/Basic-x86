; Ekuivalensi instruksi MOV dan LEA pada saat melakukan load memory
; mov -> move / memindahkan konten maupun memori dari src ke dest
;        perintah ini bisa digunakan untuk indirect addressing dengan mengambil konten berupa alamat memori yang disimpan oleh suatu register
; lea -> load effective address / mengambil alamat memori dari suatu label
;        perintah ini tidak bisa dilakukan untuk indirect addressing karena lea tidak bisa mengambil konten yang dimiliki suatu register
; ekuvalensi:
;
;           mov reg, mem == lea reg, [mem]
;
; indirect addressing
; mov ecx, mem            // ambil address dengan label mem
; mov edx, [ecx]          // ambil nilai yang disimpan ecx, yaitu addresss dengan label mem dan pindahkan (move) ke register edx
;
; lea ecx, [mem]          // ambil address dengan label mem
; mov edx, [ecx]          // ambil nilai yang disimpan ecx, yaitu address dengan label mem dan pindahkan (move) ke register edx
;
; lea ecx, [mem]          // ambil address dengan label mem
; lea dx, [ecx]           // ambil address dari ecx, bukan address yang disimpan oleh ecx (address dengan label mem)
;
; Kesimpulan: indirect addressing hanya bisa dilakukan dengan instruksi mov saja
;             instruksi lea dikhususkan untuk mengambil alamat memori suatu mem
;             untuk load memory kita bisa menggunakan mov maupun lea

global _start

section .bss

section .data
    pesan db "Aysuka Ansari", 0x0a, 0x00
    len equ $ - pesan

section .code
_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, pesan
;   instruksi di atas ekuivalen dengan:
;   lea ecx, [pesan]
    mov edx, len
    int 0x80
    call end

end:
    mov eax, 1
    mov ebx, 0
    int 0x80    
