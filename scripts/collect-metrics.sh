#!/bin/sh

# Script: collect-metrics.sh
# Description: Aggregates and archives benchmark results (JSON and logs) for analysis.
# Usage: ./collect-metrics.sh <results-dir>

RESULTS_DIR=${1:-results}
TIMESTAMP=$(date +%Y%m%d%H%M%S)
ARCHIVE_NAME="benchmark-results-${TIMESTAMP}.tar.gz"

echo "Collecting metrics from ${RESULTS_DIR}..."

if [ ! -d "${RESULTS_DIR}" ]; then
  echo "Error: Results directory ${RESULTS_DIR} does not exist."
  exit 1
fi

# Find all JSON and LOG files
find "${RESULTS_DIR}" -name "*.json" -o -name "*.log" > "${RESULTS_DIR}/file_list.txt"

# Create a summary report (placeholder for real analysis logic)
echo "Benchmark Summary Report - ${TIMESTAMP}" > "${RESULTS_DIR}/summary.txt"
echo "----------------------------------------" >> "${RESULTS_DIR}/summary.txt"
echo "Total files collected: $(wc -l < "${RESULTS_DIR}/file_list.txt")" >> "${RESULTS_DIR}/summary.txt"

# Archive results
tar -czf "${ARCHIVE_NAME}" -C "${RESULTS_DIR}" .
echo "Metrics collected and archived to ${ARCHIVE_NAME}"
