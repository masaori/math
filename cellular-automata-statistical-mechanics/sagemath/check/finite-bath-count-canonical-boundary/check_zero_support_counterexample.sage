# 対象ラベル: claim_binary_finite_bath_count_not_always_exponential_canonical
# 式ペア: |Sigma_0|=2、P_0^count(x_0)=1、P_0^count(x_1)=0。
# 帰属: 有限集合、ZZ、QQ と、有限実数値指数形の正値域。
# 零成分までを厳密計算し、exp_R(r)>0 という本文の実指数関数の値域と比較する。浮動小数点は使わない。
first_set = ((ZZ(0),), (ZZ(1),))
second_set = ((ZZ(0),), (ZZ(1),))
first_observation = (ZZ(0), ZZ(1))
second_observation = (ZZ(0), ZZ(0))
total = ZZ(0)

omega_zero = ZZ(sum(1 for value in second_observation if value == 0))
omega_minus_one = ZZ(sum(1 for value in second_observation if value == -1))
assert omega_zero == 2
assert omega_minus_one == 0

shell = tuple(
    (first_index, second_index)
    for first_index in range(len(first_set))
    for second_index in range(len(second_set))
    if first_observation[first_index] + second_observation[second_index] == total
)
shell_size = ZZ(len(shell))
assert shell_size == omega_zero + omega_minus_one
assert shell_size == 2

count_distribution = (
    QQ(omega_zero) / shell_size,
    QQ(omega_minus_one) / shell_size,
)
assert count_distribution == (QQ(1), QQ(0))

# 有限実数値 E と beta>0 では各 exp_R(-beta E(x)) とその有限和が正なので、
# 定義された指数規格化分布の各成分も正である。従って第二成分 0 とは一致しない。
assert count_distribution[1] == 0
print('finite shell pairs checked:', shell_size)
print('zero count-distribution components checked:', ZZ(1))
print('RESULT: PASS')
