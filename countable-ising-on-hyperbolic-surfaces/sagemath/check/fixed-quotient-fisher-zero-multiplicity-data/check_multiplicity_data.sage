# SageMath: 固定剰余類格子の Fisher 零点の代数的重複度データ
# 対象ラベル: theorem_fixed_quotient_fisher_zero_multiplicity_data
# 帰属: ZZ[x]、QQ[x]、QQbar[x] だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../fixed-quotient-partition-polynomial-irreducible-factorization/check_irreducible_factorization.sage",
    )
)

assert irreducible_factor(-1) != 0
assert gcd(irreducible_factor, irreducible_factor.derivative()) == 1

algebraic_roots = irreducible_factor.roots(ring=QQbar, multiplicities=True)
assert len(algebraic_roots) == 44
assert len(set(root for root, _ in algebraic_roots)) == 44
assert all(multiplicity == 1 for _, multiplicity in algebraic_roots)

partition_roots = partition_polynomial.roots(ring=QQbar, multiplicities=True)
partition_root_multiplicities = dict(partition_roots)
assert len(partition_roots) == 45
assert partition_root_multiplicities[QQbar(-1)] == 12
assert all(
    partition_root_multiplicities[root] == 1
    for root, _ in algebraic_roots
)
assert sum(partition_root_multiplicities.values()) == 56

print(
    "RESULT: PASS — exact QQbar root construction gives 44 distinct simple "
    "roots of Q_Q and the additional root -1 with multiplicity 12, for 45 "
    "distinct Fisher zeros and total multiplicity 56"
)
