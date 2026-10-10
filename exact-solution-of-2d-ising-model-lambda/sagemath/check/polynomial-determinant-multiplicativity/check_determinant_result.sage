# 対象ラベル: claim_polynomial_determinant_mul
# 式ペア: \left(\sum_\tau c_\tau\prod_i A_{i,\tau(i)}\right)\det_x(B) = \det_x(A)\det_x(B)
# 帰属: 有限集合・ZZ・Q(zeta_8)[x]。浮動小数点を使わない。
import os

if '_pdm_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

def _rows():
    for n, A, B in _pdm_cases:
        perms = list(permutations(range(n)))
        functions = _pdm_functions(n)
        yield _pdm_sum(_pdm_sign(tau)*_pdm_prod(A[i, tau[i]] for i in range(n)) for tau in perms)*B.det(), A.det()*B.det()

_pdm_verify(_rows(), 'determinant_result', 'polynomial')
