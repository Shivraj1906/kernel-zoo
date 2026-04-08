
#include <cuda_runtime.h>

#include "../../common/utils.h"

__global__ void matmul(float* A, float* B, float* C, int N) {
    int y = blockDim.x * blockIdx.x + threadIdx.x;
    int x = blockDim.y * blockIdx.y + threadIdx.y;

    if (x < N && y < N) {
        float sum = 0.0f;
        for (int k = 0; k < N; k++) 
            sum += A[x * N + k] * B[k * N + y];
        C[x * N + y] = sum;
    }
}

int main() {
    constexpr int N = 1024;
    constexpr size_t bytes = static_cast<size_t>(N * N) * sizeof(float);

    float *A, *B, *C;
    float *d_A, *d_B, *d_C;

    A = initialize_matrix_fp32(N, N);
    B = initialize_matrix_fp32(N, N);
    C = initialize_matrix_zero_fp32(N, N);

    cudaMalloc(&d_A, bytes);
    cudaMalloc(&d_B, bytes);
    cudaMalloc(&d_C, bytes);

    cudaMemcpy(d_A, A, bytes, cudaMemcpyHostToDevice);
    cudaMemcpy(d_B, B, bytes, cudaMemcpyHostToDevice);

    dim3 blockSize = dim3(32, 32);
    dim3 gridSize = dim3((N + 32 - 1) / 32, (N + 32 - 1) / 32);
    matmul<<<gridSize, blockSize>>>(d_A, d_B, d_C, N);
    cudaDeviceSynchronize();

    cudaMemcpy(C, d_C, bytes, cudaMemcpyDeviceToHost);

    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);
    return 0;
}
