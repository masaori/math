"""有限合同系の全解で固定される係数を名前で同定する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

左スロットの正準二項を固定した一辺二・三の有限合同系を再構成し、
係数座標へ射影した右核で動かない係数を名前へ戻す。固定非零係数を
有限データが強制する核、縮約代表の残りの支持台を右核で変更できる
代表依存項として分ける。有限集合と F_2 の厳密演算だけを使う。
"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-canonical-two-term-formula/check.sage")

coefficient_names = [None] * len(coefficient_columns)
coefficient_lengths = [None] * len(coefficient_columns)
for length in (1, 2, 3):
    names, local_start = coefficient_name_data(length, blocks[length])
    for offset, name in enumerate(names):
        coefficient_names[local_start + offset] = name
        coefficient_lengths[local_start + offset] = length


def named_coefficients(indices):
    return tuple(
        (coefficient_lengths[index], coefficient_names[index])
        for index in sorted(indices)
    )


forced_nonzero_named = named_coefficients(forced_nonzero)
forced_zero_named = named_coefficients(forced - set(forced_nonzero))

expected_forced_nonzero = (
    (2, "step0_e_up*end0_d_left"),
    (2, "step0_d_up*end0_e_left"),
    (3, "step1_wrap_row0*end0_wrap_col0"),
    (3, "step1_wrap_row0*end0_wrap_collast"),
    (3, "step1_wrap_rowlast*end1_wrap_col0"),
    (3, "step1_wrap_col0*end0_wrap_row0"),
    (3, "step1_wrap_col0*end1_wrap_rowlast"),
    (3, "step1_wrap_collast*end0_wrap_row0"),
    (3, "step1_wrap_collast*end1_wrap_row0"),
    (3, "step1_wrap_collast*end1_wrap_rowlast"),
)
expected_forced_zero = (
    (3, "step1_wrap_row0*end1_wrap_col0"),
    (3, "step1_wrap_row0*end1_wrap_collast"),
    (3, "step1_wrap_rowlast*end0_wrap_col0"),
    (3, "step1_wrap_rowlast*end0_wrap_collast"),
    (3, "step1_wrap_rowlast*end1_wrap_collast"),
    (3, "step1_wrap_col0*end0_wrap_rowlast"),
    (3, "step1_wrap_col0*end0_wrap_col0"),
    (3, "step1_wrap_col0*end1_wrap_row0"),
    (3, "step1_wrap_col0*end1_wrap_col0"),
    (3, "step1_wrap_collast*end0_wrap_rowlast"),
    (3, "step1_wrap_collast*end0_wrap_collast"),
    (3, "step1_wrap_collast*end1_wrap_collast"),
)

assert forced_nonzero_named == expected_forced_nonzero
assert forced_zero_named == expected_forced_zero
assert sparse.hamming_weight() - len(forced_nonzero_named) == 758

print("FORCED NONZERO COEFFICIENTS:")
for length, name in forced_nonzero_named:
    print("  length %d: %s" % (length, name))
print("FORCED ZERO COEFFICIENTS:")
for length, name in forced_zero_named:
    print("  length %d: %s" % (length, name))
print("REPRESENTATIVE-DEPENDENT SUPPORT: 758")
print("RESULT: PASS")
