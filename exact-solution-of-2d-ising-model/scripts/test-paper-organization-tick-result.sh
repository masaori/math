#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
VERIFY="$SCRIPT_DIR/verify-paper-organization-tick-result.sh"
TEST_DIR="$(mktemp -d)"
trap 'rm -f "$TEST_DIR/stop.log" "$TEST_DIR/invalid.log" "$TEST_DIR/valid.log" "$TEST_DIR/duplicate.log"; rmdir "$TEST_DIR"' EXIT

prefix='TICK_RESULT_SUCCESS:run-123:'
commit='0123456789abcdef0123456789abcdef01234567'

printf '停止報告です。npm exit 254\n' > "$TEST_DIR/stop.log"
if "$VERIFY" "$TEST_DIR/stop.log" "$prefix" >/dev/null 2>&1; then
  printf '停止報告を成功と判定した\n' >&2
  exit 1
fi

printf '%s%s\n' "$prefix" 'not-a-commit' > "$TEST_DIR/invalid.log"
if "$VERIFY" "$TEST_DIR/invalid.log" "$prefix" >/dev/null 2>&1; then
  printf '不正な成果コミットを成功と判定した\n' >&2
  exit 1
fi

printf '作業完了\n%s%s\n' "$prefix" "$commit" > "$TEST_DIR/valid.log"
test "$("$VERIFY" "$TEST_DIR/valid.log" "$prefix")" = "$commit"

printf '%s%s\n%s%s\n' "$prefix" "$commit" "$prefix" "$commit" > "$TEST_DIR/duplicate.log"
if "$VERIFY" "$TEST_DIR/duplicate.log" "$prefix" >/dev/null 2>&1; then
  printf '重複成功マーカーを成功と判定した\n' >&2
  exit 1
fi

printf 'tick結果判定の回帰テスト成功\n'
