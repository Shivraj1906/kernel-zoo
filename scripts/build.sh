#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BIN_DIR="${ROOT_DIR}/bin"

mkdir -p "${BIN_DIR}"

# Compile each CUDA translation unit into a standalone binary with matching basename.
# This intentionally assumes each .cu file provides an entry point stub during scaffold phase.
while IFS= read -r src; do
  base="$(basename "${src}" .cu)"
  out="${BIN_DIR}/${base}"
  echo "[build] nvcc ${src} -> ${out}"
  nvcc -lineinfo -std=c++17 "${src}" -o "${out}"
done < <(find "${ROOT_DIR}/kernels" -type f -name '*.cu' | sort)

echo "[build] Completed. Binaries are in ${BIN_DIR}" 
