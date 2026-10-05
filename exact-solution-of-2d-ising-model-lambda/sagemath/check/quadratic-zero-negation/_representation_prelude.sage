# 対象ラベル: claim_quadratic_zero_representation
# QQ 上の二係数を厳密な二次体で取り出し、二つの埋込みで QQbar の値を求める。
_qzr_poly = PolynomialRing(QQ, 't')
_qzr_t = _qzr_poly.gen()
_qzr_field = NumberField(_qzr_t**2 - 2, 'u')
_qzr_u = _qzr_field.gen()
_qzr_roots = (_qzr_t**2 - 2).roots(QQbar, multiplicities=False)
_qzr_samples = sorted(set(QQ(p) / QQ(q) for p in range(-4, 5) for q in range(1, 4)))
assert len(_qzr_roots) == 2 and len(_qzr_samples) == 19
_qzr_cases = []
for _qzr_s in _qzr_roots:
    assert _qzr_s * _qzr_s == QQbar(2)
    _qzr_embedding = _qzr_field.hom([_qzr_s], QQbar)
    for _qzr_a0 in _qzr_samples:
        for _qzr_b0 in _qzr_samples:
            _qzr_element = _qzr_field(_qzr_a0) + _qzr_field(_qzr_b0) * _qzr_u
            _qzr_rep = tuple(_qzr_element.list())
            assert len(_qzr_rep) == 2
            _qzr_cases.append((_qzr_s, _qzr_embedding(_qzr_element), _qzr_rep))
assert len(_qzr_cases) == 722

_qzr_counts = {}
def _qzr_check(group, step, label):
    checked = 0
    qzero, zero = QQ(0), QQbar(0)
    for s, xi, rep in _qzr_cases:
        a, b = rep
        if step != 0:
            if group in ('forward', 'pair') and xi != zero:
                continue
            if group == 'reverse' and rep != (qzero, qzero):
                continue
        if group == 'forward':
            row = (QQbar(a) + QQbar(b) * s, xi, zero, zero + zero,
                   zero + zero * s, QQbar(qzero) + zero * s,
                   QQbar(qzero) + QQbar(qzero) * s)
        elif group == 'pair':
            row = (rep, (a, b), (qzero, qzero))
        elif group == 'reverse':
            row = (xi, QQbar(a) + QQbar(b) * s,
                   QQbar(qzero) + QQbar(qzero) * s,
                   zero + QQbar(qzero) * s, zero + zero * s,
                   zero + zero, zero)
        else:
            raise ValueError(group)
        assert row[step] == row[step + 1], (label, s, rep, row)
        checked += 1
    assert checked == (722 if step == 0 else 2), (label, checked)
    _qzr_counts[label] = checked
    print('PASS %s: %d exact equations' % (label, checked))
