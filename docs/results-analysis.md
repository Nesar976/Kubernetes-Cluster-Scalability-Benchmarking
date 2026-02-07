# Results Analysis

## Understanding the Output
Every benchmark run generates a timestamped directory in `results/`. This directory contains:
*   `podLatency.json`: Raw latency measurements for pod lifecycle events.
*   `kube-burner-UUID.log`: Execution logs.

## Key Metrics to Watch
1.  **P99 PodReady Latency**:
    *   **Good**: < 2s for small clusters, < 5s for large clusters.
    *   **Warning**: > 10s indicates potential scheduler or kubelet bottlenecks.
    
2.  **API Server Latency** (if monitored):
    *   High read latency often correlates with large numbers of objects/namespaces.
    *   High write latency correlates with high churn (pod creation/deletion loops).

## Comparison Strategy
*   **Horizontal Comparison**: Compare `small` vs `medium` vs `large` configs to see how latency scales with load.
*   **Vertical Comparison**: Run the same workload/config on clusters with different node counts (e.g., 10 nodes vs 100 nodes).
