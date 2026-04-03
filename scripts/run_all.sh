#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "[run] Scaffold orchestration started"
echo "[run] This script demonstrates where experiment automation hooks live."

echo "[run] Example: matrix multiplication sweep"
python3 "${ROOT_DIR}/experiments/matmul_blocksize_sweep.py" \
  --binary "${ROOT_DIR}/bin/naive" \
  --output-dir "${ROOT_DIR}/kernels/matmul/results"

echo "[run] Example: reduction configuration sweep"
python3 "${ROOT_DIR}/experiments/reduction_config_sweep.py" \
  --binary "${ROOT_DIR}/bin/naive" \
  --output-dir "${ROOT_DIR}/kernels/reduction/results"

echo "[run] Scaffold orchestration complete"
