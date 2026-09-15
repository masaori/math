# 対象ラベル: claim_prime_vector_zero_realization_additive
# 併せて検証: def_prime_vector_zero_real_realization
# 式ペア: rho_0(a +_Lambda b) = 0 = 0 + 0 = rho_0(a) + rho_0(b)。
# 帰属: ZZ、QQ、三素数上の有限台整数ベクトル。QQ の零は標準単射 QQ -> RR で実数の零になる。
# 浮動小数点、実対数、除算、極限は使わない。
import os
from itertools import product
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

primes = (ZZ(2), ZZ(3), ZZ(5))
vectors = tuple(
    canonical_vector(dict(zip(primes, coefficients)))
    for coefficients in product(range(-2, 3), repeat=len(primes))
)

addition_count = ZZ(0)
for left_vector in vectors:
    for right_vector in vectors:
        sum_vector = vector_add(left_vector, right_vector)
        realized_sum = zero_realization(sum_vector)
        real_zero_sum = QQ(0) + QQ(0)
        realized_terms = zero_realization(left_vector) + zero_realization(right_vector)

        assert realized_sum == QQ(0)
        assert realized_sum == real_zero_sum
        assert real_zero_sum == realized_terms
        addition_count += 1

assert len(vectors) == ZZ(125)
assert addition_count == ZZ(15625)
print('vectors checked:', ZZ(len(vectors)))
print('addition identities checked:', addition_count)
print('RESULT: PASS')
