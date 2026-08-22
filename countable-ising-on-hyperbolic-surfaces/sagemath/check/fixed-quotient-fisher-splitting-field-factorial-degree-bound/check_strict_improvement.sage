# SageMath: 階乗上界が既存上界を真に強めること
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_factorial_degree_bound
# 式ペア: 44! < 44^44
# 帰属: ZZ と NN だけを用いる

factorial_bound = factorial(ZZ(44))
previous_bound = ZZ(44) ** ZZ(44)

assert factorial_bound < previous_bound

print("RESULT: PASS — the exact factorial bound 44! is strictly smaller than the previous bound 44^44")
