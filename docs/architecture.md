# Architecture

## Overview
The scalability benchmarking framework consists of three main components interactively coupled to automate the testing process.

## Components

### 1. Orchestration Layer
*   **Scripts**: `run-benchmark.sh` acts as the entry point, coordinating the selection of workloads and applying cluster-specific configurations.
*   **Configuration Management**: Uses simplified YAML/env file based references to inject dynamic parameters (QPS, Burst) into Kube-Burner.

### 2. Execution Engine (Kube-Burner)
Kube-Burner is the core engine that:
*   Generates the specified load (Pods, Deployments, Namespaces).
*   Monitors the cluster state.
*   Collects metrics from Prometheus (if configured) and local execution latencies.

### 3. Reporting Layer
*   **Metrics Collection**: `collect-metrics.sh` aggregates the JSON results and logs produced by Kube-Burner.
*   **Storage**: Results are organized by workload type, cluster size, and unique run UUIDs for historical comparison.

## Data Flow
1.  User initiates `run-benchmark.sh <workload> <size>`.
2.  Script loads `configs/<size>-cluster.yaml`.
3.  Script invokes `kube-burner init` with the appropriate `workloads/<workload>/...yaml` template.
4.  Kube-Burner creates resources on the Kubernetes cluster.
5.  Kube-Burner measures latencies (Pod Ready, etc.).
6.  `collect-metrics.sh` packages the output for analysis.
