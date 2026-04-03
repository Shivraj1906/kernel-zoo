#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

rm -rf "${ROOT_DIR}/bin"
find "${ROOT_DIR}/profiling/raw_reports" -mindepth 1 -delete

echo "[clean] Removed build artifacts and raw profiler outputs"
