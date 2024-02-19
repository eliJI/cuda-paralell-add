#include <stdio.h>
#include <cuda.h>
#include <cuda_runtime.h>


__global__ void gpu_add(int*, int*, int);
__global__  void gpu_extra(int in, int* out);

int main(int argc, char** argv) {
    printf("beginning initialization\n");
    int* array;
    int* d_array;
    cudaStream_t stream1, stream2;
    int* out = (int*)malloc(sizeof(int)*16);
    cudaMallocHost(&array, sizeof(int)*16);
    cudaStreamCreate(&stream1);
    cudaStreamCreate(&stream2);

    //initialize arra y values
    for (int i = 0; i < 16; i++) {
        array[i] = 1;
    }


    int size = 16;
    int extra_out;

    printf("initializing\n");
    while (size > 1) {

        cudaMalloc((void**)&d_array, sizeof(int)*size);
        cudaMemcpyAsync(d_array, array, sizeof(int)*size, cudaMemcpyHostToDevice, stream1);
        int* d_out;
        size = size / 2;
        cudaMalloc((void**)&d_out, sizeof(int)*size);
        gpu_add<<<1,size, 0, stream1>>>(d_array, d_out, size*2);
        gpu_extra<<<1,1,0,stream2>>>(size, &extra_out);
        cudaStreamSynchronize(stream1);
        cudaMemcpyAsync(array, d_out,sizeof(int)*size,cudaMemcpyDeviceToHost, stream1);
        
        //print intermediate
        printf("intermediate sum:\n");
        for(int i = 0; i < size; i++) {
            printf("%d, ", array[i]);
        }
        printf("\n");
    }

    //flag to keep track of kernel launches
    cudaStreamSynchronize(stream2);
    cudaStreamDestroy(stream1);
    cudaStreamDestroy(stream2);
    return 0;
 
}
