# 対象ラベル: claim_additive_realization_need_not_distinguish_counts
# 併せて検証: def_prime_vector_zero_real_realization
# 式ペア: rho_0(log_Lambda 1) = 0 = rho_0(log_Lambda 2)。
# 帰属: NN_{>0}、QQ、ZZ、有限台整数ベクトル。QQ の零は標準単射 QQ -> RR で実数の零になる。
# 浮動小数点、実対数、除算、極限は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

logarithm_of_one = prime_log_positive_integer(ZZ(1))
logarithm_of_two = prime_log_positive_integer(ZZ(2))
image_of_one = zero_realization(logarithm_of_one)
image_of_two = zero_realization(logarithm_of_two)

assert logarithm_of_one != logarithm_of_two
assert image_of_one == QQ(0)
assert QQ(0) == image_of_two
assert image_of_one == image_of_two
print('equal zero-realization image pairs checked:', ZZ(1))
print('RESULT: PASS')
