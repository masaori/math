# 対象ラベル: claim_positive_integer_reciprocal_converges_rationally
# 併せて検証: def_positive_rational_epsilon_convergence
# 式ペア・判定: epsilon=a/b と L_0=b+1 に対し、L>=L_0 なら |1/L-0|<epsilon となる証明の各不等式。
# 帰属: NN・ZZ・QQ。浮動小数点、実数、位相、完備化は使わない。

witnesses_checked = 0
tail_stages_checked = 0
for numerator in range(1, 65):
    for denominator in range(1, 65):
        epsilon = QQ(numerator) / QQ(denominator)
        threshold = ZZ(denominator + 1)

        assert epsilon.parent() is QQ
        assert epsilon > 0
        assert threshold > 0

        for length in range(threshold, threshold + 65):
            reciprocal_distance = abs(QQ(1) / QQ(length) - QQ(0))

            assert reciprocal_distance == QQ(1) / QQ(length)
            assert QQ(1) / QQ(length) <= QQ(1) / QQ(denominator + 1)
            assert QQ(1) / QQ(denominator + 1) < QQ(1) / QQ(denominator)
            assert QQ(1) / QQ(denominator) <= QQ(numerator) / QQ(denominator)
            assert QQ(numerator) / QQ(denominator) == epsilon
            assert reciprocal_distance < epsilon
            tail_stages_checked += 1

        witnesses_checked += 1

assert witnesses_checked == 64 * 64
assert tail_stages_checked == witnesses_checked * 65
assert witnesses_checked > 0
assert tail_stages_checked > 0
print('positive rational tolerances checked:', witnesses_checked)
print('tail stages checked:', tail_stages_checked)
print('RESULT: PASS')
