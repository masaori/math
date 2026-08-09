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

# 0. どの .lean も入口から import されていること。
#    **import されていないファイルはビルドも検査もされない。** 実測: 型エラーで壊れた下書きが
#    import されないまま置かれ、lake build も sorry 検査も通ってしまった
#    （壊れた宣言は字面に sorry が無くても sorryAx を使う）。
orphans=""
while IFS= read -r file; do
  module="$(printf '%s' "$file" | sed 's#/#.#g; s#\.lean$##')"
  grep -q "^import ${module}$" Ising2DLambda.lean || orphans="${orphans}  ${file}
"
done < <(find Ising2DLambda -name '*.lean' | sort)

if [ -n "$orphans" ]; then
  echo "NG: 入口 Ising2DLambda.lean から import されていない .lean がある（ビルドも検査もされない）:" >&2
  printf '%s' "$orphans" >&2
  status=1
else
  echo "OK: すべての .lean が入口から import されている"
fi

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
  Ising2DLambda.FreeEntropy.logRat_mul
  Ising2DLambda.FreeEntropy.logRat_mul_from_necSuf
  Ising2DLambda.NecSuf.FreeEntropy.sub_add_sub_of_mul
  Ising2DLambda.FreeEntropy.logRat_pow
  Ising2DLambda.FreeEntropy.logRat_pow_from_necSuf
  Ising2DLambda.NecSuf.FreeEntropy.map_pow_eq_nsmul
  Ising2DLambda.FreeEntropy.partitionPolynomial_eval_one
  Ising2DLambda.FreeEntropy.freeEntropy_at_one
  Ising2DLambda.TransferMatrix.card_rowConfig
  Ising2DLambda.TransferMatrix.edgeOfSum_injective
  Ising2DLambda.TransferMatrix.edgeOfRow_boundary0
  Ising2DLambda.TransferMatrix.edgeOfRow_boundary1_horizontal
  Ising2DLambda.TransferMatrix.edgeOfRow_boundary1_vertical
  Ising2DLambda.TransferMatrix.brokenBondCount_eq_row_decomposition
  Ising2DLambda.TransferMatrix.brokenBondCount_eq_row_decomposition_from_necSuf
  Ising2DLambda.NecSuf.TransferMatrix.card_filter_eq_sum_add_sum
  Ising2DLambda.TransferMatrix.card_rowFamily
  Ising2DLambda.TransferMatrix.configOfRows_rowsOf
  Ising2DLambda.TransferMatrix.rowsOf_configOfRows
  Ising2DLambda.TransferMatrix.transfer_weight_product
  Ising2DLambda.TransferMatrix.transfer_weight_product_from_necSuf
  Ising2DLambda.NecSuf.TransferMatrix.prod_pow_add_eq_pow
  Ising2DLambda.TransferMatrix.rowWalksBetween_one
  Ising2DLambda.TransferMatrix.walkWeight_extendWalk
  Ising2DLambda.TransferMatrix.rowMatrixPow_apply
  Ising2DLambda.TransferMatrix.rowMatrixPow_apply_from_necSuf
  Ising2DLambda.NecSuf.TransferMatrix.matPow_apply_eq_sum_walkWeight
  Ising2DLambda.TransferMatrix.familyOfWalk_walkOfFamily
  Ising2DLambda.TransferMatrix.walkOfFamily_familyOfWalk
  Ising2DLambda.TransferMatrix.sum_closedRowWalks_eq_sum_between
  Ising2DLambda.TransferMatrix.walkWeight_walkOfFamily_rowsOf
  Ising2DLambda.TransferMatrix.partitionPolynomial_eq_trace
  Ising2DLambda.TransferMatrix.partitionPolynomial_eq_trace_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.spinIndex_injective
  Ising2DLambda.AlgebraicEigenvalue.rowConfigLess_trichotomy
  Ising2DLambda.AlgebraicEigenvalue.rowConfigLess_trans
  Ising2DLambda.AlgebraicEigenvalue.rowConfigLess_trichotomy_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.rowConfigLess_trans_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.permSign_eq_one_or_neg_one
  Ising2DLambda.AlgebraicEigenvalue.permSign_mul_self
  Ising2DLambda.AlgebraicEigenvalue.permSign_id
  Ising2DLambda.AlgebraicEigenvalue.permSign_comp
  Ising2DLambda.AlgebraicEigenvalue.permSign_comp_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.permSign_id_from_necSuf
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.sign_comp
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.sign_one
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.sign_mul_self
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.lexLess_trichotomy
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.lexLess_trans
  Ising2DLambda.NecSuf.TransferMatrix.trace_matPow_eq_sum_cyclicWeight
  Ising2DLambda.AlgebraicEigenvalue.two_le_card_movedBy
  Ising2DLambda.AlgebraicEigenvalue.determinant_diagonal
  Ising2DLambda.AlgebraicEigenvalue.determinant_identity
  Ising2DLambda.AlgebraicEigenvalue.two_le_card_movedBy_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.determinant_diagonal_from_necSuf
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.two_le_card_moved
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.det_diagonal
  Ising2DLambda.AlgebraicEigenvalue.degLe_sum
  Ising2DLambda.AlgebraicEigenvalue.degLe_mul
  Ising2DLambda.AlgebraicEigenvalue.degLe_prod
  Ising2DLambda.AlgebraicEigenvalue.monicDeg_mul
  Ising2DLambda.AlgebraicEigenvalue.monicDeg_prod
  Ising2DLambda.AlgebraicEigenvalue.monicDeg_add_of_degLe
  Ising2DLambda.AlgebraicEigenvalue.degLe_sum_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.degLe_prod_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.monicDeg_prod_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.monicDeg_add_of_degLe_from_necSuf
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.degLe_sum
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.degLe_mul
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.degLe_prod
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.monicDeg_mul
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.monicDeg_prod
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.monicDeg_add_of_degLe
  Ising2DLambda.AlgebraicEigenvalue.degLe_constSecond
  Ising2DLambda.AlgebraicEigenvalue.monicDeg_indeterminate_add_constSecond
  Ising2DLambda.AlgebraicEigenvalue.monicDeg_identity_term
  Ising2DLambda.AlgebraicEigenvalue.degLe_term_of_ne_one
  Ising2DLambda.AlgebraicEigenvalue.degLe_rest
  Ising2DLambda.AlgebraicEigenvalue.monicDeg_charPoly
  Ising2DLambda.AlgebraicEigenvalue.charMatrix_eq_necSuf
  Ising2DLambda.AlgebraicEigenvalue.monicDeg_charPoly_from_necSuf
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.degLe_C
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.monicDeg_X_add_C
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.monicDeg_identity_term
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.degLe_term_of_ne_one
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.monicDeg_charDet
  Ising2DLambda.AlgebraicEigenvalue.card_filter_columnTranslation
  Ising2DLambda.AlgebraicEigenvalue.intraRowBrokenCount_rowShift
  Ising2DLambda.AlgebraicEigenvalue.interRowBrokenCount_rowShift
  Ising2DLambda.AlgebraicEigenvalue.transferMatrix_rowShift
  Ising2DLambda.AlgebraicEigenvalue.columnTranslation_eq_necSuf
  Ising2DLambda.AlgebraicEigenvalue.rowShift_eq_necSuf
  Ising2DLambda.AlgebraicEigenvalue.intraRowBrokenCount_rowShift_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.interRowBrokenCount_rowShift_from_necSuf
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.card_filter_comp_equiv
  Ising2DLambda.AlgebraicEigenvalue.shiftMatrix_mul_apply
  Ising2DLambda.AlgebraicEigenvalue.rowShift_eq_iff
  Ising2DLambda.AlgebraicEigenvalue.mul_shiftMatrix_apply
  Ising2DLambda.AlgebraicEigenvalue.shiftMatrix_transferMatrix_comm
  Ising2DLambda.AlgebraicEigenvalue.shiftMatrix_eq_necSuf
  Ising2DLambda.AlgebraicEigenvalue.shiftMatrix_mul_apply_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.mul_shiftMatrix_apply_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.shiftMatrix_transferMatrix_comm_from_necSuf
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.permMatrix_mul_apply
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.eq_apply_iff
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.mul_permMatrix_apply
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.permMatrix_comm
  Ising2DLambda.AlgebraicEigenvalue.columnTranslationIterate_apply
  Ising2DLambda.AlgebraicEigenvalue.columnTranslationIterate_period
  Ising2DLambda.AlgebraicEigenvalue.rowShiftIterate_apply
  Ising2DLambda.AlgebraicEigenvalue.rowShiftIterate_period
  Ising2DLambda.AlgebraicEigenvalue.shiftMatrix_pow_apply
  Ising2DLambda.AlgebraicEigenvalue.shiftMatrix_pow_L
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.iterRight_add_apply
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.iterRight_add_period
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.precompIterate_apply
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.precompIterate_period
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.permMatrix_pow_apply
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.permMatrix_pow_eq_identity
  Ising2DLambda.AlgebraicEigenvalue.columnTranslationIterate_eq_necSuf
  Ising2DLambda.AlgebraicEigenvalue.columnTranslationIterate_apply_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.columnTranslationIterate_period_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.rowShiftIterate_eq_necSuf
  Ising2DLambda.AlgebraicEigenvalue.rowShiftIterate_apply_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.rowShiftIterate_period_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.iterLeft_rowShiftEquiv_eq
  Ising2DLambda.AlgebraicEigenvalue.shiftMatrixPow_eq_necSuf
  Ising2DLambda.AlgebraicEigenvalue.shiftMatrix_pow_apply_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.shiftMatrix_pow_L_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.rowShiftIterate_add
  Ising2DLambda.AlgebraicEigenvalue.rowShiftIterate_period_exists
  Ising2DLambda.AlgebraicEigenvalue.rowShiftMinimalPeriod_pos
  Ising2DLambda.AlgebraicEigenvalue.rowShiftIterate_minimalPeriod
  Ising2DLambda.AlgebraicEigenvalue.not_rowShiftIterate_of_lt_minimalPeriod
  Ising2DLambda.AlgebraicEigenvalue.rowShiftIterate_mul
  Ising2DLambda.AlgebraicEigenvalue.rowShiftIterate_eq_self_iff
  Ising2DLambda.AlgebraicEigenvalue.rowShiftMinimalPeriod_dvd_L
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.iterLeft_add
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.minimalPeriod_pos
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.iterLeft_minimalPeriod
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.not_iterLeft_of_lt_minimalPeriod
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.iterLeft_mul
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.iterLeft_eq_self_iff
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.minimalPeriod_dvd_of_iterLeft_eq_self
  Ising2DLambda.AlgebraicEigenvalue.rowShiftIterate_eq_iterLeft
  Ising2DLambda.AlgebraicEigenvalue.rowShiftIterate_add_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.iterLeft_period_exists
  Ising2DLambda.AlgebraicEigenvalue.rowShiftMinimalPeriod_eq_necSuf
  Ising2DLambda.AlgebraicEigenvalue.rowShiftIterate_eq_self_iff_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.rowShiftMinimalPeriod_dvd_L_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.rowShiftIterate_injective
  Ising2DLambda.AlgebraicEigenvalue.eq_zero_of_dvd_of_lt_period
  Ising2DLambda.AlgebraicEigenvalue.eq_of_rowShiftIterate_eq_of_le
  Ising2DLambda.AlgebraicEigenvalue.card_rowShiftOrbit
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.iterLeft_injective
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.eq_zero_of_dvd_of_lt_period
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.eq_of_iterLeft_eq_of_le
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.card_orbit
  Ising2DLambda.AlgebraicEigenvalue.rowShiftIterate_injective_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.rowShiftOrbit_eq_necSuf
  Ising2DLambda.AlgebraicEigenvalue.card_rowShiftOrbit_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.rowShiftOrbit_subset_of_mem
  Ising2DLambda.AlgebraicEigenvalue.self_mem_rowShiftOrbit
  Ising2DLambda.AlgebraicEigenvalue.rowShiftOrbit_eq_of_mem
  Ising2DLambda.AlgebraicEigenvalue.rowShiftOrbit_eq_of_inter_nonempty
  Ising2DLambda.AlgebraicEigenvalue.rowShiftOrbitSet_partition
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.orbit_subset_of_mem
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.self_mem_orbit
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.orbit_eq_of_mem
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.orbit_eq_of_inter_nonempty
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.orbitSet_partition
  Ising2DLambda.AlgebraicEigenvalue.rowShiftOrbit_eq_of_mem_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.rowShiftOrbit_eq_of_inter_nonempty_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.rowShiftOrbitSet_eq_necSuf
  Ising2DLambda.AlgebraicEigenvalue.rowShiftOrbitSet_partition_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.charMatrix_shiftMatrix_eq_zero
  Ising2DLambda.AlgebraicEigenvalue.charTerm_shiftMatrix_eq_zero
  Ising2DLambda.AlgebraicEigenvalue.orbitPreserving_one
  Ising2DLambda.AlgebraicEigenvalue.orbitPreserving_of_fixed_or_shift
  Ising2DLambda.AlgebraicEigenvalue.image_orbit_eq_of_orbitPreserving
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.charMatrix_eq_zero_of_ne
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.term_eq_zero_of_entry_zero
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.charTerm_eq_zero
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.orbitPreserving_of_fixed_or_map
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.image_orbit_eq
  Ising2DLambda.AlgebraicEigenvalue.shiftMatrix_eq_permMatrixOf_necSuf
  Ising2DLambda.AlgebraicEigenvalue.charMatrix_shiftMatrix_eq_necSuf
  Ising2DLambda.AlgebraicEigenvalue.charMatrix_shiftMatrix_eq_zero_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.charTerm_shiftMatrix_eq_zero_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.orbitPreserving_iff_necSuf
  Ising2DLambda.AlgebraicEigenvalue.orbitPreserving_of_fixed_or_shift_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.image_orbit_eq_of_orbitPreserving_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.mem_of_orbitPreserving
  Ising2DLambda.AlgebraicEigenvalue.orbitRestriction_val
  Ising2DLambda.AlgebraicEigenvalue.orbitRestriction_bijective
  Ising2DLambda.AlgebraicEigenvalue.eq_of_orbitRestriction_eq
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.restrictionOf_val
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.restriction_bijective
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.eq_of_agree_on_cover
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.apply_eq_of_restriction_eq
  Ising2DLambda.AlgebraicEigenvalue.orbitRestriction_eq_necSuf
  Ising2DLambda.AlgebraicEigenvalue.orbitRestriction_bijective_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.eq_of_orbitRestriction_eq_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.rowShiftOrbit_eq_of_mem_orbitSet
  Ising2DLambda.AlgebraicEigenvalue.glueFun_mem_orbit
  Ising2DLambda.AlgebraicEigenvalue.glueFun_apply_of_mem
  Ising2DLambda.AlgebraicEigenvalue.glueFun_bijective
  Ising2DLambda.AlgebraicEigenvalue.gluePerm_orbitPreserving
  Ising2DLambda.AlgebraicEigenvalue.orbitRestriction_gluePerm
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.glue_mem_block
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.restriction_glue
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.glue_bijective
  Ising2DLambda.AlgebraicEigenvalue.glueFun_eq_necSuf
  Ising2DLambda.AlgebraicEigenvalue.glueFun_mem_orbit_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.glueFun_bijective_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.orbitRestriction_gluePerm_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.inv_mem_of_orbitPreserving
  Ising2DLambda.AlgebraicEigenvalue.card_crossOrderedPairsImage
  Ising2DLambda.AlgebraicEigenvalue.disjoint_of_ne_of_mem_orbitSet
  Ising2DLambda.AlgebraicEigenvalue.crossInversions_left_eq_sdiff
  Ising2DLambda.AlgebraicEigenvalue.card_crossInversions_right
  Ising2DLambda.AlgebraicEigenvalue.card_sdiff_eq_card_sdiff
  Ising2DLambda.AlgebraicEigenvalue.card_crossInversions_eq_two_mul
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.card_pairs_image_eq
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.crossInvLeft_eq_sdiff
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.card_crossInvRight
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.card_sdiff_eq_card_sdiff
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.card_crossInv_eq_two_mul
  Ising2DLambda.AlgebraicEigenvalue.crossOrderedPairs_eq_necSuf
  Ising2DLambda.AlgebraicEigenvalue.crossOrderedPairsImage_eq_necSuf
  Ising2DLambda.AlgebraicEigenvalue.crossInversions_eq_necSuf
  Ising2DLambda.AlgebraicEigenvalue.rowConfigLess_asymm
  Ising2DLambda.AlgebraicEigenvalue.rowConfigLess_total
  Ising2DLambda.AlgebraicEigenvalue.card_crossOrderedPairsImage_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.card_crossInversions_eq_two_mul_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.inversionCount_eq_card_inversionPairs
  Ising2DLambda.AlgebraicEigenvalue.orbitInversionCount_congr
  Ising2DLambda.AlgebraicEigenvalue.orbitRestrictionAmbient_eq
  Ising2DLambda.AlgebraicEigenvalue.innerInversionPairs_eq_filter
  Ising2DLambda.AlgebraicEigenvalue.card_innerInversionPairs
  Ising2DLambda.AlgebraicEigenvalue.card_same_add_card_cross
  Ising2DLambda.AlgebraicEigenvalue.sameOrbitInversionPairs_eq_biUnion
  Ising2DLambda.AlgebraicEigenvalue.innerInversionPairs_disjoint
  Ising2DLambda.AlgebraicEigenvalue.inversionCount_orbit_decomposition
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.inner_eq_filter_crossPairs
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.card_same_add_card_cross
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.sameOrbit_eq_biUnion
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.innerInversionPairs_pairwiseDisjoint
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.inversion_count_decomposition
  Ising2DLambda.AlgebraicEigenvalue.inversionPairs_eq_necSuf
  Ising2DLambda.AlgebraicEigenvalue.innerInversionPairs_eq_necSuf
  Ising2DLambda.AlgebraicEigenvalue.crossOrbitInversionPairs_eq_necSuf
  Ising2DLambda.AlgebraicEigenvalue.innerInversionPairs_eq_filter_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.card_innerInversionPairs_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.existsUnique_rowConfigMin
  Ising2DLambda.AlgebraicEigenvalue.rowConfigMin_isMin
  Ising2DLambda.AlgebraicEigenvalue.rowConfigMin_mem
  Ising2DLambda.AlgebraicEigenvalue.rowConfigMin_le
  Ising2DLambda.AlgebraicEigenvalue.rowShiftOrbit_nonempty
  Ising2DLambda.AlgebraicEigenvalue.rowConfigMin_orbit_ne
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.exists_min
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.min_unique
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.existsUnique_min
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.ne_of_mem_of_mem_of_disjoint
  Ising2DLambda.AlgebraicEigenvalue.rowConfigLess_compare
  Ising2DLambda.AlgebraicEigenvalue.rowConfigLess_asymm
  Ising2DLambda.AlgebraicEigenvalue.isRowConfigMin_eq_necSuf
  Ising2DLambda.AlgebraicEigenvalue.existsUnique_rowConfigMin_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.rowConfigMin_orbit_ne_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.inversionCount_orbit_decomposition_from_necSuf
  # 「またぐ転倒対の全体の個数の偶数性」（定義 1 件・主張 3 件）
  Ising2DLambda.AlgebraicEigenvalue.ne_of_mem_orientedOrbitPairs
  Ising2DLambda.AlgebraicEigenvalue.swap_not_mem_orientedOrbitPairs
  Ising2DLambda.AlgebraicEigenvalue.mem_orientedOrbitPairs_or_swap
  Ising2DLambda.AlgebraicEigenvalue.crossInversions_disjoint
  Ising2DLambda.AlgebraicEigenvalue.crossOrbitInversionPairs_eq_biUnion
  Ising2DLambda.AlgebraicEigenvalue.card_crossOrbitInversionPairs_eq_two_mul
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.crossInv_disjoint
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.crossInv_eq_biUnion
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.card_biUnion_eq_two_mul
  Ising2DLambda.AlgebraicEigenvalue.crossInversions_disjoint_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.crossOrbitInversionPairs_eq_biUnion_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.card_crossOrbitInversionPairs_eq_two_mul_from_necSuf
  # 「軌道を保つ置換の符号は軌道ごとの符号の積である」（定義 1 件・主張 1 件）
  Ising2DLambda.AlgebraicEigenvalue.orbitPermSign_congr
  Ising2DLambda.AlgebraicEigenvalue.permSign_eq_prod_orbitPermSign
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.pow_eq_prod_pow_of_even_remainder
  Ising2DLambda.AlgebraicEigenvalue.permSign_eq_prod_orbitPermSign_from_necSuf
  # 「軌道を保つ置換の項は軌道ごとの因子の積である」（定義 1 件・主張 3 件）
  Ising2DLambda.AlgebraicEigenvalue.constSecond_constPoly_prod
  Ising2DLambda.AlgebraicEigenvalue.prod_eq_prod_orbit
  Ising2DLambda.AlgebraicEigenvalue.term_eq_prod_orbitFactor
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.map_prod_of_mul
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.prod_eq_prod_of_partition
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.mul_prod_eq_prod_mul_of_decomp
  Ising2DLambda.AlgebraicEigenvalue.constSecond_constPoly_prod_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.prod_eq_prod_orbit_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.term_eq_prod_orbitFactor_from_necSuf
  # 「χ_U を軌道を保つ置換にわたる和へ絞ること」（主張 2 件）
  Ising2DLambda.AlgebraicEigenvalue.orbitFactor_congr
  Ising2DLambda.AlgebraicEigenvalue.orbitRestrictionAmbient_eq_coe
  Ising2DLambda.AlgebraicEigenvalue.charTerm_shiftMatrix_eq_zero_of_not_orbitPreserving
  Ising2DLambda.AlgebraicEigenvalue.charPoly_shiftMatrix_eq_sum_orbitFactor
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.eq_zero_of_not_of_forall_or
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.sum_eq_sum_subset_congr
  Ising2DLambda.AlgebraicEigenvalue.charTerm_shiftMatrix_eq_zero_of_not_orbitPreserving_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.charPoly_shiftMatrix_eq_sum_orbitFactor_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.restrictionFamily_glue
  Ising2DLambda.AlgebraicEigenvalue.glue_restrictionFamily
  Ising2DLambda.AlgebraicEigenvalue.charPoly_shiftMatrix_eq_sum_family
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.sum_eq_sum_of_inverse
  Ising2DLambda.AlgebraicEigenvalue.charPoly_shiftMatrix_eq_sum_family_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.orbitFamilyInsert_leftInverse
  Ising2DLambda.AlgebraicEigenvalue.orbitFamilyInsert_rightInverse
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.insertFamily_leftInverse
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.insertFamily_rightInverse
  Ising2DLambda.AlgebraicEigenvalue.orbitFamilyInsert_leftInverse_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.orbitFamilyInsert_rightInverse_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.prod_attach_orbitInsertFamily
  Ising2DLambda.AlgebraicEigenvalue.prod_sum_eq_sum_prod_orbitFamily
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.prod_attach_insertFamily
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.prod_sum_eq_sum_prod_family
  Ising2DLambda.AlgebraicEigenvalue.prod_sum_eq_sum_prod_orbitFamily_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.prod_sum_eq_sum_prod_orbitFamilyAll
  Ising2DLambda.AlgebraicEigenvalue.charPoly_shiftMatrix_eq_prod_orbit_sum
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.prod_sum_eq_sum_prod_pi
  Ising2DLambda.AlgebraicEigenvalue.prod_sum_eq_sum_prod_orbitFamilyAll_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.rowShift_orbitPreserving
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.self_apply_mem_orbit
  Ising2DLambda.AlgebraicEigenvalue.rowShift_orbitPreserving_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.orbitBij_eq_id_or_shift
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.eq_id_or_apply_of_fixed_or_apply
  Ising2DLambda.AlgebraicEigenvalue.orbitBij_eq_id_or_shift_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.orbitPermSign_eq_one_or_neg_one
  Ising2DLambda.AlgebraicEigenvalue.orbitPermSign_mul_self
  Ising2DLambda.AlgebraicEigenvalue.orbitInversionCount_id
  Ising2DLambda.AlgebraicEigenvalue.orbitPermSign_id
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.signOn_eq_or
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.signOn_mul_self
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.inversionCountOn_id
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.signOn_id
  Ising2DLambda.AlgebraicEigenvalue.orbitPermSign_eq_one_or_neg_one_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.orbitPermSign_mul_self_from_necSuf
  Ising2DLambda.AlgebraicEigenvalue.orbitPermSign_id_from_necSuf
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
