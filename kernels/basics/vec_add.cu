#include <cuda_runtime.h>

#include "../../common/utils.h"

__global__ void vectorAdd(double* A, double* B, double* C, int N) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < N) {
        C[idx] = A[idx] + B[idx];
    }
}

int main() {
    constexpr int N = 1 << 21;
    constexpr size_t bytes = static_cast<size_t>(N) * sizeof(double);

    double *A, *B, *C;
    double *d_A, *d_B, *d_C;

    A = initialize_matrix(1, N);
    B = initialize_matrix(1, N);
    C = initialize_matrix_zero(1, N);

    cudaMalloc(&d_A, bytes);
    cudaMalloc(&d_B, bytes);
    cudaMalloc(&d_C, bytes);

    cudaMemcpy(d_A, A, bytes, cudaMemcpyHostToDevice);
    cudaMemcpy(d_B, B, bytes, cudaMemcpyHostToDevice);

    constexpr int blockSize = 256;
    const int gridSize = (N + blockSize - 1) / blockSize;
    vectorAdd<<<gridSize, blockSize>>>(d_A, d_B, d_C, N);
    cudaDeviceSynchronize();

    cudaMemcpy(C, d_C, bytes, cudaMemcpyDeviceToHost);

    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);
    return 0;
}
