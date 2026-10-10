# 対象ラベル: claim_quadratic_trichotomy_at_least_one
# 既存統合検算と同じ有理数27個を、本文の符号と平方比較で場合分けする。
_qta_values = sorted({QQ(n) / QQ(d) for n in range(-6, 7) for d in range(1, 4)})
assert len(_qta_values) == 27
_qta_pairs = [(a, b) for a in _qta_values for b in _qta_values]
_qta_cases = {
    'nonpositive': [(a, b) for a, b in _qta_pairs
                    if a <= 0 and b <= 0 and (a, b) != (QQ(0), QQ(0))],
    'positive_negative_direct': [(a, b) for a, b in _qta_pairs
                                 if 0 < a and b < 0 and QQ(2)*(b*b) < a*a],
    'positive_negative_negated': [(a, b) for a, b in _qta_pairs
                                  if 0 < a and b < 0 and a*a < QQ(2)*(b*b)],
    'negative_positive_direct': [(a, b) for a, b in _qta_pairs
                                 if a < 0 and 0 < b and a*a < QQ(2)*(b*b)],
    'negative_positive_negated': [(a, b) for a, b in _qta_pairs
                                  if a < 0 and 0 < b and QQ(2)*(b*b) < a*a],
}
assert all(_qta_cases.values())


def _qta_check_pair(case, left, right, relation, label):
    checked = 0
    for a, b in _qta_cases[case]:
        lhs, rhs = left(a, b), right(a, b)
        assert lhs.parent() is QQ and rhs.parent() is QQ
        if relation == '=':
            assert lhs == rhs, (label, a, b, lhs, rhs)
        else:
            assert relation == '<'
            assert lhs < rhs, (label, a, b, lhs, rhs)
        checked += 1
    assert checked > 0, (label, 'no tested cases')
    print('RESULT: PASS (%s: %d 有理数組、%s)' % (label, checked, relation))
