main: main.cu gpu_add.cu
	rm -f main
	nvcc main.cu gpu_add.cu -o main
