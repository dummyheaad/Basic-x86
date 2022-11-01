; Contoh program untuk memanggil sebuah fungsi
; Fungsi yang dipanggil akan menggunakan stack untuk menyimpan nilai
; Kemudian isi dari stack akan dicetak
; Fungsi akan return ke fungsi pemanggil
; Namun dikarenakan stack digunakan maka otomatis akan ada skema overwriteterhadap return address yang diperlukan oleh instruksi ret
; Oleh karena itu kita bisa memakai EBP untuk menyimpan top dari stack sebelum melakukan operasi pada stack

; Berikut adalah sedikit modifikasi dari program sebelumnya

; Prologue
; instruksi call dijalankan
; alamat instruksi pemanggilan fungsi x di-push ke stack
; jmp ke label / fungsi x
; pada kondisi ini stack berisi satu elemen, yaitu return address
; esp sekarang menunjuk ke top of the stack, yaitu return address
; kemudian nilai awal ebp di-push ke stack
; pada kondisi ini stack berisi dua elemen dimana top of the stack diisi oleh nilai ebp
; esp sekarang menunjuk ke stack frame yang mengandung ebp
; simpan alamat stack frame yang mengandung nilai ebp ke esp
; alokasi memori bisa dilakukan pada stack untuk menjalankan fungsi lain maupun menjalankan variabel lokal
; dari sini terlihat bahwa stack frame return address berada di bawah stack frame dari ebp. Dengan data inilah navigasi return address bisa dilakukan

; Epilogue
; perintah mov esp, ebp dijalankan. Kegunaan instruksi ini adalah untuk menjadikan pointer stack (esp) menunjuk ke alamat di mana stack frame tempat menyimpan nilai ebp awal berada.
; disini terlihat bahwa stack frame return address akan berada tepat di atas stack frame yang berisi nilai awal ebp
; kemudian dilakukan pop ebp, yaitu mengembalikan nilai awal dari ebp ke ebp itu sendiri
; dengan pemanggilan pop maka pointer esp akan otomatis di-increment dan langsung menunjuk ke stack frame yang mengandung return address
; kemudian perintah ret dijalankan sehingga instruction pointer (eip) akan membaca nilai dari esp yaitu return address.
; instruksi kemudian dikembalikan ke fungsi pemanggil dan dimulai dari satu instruksi di bawah pemanggilan fungsi x

global _start

section .text
_start:
    call func                       ; panggil fungsi
    mov eax, 1
    mov ebx, ebp                    ; jadikan nilai ebp sebagai exit status (untuk mengecek apakah memang benar nilai yang akan dikeluarkan oleh ebx adalah nilai ebp awal yaitu 20 via echo $?)
    int 0x80

func:
    mov ebp, 20                     ; move nilai 20 ke ebp
    push ebp                        ; push nilai ebp ke stack
    mov ebp, esp                    ; simpan alamat stack frame yang mengandung nilai awal dari ebp, yaitu 20 ke ebp
    sub esp, 2                      ; alokasi ruang pada stack
    mov [esp], byte 'H'             ; top dari stack di-overwrite
    mov [esp+1], byte 'i'           ; operasi stack
    mov eax, 4
    mov ebx, 1
    mov ecx, esp
    mov edx, 2
    int 0x80
    mov esp, ebp                    ; setelah esp dipakai, kembalikan nilai return address yang disimpan di EBP ke ESP
    pop ebp                         ; pop ebp / kembalikan nilai ebp awal, yaitu 20. Disini esp akan diincrement dan akan menunjuk ke bagian stack di atas stack yang mengandung nilai ebp, yaitu return address. Sehingga esp akan menunjuk ke return address
    ret                             ; ret akan membaca return address dari esp melalui eip kemudian eip akan mengembalikan urutan instruksi ke fungsi pemanggil, dalam hal ini fungsi main



; kode pada baris 23-25 disebut sebagai Prologue dari fungsi
; kode pada baris 33-35 disebut sebagai Epilogue dari fungsi
; disarankan untuk menggunakan Prologue dan Epilogue pada fungsi
