#!/usr/bin/env bash
set -euo pipefail

# Nsight Compute command templates.
# Usage: ./profiling/ncu_commands.sh <binary_path> [basic|full|export|csv|all]

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <binary_path> [basic|full|export|csv|all]"
  exit 1
fi

BINARY_PATH="$1"
MODE="${2:-all}"
REPORT_BASENAME="$(basename "$BINARY_PATH")"

run_basic() {
  sudo ncu \
    --export "profiling/raw_reports/${REPORT_BASENAME}_basic" \
    "$BINARY_PATH"
}

run_full() {
  sudo ncu -f \
    --set full \
    --export "profiling/raw_reports/${REPORT_BASENAME}_full_set" \
    "$BINARY_PATH"
}

run_export() {
  sudo ncu \
    --target-processes all \
    --export "profiling/raw_reports/${REPORT_BASENAME}_full" \
    "$BINARY_PATH"
}

run_csv() {
  sudo ncu \
    --metrics sm__throughput.avg.pct_of_peak_sustained_elapsed,dram__throughput.avg.pct_of_peak_sustained_elapsed \
    --csv \
    "$BINARY_PATH"
}

case "$MODE" in
  basic)
    run_basic
    ;;
  full)
    run_full
    ;;
  export)
    run_export
    ;;
  csv)
    run_csv
    ;;
  all)
    run_basic
    run_full
    run_export
    run_csv
    ;;
  *)
    echo "Unknown mode: $MODE"
    echo "Expected one of: basic, full, export, csv, all"
    exit 1
    ;;
esac
