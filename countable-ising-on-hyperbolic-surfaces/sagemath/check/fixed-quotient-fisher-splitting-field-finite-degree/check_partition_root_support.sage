# SageMath: 分配多項式の全根は既約因子の四十四根と有理根 -1 で尽くされること
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_finite_degree
# 式ペア: Roots(Z_GQ) = Roots(Q_Q) union {-1}
# 帰属: QQbar の有限集合だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../fixed-quotient-partition-polynomial-irreducible-factorization/check_irreducible_factorization.sage",
    )
)

assert partition_polynomial == 2 * (x + 1) ** 12 * irreducible_factor
assert irreducible_factor(-1) != 0
assert irreducible_factor.degree() == 44

print("RESULT: PASS — factorization and coprimality show that the full root support is the 44 Q_Q roots together with -1")
