# SageMath: 各段の次数上界の積
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_factorial_degree_bound
# 式ペア: product_(r=1)^44 (45-r) = 44!
# 帰属: ZZ と NN だけを用いる

tower_degree_bound = ZZ(1)
for root_index in range(ZZ(1), ZZ(45)):
    tower_degree_bound *= ZZ(45) - root_index

assert tower_degree_bound == factorial(ZZ(44))
assert tower_degree_bound in NN
assert tower_degree_bound > 0

print("RESULT: PASS — the product of the 44 successive degree bounds is exactly 44!")
