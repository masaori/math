# 対象ラベル: claim_polynomial_determinant_mul
# 式ペア: \pi(\tau(\tau^{-1}(i))) = \pi(i)
# 帰属: 有限集合・ZZ・Q(zeta_8)[x]。浮動小数点を使わない。
import os

if '_pdm_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

def _rows():
    for n in (1, 2, 3):
        for tau in permutations(range(n)):
            for pi in permutations(range(n)):
                for i in range(n):
                    yield pi[tau[_pdm_inverse(tau)[i]]], pi[i]

_pdm_verify(_rows(), 'right_comp_left_inverse', 'finite')
