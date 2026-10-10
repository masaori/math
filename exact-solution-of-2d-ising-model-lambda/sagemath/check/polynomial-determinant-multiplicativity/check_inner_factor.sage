# 対象ラベル: claim_polynomial_determinant_mul
# 式ペア: \sum_\pi c_\tau\left(c_\pi\prod_j B_{j,\pi(j)}\right) = c_\tau\sum_\pi c_\pi\prod_j B_{j,\pi(j)}
# 帰属: 有限集合・ZZ・Q(zeta_8)[x]。浮動小数点を使わない。
import os

if '_pdm_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

def _rows():
    for n, A, B in _pdm_cases:
        perms = list(permutations(range(n)))
        for tau in perms:
            yield _pdm_sum(_pdm_sign(tau)*(_pdm_sign(pi)*_pdm_prod(B[j, pi[j]] for j in range(n))) for pi in perms), _pdm_sign(tau)*_pdm_sum(_pdm_sign(pi)*_pdm_prod(B[j, pi[j]] for j in range(n)) for pi in perms)

_pdm_verify(_rows(), 'inner_factor', 'polynomial')
