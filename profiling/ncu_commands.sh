#!/usr/bin/env bash
set -euo pipefail

# Nsight Compute command templates.
# Replace binary paths and output names as implementations become available.

# 1) Basic profiling (default section set)
ncu ./bin/matmul_naive

# 2) Full metric collection (broad pass; can increase overhead)
ncu --set full ./bin/matmul_naive

# 3) Profile specific kernel launches by process and export report
ncu \
  --target-processes all \
  --export profiling/raw_reports/matmul_naive_full \
  ./bin/matmul_naive

# 4) CSV-style extraction example for selected metrics
ncu \
  --metrics sm__throughput.avg.pct_of_peak_sustained_elapsed,dram__throughput.avg.pct_of_peak_sustained_elapsed \
  --csv \
  ./bin/matmul_naive
