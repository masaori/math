# 対象ラベル: claim_polynomial_determinant_mul
# 式ペア: \widehat{\iota_{\mathbb Z}(\operatorname{sgn}(\pi))\,\iota_{\mathbb Z}(\operatorname{sgn}(\tau))} = \widehat{\iota_{\mathbb Z}(\operatorname{sgn}(\pi))}\,\widehat{\iota_{\mathbb Z}(\operatorname{sgn}(\tau))}
# 帰属: 有限集合・ZZ・Q(zeta_8)[x]。浮動小数点を使わない。
import os

if '_pdm_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

def _rows():
    for n in (1, 2, 3):
        for tau in permutations(range(n)):
            for pi in permutations(range(n)):
                yield _pdm_ring(_pdm_field(_pdm_sign_integer(pi))*_pdm_field(_pdm_sign_integer(tau))), _pdm_ring(_pdm_field(_pdm_sign_integer(pi)))*_pdm_ring(_pdm_field(_pdm_sign_integer(tau)))

_pdm_verify(_rows(), 'coefficient_constant_map', 'polynomial')
