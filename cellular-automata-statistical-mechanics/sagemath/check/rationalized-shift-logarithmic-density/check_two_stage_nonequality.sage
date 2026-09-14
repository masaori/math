# 対象ラベル: claim_shift_rationalized_logarithmic_density_not_eventually_constant
# 式ペア・判定: 任意に検査した開始段階 L と後続段階 2L で、素数 2 係数 1/L と 1/(2L) は異なる。
# 帰属: NN・ZZ・QQ と有限台ベクトル。浮動小数点、実数、距離、極限、完備化は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

logarithmic_count = {ZZ(2): ZZ(1)}
pairs_checked = 0
for start in range(1, 129):
    first = divide_rational_vector(rational_embedding(logarithmic_count), ZZ(start))
    later = divide_rational_vector(rational_embedding(logarithmic_count), ZZ(2 * start))
    first_coefficient = coefficient(first, ZZ(2))
    later_coefficient = coefficient(later, ZZ(2))

    assert first_coefficient == QQ(1) / QQ(start)
    assert later_coefficient == QQ(1) / QQ(2 * start)
    assert QQ(2 * start) * first_coefficient == QQ(2)
    assert QQ(2 * start) * later_coefficient == QQ(1)
    assert first_coefficient != later_coefficient
    assert first != later
    assert 2 * start >= start
    pairs_checked += 1

assert pairs_checked == 128
assert pairs_checked > 0
print('start/later stage pairs checked:', pairs_checked)
print('RESULT: PASS')
