#!/usr/bin/env bash
# 本プロジェクトの主要定理が sorry に依存していないことを確認する。
#
# 使い方:
#   cd exact-solution-of-2d-ising-model-lambda/lean && bash scripts/check-no-sorry.sh
#
# 終了コード 0 = すべて sorry 非依存。1 = sorryAx への依存またはソース中の sorry を検出。
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

# 1. ソース中に sorry / admit が残っていないか
if grep -rn --include='*.lean' -E '\bsorry\b|\badmit\b' Ising2DLambda.lean Ising2DLambda/; then
  echo "NG: ソース中に sorry / admit が残っている" >&2
  status=1
else
  echo "OK: ソース中に sorry / admit は無い"
fi

# 2. 主要定理の依存公理に sorryAx が含まれていないか
#    形式化した定理を増やしたら、必ずこの配列へ追加する（追加漏れは検査の穴になる）。
targets=(
  Ising2DLambda.PartitionPolynomial.multiplicity_sum_eq_two_pow
  Ising2DLambda.PartitionPolynomial.multiplicity_sum_eq_two_pow_from_necSuf
  Ising2DLambda.NecSuf.PartitionPolynomial.sum_card_fiber_eq_card
  Ising2DLambda.PartitionPolynomial.partitionPolynomial_eq_sum_multiplicity
  Ising2DLambda.PartitionPolynomial.partitionPolynomial_eq_sum_multiplicity_from_necSuf
  Ising2DLambda.NecSuf.PartitionPolynomial.sum_comp_eq_sum_nsmul
  Ising2DLambda.FreeEntropy.rationalExponent_well_defined
  Ising2DLambda.FreeEntropy.rationalExponent_well_defined_from_necSuf
  Ising2DLambda.NecSuf.FreeEntropy.sub_eq_sub_of_mul_eq_mul
  Ising2DLambda.FreeEntropy.partitionPolynomial_eval_pos
  Ising2DLambda.FreeEntropy.partitionPolynomial_eval_pos_from_necSuf
  Ising2DLambda.NecSuf.FreeEntropy.sum_pow_pos
)

if [ ${#targets[@]} -eq 0 ]; then
  echo "注意: 検査対象の定理がまだ 1 つも登録されていない（形式化は未着手）"
  exit "$status"
fi

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
{
  echo "import Ising2DLambda"
  for target in "${targets[@]}"; do
    echo "#print axioms $target"
  done
} > "$tmp/CheckAxioms.lean"

if lake env lean "$tmp/CheckAxioms.lean" | tee "$tmp/out.txt" | grep -q "sorryAx"; then
  echo "NG: sorryAx に依存している定理がある" >&2
  grep -n "sorryAx" "$tmp/out.txt" >&2 || true
  status=1
else
  echo "OK: 登録された ${#targets[@]} 件の定理はいずれも sorryAx に依存していない"
fi

exit "$status"
