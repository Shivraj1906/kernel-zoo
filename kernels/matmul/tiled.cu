
#include <cuda_runtime.h>

#include "../../common/utils.h"

#define BLOCK_DIM 32

__global__
void tiled_matmul(float*A, float*B, float*C, int M, int N, int K) {
    int row = blockDim.y * blockIdx.y + threadIdx.y;
    int col = blockDim.x * blockIdx.x + threadIdx.x;

    __shared__ float tileA[BLOCK_DIM][BLOCK_DIM];
    __shared__ float tileB[BLOCK_DIM][BLOCK_DIM];

    float sum = 0.0;
    for (int i = 0; i < K; i += BLOCK_DIM) {
        tileA[threadIdx.y][threadIdx.x] = A[row * K + (i + threadIdx.x)];
        tileB[threadIdx.y][threadIdx.x] = B[(i + threadIdx.y) * N + col];
        __syncthreads();
        
        for (int j = 0; j < BLOCK_DIM; j++) {
            sum += tileA[threadIdx.y][j] * tileB[j][threadIdx.x];
        }
        __syncthreads();
    }
    C[row * N + col] = sum;
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
    tiled_matmul<<<gridSize, blockSize>>>(d_A, d_B, d_C, N, N, N);
    cudaDeviceSynchronize();

    cudaMemcpy(C, d_C, bytes, cudaMemcpyDeviceToHost);

    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);
    return 0;
}
