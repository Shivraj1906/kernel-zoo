# Nsight Compute Metric Guide

This guide summarizes core metric categories used in this repository. It is intentionally value-free and focuses on interpretation.

## 1. SM Utilization

What it indicates:

- How effectively streaming multiprocessors are kept busy.

Why it matters:

- Low utilization may indicate memory bottlenecks, insufficient parallelism, or control-flow inefficiency.

How to use it:

- Compare across kernel variants under identical input sizes and launch settings.

## 2. DRAM Throughput

What it indicates:

- Fraction of sustained peak memory bandwidth being used.

Why it matters:

- Helps classify kernels as memory-bound versus compute-bound.

How to use it:

- Pair with SM utilization and stall metrics to identify whether memory traffic is the limiting factor.

## 3. Warp Stall Reasons

What it indicates:

- Dominant reasons warps are unable to issue instructions (for example memory dependency, barrier, execution dependency).

Why it matters:

- Guides optimization direction toward memory behavior, synchronization strategy, or instruction-level structure.

How to use it:

- Track stall distribution changes after each optimization variant.

## 4. Occupancy

What it indicates:

- Ratio of active warps to the theoretical hardware maximum.

Why it matters:

- Resource usage (registers/shared memory/block size) can limit active warps and hide latency less effectively.

How to use it:

- Analyze together with achieved performance, since higher occupancy is not always equivalent to higher throughput.

## Profiling Practice Notes

- Keep metric sets consistent for apples-to-apples comparisons.
- Record toolchain versions with each profiling batch.
- Store raw reports in `profiling/raw_reports/` before generating summaries.
