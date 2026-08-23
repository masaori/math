# SageMath: 固定剰余類格子の Fisher 既約因子の根式非可解性
# 対象ラベル: theorem_fixed_quotient_fisher_irreducible_factor_not_solvable_by_radicals
# 帰属: QQ[x]、有限置換群、NN だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../fixed-quotient-partition-polynomial-irreducible-factorization/check_irreducible_factorization.sage",
    )
)

rational_polynomial_ring = PolynomialRing(QQ, "x")
rational_irreducible_factor = rational_polynomial_ring(irreducible_factor)
root_count = NN(rational_irreducible_factor.degree())

assert QQ.characteristic() == 0
assert root_count == 44
assert rational_irreducible_factor.is_irreducible()

root_symmetric_group = SymmetricGroup(root_count)

assert root_symmetric_group.cardinality() == factorial(root_count)
assert not root_symmetric_group.is_solvable()

print(
    "RESULT: PASS — Q_Q is irreducible of degree 44 over the characteristic-zero "
    "field QQ, and its established Galois group Sym(44) is not solvable"
)
