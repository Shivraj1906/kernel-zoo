# Environment Setup

## 1. Install CUDA Toolkit

Choose one installation path based on your platform:

- Linux package manager (distribution-provided or NVIDIA repository)
- NVIDIA local installer / runfile
- Container-based workflow with NVIDIA Container Toolkit

After installation, ensure `nvcc` is on `PATH` and CUDA libraries are discoverable (for example via `LD_LIBRARY_PATH` if needed).

## 2. Install Nsight Compute

Nsight Compute is typically shipped with the CUDA Toolkit and may also be installed separately depending on platform packaging.

Confirm that `ncu` is available on `PATH`.

## 3. Optional: Recommended Build Tools

- `gcc` / `g++` compatible with your CUDA Toolkit version
- `make` (optional, if you later add Makefiles)
- Python 3 (for experiment script orchestration)

## 4. Verification Commands

Run the following commands:

```bash
nvcc --version
ncu --version
nvidia-smi
```

Expected outcome:

- `nvcc` reports a valid CUDA compiler version
- `ncu` reports Nsight Compute CLI version
- `nvidia-smi` detects at least one CUDA-capable GPU

## 5. Reproducibility Notes

- Record GPU model, driver version, CUDA version, and Nsight Compute version with each experiment batch.
- Keep profiling command lines version-controlled (see `profiling/ncu_commands.sh`).
- Store raw profiler exports under `profiling/raw_reports/`.
