#include<stdio.h>
#include"addthenmultiply7.h"

int main()
{
    int result;
    int a = 3, b = 7, c = 11;
    result = addthenmultiply7(a, b, c);
    printf("Result of (%d + %d + %d) * 7 = %d\n", a, b, c, result);
    return 0;
}
