# 対象ラベル: claim_shift_rationalized_logarithmic_density_vector_converges
# 併せて検証: def_rational_prime_vector_finite_sum_distance, def_shift_rationalized_logarithmic_density_sequence
# 式ペア・判定: シフト正規化ベクトルと零ベクトルの有限和差量は各段階で正整数の逆数に一致する。
# 帰属: NN・ZZ・QQ と有限台ベクトル。実数値ノルム、無限和、完備化は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

stages_checked = 0
for length in range(1, 257):
    vector = shift_normalized_vector(ZZ(length))
    distance = finite_sum_distance(vector, zero_vector())

    assert support(vector).union(support(zero_vector())) == {ZZ(2)}
    assert distance.parent() is QQ
    assert distance == abs(QQ(1) / QQ(length) - QQ(0))
    assert distance == QQ(1) / QQ(length)
    assert distance > 0
    stages_checked += 1

assert stages_checked == 256
assert stages_checked > 0
print('finite-sum distances checked:', stages_checked)
print('RESULT: PASS')
