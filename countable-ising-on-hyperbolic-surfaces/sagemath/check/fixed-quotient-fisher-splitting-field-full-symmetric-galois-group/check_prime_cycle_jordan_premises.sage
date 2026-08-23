# SageMath: 素数四十一巡回と Jordan の定理の数値前提
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_full_symmetric_galois_group
# 帰属: 四十四元有限集合と NN だけを用いる

root_count = ZZ(44)
prime_cycle_length = ZZ(41)
root_permutation_group = SymmetricGroup(root_count)
sigma_131 = root_permutation_group([
    tuple(range(1, 42)),
    (42, 43),
])
prime_cycle = sigma_131^2

assert sigma_131.cycle_type() == [41, 2, 1]
assert gcd(ZZ(2), prime_cycle_length) == 1
assert prime_cycle.cycle_type() == [41, 1, 1, 1]
assert prime_cycle_length.is_prime()
assert prime_cycle_length == root_count - 3
assert prime_cycle_length <= root_count - 3

print(
    "RESULT: PASS — squaring the cycle type 1,2,41 gives a 41-cycle with "
    "three fixed points, and 41 is prime with 41 <= 44-3"
)
