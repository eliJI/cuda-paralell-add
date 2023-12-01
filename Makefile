main: main.cu gpu_add.cu
	nvcc main.cu gpu_add.cu -o main
