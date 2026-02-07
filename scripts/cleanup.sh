#!/bin/sh

# Script to clean up benchmark resources
# Usage: ./cleanup.sh

echo "Cleaning up benchmark resources..."

# Delete namespaces created by workloads
echo "Deleting namespaces..."
kubectl delete ns -l kube-burner-uuid --ignore-not-found

echo "Cleanup complete."
