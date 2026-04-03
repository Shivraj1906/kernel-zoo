# Microarchitectural Analysis of CUDA Kernels using Nsight Compute

## Overview

This repository provides a reproducible, research-oriented scaffold for CUDA performance engineering using Nsight Compute. It is designed for iterative kernel optimization studies, controlled experiments, and metric-driven microarchitectural analysis.

The current state intentionally focuses on structure, documentation, and workflow. Kernel implementations are deferred to future work.

## Motivation

GPU performance engineering requires careful reasoning across multiple hardware and software layers, including memory hierarchy behavior, warp scheduling, occupancy, and instruction throughput. This project organizes those activities into a modular workflow so optimization decisions can be grounded in profiler evidence rather than intuition alone.

## Kernel Suites and Purpose

- `basics/vec_add`: Entry-point sanity benchmark for baseline profiling workflow validation.
- `matmul`: Matrix multiplication variants intended to study memory access patterns, tiling, and compute intensity.
- `reduction`: Reduction variants intended to study synchronization overhead, memory coalescing, and warp-level execution.
- `stencil`: Stencil variants intended to study neighborhood reuse, shared memory locality, and bandwidth pressure.
- `divergence`: Divergence-focused variants intended to study control-flow efficiency and warp execution behavior.
- `histogram`: Histogram variants intended to study atomics contention, privatization strategies, and memory traffic.

## Methodology

The workflow follows an Nsight Compute-driven optimization cycle:

1. Build controlled kernel binaries.
2. Profile with a standard metric set.
3. Compare microarchitectural signals across variants.
4. Run structured parameter sweeps.
5. Store raw reports and summarized outputs.
6. Consolidate findings in a report.

## Repository Layout

- `environment/`: Environment setup and tool verification steps.
- `common/`: Shared utility headers and timing/check scaffolding.
- `kernels/`: Kernel family directories, variant stubs, and per-family result folders.
- `profiling/`: Nsight Compute command templates, metric reference, and raw report output.
- `experiments/`: Parameter sweep script scaffolds and plot output directory.
- `report/`: Final report draft and figure assets.
- `scripts/`: Build, run orchestration, and cleanup scripts.

## Build and Run (High-Level)

1. Install and verify CUDA Toolkit and Nsight Compute using `environment/setup.md`.
2. Build binaries into `./bin/` using `scripts/build.sh`.
3. Run placeholder orchestration with `scripts/run_all.sh`.
4. Profile selected binaries using templates in `profiling/ncu_commands.sh`.
5. Aggregate outputs under `kernels/*/results/`, `profiling/raw_reports/`, and `report/figures/`.

## Notes

- No kernel logic is implemented in this scaffold by design.
- No synthetic performance results are included.
- The structure is intended to be GitHub-ready and extensible for future experiments.
