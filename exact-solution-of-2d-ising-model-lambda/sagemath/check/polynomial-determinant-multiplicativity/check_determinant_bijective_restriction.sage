# 対象ラベル: claim_polynomial_determinant_mul
# 式ペア: \sum_{f\in\mathcal F}P(f)I(f) = \sum_{f\in\mathcal U}P(f)I(f)
# 帰属: 有限集合・ZZ・Q(zeta_8)[x]。浮動小数点を使わない。
import os

if '_pdm_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

def _rows():
    for n, A, B in _pdm_cases:
        perms = list(permutations(range(n)))
        functions = _pdm_functions(n)
        yield _pdm_sum(_pdm_P(A, f)*_pdm_I(B, f) for f in functions), _pdm_sum(_pdm_P(A, f)*_pdm_I(B, f) for f in functions if _pdm_bijective(f))

_pdm_verify(_rows(), 'determinant_bijective_restriction', 'polynomial')
