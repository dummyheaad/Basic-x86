#include<stdio.h>

//#pragma warn -rvl       // ignore if a function doesn't return a value
//#pragma warn -par       // ignore if there's no parameter passed into a function that need parameter

int ambilnilai(int x)
{
    // parameter x tidak digunakan sama sekali
    printf("masuk ke fungsi ambilnilai\n");
    // tidak ada kembalian fungsi
}

int main()
{
    ambilnilai(3);
    printf("masuk ke fungsi main");
    return 0;
}

/*
Note: tidak semua compiler mendukung pragma. Jadi untuk menggunakan pragma pastikan compiler mendukung pragma.
*/
