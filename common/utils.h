#ifndef CUDA_KERNEL_OPTIMIZATION_UTILS_H
#define CUDA_KERNEL_OPTIMIZATION_UTILS_H

// Shared utility declarations for future kernel runners and experiment helpers.
// Intentionally minimal in this scaffold phase.

double* initialize_matrix(int rows, int cols) {
    double *ptr = (double *) malloc(sizeof(double) * rows * cols);
    for (int i = 0; i < rows * cols; ++i)
        ptr[i] = static_cast<double>(i % 100);
    return ptr;
}

double* initialize_matrix_zero(int rows, int cols) {
    double *ptr = (double *) malloc(sizeof(double) * rows * cols);
    for (int i = 0; i < rows * cols; ++i)
        ptr[i] = 0;
    return ptr;
}

float* initialize_matrix_fp32(int rows, int cols) {
    float *ptr = (float *) malloc(sizeof(float) * rows * cols);
    for (int i = 0; i < rows * cols; ++i)
        ptr[i] = static_cast<float>(i % 100);
    return ptr;
}

float* initialize_matrix_zero_fp32(int rows, int cols) {
    float *ptr = (float *) malloc(sizeof(float) * rows * cols);
    for (int i = 0; i < rows * cols; ++i)
        ptr[i] = 0.0f;
    return ptr;
}

#endif  // CUDA_KERNEL_OPTIMIZATION_UTILS_H
