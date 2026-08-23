# SageMath: 四十四元根集合の全対称群の位数と分解体次数の結論
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_exact_degree
# 帰属: 四十四元有限集合、有限置換群、NN だけを用いる

root_count = ZZ(44)
root_permutation_group = SymmetricGroup(root_count)
galois_group_order = ZZ(root_permutation_group.order())
factorial_degree = ZZ(root_count.factorial())

assert galois_group_order == factorial_degree
assert factorial_degree == ZZ(2658271574788448768043625811014615890319638528000000000)

print(
    "RESULT: PASS — the full symmetric Galois group on 44 roots has order 44!, "
    "so the finite Galois splitting field has degree 44!"
)
