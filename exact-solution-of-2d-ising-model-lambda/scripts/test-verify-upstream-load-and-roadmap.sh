#!/usr/bin/env bash
# 構成／assertion の分離の検査そのものが、壊れた形を本当に見つけられるかを確かめる。
#
# 2026-09-05 に起きた事故の回帰試験である。下流の検算が上流の check.sage を読んでいたため、
# 一本の検算を走らせるだけで先行 36 本の assertion が再実行され、自動ループの tick が
# 2700 秒の上限で打ち切られた（終了コード 124）。分離を戻してしまったときに気づけるよう、
# 検査器へ壊れた入力を渡して「NG を出すこと」を確かめる。
#
#   bash scripts/test-verify-upstream-load-and-roadmap.sh
set -uo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
TOOL="$PROJECT_DIR/sagemath/tools/verify-construction-separation.py"

work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT

failures=0
expect() {
  local want="$1" name="$2"; shift 2
  local output status
  output="$(python3 "$TOOL" "$@" 2>&1)"; status=$?
  if [ "$status" -eq "$want" ]; then
    printf '✓ %s\n' "$name"
  else
    printf '✗ %s（終了コード %d、期待 %d）\n%s\n' "$name" "$status" "$want" "$output"
    failures=$((failures + 1))
  fi
}

make_case() {
  local root="$work/$1"; shift
  mkdir -p "$root/sagemath/check/upstream" "$root/sagemath/check/downstream"
  printf '%s\n' 'VALUE = 1' > "$root/sagemath/check/upstream/construction.sage"
  printf '%s\n' 'load("sagemath/check/upstream/construction.sage")' 'assert VALUE == 1' \
    > "$root/sagemath/check/upstream/check.sage"
  printf '%s\n' 'load("sagemath/check/upstream/construction.sage")' 'assert VALUE == 1' \
    > "$root/sagemath/check/downstream/check.sage"
  echo "$root"
}

# 正しい形は通る。
root="$(make_case ok)"
expect 0 "構成だけを読む形は通る" "$root" "sagemath/check/downstream/check.sage"

# 上流の検算そのものを読むと落ちる（これが事故の形）。
root="$(make_case reads_upstream_check)"
printf '%s\n' 'load("sagemath/check/upstream/check.sage")' 'assert VALUE == 1' \
  > "$root/sagemath/check/downstream/check.sage"
expect 1 "上流の check.sage を読むと落ちる" "$root" "sagemath/check/downstream/check.sage"

# 構成に assertion が残っていると落ちる。
root="$(make_case assert_in_construction)"
printf '%s\n' 'VALUE = 1' 'assert VALUE == 1' > "$root/sagemath/check/upstream/construction.sage"
expect 1 "構成に assertion が残っていると落ちる" "$root" "sagemath/check/downstream/check.sage"

# 構成に観測の出力が残っていると落ちる。
root="$(make_case print_in_construction)"
printf '%s\n' 'VALUE = 1' 'print("PASS")' > "$root/sagemath/check/upstream/construction.sage"
expect 1 "構成に観測の出力が残っていると落ちる" "$root" "sagemath/check/downstream/check.sage"

# 構成に対応する check.sage を消すと落ちる（assertion の握り潰し）。
root="$(make_case check_removed)"
rm "$root/sagemath/check/upstream/check.sage"
expect 1 "上流の check.sage を消すと落ちる" "$root" "sagemath/check/downstream/check.sage"

# 上流の check.sage が自分の構成を読んでいないと落ちる。
root="$(make_case check_ignores_own_construction)"
printf '%s\n' 'VALUE = 1' 'assert VALUE == 1' > "$root/sagemath/check/upstream/check.sage"
expect 1 "上流の check.sage が自分の構成を読まないと落ちる" "$root" "sagemath/check/downstream/check.sage"

# 関数の中の assert は構成に残してよい（well-defined 性の番人）。
root="$(make_case assert_inside_function)"
printf '%s\n' 'def guarded(value):' '    assert value == 1' '    return value' 'VALUE = 1' \
  > "$root/sagemath/check/upstream/construction.sage"
expect 0 "関数の中の assert は構成に残してよい" "$root" "sagemath/check/downstream/check.sage"

if [ "$failures" -eq 0 ]; then
  echo "PASS: 検査器は壊れた形を全て検出する"
  exit 0
fi
echo "FAIL: $failures 件"
exit 1
