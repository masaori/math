#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
VERIFY="$SCRIPT_DIR/verify-paper-organization-tick-result.sh"
TICK="$SCRIPT_DIR/paper-organization-tick.sh"
TIMEOUT_DISPOSITION="$SCRIPT_DIR/paper-organization-timeout-disposition.sh"
HAS_PENDING_WORK="$SCRIPT_DIR/paper-organization-has-pending-work.sh"
TEST_DIR="$(mktemp -d)"
PENDING_REPO="$TEST_DIR/pending-repo"
trap 'rm -rf "$PENDING_REPO"; rm -f "$TEST_DIR/stop.log" "$TEST_DIR/invalid.log" "$TEST_DIR/valid.log" "$TEST_DIR/duplicate.log" "$TEST_DIR/different.log" "$TEST_DIR/mixed-invalid.log"; rmdir "$TEST_DIR"' EXIT

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
test "$("$VERIFY" "$TEST_DIR/duplicate.log" "$prefix")" = "$commit"

different_commit='89abcdef0123456789abcdef0123456789abcdef'
printf '%s%s\n%s%s\n' "$prefix" "$commit" "$prefix" "$different_commit" > "$TEST_DIR/different.log"
if "$VERIFY" "$TEST_DIR/different.log" "$prefix" >/dev/null 2>&1; then
  printf '異なる成果コミットを一意の成功と判定した\n' >&2
  exit 1
fi

printf '%s%s\n%s%s\n' "$prefix" "$commit" "$prefix" 'not-a-commit' > "$TEST_DIR/mixed-invalid.log"
if "$VERIFY" "$TEST_DIR/mixed-invalid.log" "$prefix" >/dev/null 2>&1; then
  printf '正当なマーカーと混在した不正マーカーを無視した\n' >&2
  exit 1
fi

if grep -Eq 'gh[[:space:]]+pr|gh[[:space:]]+auth' "$TICK"; then
  printf 'tmux外tickへGitHub CLI操作が混入している\n' >&2
  exit 1
fi
grep -Fq "git push origin HEAD:\$default_branch" "$TICK"
grep -Fq 'continuation_mode=1' "$TICK"
grep -Fq '既存棚卸し項目を最大二項だけ扱う' "$TICK"
grep -Fq 'CHECKPOINT: 有限上限までの成果をworktreeへ保持し、次回は継続モードで完了工程だけを行う' "$TICK"
test "$("$TIMEOUT_DISPOSITION" 124 1)" = checkpoint
test "$("$TIMEOUT_DISPOSITION" 137 1)" = checkpoint
test "$("$TIMEOUT_DISPOSITION" 124 0)" = timeout
test "$("$TIMEOUT_DISPOSITION" 137 0)" = timeout
test "$("$TIMEOUT_DISPOSITION" 1 1)" = continue
test "$("$TIMEOUT_DISPOSITION" 0 0)" = continue

git init -q "$PENDING_REPO"
git -C "$PENDING_REPO" config user.name tick-test
git -C "$PENDING_REPO" config user.email tick-test@example.invalid
printf 'base\n' > "$PENDING_REPO/tracked.txt"
git -C "$PENDING_REPO" add tracked.txt
git -C "$PENDING_REPO" commit -qm base
git -C "$PENDING_REPO" update-ref refs/remotes/origin/main HEAD
if "$HAS_PENDING_WORK" "$PENDING_REPO" origin/main; then
  printf 'remote default一致のclean worktreeを前回成果ありと判定した\n' >&2
  exit 1
fi
printf 'dirty\n' >> "$PENDING_REPO/tracked.txt"
"$HAS_PENDING_WORK" "$PENDING_REPO" origin/main
git -C "$PENDING_REPO" checkout -- tracked.txt
printf 'ahead\n' >> "$PENDING_REPO/tracked.txt"
git -C "$PENDING_REPO" commit -qam ahead
"$HAS_PENDING_WORK" "$PENDING_REPO" origin/main

printf 'tick結果判定の回帰テスト成功\n'
