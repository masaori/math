# SageMath: 分解体の生成元となる四十四根の代数次数
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_finite_degree
# 式ペア: [QQ(alpha_r):QQ] = 44
# 帰属: QQ[x]、QQbar、NN だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../fixed-quotient-partition-polynomial-irreducible-factorization/check_irreducible_factorization.sage",
    )
)

assert irreducible_factor.degree() == 44
assert irreducible_factor.is_irreducible()

print("RESULT: PASS — every root of the irreducible degree-44 factor has algebraic degree 44 over QQ")
