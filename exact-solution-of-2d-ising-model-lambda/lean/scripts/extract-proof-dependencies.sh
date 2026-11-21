#!/usr/bin/env bash
set -euo pipefail
lean_dir="$(cd "$(dirname "$0")/.." && pwd)"
cd "$lean_dir"
mkdir -p .lake/one-to-one
lake env lean scripts/ProofDependencies.lean
LC_ALL=C sort -u .lake/one-to-one/direct-dependencies.unsorted.tsv > .lake/one-to-one/direct-dependencies.tsv
rm .lake/one-to-one/direct-dependencies.unsorted.tsv
printf '%s\n' "$lean_dir/.lake/one-to-one/direct-dependencies.tsv"
