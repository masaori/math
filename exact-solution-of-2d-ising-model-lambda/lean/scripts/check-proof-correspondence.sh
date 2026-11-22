#!/usr/bin/env bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$project_dir"
mkdir -p lean/.lake/one-to-one
bash lean/scripts/extract-proof-dependencies.sh > /dev/null
node structured-latex/tools/trace-proof-dependencies.ts \
  lean/.lake/one-to-one/citations.json lean/.lake/one-to-one/direct-dependencies.tsv \
  > lean/.lake/one-to-one/traced.json
node structured-latex/tools/check-proof-correspondence.ts \
  lean/.lake/one-to-one/citations.json lean/.lake/one-to-one/traced.json \
  lean/one-to-one-dependency-ledger.tsv
