# 対象ラベル: claim_polynomial_determinant_mul
# 式ペア: \sum_\tau\bigl(P(\alpha(\tau))c_\tau\bigr)\det_x(B) = \sum_\tau\bigl(c_\tau P(\alpha(\tau))\bigr)\det_x(B)
# 帰属: 有限集合・ZZ・Q(zeta_8)[x]。浮動小数点を使わない。
import os

if '_pdm_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

def _rows():
    for n, A, B in _pdm_cases:
        perms = list(permutations(range(n)))
        functions = _pdm_functions(n)
        yield _pdm_sum((_pdm_P(A, _pdm_alpha(tau))*_pdm_sign(tau))*B.det() for tau in perms), _pdm_sum((_pdm_sign(tau)*_pdm_P(A, _pdm_alpha(tau)))*B.det() for tau in perms)

_pdm_verify(_rows(), 'determinant_commute', 'polynomial')
