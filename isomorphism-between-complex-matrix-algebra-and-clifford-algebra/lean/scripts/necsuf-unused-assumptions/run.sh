#!/usr/bin/env bash
# 必要十分版の仮定のうち、証明で使わないものを主張ごとに並べる（lean/ で lake build の後に打つ）。
# 一覧は lean/.lake/necsuf-unused-assumptions/report.tsv に書く。
set -euo pipefail
cd "$(dirname "$0")/../.."
if ! command -v lake >/dev/null 2>&1 && [ -x "$HOME/.elan/bin/lake" ]; then PATH="$HOME/.elan/bin:$PATH"; fi
lake env lean scripts/necsuf-unused-assumptions/Audit.lean
node scripts/necsuf-unused-assumptions/aggregate.ts .
