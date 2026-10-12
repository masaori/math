# 対象ラベル: claim_quadratic_positive_cone_mul_closed
# 有理係数と t^2-2 の二次体の厳密計算。実数・複素数・浮動小数点を使わない。
from collections import Counter, namedtuple

def _qpm_conditions(a, b):
    return (a >= 0 and b >= 0 and (a, b) != (0, 0),
            a > 0 and b < 0 and 2 * b * b < a * a,
            a < 0 and b > 0 and a * a < 2 * b * b)

def _qpm_positive(pair):
    return any(_qpm_conditions(*pair))

_qpm_names = ('nonnegative', 'negative_second', 'negative_first')
_qpm_values = sorted(set(sign * QQ(n) / QQ(d)
                         for n in range(5) for d in range(1, 5) for sign in (1, -1)))
_qpm_inputs = []
for _qpm_a in _qpm_values:
    for _qpm_b in _qpm_values:
        _qpm_flags = _qpm_conditions(_qpm_a, _qpm_b)
        if not any(_qpm_flags):
            continue
        assert sum(_qpm_flags) == 1
        _qpm_inputs.append((_qpm_a, _qpm_b, _qpm_names[_qpm_flags.index(True)]))
assert len(_qpm_inputs) == 264

_qpm_polynomial = PolynomialRing(QQ, 't')
_qpm_t = _qpm_polynomial.gen()
_qpm_field = NumberField(_qpm_t**2 - 2, 'r')
_qpm_r = _qpm_field.gen()

def _qpm_rep(value, root_sign):
    # r を基準にした標準形から、指定した根 root_sign*r の係数を取り出す。
    return (QQ(value[0]), root_sign * QQ(value[1]))

_QpmCase = namedtuple('_QpmCase', 'root_sign a b ap bp forward reverse branch')
_qpm_cases = []
_qpm_case_counts = Counter()
for _qpm_sign in (QQ(1), QQ(-1)):
    _qpm_s = _qpm_sign * _qpm_r
    assert _qpm_s * _qpm_s == _qpm_field(2)
    for _qpm_a, _qpm_b, _qpm_first in _qpm_inputs:
        _qpm_xi = _qpm_field(_qpm_a) + _qpm_field(_qpm_b) * _qpm_s
        assert _qpm_rep(_qpm_xi, _qpm_sign) == (_qpm_a, _qpm_b)
        for _qpm_ap, _qpm_bp, _qpm_second in _qpm_inputs:
            _qpm_eta = _qpm_field(_qpm_ap) + _qpm_field(_qpm_bp) * _qpm_s
            assert _qpm_rep(_qpm_eta, _qpm_sign) == (_qpm_ap, _qpm_bp)
            _qpm_branch = (_qpm_first, _qpm_second)
            _qpm_cases.append(_QpmCase(
                _qpm_sign, _qpm_a, _qpm_b, _qpm_ap, _qpm_bp,
                _qpm_rep(_qpm_xi * _qpm_eta, _qpm_sign),
                _qpm_rep(_qpm_eta * _qpm_xi, _qpm_sign), _qpm_branch))
            _qpm_case_counts[_qpm_branch] += 1
assert len(_qpm_cases) == 139392
assert set(_qpm_case_counts) == {(left, right) for left in _qpm_names for right in _qpm_names}
_qpm_class_counts = Counter(name for a, b, name in _qpm_inputs)
assert all(count == 2 * _qpm_class_counts[left] * _qpm_class_counts[right]
           for (left, right), count in _qpm_case_counts.items())

def _qpm_selected(branch=None):
    for case in _qpm_cases:
        if branch is None or case.branch == branch:
            yield case

_qpm_results = {}
def _qpm_record(name, count, branch, kind):
    expected = len(_qpm_cases) if branch is None else _qpm_case_counts[branch]
    assert count == expected and count > 0, (name, count, expected)
    assert name not in _qpm_results
    _qpm_results[name] = (count, kind)
    print('RESULT: PASS (%s: %d %s)' % (name, count, kind))
