# 対象ラベル: claim_quadratic_negation_mem
# 帰属: QQ / QQbar の厳密計算。浮動小数点を使わない。
import os
import sys

if '_qnm_cases' not in globals():
    _qnm_check_dir = os.path.dirname(os.path.abspath(__file__))
    if not os.path.isfile(os.path.join(_qnm_check_dir, '_negation_membership_prelude.sage')):
        _qnm_check_dir = os.path.dirname(os.path.abspath(sys.argv[0]))
    load(os.path.join(_qnm_check_dir, '_negation_membership_prelude.sage'))

# 所属: iota_Q(-a)+iota_Q(-b)*s in Q_s、証人 (-a,-b) in QQ^2。
_qnm_count = 0
for _qnm_s, _qnm_xi, (_qnm_a, _qnm_b) in _qnm_cases:
    _qnm_witness = (-_qnm_a, -_qnm_b)
    assert all(c in QQ for c in _qnm_witness)
    assert -_qnm_xi == QQbar(_qnm_witness[0]) + QQbar(_qnm_witness[1])*_qnm_s
    _qnm_count += 1
assert _qnm_count == 722
print('PASS negation_membership_witness: %d exact witnesses' % _qnm_count)
