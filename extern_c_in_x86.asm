; Extern C in Assembly x86
; Contoh program untuk coding inline C di x86

global main                 ; untuk linker memakai gcc maka digunakan label main bukan _start dikarenakan gcc sudah otomatis mengidentifikasi _start

extern printf               ; ambil fungsi printf pada library C

section .data
    result db "Hasil Penjumlahan %d + %d = %d", 0x0a, 0x00

section .text
main:
    push ebp                ; prologue
    mov ebp, esp
    ; sub esp nya berapa ??

    mov ebx, 10             ; simpan nilai 10 di register ebx
    mov ecx, 12             ; simpan nilai 12 di register ecx
    mov edx, 0              ; simpan nilai 0 di register edx
    add edx, ebx            ; edx += ebx
    add edx, ecx            ; edx += ecx

    push edx                ; push edx ke stack
    push ebx                ; push ebx ke stack
    push ecx                ; push ecx ke stack
    push result             ; push result ke stack
    call printf             ; panggil fungsi printf
                            ; kemudian printf akan membaca isi dari stack

    mov eax, 0              ; return fungsi main bernilai 0

    mov esp, ebp            
    pop ebp
    ret                     ; epilogue


; Perhatikan bahwa proses push dilakukan secara terbalik (reverse)
; Hal ini didasari oleh konsep read dan write pada stack
; Pada stack berlaku konsep LIFO (Last In First Out)
; Pada stack proses read akan dilakukan pada "top of the stack"
; Dikarenakan kita ingin agar variabel result dibaca terlebih dahulu maka
; kita harus mempush result di akhir
; Hal ini akan mengakibatkan result berada pada top of the stack sehingga result akan dibaca pertama kali oleh fungsi printf
; Begitupun dengan sisa parameter yang diperlukan oleh printf

; Compile file object di gcc pakai opsi -no-pie ama -m32
