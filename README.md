# Kubernetes Cluster Scalability Benchmarking using Kube-Burner

## Overview
This project provides a comprehensive benchmarking framework to measure and analyze Kubernetes cluster scalability. Utilizing [Kube-Burner](https://kube-burner.github.io/kube-burner/), it orchestrates stress tests across various objects (Pods, Deployments, Namespaces) to evaluate control plane performance and worker node capacity.

## Motivation
Understanding Kubernetes behavior under load is critical for platform engineering and SRE teams. This framework simplifies the process of:
*   Identifying bottlenecks in the API server, Scheduler, and Controller Manager.
*    validating cluster capacity sizing (Small, Medium, Large).
*   Establishing performance baselines for upgrades and configuration changes.

## Benchmark Scenarios
We focus on three primary density tests:
1.  **Pod Density**: High churn of individual pods to test scheduler throughput.
2.  **Deployment Density**: Scaling deployment replicas to test controller manager performance.
3.  **Namespace Density**: Creating high volumes of namespaces with mixed resources to test API server object management.

## Project Structure
*   `workloads/`: Kube-Burner configuration files for specific tests.
*   `configs/`: Cluster sizing variables (Small, Medium, Large).
*   `scripts/`: Automation for running benchmarks, collecting metrics, and cleanup.
*   `docs/`: Detailed design, architecture, and analysis guides.


## Quick Start

### Prerequisites
*   Kubernetes Cluster (tested on v1.25+)
*   `kubectl` configured with cluster admin access.
*   `kube-burner` binary installed (v1.0+).

### Running a Benchmark

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-org/Kubernetes-Cluster-Scalability-Benchmarking.git
    cd Kubernetes-Cluster-Scalability-Benchmarking
    ```

2.  **Execute the benchmark script:**
    The `run-benchmark.sh` script handles workload selection and configuration.
    
    Syntax: `./scripts/run-benchmark.sh <workload> <cluster-size>`

    Examples:
    ```bash
    # Run Pod Density on a Small Cluster
    ./scripts/run-benchmark.sh pods small

    # Run Deployment Density on a Medium Cluster
    ./scripts/run-benchmark.sh deployments medium
    ```

3.  **Collect Results:**
    Results are automatically collected in the `results/` directory, organized by UUID.
    
    To manually archive results:
    ```bash
    ./scripts/collect-metrics.sh results/
    ```

4.  **Cleanup:**
    To remove all resources created by the benchmark:
    ```bash
    ./scripts/cleanup.sh
    ```

## Configuration
Adjust the parameters in `configs/` to match your cluster capacity.

| Parameter | Description |
| :--- | :--- |
| `JOB_ITERATIONS` | Number of distinct jobs/objects to create. |
| `QPS` | Rate of API requests per second. |
| `BURST` | Maximum burst size for API requests. |

## License
Apache 2.0