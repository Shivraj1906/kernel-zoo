# Microarchitectural Analysis Report

## Scope

This document is the final synthesis point for profiling-driven CUDA kernel optimization experiments.

## Planned Sections

1. Experimental setup (hardware, software, toolchain)
2. Workload definitions and kernel variants
3. Profiling methodology and metric selection
4. Per-kernel-family findings
5. Cross-family comparison and bottleneck taxonomy
6. Optimization takeaways and future work

## Data Sources

- Raw Nsight Compute reports from `profiling/raw_reports/`
- Aggregated outputs from `kernels/*/results/`
- Figures from `report/figures/`

## Notes

- Keep all claims tied to profiler evidence.
- Record command lines and configuration details for reproducibility.
- Avoid conclusions not supported by collected metrics.
