#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT
LOG_FILE="$TMP_DIR/auto-loop.log"

for generation in 1 2 3 4; do
  printf '2026-08-30 0%s:05:00 === tick 開始\n研究出力-%s\n2026-08-30 0%s:17:00 === tick 正常終了\n' \
    "$generation" "$generation" "$generation" > "$LOG_FILE"
  bash "$SCRIPT_DIR/rotate-auto-loop-log.sh" "$LOG_FILE" 1 3
  sleep 1
done

[ "$(find "$TMP_DIR" -name 'auto-loop.*.log.gz' | wc -l | tr -d ' ')" = 3 ]
for archive in "$TMP_DIR"/auto-loop.*.log.gz; do gzip -t "$archive"; done
gzip -cd "$TMP_DIR"/auto-loop.*.log.gz | grep -q '研究出力-4'
grep -q '=== tick 正常終了' "$TMP_DIR/auto-loop-status.log"

printf 'threshold-not-reached\n' > "$LOG_FILE"
bash "$SCRIPT_DIR/rotate-auto-loop-log.sh" "$LOG_FILE" 1048576 3
[ -f "$LOG_FILE" ]
[ "$(cat "$LOG_FILE")" = 'threshold-not-reached' ]

printf 'OK: rotation, gzip integrity, finite retention, status index, threshold\n'

