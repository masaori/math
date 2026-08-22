# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_finite_degree
# 帰属: ZZ[x]、QQ[x]、QQbar[x]、NN だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../fixed-quotient-partition-polynomial-irreducible-factorization/check_irreducible_factorization.sage",
    )
)

irreducible_roots = irreducible_factor.roots(ring=QQbar, multiplicities=False)
partition_roots = partition_polynomial.roots(ring=QQbar, multiplicities=False)
