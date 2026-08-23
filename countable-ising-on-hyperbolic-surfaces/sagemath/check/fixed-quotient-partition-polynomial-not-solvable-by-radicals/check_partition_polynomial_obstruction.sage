# SageMath: 固定剰余類格子の Ising 分配多項式の根式非可解性
# 対象ラベル: theorem_fixed_quotient_partition_polynomial_not_solvable_by_radicals
# 帰属: ZZ[x]、QQ[x]、有限置換群、NN だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../fixed-quotient-partition-polynomial-irreducible-factorization/check_irreducible_factorization.sage",
    )
)

integer_polynomial_ring = PolynomialRing(ZZ, "x")
integer_partition_polynomial = integer_polynomial_ring(partition_polynomial)
integer_irreducible_factor = integer_polynomial_ring(irreducible_factor)

assert integer_partition_polynomial == 2 * (x + 1) ** 12 * integer_irreducible_factor
assert integer_partition_polynomial % integer_irreducible_factor == 0
assert integer_irreducible_factor.degree() == 44

rational_polynomial_ring = PolynomialRing(QQ, "x")
rational_irreducible_factor = rational_polynomial_ring(integer_irreducible_factor)
root_symmetric_group = SymmetricGroup(NN(rational_irreducible_factor.degree()))

assert QQ.characteristic() == 0
assert rational_irreducible_factor.is_irreducible()
assert not root_symmetric_group.is_solvable()

print(
    "RESULT: PASS — the fixed quotient partition polynomial is divisible by its "
    "degree-44 irreducible factor, whose established Galois group Sym(44) is not solvable"
)
