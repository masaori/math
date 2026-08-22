# SageMath: 分解体に含まれる根が生成する単拡大の次数
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_degree_irreducible_factor_multiple
# 式ペア: [QQ(alpha_1):QQ] = 44
# 帰属: QQ[x]、QQbar、NN だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../fixed-quotient-partition-polynomial-irreducible-factorization/check_irreducible_factorization.sage",
    )
)

roots = irreducible_factor.roots(ring=QQbar, multiplicities=False)
alpha_1 = roots[0]

assert irreducible_factor.degree() == 44
assert irreducible_factor.is_irreducible()
assert irreducible_factor(alpha_1) == 0
assert alpha_1.minpoly().degree() == 44
assert NN(alpha_1.minpoly().degree()) == 44

print("RESULT: PASS — a root of the irreducible degree-44 factor generates a degree-44 extension of QQ")
