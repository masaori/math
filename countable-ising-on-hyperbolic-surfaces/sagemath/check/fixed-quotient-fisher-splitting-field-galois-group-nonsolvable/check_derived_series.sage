# SageMath: 四十四元根集合上の全対称群の導来列と非可解性
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_galois_group_nonsolvable
# 帰属: 四十四元有限集合、有限置換群、NN だけを用いる

root_count = ZZ(44)
root_symmetric_group = SymmetricGroup(root_count)
root_alternating_group = AlternatingGroup(root_count)
derived_series = root_symmetric_group.derived_series()

assert root_count >= 5
assert root_alternating_group.is_simple()
assert len(derived_series) == 2
assert derived_series[0] == root_symmetric_group
assert derived_series[1].order() == root_alternating_group.order()
assert derived_series[1].is_subgroup(root_alternating_group)
assert root_alternating_group.is_subgroup(derived_series[1])
assert not root_symmetric_group.is_solvable()

print(
    "RESULT: PASS — the derived series of Sym(44) stabilizes at the nontrivial "
    "simple alternating subgroup Alt(44), so Sym(44) is not solvable"
)
