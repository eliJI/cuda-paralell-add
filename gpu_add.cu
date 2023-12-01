__global__ void gpu_add(int* in, int* out, int size) {
    int id = threadIdx.x;
    out[id] = in[id] + in[size-1 - id];
}
