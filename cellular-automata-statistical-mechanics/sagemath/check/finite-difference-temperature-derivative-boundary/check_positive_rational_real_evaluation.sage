# 対象ラベル: claim_prime_vector_real_evaluation_of_prime_logarithm
# 式ペア: rho_Lambda(log_Lambda q) = log_R(iota_{Q,R}(q))。
# 帰属: QQ_{>0}、ZZ、有限台整数素数ベクトルと、素数の実対数を表す形式変数。
# 実対数の有限積法則を適用した後の係数恒等式を厳密に検査し、浮動小数点・極限・無限和は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

sample_count = ZZ(0)
coefficient_count = ZZ(0)
for value in positive_rational_samples():
    valuation = positive_rational_valuation(value)
    primes = tuple(sorted(valuation))
    if primes:
        ring = PolynomialRing(QQ, names=tuple('L%s' % prime for prime in primes))
        logarithms = dict(zip(primes, ring.gens()))
        realized_prime_vector = formal_logarithmic_realization(valuation, logarithms)
        real_log_after_product_law = sum(
            valuation[prime] * logarithms[prime]
            for prime in primes
        )
        assert realized_prime_vector == real_log_after_product_law
        coefficient_count += len(primes)
    else:
        assert value == QQ(1)
    sample_count += 1

assert sample_count > 0
assert coefficient_count > 0
print('positive rational values checked:', sample_count)
print('prime-log coefficients checked:', coefficient_count)
print('RESULT: PASS')
