# 対象ラベル: claim_rational_prime_vector_geometric_truncations_cauchy
# 併せて検証: def_rational_prime_vector_finite_sum_cauchy, claim_positive_integer_reciprocal_converges_rationally
# 式ペア・判定: epsilon=a/b に開始段階 b+1 を選ぶと、検査した全ての二段階の差量が epsilon 未満になる。
# 帰属: NN・ZZ・QQ と有限台ベクトル。極限値、無限和、完備化、実数体は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

tolerances_checked = 0
tail_pairs_checked = 0
for numerator in range(1, 9):
    for denominator in range(1, 9):
        epsilon = QQ(numerator) / QQ(denominator)
        threshold = ZZ(denominator + 1)

        assert epsilon > 0
        assert QQ(1) / QQ(threshold) < QQ(1) / QQ(denominator)
        assert QQ(1) / QQ(denominator) <= epsilon
        for left_stage in range(threshold, threshold + 5):
            for right_stage in range(threshold, threshold + 5):
                lower_stage = ZZ(min(left_stage, right_stage))
                distance = finite_sum_distance(
                    geometric_truncation(left_stage),
                    geometric_truncation(right_stage))

                assert distance < QQ(1) / QQ(2 ** lower_stage)
                assert QQ(1) / QQ(2 ** lower_stage) <= QQ(1) / QQ(lower_stage)
                assert QQ(1) / QQ(lower_stage) <= QQ(1) / QQ(threshold)
                assert distance < epsilon
                tail_pairs_checked += 1
        tolerances_checked += 1

assert tolerances_checked == 8 * 8
assert tail_pairs_checked == tolerances_checked * 5 * 5
assert tolerances_checked > 0
assert tail_pairs_checked > 0
print('positive rational tolerances checked:', tolerances_checked)
print('tail stage pairs checked:', tail_pairs_checked)
print('RESULT: PASS')
