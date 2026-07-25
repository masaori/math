#!/usr/bin/env bash
# 本プロジェクトの主要定理が sorry に依存していないことを確認する。
#
# 使い方:
#   cd exact-solution-of-2d-ising-model/lean && ./scripts/check-no-sorry.sh
#
# 終了コード 0 = すべて sorry 非依存。1 = sorryAx への依存またはソース中の sorry を検出。
set -euo pipefail

cd "$(dirname "$0")/.."

# lake は elan 経由で入るため、非対話シェルの PATH に無いことがある。
# PATH に無ければ elan の既定インストール先を探す。
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
if grep -rn --include='*.lean' -E '\bsorry\b|\badmit\b' Ising2D.lean Ising2D/; then
  echo "NG: ソース中に sorry / admit が残っている" >&2
  status=1
else
  echo "OK: ソース中に sorry / admit は無い"
fi

# 2. 主要定理の依存公理に sorryAx が含まれていないか
targets=(
  Ising2D.tensorPowBasis
  Ising2D.matTensorPowBasis
  Ising2D.tensorPowAlgEquiv
  Ising2D.toFinPowAlgEquiv
  Ising2D.E_mul_E
  Ising2D.one_eq_sum_E
  Ising2D.scalar_identity_commutes
  Ising2D.centralizer_is_scalar
  Ising2D.centralizer_is_scalar_abstract
  Ising2D.matExp_units_conj
  Ising2D.Conjugation.T_mul
  Ising2D.Conjugation.T_one
  Ising2D.Conjugation.T_add
  Ising2D.Conjugation.T_comp
  Ising2D.Conjugation.TMonoidHom
  Ising2D.Conjugation.matrix_conj_mul
  Ising2D.Conjugation.matrix_conj_one
  Ising2D.Conjugation.matrix_conj_comp
)

{
  echo "import Ising2D"
  for t in "${targets[@]}"; do
    echo "#print axioms $t"
  done
} > /tmp/ising2d_axiom_check.lean

out="$(lake env lean --stdin < /tmp/ising2d_axiom_check.lean)"
echo "$out"

if echo "$out" | grep -q 'sorryAx'; then
  echo "NG: sorryAx に依存している定理がある" >&2
  status=1
else
  echo "OK: 主要定理はいずれも sorryAx に依存していない"
fi

exit "$status"
