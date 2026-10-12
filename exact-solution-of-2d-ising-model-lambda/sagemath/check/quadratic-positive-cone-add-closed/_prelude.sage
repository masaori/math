# 対象ラベル: claim_quadratic_positive_cone_add_closed
# 有理係数と t^2-2 の二次体の厳密計算。実数・複素数・浮動小数点を使わない。
from collections import Counter, namedtuple

def _qpa_conditions(a, b):
    return (a >= 0 and b >= 0 and (a, b) != (0, 0),
            a > 0 and b < 0 and 2 * b * b < a * a,
            a < 0 and b > 0 and a * a < 2 * b * b)

def _qpa_positive(pair):
    return any(_qpa_conditions(*pair))

_qpa_names = ('nonnegative', 'negative_second', 'negative_first')
_qpa_values = sorted(set(sign * QQ(n) / QQ(d)
                         for n in range(5) for d in range(1, 5) for sign in (1, -1)))
_qpa_inputs = []
for _qpa_a in _qpa_values:
    for _qpa_b in _qpa_values:
        _qpa_flags = _qpa_conditions(_qpa_a, _qpa_b)
        if not any(_qpa_flags):
            continue
        assert sum(_qpa_flags) == 1
        _qpa_inputs.append((_qpa_a, _qpa_b, _qpa_names[_qpa_flags.index(True)]))
assert len(_qpa_inputs) == 264

_qpa_polynomial = PolynomialRing(QQ, 't')
_qpa_t = _qpa_polynomial.gen()
_qpa_field = NumberField(_qpa_t**2 - 2, 'r')
_qpa_r = _qpa_field.gen()

def _qpa_rep(value, root_sign):
    # r を基準にした標準形から、指定した根 root_sign*r の係数を取り出す。
    return (QQ(value[0]), root_sign * QQ(value[1]))

_QpaCase = namedtuple('_QpaCase', 'root_sign a b ap bp forward reverse branch')
_qpa_cases = []
_qpa_case_counts = Counter()
for _qpa_sign in (QQ(1), QQ(-1)):
    _qpa_s = _qpa_sign * _qpa_r
    assert _qpa_s * _qpa_s == _qpa_field(2)
    for _qpa_a, _qpa_b, _qpa_first in _qpa_inputs:
        _qpa_xi = _qpa_field(_qpa_a) + _qpa_field(_qpa_b) * _qpa_s
        assert _qpa_rep(_qpa_xi, _qpa_sign) == (_qpa_a, _qpa_b)
        for _qpa_ap, _qpa_bp, _qpa_second in _qpa_inputs:
            _qpa_eta = _qpa_field(_qpa_ap) + _qpa_field(_qpa_bp) * _qpa_s
            assert _qpa_rep(_qpa_eta, _qpa_sign) == (_qpa_ap, _qpa_bp)
            _qpa_branch = (_qpa_first, _qpa_second)
            _qpa_cases.append(_QpaCase(
                _qpa_sign, _qpa_a, _qpa_b, _qpa_ap, _qpa_bp,
                _qpa_rep(_qpa_xi + _qpa_eta, _qpa_sign),
                _qpa_rep(_qpa_eta + _qpa_xi, _qpa_sign), _qpa_branch))
            _qpa_case_counts[_qpa_branch] += 1
assert len(_qpa_cases) == 139392
assert set(_qpa_case_counts) == {(left, right) for left in _qpa_names for right in _qpa_names}
_qpa_class_counts = Counter(name for a, b, name in _qpa_inputs)
assert all(count == 2 * _qpa_class_counts[left] * _qpa_class_counts[right]
           for (left, right), count in _qpa_case_counts.items())

def _qpa_selected(branch=None):
    for case in _qpa_cases:
        if branch is None or case.branch == branch:
            yield case

_qpa_results = {}
def _qpa_record(name, count, branch, kind):
    expected = len(_qpa_cases) if branch is None else _qpa_case_counts[branch]
    assert count == expected and count > 0, (name, count, expected)
    assert name not in _qpa_results
    _qpa_results[name] = (count, kind)
    print('RESULT: PASS (%s: %d %s)' % (name, count, kind))
