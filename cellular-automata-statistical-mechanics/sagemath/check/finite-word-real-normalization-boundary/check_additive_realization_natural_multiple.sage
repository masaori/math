# 対象ラベル: claim_prime_vector_additive_realization_natural_multiple
# 有限台整数ベクトル上の有理値加法写像について、零・加法・自然数倍を段別に検査する。
# QQ 値は標準単射 QQ -> RR で実数値になるが、等号判定は QQ 内で厳密に行う。
# 帰属: NN、ZZ、QQ、有限台整数ベクトル。浮動小数点、実対数、極限は使わない。
import os
from itertools import product
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

primes = (ZZ(2), ZZ(3), ZZ(5))
prime_weights = {ZZ(2): QQ(3) / 2, ZZ(3): -QQ(2) / 3, ZZ(5): QQ(5) / 7}
vectors = tuple(
    canonical_vector(dict(zip(primes, coefficients)))
    for coefficients in product(range(-2, 3), repeat=len(primes))
)

zero_count = ZZ(0)
addition_count = ZZ(0)
multiple_count = ZZ(0)
zero = canonical_vector({})
assert rational_realization(zero, prime_weights) == 0
assert rational_realization({ZZ(7): ZZ(1)}, prime_weights) == 0
zero_count += 1

for left in vectors:
    for right in vectors:
        assert rational_realization(vector_add(left, right), prime_weights) == (
            rational_realization(left, prime_weights)
            + rational_realization(right, prime_weights)
        )
        addition_count += 1

    for multiplier in range(0, 17):
        assert rational_realization(natural_multiple(multiplier, left), prime_weights) == (
            QQ(multiplier) * rational_realization(left, prime_weights)
        )
        multiple_count += 1

assert len(vectors) == ZZ(125)
assert zero_count == ZZ(1)
assert addition_count == ZZ(15625)
assert multiple_count == ZZ(2125)
print('zero identities checked:', zero_count)
print('addition identities checked:', addition_count)
print('natural-multiple identities checked:', multiple_count)
print('RESULT: PASS')
