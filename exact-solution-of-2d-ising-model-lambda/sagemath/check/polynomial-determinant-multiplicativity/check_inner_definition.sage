# 対象ラベル: claim_polynomial_determinant_mul
# 式ペア: I(\alpha(\tau)) = \sum_\sigma c_\sigma\prod_i B_{\alpha(\tau)(i),\sigma(i)}
# 帰属: 有限集合・ZZ・Q(zeta_8)[x]。浮動小数点を使わない。
import os

if '_pdm_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

def _rows():
    for n, A, B in _pdm_cases:
        perms = list(permutations(range(n)))
        for tau in perms:
            yield _pdm_I(B, _pdm_alpha(tau)), _pdm_sum(_pdm_sign(sigma)*_pdm_prod(B[_pdm_alpha(tau)[i], sigma[i]] for i in range(n)) for sigma in perms)

_pdm_verify(_rows(), 'inner_definition', 'polynomial')
