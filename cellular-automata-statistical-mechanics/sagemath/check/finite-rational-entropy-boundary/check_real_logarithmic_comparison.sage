# 対象ラベル: claim_finite_rational_entropy_real_comparison
# 併せて検証: def_rational_prime_vector_logarithmic_real_evaluation
# 式ペア: rho_log(H_Q(p)) = -sum_{x in X_p} p(x) log_R(p(x))。
# 帰属: QQ、ZZ と素数の実対数を表す形式変数。実対数の積法則適用後の有限係数恒等式を厳密に検査する。
# 浮動小数点、零の対数、無限和、極限は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

distribution_count = ZZ(0)
formal_identity_count = ZZ(0)
for weights in sample_distributions():
    support = positive_support(weights)
    valuations = {
        index: positive_rational_valuation(weights[index])
        for index in support
    }
    primes = tuple(sorted(set().union(*(set(vector) for vector in valuations.values()))))
    if primes:
        ring = PolynomialRing(QQ, names=tuple('L%s' % prime for prime in primes))
        logarithms = dict(zip(primes, ring.gens()))
        entropy = rational_entropy_vector(weights)
        realized_entropy = sum(
            entropy.get(prime, QQ(0)) * logarithms[prime]
            for prime in primes
        )
        shannon_after_log_product = -sum(
            weights[index] * sum(
                valuations[index].get(prime, QQ(0)) * logarithms[prime]
                for prime in primes
            )
            for index in support
        )
        assert realized_entropy == shannon_after_log_product
        formal_identity_count += 1
    distribution_count += 1

assert distribution_count > 0
assert formal_identity_count > 0
print('finite rational distributions checked:', distribution_count)
print('formal real-log coefficient identities checked:', formal_identity_count)
print('RESULT: PASS')
