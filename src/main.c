#include <stdio.h>

int main() {
    int limit = 10000000; // 100 Juta
    int count = 0;
    volatile int i;

    for (i = 0; i < limit; i++) {
        count = count + 1;
    }

    printf("%d\n", count);
    return 0;
}