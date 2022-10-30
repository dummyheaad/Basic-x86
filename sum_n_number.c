/*
Program ini akan mengimplementasikan command line argument pada C untuk menghitung jumlah dari n buah bilangan yang diinputkan via argumen.

Contoh pemakaian:

./sum_n_number bil1 bil2 bil3 bil4 ... biln

Output:
hasil penjumlahan semua bilangan
*/

#include<stdio.h>
#include<stdlib.h>

int main(int argc, char* argv[])
{
    int total_bil = argc - 1;
    printf("Terdapat %d buah bilangan yang terbaca\n", total_bil);
    int sum = 0;
    for (int i = 1;i < argc;i ++)
    {
        int nilai = atoi(argv[i]);
        sum += nilai;
    }
    printf("Total nilai adalah: %d\n", sum);
    return 0;
}
