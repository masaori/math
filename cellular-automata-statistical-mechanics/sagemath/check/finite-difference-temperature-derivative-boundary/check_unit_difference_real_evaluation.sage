# 対象ラベル: claim_binary_ca_unit_difference_real_evaluation
# 併せて検証: claim_prime_vector_real_evaluation_of_prime_logarithm
# 式ペア: rho_Lambda(log_Lambda(Omega_1/Omega_0)) = log_R(Omega_1)-log_R(Omega_0)。
# 帰属: NN_{>0}、QQ_{>0}、ZZ、有限台整数素数ベクトルと、素数の実対数を表す形式変数。
# 実対数の商の法則を適用した後の係数恒等式を厳密に検査し、零の対数・浮動小数点・極限は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

pair_count = ZZ(0)
coefficient_count = ZZ(0)
for left_count in range(1, 65):
    for right_count in range(1, 65):
        left_vector = positive_rational_valuation(QQ(left_count))
        right_vector = positive_rational_valuation(QQ(right_count))
        ratio_vector = positive_rational_valuation(QQ(right_count) / left_count)
        primes = tuple(sorted(set(left_vector).union(right_vector).union(ratio_vector)))

        if primes:
            ring = PolynomialRing(QQ, names=tuple('L%s' % prime for prime in primes))
            logarithms = dict(zip(primes, ring.gens()))
            evaluated_ratio = formal_logarithmic_realization(ratio_vector, logarithms)
            finite_real_difference = (
                formal_logarithmic_realization(right_vector, logarithms)
                - formal_logarithmic_realization(left_vector, logarithms)
            )
            assert ratio_vector == vector_subtract(right_vector, left_vector)
            assert evaluated_ratio == finite_real_difference
            coefficient_count += len(primes)
        else:
            assert left_count == right_count == 1
        pair_count += 1

assert pair_count == ZZ(4096)
assert coefficient_count > 0
print('positive finite-count pairs checked:', pair_count)
print('prime-log coefficients checked:', coefficient_count)
print('RESULT: PASS')
