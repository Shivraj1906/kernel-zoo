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

## Kernel Analysis: Vector Addition

### 1. Workload Description

- Element-wise vector addition:
  
  C[i] = A[i] + B[i]

- Data type: `double` (kept intentionally to see the effects of using FP64 instead of FP32)
- Access pattern: sequential, fully coalesced
- Arithmetic intensity: 0.04 (≈ 1 FLOP per 24 bytes)

---

### 2. Profiling Configuration

- Block size: 256  
- Grid size: ceil(N / 256)  
- Tool: Nsight Compute (full metric set)

---

### 3. Key Metrics Observed

| Metric | Observation |
|--------|------------|
| DRAM Throughput | ~92% of peak |
| Long Scoreboard Stall | ~95.8% |
| Compute Throughput | 13.17% |
| Memory Access Pattern | Fully coalesced |

---

### 4. Observations

1. **Dominant Stall Reason**
   - Long scoreboard stalls account for ~95.8% of warp stall cycles  
   - Indicates threads are predominantly waiting on memory dependencies  

2. **High Memory System Utilization**
   - DRAM throughput is close to saturation (~92%)  
   - Suggests heavy reliance on global memory bandwidth and caches are ineffective

3. **Low Compute Pressure**
   - Minimal arithmetic work per memory access  
   - No opportunity to hide latency via computation  

---

### 5. Bottleneck Classification

> The kernel is **memory-bound**

---

### 6. Evidence-Based Reasoning

- High **long scoreboard stalls**  
  → threads stalled on memory fetch  

- High **DRAM utilization**  
  → memory subsystem heavily exercised  

- Low **compute utilization**  
  → no arithmetic bottleneck  

---

### 7. Key Insight

> Even with fully coalesced accesses and high bandwidth utilization,  
> the kernel remains latency-limited due to extremely low arithmetic intensity.

---

### 8. Experimental Extension (Coalescing Perturbation)

**Modification:**

```cpp
C[idx] = A[idx * 2] + B[idx * 2];
```
---



## Data Sources

- Raw Nsight Compute reports from `profiling/raw_reports/`
- Aggregated outputs from `kernels/*/results/`
- Figures from `report/figures/`

## Notes

- Keep all claims tied to profiler evidence.
- Record command lines and configuration details for reproducibility.
- Avoid conclusions not supported by collected metrics.
