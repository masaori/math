# SageMath: 分解体の Galois 群が作用する根集合と全置換群の位数
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_degree_divides_factorial
# 式ペア: |A_Q| = 44, |Sym(A_Q)| = 44!
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
root_count = NN(len(roots))
permutation_group_order = SymmetricGroup(root_count).order()

assert irreducible_factor.degree() == 44
assert gcd(irreducible_factor, irreducible_factor.derivative()) == 1
assert root_count == 44
assert all(irreducible_factor(root) == 0 for root in roots)
assert permutation_group_order == factorial(ZZ(44))
assert permutation_group_order in NN

print("RESULT: PASS — the separable degree-44 factor has 44 distinct algebraic roots and their full permutation group has order 44!")
