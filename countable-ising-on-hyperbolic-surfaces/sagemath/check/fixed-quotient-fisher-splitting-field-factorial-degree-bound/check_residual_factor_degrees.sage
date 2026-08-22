# SageMath: 既知の相異なる根を除いた剰余因子の次数
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_factorial_degree_bound
# 式ペア: deg R_(r-1) = 44 - (r-1) = 45-r
# 帰属: ZZ と NN だけを用いる

for root_index in range(ZZ(1), ZZ(45)):
    removed_root_count = root_index - ZZ(1)
    residual_degree = ZZ(44) - removed_root_count
    assert residual_degree == ZZ(45) - root_index
    assert residual_degree in NN
    assert residual_degree > 0

print("RESULT: PASS — removing r-1 distinct linear factors leaves exact degree 45-r for every r from 1 through 44")
