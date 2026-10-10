# 対象ラベル: claim_polynomial_determinant_mul
# 式ペア: P(f)I(f) = P(f)\,0
# 帰属: 有限集合・ZZ・Q(zeta_8)[x]。浮動小数点を使わない。
import os

if '_pdm_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

def _rows():
    for n, A, B in _pdm_cases:
        for f in _pdm_functions(n):
            if not _pdm_bijective(f):
                yield _pdm_P(A, f)*_pdm_I(B, f), _pdm_P(A, f)*_pdm_ring.zero()

_pdm_verify(_rows(), 'nonbijective_weight_substitute', 'polynomial')
