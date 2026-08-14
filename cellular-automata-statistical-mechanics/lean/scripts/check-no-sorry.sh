#!/usr/bin/env bash
# 本プロジェクトの形式化した定理が sorry に依存していないことを確認する。
#
# 使い方:
#   cd cellular-automata-statistical-mechanics/lean && bash scripts/check-no-sorry.sh
#
# 終了コード 0 = すべて sorry 非依存。1 = sorryAx への依存、ソース中の sorry、
# または入口から import されていない .lean を検出。
set -euo pipefail

cd "$(dirname "$0")/.."

# lake は elan 経由で入るため、非対話シェルの PATH に無いことがある。
if ! command -v lake >/dev/null 2>&1; then
  if [ -x "$HOME/.elan/bin/lake" ]; then
    PATH="$HOME/.elan/bin:$PATH"
    export PATH
  else
    echo "NG: lake が見つからない（elan を導入し PATH を通すこと）" >&2
    exit 1
  fi
fi

status=0

# 0. どの .lean も入口から import されていること。
#    **import されていないファイルはビルドも検査もされない。**
orphans=""
if [ -d CellularAutomata ]; then
  while IFS= read -r file; do
    module="$(printf '%s' "$file" | sed 's#/#.#g; s#\.lean$##')"
    grep -q "^import ${module}$" CellularAutomata.lean || orphans="${orphans}  ${file}
"
  done < <(find CellularAutomata -name '*.lean' | sort)
fi

if [ -n "$orphans" ]; then
  echo "NG: 入口 CellularAutomata.lean から import されていない .lean がある（ビルドも検査もされない）:" >&2
  printf '%s' "$orphans" >&2
  status=1
else
  echo "OK: すべての .lean が入口から import されている"
fi

# 1. ソース中に sorry / admit が残っていないか
if grep -rn --include='*.lean' -E '\bsorry\b|\badmit\b' CellularAutomata.lean CellularAutomata 2>/dev/null; then
  echo "NG: ソース中に sorry / admit が残っている" >&2
  status=1
else
  echo "OK: ソース中に sorry / admit は無い"
fi

# 2. 形式化した定理の依存公理に sorryAx が含まれていないか。
#    **形式化した定理を増やしたら、必ずこの配列へ追加する（追加漏れは検査の穴になる）。**
targets=(
  CellularAutomata.EssentialDependency.ne_iff_eq_nu
  CellularAutomata.EssentialDependency.essentialDep_iff_flip
  CellularAutomata.EssentialDependency.mem_supp_iff
  CellularAutomata.EssentialDependency.card_scan_pairs
  CellularAutomata.EssentialDependency.essentialDep_iff_flip_from_necessary_sufficient
  CellularAutomata.EssentialDependency.card_scan_pairs_from_necessary_sufficient
  CellularAutomata.NecSuf.EssentialDependency.essentialDep_iff_flip
  CellularAutomata.NecSuf.EssentialDependency.card_scan_pairs
  CellularAutomata.RedundantNeighbor.restrict_baseExtend
  CellularAutomata.RedundantNeighbor.no_essentialDep_on_added_element
  CellularAutomata.RedundantNeighbor.essentialDep_transfer
  CellularAutomata.RedundantNeighbor.supp_extendRule
)

tmpfile="$(mktemp /tmp/check-axioms-XXXXXX.lean)"
trap 'rm -f "$tmpfile"' EXIT

{
  echo "import CellularAutomata"
  for t in "${targets[@]}"; do
    echo "#print axioms $t"
  done
} > "$tmpfile"

output="$(lake env lean "$tmpfile" 2>&1)" || {
  echo "NG: 公理検査用ファイルの実行に失敗した" >&2
  printf '%s\n' "$output" >&2
  exit 1
}

printf '%s\n' "$output"

if printf '%s' "$output" | grep -q "sorryAx"; then
  echo "NG: sorryAx に依存する定理がある" >&2
  status=1
else
  echo "OK: 登録した定理はいずれも sorryAx に依存しない"
fi

exit $status
