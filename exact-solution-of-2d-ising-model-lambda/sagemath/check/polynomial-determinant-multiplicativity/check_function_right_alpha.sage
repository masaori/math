# 対象ラベル: claim_polynomial_determinant_mul
# 式ペア: \alpha(\beta(f))(i) = \beta(f)(i)
# 帰属: 有限集合・ZZ・Q(zeta_8)[x]。浮動小数点を使わない。
import os

if '_pdm_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

def _rows():
    for n in (1, 2, 3):
        for f in filter(_pdm_bijective, _pdm_functions(n)):
            for i in range(n):
                yield _pdm_alpha(_pdm_beta(f))[i], _pdm_beta(f)[i]

_pdm_verify(_rows(), 'function_right_alpha', 'finite')
