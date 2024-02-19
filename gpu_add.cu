#include <iostream>
#include <time.h>

__global__ void gpu_add(int* in, int* out, int size) {
    int id = threadIdx.x;
    out[id] = in[id] + in[size-1 - id];
}

__global__ void gpu_extra(int in, int* out) {
    clock_t start_clock = clock();
    clock_t curr;
    float seconds = 2000;
    
    while (((clock() - start_clock) / (float)CLOCKS_PER_SEC) < seconds) { 
        curr = clock(); 
    }
}
