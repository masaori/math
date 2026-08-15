#!/usr/bin/env bash
# 本プロジェクトの形式化した定理が sorry に依存していないことを確認する。
#
# 使い方:
#   cd countable-core-of-3d-ising/lean && bash scripts/check-no-sorry.sh
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
if [ -d Ising3DCut ]; then
  while IFS= read -r file; do
    module="$(printf '%s' "$file" | sed 's#/#.#g; s#\.lean$##')"
    grep -q "^import ${module}$" Ising3DCut.lean || orphans="${orphans}  ${file}
"
  done < <(find Ising3DCut -name '*.lean' | sort)
fi

if [ -n "$orphans" ]; then
  echo "NG: 入口 Ising3DCut.lean から import されていない .lean がある（ビルドも検査もされない）:" >&2
  printf '%s' "$orphans" >&2
  status=1
else
  echo "OK: すべての .lean が入口から import されている"
fi

# 1. ソース中に sorry / admit が残っていないか
if grep -rn --include='*.lean' -E '\bsorry\b|\badmit\b' Ising3DCut.lean Ising3DCut 2>/dev/null; then
  echo "NG: ソース中に sorry / admit が残っている" >&2
  status=1
else
  echo "OK: ソース中に sorry / admit は無い"
fi

# 2. 形式化した定理の依存公理に sorryAx が含まれていないか。
#    **形式化した定理を増やしたら、必ずこの配列へ追加する（追加漏れは検査の穴になる）。**
#    具体版・必要十分版・両者をつなぐ導出の 3 本を、いずれも登録する。
targets=(
  Ising3DCut.NullModel.edge_endpoints_parity_differ
  Ising3DCut.NecSuf.NullModel.endpoint_colors_differ_iff_not
  Ising3DCut.NullModel.edge_endpoints_parity_differ_from_necSuf
  Ising3DCut.NullModel.oddFlip_oddFlip
  Ising3DCut.NullModel.oddFlip_bijective
  Ising3DCut.NecSuf.NullModel.flipOn_flipOn
  Ising3DCut.NecSuf.NullModel.flipOn_bijective
  Ising3DCut.NullModel.oddFlip_oddFlip_from_necSuf
  Ising3DCut.NullModel.oddFlip_bijective_from_necSuf
  Ising3DCut.NullModel.oddFlip_reverses_edge
  Ising3DCut.NecSuf.NullModel.flipOn_reverses_edge
  Ising3DCut.NullModel.oddFlip_reverses_edge_from_necSuf
  Ising3DCut.NullModel.brokenCount_oddFlip
  Ising3DCut.NecSuf.NullModel.card_filter_of_iff_not
  Ising3DCut.NullModel.brokenCount_oddFlip_from_necSuf
  Ising3DCut.NullModel.multiplicity_palindrome
  Ising3DCut.NullModel.partitionPolynomial_value_at_one
  Ising3DCut.NecSuf.NullModel.levelPolynomial_value_at_one
  Ising3DCut.NullModel.partitionPolynomial_value_at_one_from_necSuf
  Ising3DCut.NullModel.partitionPolynomial_coeff_nonnegative
  Ising3DCut.NecSuf.NullModel.levelPolynomial_coeff_nonnegative
  Ising3DCut.NullModel.partitionPolynomial_coeff_nonnegative_from_necSuf
  Ising3DCut.NullModel.partitionPolynomial_support_endpoints
  Ising3DCut.NecSuf.NullModel.levelPolynomial_support_endpoints
  Ising3DCut.NullModel.partitionPolynomial_support_endpoints_from_necSuf
  Ising3DCut.NullModel.multiplicity_even
  Ising3DCut.NecSuf.NullModel.card_eq_two_mul_of_fixedPointFree_involution
  Ising3DCut.NullModel.multiplicity_even_from_necSuf
  Ising3DCut.NullModel.galoisGroup_embeds_in_pairPermutations
  Ising3DCut.NecSuf.NullModel.embeds_in_pairPermutations
  Ising3DCut.NullModel.galoisGroup_embeds_in_pairPermutations_from_necSuf
  Ising3DCut.NullModel.rationalPolynomial_eq_of_primeExponentData_eq
  Ising3DCut.NecSuf.NullModel.eq_of_injective_data_at_too_many_points
  Ising3DCut.NullModel.rationalPolynomial_eq_of_primeExponentData_eq_from_necSuf
  Ising3DCut.NullModel.same_partition_different_pairData
  Ising3DCut.NecSuf.NullModel.same_partition_different_pairData
  Ising3DCut.NullModel.same_partition_different_pairData_from_necSuf
  Ising3DCut.NullModel.splittingDegree_galoisGroup_do_not_determine_polynomial
  Ising3DCut.NecSuf.NullModel.splittingDegree_galoisGroup_do_not_determine_polynomial
  Ising3DCut.NullModel.splittingDegree_galoisGroup_do_not_determine_polynomial_from_necSuf
  Ising3DCut.NullModel.discriminant_does_not_determine_polynomial
  Ising3DCut.NecSuf.NullModel.discriminant_does_not_determine_object
  Ising3DCut.NullModel.discriminant_does_not_determine_polynomial_from_necSuf
  Ising3DCut.NullModel.factorizationType_determines_rootMinimalPolynomialDegrees
  Ising3DCut.NullModel.minpoly_natDegree_eq_of_irreducible_monic
  Ising3DCut.NullModel.irreducible_rootSet_card_eq_natDegree
  Ising3DCut.NullModel.irreducible_rootMultiplicity_le_one
  Ising3DCut.NullModel.irreducible_rootMultiplicity_pow_eq_exponent
  Ising3DCut.NullModel.irreducible_monic_eq_of_common_root
  Ising3DCut.NullModel.irreducibleFactorizationType_determines_rootMinimalPolynomialDegrees
  Ising3DCut.NecSuf.NullModel.card_fiber_complement
  Ising3DCut.NullModel.multiplicity_palindrome_from_necSuf
  Ising3DCut.NullModel.one_le_periodicMultiplicity_zero
  Ising3DCut.NecSuf.NullModel.one_le_card_fiber
  Ising3DCut.NullModel.one_le_periodicMultiplicity_zero_from_necSuf
  Ising3DCut.NullModel.periodicMultiplicity_full_eq_zero
  Ising3DCut.NecSuf.NullModel.no_odd_cycle_all_opposite
  Ising3DCut.NullModel.periodicMultiplicity_full_eq_zero_from_necSuf
  Ising3DCut.NullModel.periodicMultiplicity_not_palindrome
  Ising3DCut.NecSuf.NullModel.ne_of_one_le_of_eq_zero
  Ising3DCut.NullModel.periodicMultiplicity_not_palindrome_from_necSuf
  Ising3DCut.StructuralCore.multiplicity_palindrome
  Ising3DCut.NecSuf.StructuralCore.multiplicity_palindrome
  Ising3DCut.StructuralCore.multiplicity_palindrome_from_necSuf
)

if [ "${#targets[@]}" -eq 0 ]; then
  echo "OK: 登録された定理は 0 件（まだ形式化していない）"
  # まだ 1 本も形式化していない段階では、定理の検査対象が無いことは異常ではない。
  # ただし本文に主張があるのに 0 件のままなら、それは登録漏れである。台帳で status を偽らないこと。
  exit "$status"
fi

check_file="$(mktemp -t ising3dcut-no-sorry).lean"
{
  echo "import Ising3DCut"
  for t in "${targets[@]}"; do
    echo "#print axioms $t"
  done
} > "$check_file"

output="$(lake env lean "$check_file" 2>&1)" || {
  echo "NG: 依存公理の確認に失敗した" >&2
  printf '%s\n' "$output" >&2
  rm -f "$check_file"
  exit 1
}
rm -f "$check_file"

printf '%s\n' "$output"
if printf '%s\n' "$output" | grep -q 'sorryAx'; then
  echo "NG: sorryAx への依存がある" >&2
  status=1
else
  echo "OK: 登録された ${#targets[@]} 件はいずれも sorryAx に依存していない"
fi

exit "$status"
