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
*(Detailed instructions coming in future commits)*

## License
Apache 2.0