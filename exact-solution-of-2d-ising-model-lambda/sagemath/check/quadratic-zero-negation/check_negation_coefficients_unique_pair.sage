# 対象ラベル: claim_quadratic_negation_representation
# 帰属: QQ / QQbar の厳密計算。浮動小数点を使わない。
import os
import sys

if '_qnm_cases' not in globals():
    _qnm_check_dir = os.path.dirname(os.path.abspath(__file__))
    if not os.path.isfile(os.path.join(_qnm_check_dir, '_negation_membership_prelude.sage')):
        _qnm_check_dir = os.path.dirname(os.path.abspath(sys.argv[0]))
    load(os.path.join(_qnm_check_dir, '_negation_membership_prelude.sage'))

# 式ペア: rep_s(-xi) = (-a,-b)
# 二次体内で負元を作り、その二係数を独立に取り出す。
def _qnm_rows():
    for s, xi, (a, b) in _qnm_cases:
        element = _qzr_field(a) + _qzr_field(b)*_qzr_u
        embedding = _qzr_field.hom([s], QQbar)
        assert embedding(element) == xi
        assert embedding(-element) == -xi
        yield tuple((-element).list()), (-a, -b)

_qnm_check(_qnm_rows(), "negation_coefficients_unique_pair")
