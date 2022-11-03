/*
	Program untuk melakukan operasi aritmetika sederhana menggunakan inline x86 dengan syntax intel.
	Keyword untuk menggunakan inline assembly adalah: __asm__
*/

#include<stdio.h>
#include<stdlib.h>
#include<string.h>

/*
    Extended Inline Assembly Syntax
    bentuk umum:
    __asm__( "assembly code (intel/at&t)"
                    : output operands           [opt]
                    : input operands            [opt]
                    : list of clobbered registers (modified by inline assembler) [opt]
    );
    * [opt] = optional
*/

int main()
{
    int bil1, bil2, tambah, kurang, kali, bagi, sisa_bagi;

    printf("Basic Arthmetic using Inline x86 in C [Intel Syntax]\n");
    
    int cek = scanf("%d%d",&bil1, &bil2);												// simpan retval scanf (soalnya kalau cuma pakai scanf pas di-compile ada warning)
    if (!cek)
        printf("bilangan tidak berhasil dibaca:\n\n");
        
    __asm__("add eax, ebx;" : "=a" (tambah) : "a" (bil1) , "b" (bil2));					// input: bil1 dan bil2, output: tambah
																						// nilai bil1 disimpan di register eax (constraint register a)
																						// nilai bili2 disimpan di register ebx (constraint register b)
																						// nilai tambah disimpan di register eax
																						// berikut adalah alur nya:
																						// eax = bil1
																						// ebx = bil2
																						// eax += ebx
																						// tambah = eax
																						
    
    __asm__("sub eax, ebx;" : "=a" (kurang) : "a" (bil1) , "b" (bil2));					// input: bil1 dan bil2, output: kurang
																						// nilai bil1 disimpan di register eax (constraint register a)
																						// nilai bil2 disimpan di register ebx (constraint register b)
																						// nilai kurang disimpan di register eax (constraint register a)
																						// berikut adalah alur nya:
																						// eax = bil1
																						// ebx = bil2
																						// eax -= ebx
																						// kurang = eax
																						
    __asm__("imul ebx;" : "=a" (kali) : "a" (bil1) , "b" (bil2));						// input: bil1 dan bil2, output: kali
																						// nilai bil1 disimpan di register eax (constraint register a)
																						// nilai bil2 disimpan di register ebx (constraint register b)
																						// nilai kali disimpan di register eax (constraint register a)
																						// berikut adalah alur nya:
																						// eax = bil1
																						// ebx = bil2
																						// eax *= ebx
																						// kali = eax
    
    __asm__("mov edx, 0;"																// input: bil1 dan bil2, output: bagi dan sisa bagi
            "mov eax, %2;"																// nilai bil1 disimpan di general purpose register yang ditentukan bebas oleh compiler (constraint register g)
            "mov ebx, %3;"																// nilai bil2 disimpan di general purpose register yang ditentukan bebas oleh compiler (constraint register g)
            "idiv ebx;" : "=a" (bagi), "=d" (sisa_bagi) : "g" (bil1), "g" (bil2)		// %2 merepresentasikan argumen ke-3, yaitu bil1
    );																					// %3 merepresentasikan argumen ke-4, yaitu bil2
																						// nilai bagi disimpan di register eax (constraint register a)
																						// nilai sisa_bagi disimpan di register edx (constraint register d)
																						// berikut adalah alurnya:
																						// edx = 0
																						// eax = %2 -> bil1
																						// ebx = %3 -> bil2
																						// idiv ebx; => hasil bagi disimpan ke eax dan sisa bagi disimpan ke edx
																						// bagi = eax
																						// sisa_bagi = edx

    // printf("%d (ignore this part lmaoo)\n", bil1);

    printf("%d + %d = %d\n", bil1, bil2, tambah);
    printf("%d - %d = %d\n", bil1, bil2, kurang);
    printf("%d * %d = %d\n", bil1, bil2, kali);
    printf("%d / %d = %d\n", bil1, bil2, bagi);
    printf("%d %% %d = %d\n", bil1, bil2, sisa_bagi);

    return 0;
}

