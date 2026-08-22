# SageMath: 全四十四根を添加すると既約因子が一次式の積へ分解すること
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_finite_degree
# 式ペア: Q_Q(x) / lc(Q_Q) = product_{r=1}^{44} (x-alpha_r)
# 帰属: QQbar[x] だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(check_directory, "_prelude.sage"))

assert len(irreducible_roots) == irreducible_factor.degree() == 44
assert len(set(irreducible_roots)) == 44
assert all(irreducible_factor(root) == 0 for root in irreducible_roots)
assert gcd(irreducible_factor, irreducible_factor.derivative()) == 1

print("RESULT: PASS — 44 distinct exact QQbar roots exhaust the degree-44 factor and therefore give its complete linear factorization")
