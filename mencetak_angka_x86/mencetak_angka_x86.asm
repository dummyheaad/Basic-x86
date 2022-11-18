; Program untuk mencetak sembarang angka
; Implementasinya menggunkan Stack dan operator DIV
; Misal: input = 12345
; DIV -> Unsigned Divide
; DIV VAL i.e (r/m8,16,32,64) -> EAX / VAL
; EAX -> nilai yang akan dibagi
; VAL -> pembagi
; sisa bagi disimpan di register EDX
; hasil bagi disimpan di register EDX:EAX

; PENTING !! perhatikan bahwa untuk proses div secara iteratif maka nilai edx harus selalu di-set 0 di setiap iterasi nya. Sehingga hal ini akan menyebabkan edx:eax bernilai sama dengan eax dimana eax adalah bilangan selanjutnya yang akan dibagi

; Pada program ini, operasi push dilakukan dengan menggunakan register 32-bit, yaitu edx
; Sehingga ukuran stack frame dari data yang di-push akan sama dengan ukuran ebp dan return address, yaitu 4 bytes

global _start

section .bss
    tmp resw 1      ; reserve word (2-byte)
    mynum resw 1    ; reserve word (2-byte)

section .data
    counter db 1    ; 0x01, digunakan untuk navigasi digit
    newline db 0x0a ; 0x0a
    len equ 5       ; equ = 5 (constant), digunakan untuk membatasi iterasi
  
section .text
_start:
    ; inisialisasi angka yang akan dicetak
    mov [mynum], word 12345
    ; inisialisasi nilai ebp (agar mudah diidentifikasi pada stack)
    mov ebp, 27

    ; ret_addr_func di-push ke stack dan esp menunjuk ke alamat ini
    call func
    ; stack di-restore

    ; melompat ke instruksi end untuk mengakhiri program (ret_addr_end doesn't important)
    call end

func:
    ; push nilai ebp, yaitu 27 ke stack
    push ebp
    ; simpan alamat pada stack yang menyimpan nilai ebp (27) di ebp
    ; ebp = addr_27_pada_stack
    mov ebp, esp

    ; pindahkan data ke register eax (karena akan dilakukan operasi DIV)
    mov eax, [mynum]
    ; eax = 12345

    ; set nilai pembagi, yaitu 10 ke esi
    mov esi, 10

    ; Dikarenakan kita menggunakan register esi sebagai pembagi
    ; maka jenis operator DIV nya adalah DIV r/m32
    ; dimana hasil bagi disimpan di EAX dan sisa bagi disimpan di EDX

    ; push ret_addr_ambil_digit ke stack
    call ambil_digit
    ; esp sekarang menunjuk ke satu stack di atas ret_addr_ambil_digit

    ; inisialisasi ulang counter karena kita akan mencetak masing-masing digit dan diperlukan navigator digit
    mov [counter], byte 1

    ; push ret_addr_cetak_digit. Perintah ini akan melakukan overwrite terhadap ret_addr_ambil_digit
    call cetak_digit
    ; pointer esp berada pada satu stack frame di atas ret_addr_cetak_digit

    ; push ret_addr_cetak_newline. Perintah ini akan melakukan overwrite terhadap ret_addr_cetak_digit
    call cetak_newline
   
    mov esp, ebp
    pop ebp
    ret

ambil_digit:
    ; push nilai ebp ke stack, yaitu addr_27_pada_stack
    push ebp
    ; simpan alamat pada stack yang menyimpan addr_27_pada_stack di ebp
    ; ebp = addr_addr_27_pada_stack
    mov ebp, esp

    ; melompat ke label push_digit (return address tidak di-push sehingga kondisi stack tetap)
    jmp push_digit

push_digit:
    ; set edx = 0 terlebih dahulu, karena pembagian dilakukan antara EDX:EAX dengan r/m32
    mov edx, 0
    ; EDX;EAX / ESI
    div esi
    ; (iterasi 1)
    ; EDX = 5
    ; EAX = 1234

    ; tambahkan nilai pada edx dengan ASCII '0'
    ; agar angka bisa dicetak
    add edx, 0x30

    ; push nilai edx ke stack
    push edx

    ; increment nilai counter, artinya kita beranjak ke digit selanjutnya
    add [counter], byte 1
    ; cek apakah sudah melewati batas atau tidak
    cmp [counter], byte len
    ; jika masih kecil maka loop ke fungsi push_digit
    jle push_digit

    ; set kembali esp agar menunjuk ke alamat ebp pada stack, yaitu addr_27_pada_stack
    mov esp, ebp
    ; restore nilai ebp, yaitu ret_addr_27_pada_stack
    pop ebp
    ; pop dan jmp ke ret_addr_ambil_digit
    ret    

cetak_digit:
    ; push nilai ebp ke stack, yaitu addr_27_pada_stack
    push ebp
    ; simpan alamat pada stack yang menyimpan nilai ebp ke ebp
    ; ebp = addr_addr_27_pada_stack
    mov ebp, esp

    ; Perhatikan bahwa stack frame di bawah esp akan berisi nilai-nilai digit yang akan dicetak namun urutannya masih terbalik.
    ; Digit pertama yang harus dicetak berada pada posisi ke-5
    ; Sehingga kita harus arahkan terlebih dahulu pointer esp ke offset tersebut
    sub esp, len*4

    ; Setelah esp menunjuk ke digit pertama yang akan dicetak maka pop value-nya dan simpan ke register edi
    pop edi
    
    ; push ret_addr_print ke-stack, nilai return address melakukan overwrite
    ; pada elemen 0x30 + 1, namun dikarenakan kita sudah menyimpan nilainya
    ; maka hal ini tidak terlalu diperhitungkan
    call print
    ; Setelah iterasi pertama dan pemanggilan fungsi print
    ; maka esp akan menunjuk ke 0x30 + 2 (karena ada instruksi pop sebelumnya).

    ; cek sudah sampai di digit ke-berapa
    add [counter], byte 1
    ; cek apakah semua digit sudah dicetak
    cmp [counter], byte len
    ; jmp ke cetak_sisa_digit jika semua digit belum dicetak (kondisi stack tetap).
    jle cetak_sisa_digit
    
    mov esp, ebp
    pop ebp
    ret

cetak_sisa_digit:
    ; [iterasi-2]
    ; pop nilai 0x30 + 2 dan simpan ke edi
    pop edi
    ; pointer esp menunjuk ke satu frame di atas 0x30 + 2, yaitu 0x30 + 3
    ; push ret_addr_print. Perintah ini akan melakukan overwrite terhadap inlai 0x30 + 2
    call print
    ; Setelah iterasi kedua, esp akan menunjuk ke 0x30 + 3 (karena ada instruksi pop pada perintah ret)

    add [counter], byte 1   
    cmp [counter], byte len
    ; looping
    jle cetak_sisa_digit

    ; setelah semua digit telah dicetak maka restore stack dan return
    mov esp, ebp
    pop ebp
    ret
    
print:
    mov [tmp], edi
    mov eax, 4
    mov ebx, 1
    lea ecx, [tmp]
    mov edx, 1
    int 0x80

    ; pop ret_addr_print dan jmp ke ret_addr_print
    ret

cetak_newline:
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    ret

end:
    mov eax, 1
    mov ebx, 0
    int 0x80    
