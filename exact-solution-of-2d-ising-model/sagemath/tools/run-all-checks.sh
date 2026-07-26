#!/usr/bin/env bash
# sagemath/check/ 配下の全 check を実行し、各 check ディレクトリの logs/ へ出力を保存する。
#
# 使い方:
#   bash sagemath/tools/run-all-checks.sh            # 全部
#   bash sagemath/tools/run-all-checks.sh 017 220    # ディレクトリ名に 017 or 220 を含むものだけ
#
# 終了コード: 1 つでも失敗したら 1。

set -u

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
project_root="$(cd "${here}/../.." && pwd)"
check_root="${project_root}/sagemath/check"

if ! command -v sage >/dev/null 2>&1; then
  echo "sage が PATH に無い" >&2
  exit 1
fi

filters=("$@")

matches_filter() {
  local name="$1"
  if [ "${#filters[@]}" -eq 0 ]; then return 0; fi
  local f
  for f in "${filters[@]}"; do
    case "$name" in *"$f"*) return 0 ;; esac
  done
  return 1
}

total=0
failed=0
failed_list=()

for dir in "${check_root}"/*/; do
  name="$(basename "$dir")"
  matches_filter "$name" || continue

  shopt -s nullglob
  scripts=("${dir}"check_*.sage "${dir}"check_*.py)
  shopt -u nullglob
  [ "${#scripts[@]}" -eq 0 ] && continue

  mkdir -p "${dir}logs"

  for script in "${scripts[@]}"; do
    base="$(basename "$script")"
    # .sage.py は SageMath が生成する中間ファイルなので実行対象から外す
    case "$base" in *.sage.py) continue ;; esac

    log="${dir}logs/${base}.log"
    total=$((total + 1))
    printf '[run] %s/%s ... ' "$name" "$base"
    if sage "$script" >"$log" 2>&1; then
      printf 'PASS\n'
    else
      printf 'FAIL (see %s)\n' "${log#${project_root}/}"
      failed=$((failed + 1))
      failed_list+=("${name}/${base}")
    fi
  done
done

echo
echo "ran ${total} check script(s), ${failed} failed"
if [ "$failed" -ne 0 ]; then
  for f in "${failed_list[@]}"; do echo "  - $f"; done
  exit 1
fi
