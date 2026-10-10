# 対象ラベル: claim_quadratic_negation_representation
# 帰属: QQ / QQbar の厳密計算。浮動小数点を使わない。
import os
import sys

if '_qnm_cases' not in globals():
    _qnm_check_dir = os.path.dirname(os.path.abspath(__file__))
    if not os.path.isfile(os.path.join(_qnm_check_dir, '_negation_membership_prelude.sage')):
        _qnm_check_dir = os.path.dirname(os.path.abspath(sys.argv[0]))
    load(os.path.join(_qnm_check_dir, '_negation_membership_prelude.sage'))

# 式ペア: iota_Q(-a)+(-iota_Q(b))*s = iota_Q(-a)+iota_Q(-b)*s
def _qnm_rows():
    for s, xi, (a, b) in _qnm_cases:
        yield QQbar(-a) + (-QQbar(b))*s, QQbar(-a) + QQbar(-b)*s

_qnm_check(_qnm_rows(), "negation_coefficients_right_embedding")
