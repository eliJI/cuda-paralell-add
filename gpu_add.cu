#include <iostream>
#include <time.h>

__global__ void gpu_add(int* in, int* out, int size) {
    int id = threadIdx.x;
    out[id] = in[id] + in[size-1 - id];
    return;
}

__global__ void gpu_extra(int in, int* out) {
    clock_t start_clock = clock();
    clock_t curr;
    float seconds = 2000;
 
    while (((clock() - start_clock) / (float)CLOCKS_PER_SEC) < seconds) { 
        curr = clock(); 
    }
    return;
}

__global__ void gpu_mult(int* in, int size) {
    if (size < 1) return;
    int base = 1;
    for (int i = 0; i < size; i++) {
        base = base * in[i];
    }
    printf("MULT: %d\n", base);
    return;
}
