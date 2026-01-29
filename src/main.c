#include <stdio.h>

int main() {
    int limit = 100000; // 1 Juta
    int count = 0;
    int i;

    for (i = 0; i < limit; i++) {
        count = count + 1;
    }

    printf("%d\n", count);
    return 0;
}