# SageMath: 四十三巡回による原始性証明の有限置換前提
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_full_symmetric_galois_group
# 帰属: 四十四元有限集合と NN だけを用いる

root_count = ZZ(44)
root_permutation_group = SymmetricGroup(root_count)
sigma_389 = root_permutation_group([tuple(range(1, 44))])
fixed_root = ZZ(44)
moving_roots = set(range(1, 44))

assert sigma_389.cycle_type() == [43, 1]
assert sigma_389(fixed_root) == fixed_root
assert set(sigma_389.orbit(ZZ(1))) == moving_roots
assert len(moving_roots) == root_count - 1

for beta in moving_roots:
    orbit = {(sigma_389^power)(beta) for power in range(43)}
    assert orbit == moving_roots

print(
    "RESULT: PASS — the cycle type 1,43 fixes one root and its powers act "
    "transitively on the other 43 roots"
)
