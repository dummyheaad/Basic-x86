; Indexing pada Array
; Misalkan array of bytes sebanyak 5 elemen
; Pada program ini akan didemonstrasikan cara mengakses elemen array via indirect address

global _start

section .data
    myArray db 65, 66, 67, 68, 69
    
section .text
_start:
    mov ecx, myArray        ; simpan offset elemen pertama myArray atau base address dari array myArray atau address dari elemen pertama myArray
    add ecx, 1              ; pindah sebanyak satu byte ke kanan sehingga sekarang ecx menyimpan/menunjuk address dari elemen kedua myAray
                            ; sekarang ecx menunjuk ke address dari elemen kedua myArray, yaitu elemen dengan nilai 66
    add [ecx], byte 10      ; tambahkan nilai sebanyak 10 ke address dari elemen yang ditunjuk register ecx, yaitu elemen kedua myArray
                            ; sehingga elemen kedua myAray akan menjadi 66 + 10 = 76
    
    add ecx, 3              ; pindah sebanyak 3 byte sehingga sekarang ecx menyimpan/menunjuk address dari elemen kelima myArray
                            ; sekarang ecx menunjuk ke address dari elemen keempat myArray, yaitu elemen dengan nilai 69
    sub [ecx - 2], byte 5   ; kurangi nilai sebanyak 5 ke address dari elmeen yang ditunjuk register ecx, dikurangi 2 bytes
                            ; artinya ecx akan menunjuk ke elemen (4 - 2 + 1) = 3 dari myArray, yaitu 67
                            ; kemudian nilai 67 dikurangi dengan 5 sehingga menjadi 67 - 5 = 62
    
    ; perhatikan bahwa ecx masih bernilai ecx + 4, meskipun ada perintah ecx - 2. Hal ini dikarenakan nilai ecx tidak di-update
    
    sub ecx, 1              ; pindah sebanyak 1 byte ke kiri sehingga sekarang ecx menyimpan/menunjuk address dari elemen keempat
                            ; sehingga sekarang ecx menyimpan/menunjuk ke address dari elemen keempat myArray yaitu 68
    
    add [ecx], byte 5       ; tambahkan nilai sebanyak 5 ke elemen yang addressnya ditunjuk ecx, yaitu elemen keempat yang bernilai 68
                            ; sehingga sekarang elemen keempat akan bernilai 68 + 5 = 73
                            
    ; kondisi akhir myArray: 65, 76, 62, 73, 69
    
    mov eax, 4
    mov ebx, 1
    mov ecx, myArray
    mov edx, 5
    int 0x80
    
    mov eax, 1
    mov ebx, 0
    int 0x80
    
    ; Output: AL>IE
    
