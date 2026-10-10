# 対象ラベル: claim_polynomial_determinant_mul
# 式ペア: \sum_\pi c_{T_\tau(\pi)}\prod_i B_{\tau(i),T_\tau(\pi)(i)} = \sum_\pi c_{\pi\circ\tau}\prod_i B_{\tau(i),(\pi\circ\tau)(i)}
# 帰属: 有限集合・ZZ・Q(zeta_8)[x]。浮動小数点を使わない。
import os

if '_pdm_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

def _rows():
    for n, A, B in _pdm_cases:
        perms = list(permutations(range(n)))
        for tau in perms:
            yield _pdm_sum(_pdm_sign(_pdm_T(tau, pi))*_pdm_prod(B[tau[i], _pdm_T(tau, pi)[i]] for i in range(n)) for pi in perms), _pdm_sum(_pdm_sign(_pdm_comp(pi, tau))*_pdm_prod(B[tau[i], _pdm_comp(pi, tau)[i]] for i in range(n)) for pi in perms)

_pdm_verify(_rows(), 'inner_T_definition', 'polynomial')
