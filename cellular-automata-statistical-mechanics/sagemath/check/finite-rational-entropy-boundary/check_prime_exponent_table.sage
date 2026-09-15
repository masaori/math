# 対象ラベル: def_finite_rational_prime_vector_entropy
# 併せて検証: def_finite_rational_probability_distribution_support、def_positive_rational_prime_valuation
# 式ペア: 正の台の各 p(x) にだけ v_l(p(x)) を適用し、素数指数表から p(x) を復元する。
# 帰属: QQ、ZZ、有限台有理素数ベクトル。実数体、実対数、零の対数、極限は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

distribution_count = ZZ(0)
positive_weight_count = ZZ(0)
zero_weight_count = ZZ(0)
for weights in sample_distributions():
    support = positive_support(weights)
    assert all(weights[index] > 0 for index in support)
    assert all((weights[index] > 0) == (index in support) for index in range(len(weights)))
    for index, weight in enumerate(weights):
        if index in support:
            valuation = positive_rational_valuation(weight)
            assert reconstruct(valuation) == weight
            positive_weight_count += 1
        else:
            assert weight == 0
            zero_weight_count += 1
    distribution_count += 1

assert distribution_count > 0
assert positive_weight_count > 0
assert zero_weight_count > 0
print('finite rational distributions checked:', distribution_count)
print('positive weights factored and reconstructed:', positive_weight_count)
print('zero weights excluded from valuation:', zero_weight_count)
print('RESULT: PASS')
