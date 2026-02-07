# Benchmark Design

## Design Philosophy
Our benchmarking design focuses on "Cluster Density" — the ability of the control plane to handle high concurrency of object creation and state changes.

## Workloads

### 1. Pod Density
*   **Goal**: Saturate the Kube-Scheduler and Kubelet.
*   **Mechanism**: Creates large numbers of "pause" pods.
*   **Why**: Pods are the fundamental unit of Kubernetes. High churn rates expose scheduler latency and Kubelet PLEG issues.

### 2. Deployment Density
*   **Goal**: Stress the Kube-Controller-Manager.
*   **Mechanism**: Creates Deployments with varying replica counts.
*   **Why**: Deployments involve the logic of ReplicaSets and Controller revisions, adding processing overhead beyond simple pod creation.

### 3. Namespace Density
*   **Goal**: Stress API Server (etcd) and Namespace Controller.
*   **Mechanism**: Creates many namespaces, each populated with a few ConfigMaps.
*   **Why**: Namespaces are expensive objects. High namespace churn tests the cluster's ability to handle logical partitioning and garbage collection.

## Metrics
We primarily measure **P99 Latency** for:
*   Pod Scheduled
*   Pod Ready
*   Deployment Available

We also monitor API Server request latency and error rates if Prometheus is connected.
