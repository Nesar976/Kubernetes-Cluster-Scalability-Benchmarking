#!/bin/sh

# Main script to run benchmarks
# Usage: ./run-benchmark.sh <workload> <cluster-size>

WORKLOAD=$1
CLUSTER_SIZE=$2

usage() {
  echo "Usage: $0 <workload> <cluster-size>"
  echo "Workloads: pods, deployments, namespaces"
  echo "Cluster Sizes: small, medium, large"
  exit 1
}

if [ -z "$WORKLOAD" ] || [ -z "$CLUSTER_SIZE" ]; then
  usage
fi

echo "Starting Benchmark..."
echo "Workload: $WORKLOAD"
echo "Cluster Size: $CLUSTER_SIZE"

# Validation
if [ ! -d "workloads/$WORKLOAD" ]; then
  echo "Error: Workload '$WORKLOAD' not found."
  exit 1
fi

if [ ! -f "configs/${CLUSTER_SIZE}-cluster.yaml" ]; then
  echo "Error: Cluster size config '${CLUSTER_SIZE}' not found."
  exit 1
fi
