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


# Load Cluster Config
source configs/${CLUSTER_SIZE}-cluster.yaml

echo "Loading configuration for ${CLUSTER_SIZE} cluster..."
echo "Iterations: ${JOB_ITERATIONS}"
echo "QPS: ${QPS}"
echo "Bursts: ${BURST}"

export JOB_ITERATIONS
export QPS
export BURST

# Mapping inputs to workload files
case $WORKLOAD in
  pods)
    CONFIG_FILE="workloads/pods/pod-density.yaml"
    ;;
  deployments)
    CONFIG_FILE="workloads/deployments/deployment-density.yaml"
    ;;
  namespaces)
    CONFIG_FILE="workloads/namespaces/namespace-density.yaml"
    ;;
  *)
    echo "Error: Unknown workload type '$WORKLOAD'"
    exit 1
    ;;
esac

echo "Running Kube-Burner..."
# Assuming kube-burner is in PATH. 
# Using uuid based output directory to avoid overwrites
UUID=$(uuidgen)
RESULTS_DIR="results/${WORKLOAD}-${CLUSTER_SIZE}-${UUID}"
mkdir -p "$RESULTS_DIR"

echo "Results will be stored in: $RESULTS_DIR"

# Execute Kube-Burner
# We use 'init' command for these density workloads
kube-burner init -c "${CONFIG_FILE}" --uuid "${UUID}" --log-level=info

echo "Benchmark finished."

# Collect Metrics
./scripts/collect-metrics.sh "$RESULTS_DIR"

