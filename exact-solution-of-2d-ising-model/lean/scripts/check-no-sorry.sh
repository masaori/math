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
  Ising2D.commutator_via_anticommutators
  Ising2D.lie_mul_eq_acomm_sub_acomm
  Ising2D.matrix_commutator_via_anticommutators
  Ising2D.sum_smul_mul_sum_smul
  Ising2D.acomm_sum_smul_left
  Ising2D.acomm_sum_smul
  Ising2D.siteOp_one
  Ising2D.siteOp_mul_same
  Ising2D.siteOp_mul_comm
  Ising2D.sigmaX_eq
  Ising2D.jw_eq_xString_mul
  Ising2D.Z_eq_xString_mul
  Ising2D.Y_eq_xString_mul
  Ising2D.xString_mul_self
  Ising2D.jw_mul_jw_same
  Ising2D.Z_mul_Y_same
  Ising2D.xString_succ_eq
  Ising2D.siteProd_smul_family
  Ising2D.siteProd_anticomm_of_single_site
  Ising2D.jw_sq
  Ising2D.jw_anticomm
  Ising2D.anticomm_Z_Z
  Ising2D.anticomm_Z_Y
  Ising2D.anticomm_Y_Y
  Ising2D.matrix_two_decomp
  Ising2D.siteProd_mem
  Ising2D.E_eq_siteProd
  Ising2D.Z_Y_generate_algebra
  Ising2D.acomm_ZY
  Ising2D.linearIndependent_of_clifford
  Ising2D.ZY_linearIndependent
  Ising2D.ZY_injective
  Ising2D.ZYSet_eq_range
  Ising2D.ZYSet_linearIndepOn
  Ising2D.expPhase_add
  Ising2D.expPhase_neg
  Ising2D.expPhase_natCast_mul
  Ising2D.expPhase_eq_zpow
  Ising2D.expPhase_eq_one_iff
  Ising2D.expPhase_sum
  Ising2D.dvd_sub_iff_eq
  Ising2D.hatZMinus_eq
  Ising2D.hatZPlus_eq_hatZMinus_sub
  Ising2D.expPhase_add_mul_natCast
  Ising2D.hatZ_periodic
  Ising2D.hatY_periodic
  Ising2D.hatZMinus_M_eq_neg_M
  Ising2D.hatY_M_eq_neg_M
  Ising2D.inverse_dft
  Ising2D.recover_Y
  Ising2D.recover_Z
  Ising2D.Y_eq_inverse_dft
  Ising2D.Z_eq_inverse_dft
  Ising2D.acomm_sum_smul_clifford
  Ising2D.acomm_sum_smul_zero
  Ising2D.acomm_Z_Z_clifford
  Ising2D.acomm_Y_Y_clifford
  Ising2D.expPhase_site_mul
  Ising2D.acomm_hatZ_hatZ_same
  Ising2D.acomm_hatZ_hatZ_opp
  Ising2D.acomm_hatZ_hatY
  Ising2D.acomm_hatY_hatZ
  Ising2D.acomm_hatY_hatY
  Ising2D.acomm_hatZPlus_hatZPlus
  Ising2D.acomm_hatZMinus_hatZMinus
  Ising2D.acomm_hatZPlus_hatZMinus
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
