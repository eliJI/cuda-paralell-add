#include <stdio.h>
#include <cuda.h>
#include <cuda_runtime.h>


__global__ void gpu_add(int*, int*, int);

int main(int argc, char** argv) {
    printf("beginning initialization\n");
    int* array;
    int* d_array;
    int* out = (int*)malloc(sizeof(int)*16);
    array = (int*)malloc(sizeof(int)*16);

    //initialize arra y values
    for (int i = 0; i < 16; i++) {
        array[i] = 1;
    }


    int size = 16;

    printf("initializing\n");
    while (size > 1) {

        cudaMalloc((void**)&d_array, sizeof(int)*size);
        cudaMemcpyAsync(d_array, array, sizeof(int)*size, cudaMemcpyHostToDevice);
        int* d_out;
        size = size / 2;
        cudaMalloc((void**)&d_out, sizeof(int)*size);
        gpu_add<<<1,size>>>(d_array, d_out, size*2);
        cudaDeviceSynchronize();
        cudaMemcpyAsync(array, d_out,sizeof(int)*size,cudaMemcpyDeviceToHost);
        
        //print intermediate
        printf("intermediate sum:\n");
        for(int i = 0; i < size; i++) {
            printf("%d, ", array[i]);
        }
        printf("\n");
    }

    //flag to keep track of kernel launches

    return 0;
 
}
