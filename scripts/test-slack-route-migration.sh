#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
TARGETS=(
  "cellular-automata-statistical-mechanics/scripts/publish-artifact.sh"
  "countable-core-of-3d-ising/scripts/auto-loop-tick.sh"
  "exact-solution-of-2d-ising-model-lambda/scripts/audit-light.sh"
  "exact-solution-of-2d-ising-model-lambda/scripts/audit-loop.sh"
  "exact-solution-of-2d-ising-model-lambda/scripts/auto-loop-tick.sh"
)

for relative in "${TARGETS[@]}"; do
  file="$ROOT/$relative"
  bash -n "$file"
  if ! grep -Fq 'slack route-post math' "$file"; then
    printf 'Hex-AIのmath明示routeを使っていない: %s\n' "$relative" >&2
    exit 1
  fi
done

if ! grep -Fq 'PATH="$HOME/.agent-shims:' \
  "$ROOT/countable-core-of-3d-ising/scripts/auto-loop-tick.sh"; then
  printf '3次元Ising tickの非対話PATHからSlack shimが欠落している\n' >&2
  exit 1
fi

if rg -n 'hooks[.]slack[.]com/(triggers|workflows)' \
  "$ROOT/cellular-automata-statistical-mechanics/scripts" \
  "$ROOT/countable-core-of-3d-ising/scripts" \
  "$ROOT/exact-solution-of-2d-ising-model-lambda/scripts"; then
  printf '旧Slack Workflow trigger参照が実行可能なスクリプトに残っている\n' >&2
  exit 1
fi

printf 'mathのSlack通知はHex-AIの明示routeだけを使っています。\n'
