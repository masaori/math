# 対象ラベル: claim_shift_rationalized_logarithmic_density_vector_converges
# 併せて検証: def_rational_prime_vector_finite_sum_convergence, claim_positive_integer_reciprocal_converges_rationally
# 式ペア・判定: epsilon=a/b と L_0=b+1 に対し、全検査段階でシフト正規化ベクトルと零ベクトルの差量が epsilon 未満である。
# 帰属: NN・ZZ・QQ と有限台ベクトル。任意列の極限、完備化、実数体は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

tolerances_checked = 0
tail_stages_checked = 0
for numerator in range(1, 65):
    for denominator in range(1, 65):
        epsilon = QQ(numerator) / QQ(denominator)
        threshold = ZZ(denominator + 1)

        assert epsilon.parent() is QQ
        assert epsilon > 0
        assert threshold > 0
        for length in range(threshold, threshold + 65):
            distance = finite_sum_distance(
                shift_normalized_vector(ZZ(length)), zero_vector())

            assert distance == QQ(1) / QQ(length)
            assert distance <= QQ(1) / QQ(denominator + 1)
            assert QQ(1) / QQ(denominator + 1) < QQ(1) / QQ(denominator)
            assert QQ(1) / QQ(denominator) <= epsilon
            assert distance < epsilon
            tail_stages_checked += 1
        tolerances_checked += 1

assert tolerances_checked == 64 * 64
assert tail_stages_checked == tolerances_checked * 65
assert tolerances_checked > 0
assert tail_stages_checked > 0
print('positive rational tolerances checked:', tolerances_checked)
print('tail stages checked:', tail_stages_checked)
print('RESULT: PASS')
