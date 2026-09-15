# 対象ラベル: def_finite_rational_prime_vector_entropy
# 式ペア: H_Q(p)(l) = -sum_{x in X_p} p(x) iota_Q(v_l(p(x)))。
# 帰属: QQ、ZZ、有限台有理素数ベクトル。有限和積だけを使い、実数体、実対数、極限は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

distribution_count = ZZ(0)
coefficient_count = ZZ(0)
for weights in sample_distributions():
    support = positive_support(weights)
    valuations = {
        index: positive_rational_valuation(weights[index])
        for index in support
    }
    union_support = set().union(*(set(vector) for vector in valuations.values()))
    entropy = rational_entropy_vector(weights)
    assert set(entropy).issubset(union_support)
    for prime in union_support:
        direct = -sum(
            weights[index] * valuations[index].get(prime, QQ(0))
            for index in support
        )
        assert entropy.get(prime, QQ(0)) == direct
        coefficient_count += 1
    distribution_count += 1

assert distribution_count > 0
assert coefficient_count > 0
print('finite rational distributions checked:', distribution_count)
print('weighted prime coefficients checked:', coefficient_count)
print('RESULT: PASS')
