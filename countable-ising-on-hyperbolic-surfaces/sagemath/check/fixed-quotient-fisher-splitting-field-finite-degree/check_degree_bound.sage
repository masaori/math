# SageMath: 体の塔から得る有限次数上界
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_finite_degree
# 式ペア: [K_r:QQ] <= 44^r、[K_Q:QQ] <= 44^44 < infinity
# 帰属: NN だけを用いる

degree_bound = ZZ(1)
for root_index in range(ZZ(1), ZZ(45)):
    previous_bound = degree_bound
    degree_bound = ZZ(44) * previous_bound
    assert degree_bound == ZZ(44) ** root_index

assert degree_bound == ZZ(44) ** ZZ(44)
assert degree_bound in NN

print("RESULT: PASS — the 44-step tower bound is exactly 44^44 and is finite")
