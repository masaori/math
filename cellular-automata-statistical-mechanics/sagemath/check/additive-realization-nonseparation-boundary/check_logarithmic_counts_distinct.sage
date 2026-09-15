# 対象ラベル: claim_additive_realization_need_not_distinguish_counts
# 併せて検証: claim_prime_logarithm_inverse
# 式ペア: R(log_Lambda 1) = 1 != 2 = R(log_Lambda 2)、従って log_Lambda 1 != log_Lambda 2。
# 帰属: NN_{>0}、QQ_{>0}、ZZ、有限台整数ベクトル。実数体・複素数体は使わない。
# 浮動小数点、実対数、極限は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

one = ZZ(1)
two = ZZ(2)
logarithm_of_one = prime_log_positive_integer(one)
logarithm_of_two = prime_log_positive_integer(two)

assert one > 0
assert two > 0
assert reconstruct(logarithm_of_one) == QQ(one)
assert QQ(one) != QQ(two)
assert QQ(two) == reconstruct(logarithm_of_two)
assert logarithm_of_one != logarithm_of_two
assert logarithm_of_one == {}
assert logarithm_of_two == {ZZ(2): ZZ(1)}
print('distinct logarithmic count pairs checked:', ZZ(1))
print('RESULT: PASS')
