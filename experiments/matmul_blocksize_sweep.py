#!/usr/bin/env python3
"""Placeholder scaffold for matrix multiplication block-size sweeps."""

from __future__ import annotations

import argparse
from pathlib import Path


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Scaffold for matmul block-size sweep orchestration"
    )
    parser.add_argument(
        "--binary",
        default="./bin/matmul_naive",
        help="Path to the matmul executable",
    )
    parser.add_argument(
        "--block-sizes",
        nargs="+",
        type=int,
        default=[8, 16, 32],
        help="Candidate block sizes to evaluate",
    )
    parser.add_argument(
        "--output-dir",
        default="kernels/matmul/results",
        help="Directory for run metadata and profiler outputs",
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    output_dir = Path(args.output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)

    print("[scaffold] Matmul block-size sweep")
    print(f"[scaffold] Binary: {args.binary}")
    print(f"[scaffold] Block sizes: {args.block_sizes}")
    print(f"[scaffold] Output dir: {output_dir}")

    # TODO: Add subprocess calls for execution/profiling per configuration.
    # TODO: Add structured result capture (CSV/JSON) for later plotting.

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
