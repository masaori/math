_pcp_ring = PolynomialRing(QQ, 't')
_pcp_t = _pcp_ring.gen()
_pcp_field = NumberField(_pcp_t**2 - 2, 'r')
_pcp_roots = (QQbar(2).sqrt(), -QQbar(2).sqrt())
_pcp_samples = (
    (QQ(1), QQ(0)), (QQ(2), QQ(1)), (QQ(3), QQ(-1)), (QQ(-1), QQ(1)),
    (QQ(1)/2, QQ(0)), (QQ(0), QQ(1)), (QQ(3)/2, -QQ(1)/2), (-QQ(1)/2, QQ(1)/2),
)

def _pcp_positive(pair):
    a, b = pair
    return ((a >= 0 and b >= 0 and pair != (0, 0))
            or (a > 0 and b < 0 and 2*b*b < a*a)
            or (a < 0 and b > 0 and a*a < 2*b*b))

def _pcp_field_mem(s, value, pair):
    return (len(pair) == 2 and all(c.parent() is QQ for c in pair)
            and value == QQbar(pair[0]) + QQbar(pair[1])*s)

def _pcp_cone_mem(s, value, pair):
    return _pcp_field_mem(s, value, pair) and _pcp_positive(pair)

_pcp_bases = []
_pcp_steps = []
_pcp_powers = []
for s in _pcp_roots:
    assert s*s == QQbar(2)
    embedding = _pcp_field.hom([s], QQbar)
    for pair in _pcp_samples:
        assert _pcp_positive(pair)
        element = _pcp_field(pair[0]) + _pcp_field(pair[1])*_pcp_field.gen()
        xi = QQbar(pair[0]) + QQbar(pair[1])*s
        base = dict(s=s, pair=pair, xi=xi, one_pair=tuple(_pcp_field(1).list()))
        _pcp_bases.append(base)
        for m in range(10):
            power = element**m
            value = xi**m
            _pcp_powers.append(dict(base, m=m, represented=embedding(power), value=value))
            if m < 9:
                _pcp_steps.append(dict(
                    base, m=m, product=value*xi, successor=xi**(m+1),
                    product_pair=tuple((power*element).list())))
assert len(_pcp_bases) == 16
assert len(_pcp_steps) == 144
assert len(_pcp_powers) == 160
_pcp_results = {}

def _pcp_check(name, cases, predicate):
    count = 0
    for case in cases:
        assert predicate(case), (name, case)
        count += 1
    assert count > 0 and name not in _pcp_results
    _pcp_results[name] = count
    print('PASS: %s (%d exact checks)' % (name, count))
