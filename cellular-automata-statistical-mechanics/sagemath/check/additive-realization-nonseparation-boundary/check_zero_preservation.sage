# 対象ラベル: claim_prime_vector_zero_realization_additive
# 併せて検証: def_prime_vector_zero_real_realization
# 式ペア: rho_0(0_Lambda) = 0。
# 帰属: ZZ、QQ、有限台整数ベクトル。QQ の零は標準単射 QQ -> RR で実数の零になる。
# 浮動小数点、実対数、除算、極限は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

zero_vector = canonical_vector({})
left = zero_realization(zero_vector)
right = QQ(0)

assert zero_vector == {}
assert left == right
print('zero identities checked:', ZZ(1))
print('RESULT: PASS')
