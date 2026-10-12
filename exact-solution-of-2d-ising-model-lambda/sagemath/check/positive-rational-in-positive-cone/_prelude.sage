_prc_ring = PolynomialRing(QQ, 't')
_prc_t = _prc_ring.gen()
_prc_field = NumberField(_prc_t**2 - 2, 'r')
_prc_roots = (QQbar(2).sqrt(), -QQbar(2).sqrt())
_prc_rationals = sorted(set(QQ(a)/b for a in range(1, 5) for b in range(1, 4)))
assert len(_prc_rationals) == 9
_prc_cases = []
for s in _prc_roots:
    assert s*s == QQbar(2)
    embedding = _prc_field.hom([s], QQbar)
    for q in _prc_rationals:
        assert q > 0
        element = _prc_field(q)
        assert embedding(element) == QQbar(q)
        coefficients = tuple(element.list())
        _prc_cases.append((s, q, q, QQ(0), coefficients))
assert len(_prc_cases) == 18
_prc_results = {}

def _prc_positive(coefficients):
    a, b = coefficients
    return ((a >= 0 and b >= 0 and (a,b) != (0,0))
            or (a > 0 and b < 0 and 2*b*b < a*a)
            or (a < 0 and b > 0 and a*a < 2*b*b))

def _prc_check(name, predicate):
    count = 0
    for case in _prc_cases:
        assert predicate(*case), (name, case)
        count += 1
    assert count == 18
    _prc_results[name] = count
    print('PASS: %s (%s exact checks)' % (name, count))
