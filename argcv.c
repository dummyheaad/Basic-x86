/*
Contoh program dalam bahasa C untuk mengimplementasikan command line argument.
Sederhananya command line argument bisa dipakai di program .c dengan menambahkan 2 buah parameter pada fungsi main, yaitu argc dan argv[].

- argc akan berfungsi untuk menghitung jumlah argumen yang dimasukkan
- arv akan menyimpan argumen yang diberikan dalam bentuk string
- setiap argumen dipisahkan oleh spasi
- contoh: ./argcv nama saya aysuka ansari
          maka argc akan bernilai 4
          sedangkan argv[] akan berisi:
          argv[0] = nama
          argv[1] = saya
          argv[2] = aysuka
          argv[4] = ansari
  Namun kenyataannya pada C sendiri output yang dihasilkan berbeda dimana argc akan bernilai 5 dan argv[] sendiri akan berisi ./argcv, nama, saya, aysuka, dan ansari. Oleh karena itu, kita harus sedikit memodifikasi program agar memperoleh hasil yang diinginkan.
*/

#include<stdio.h>

int main(int argc, char* argv[])
{
    // nama file akan dihitung sebagai satu buah argumen
    // oleh karena itu program perlu sedikit dimodifikasi
    int total_arg = argc - 1;
    printf("Terdapat %d buah argument yang diberikan, yaitu:\n", total_arg);
    // loop dimulai dari 1 karena argv[0] berisi nama program yaitu ./argcv
    for (int i = 1;i < argc;i ++)
        printf("<\t%s\n",argv[i]);
    return 0;
}
