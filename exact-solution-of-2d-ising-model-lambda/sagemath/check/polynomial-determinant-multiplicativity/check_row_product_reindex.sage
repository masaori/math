# 対象ラベル: claim_polynomial_determinant_mul
# 式ペア: \prod_i B_{\tau(i),\pi(\tau(i))} = \prod_j B_{j,\pi(j)}
# 帰属: 有限集合・ZZ・Q(zeta_8)[x]。浮動小数点を使わない。
import os

if '_pdm_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

def _rows():
    for n, A, B in _pdm_cases:
        for tau in permutations(range(n)):
            for pi in permutations(range(n)):
                yield _pdm_prod(B[tau[i], pi[tau[i]]] for i in range(n)), _pdm_prod(B[j, pi[j]] for j in range(n))

_pdm_verify(_rows(), 'row_product_reindex', 'polynomial')
