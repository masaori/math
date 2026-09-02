#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
source "$SCRIPT_DIR/audit-common.sh"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT
printf 'alpha\nbeta\nalpha\n' > "$TMP_DIR/values.txt"
printf '%s\n' \
  '| 章 | セクション | 状態 | 備考 |' \
  '|---|---|---|---|' \
  '| 閉形式 | 有限積 | 未着手 | 説明 |' \
  '| 閉形式 | 極限 | 未着手 | 説明 |' \
  '' > "$TMP_DIR/ledger.md"

zero="$(count_matches 'gamma' "$TMP_DIR/values.txt")"
two="$(count_matches 'alpha' "$TMP_DIR/values.txt")"
ledger_rows="$(count_remaining_ledger_rows "$TMP_DIR/ledger.md")"

[ "$zero" = "0" ] || { printf 'zero-match count was not one integer: %q\n' "$zero" >&2; exit 1; }
[ "$two" = "2" ] || { printf 'two-match count was not 2: %q\n' "$two" >&2; exit 1; }
[ "$ledger_rows" = "2" ] || { printf 'ledger row count was not 2: %q\n' "$ledger_rows" >&2; exit 1; }
case "$zero$two" in
  *$'\n'*) printf 'count contained a newline\n' >&2; exit 1 ;;
esac

printf 'OK: audit counts are single integers\n'
