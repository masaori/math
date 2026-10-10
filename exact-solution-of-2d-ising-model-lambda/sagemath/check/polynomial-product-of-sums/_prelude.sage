from itertools import product as _fps_cartesian, combinations as _fps_subsets

_fps_field = CyclotomicField(8)
_fps_zeta = _fps_field.gen()
_fps_ring = PolynomialRing(_fps_field, 'x')
_fps_x = _fps_ring.gen()

def _fps_sum(values):
    return sum(values, _fps_ring.zero())

def _fps_prod(values):
    return prod(values, _fps_ring.one())

def _fps_functions(S, B):
    return tuple(_fps_cartesian(B, repeat=len(S)))

def _fps_at(f, S, i):
    return f[S.index(i)]

def _fps_restrict(h, Sp, S):
    return tuple(_fps_at(h, Sp, i) for i in S)

def _fps_insert(S, i0, b, f):
    Sp = tuple(sorted(S + (i0,)))
    return tuple(b if i == i0 else _fps_at(f, S, i) for i in Sp)

def _fps_split(S, i0, h):
    Sp = tuple(sorted(S + (i0,)))
    return (_fps_at(h, Sp, i0), _fps_restrict(h, Sp, S))

def _fps_weight(S, g, f):
    return _fps_prod(g[i, _fps_at(f, S, i)] for i in S)

def _fps_product(S, B, g):
    return _fps_prod(_fps_sum(g[i, j] for j in B) for i in S)

_fps_cases = []
for _fps_n in range(4):
    for _fps_m in range(4):
        for _fps_variant in range(3):
            _fps_A = tuple(range(_fps_n))
            _fps_B = tuple(range(_fps_m))
            _fps_g = {}
            for _fps_i in _fps_A:
                for _fps_j in _fps_B:
                    if _fps_variant == 0:
                        _fps_value = 0 if (_fps_i + _fps_j) % 2 == 0 else _fps_i - _fps_j
                    elif _fps_variant == 1:
                        _fps_value = (_fps_i + 1)*_fps_x^2 + _fps_zeta^(_fps_j + 1)*_fps_x + _fps_j - _fps_i
                    else:
                        _fps_value = (-1)^(_fps_i + _fps_j)*(_fps_x - _fps_zeta^((_fps_i + 1)*(_fps_j + 1)))*(_fps_x + _fps_j - _fps_i)
                    _fps_g[_fps_i, _fps_j] = _fps_ring(_fps_value)
            _fps_cases.append((_fps_A, _fps_B, _fps_g))

def _fps_steps():
    for A, B, g in _fps_cases:
        for size in range(len(A)):
            for S in _fps_subsets(A, size):
                for i0 in A:
                    if i0 not in S:
                        yield A, B, g, S, i0, tuple(sorted(S + (i0,)))

def _fps_verify(pairs, label):
    count = 0
    for lhs, rhs in pairs:
        assert lhs == rhs, (label, count, lhs, rhs)
        count += 1
    assert count > 0, label
    print('RESULT: PASS (%s; %s equations)' % (label, count))
