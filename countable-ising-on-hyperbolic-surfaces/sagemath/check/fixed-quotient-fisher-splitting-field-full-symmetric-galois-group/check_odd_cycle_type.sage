# SageMath: 巡回長 1,2,5,13,23 の置換が奇置換であること
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_full_symmetric_galois_group
# 帰属: 四十四元有限集合と ZZ だけを用いる

root_count = ZZ(44)
root_permutation_group = SymmetricGroup(root_count)
root_alternating_group = AlternatingGroup(root_count)
sigma_107 = root_permutation_group([
    (1, 2),
    tuple(range(3, 8)),
    tuple(range(8, 21)),
    tuple(range(21, 44)),
])
cycle_lengths = [ZZ(1), ZZ(2), ZZ(5), ZZ(13), ZZ(23)]
transposition_count = sum(length - 1 for length in cycle_lengths)

assert sum(cycle_lengths) == root_count
assert sigma_107.cycle_type() == [23, 13, 5, 2, 1]
assert transposition_count == 39
assert sigma_107.sign() == -1
assert sigma_107 not in root_alternating_group
assert root_permutation_group.order() == 2 * root_alternating_group.order()

print(
    "RESULT: PASS — the cycle type 1,2,5,13,23 has sign (-1)^39=-1, "
    "so it lies outside the index-two alternating subgroup"
)
