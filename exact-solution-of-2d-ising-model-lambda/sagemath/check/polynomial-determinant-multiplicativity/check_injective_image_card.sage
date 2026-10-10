# 対象ラベル: claim_polynomial_determinant_mul
# 式ペア: |f(\mathcal J)| = |\mathcal J|
# 帰属: 有限集合・ZZ・Q(zeta_8)[x]。浮動小数点を使わない。
import os

if '_pdm_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

def _rows():
    for n in (1, 2, 3):
        for f in _pdm_functions(n):
            if _pdm_injective(f):
                yield ZZ(len(set(f.values()))), ZZ(n)

_pdm_verify(_rows(), 'injective_image_card', 'finite')
