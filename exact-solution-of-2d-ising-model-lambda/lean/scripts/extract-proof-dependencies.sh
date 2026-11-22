#!/usr/bin/env bash
set -euo pipefail
lean_dir="$(cd "$(dirname "$0")/.." && pwd)"
cd "$lean_dir"
mkdir -p .lake/one-to-one
node ../structured-latex/tools/extract-proof-citations.ts > .lake/one-to-one/citations.json
node -e 'const fs = require("node:fs"); const entries = JSON.parse(fs.readFileSync(process.argv[1], "utf8")); for (const name of new Set(entries.flatMap((entry) => entry.concrete))) console.log(name);' \
  .lake/one-to-one/citations.json > .lake/one-to-one/concrete-names.txt
lake env lean scripts/ProofDependencies.lean
LC_ALL=C sort -u .lake/one-to-one/direct-dependencies.unsorted.tsv > .lake/one-to-one/direct-dependencies.tsv
rm .lake/one-to-one/direct-dependencies.unsorted.tsv
printf '%s\n' "$lean_dir/.lake/one-to-one/direct-dependencies.tsv"
