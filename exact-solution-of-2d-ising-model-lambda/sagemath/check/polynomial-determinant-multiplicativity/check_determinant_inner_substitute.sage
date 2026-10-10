# 対象ラベル: claim_polynomial_determinant_mul
# 式ペア: \sum_\tau P(\alpha(\tau))I(\alpha(\tau)) = \sum_\tau P(\alpha(\tau))\bigl(c_\tau\det_x(B)\bigr)
# 帰属: 有限集合・ZZ・Q(zeta_8)[x]。浮動小数点を使わない。
import os

if '_pdm_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

def _rows():
    for n, A, B in _pdm_cases:
        perms = list(permutations(range(n)))
        functions = _pdm_functions(n)
        yield _pdm_sum(_pdm_P(A, _pdm_alpha(tau))*_pdm_I(B, _pdm_alpha(tau)) for tau in perms), _pdm_sum(_pdm_P(A, _pdm_alpha(tau))*(_pdm_sign(tau)*B.det()) for tau in perms)

_pdm_verify(_rows(), 'determinant_inner_substitute', 'polynomial')
