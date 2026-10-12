# 対象ラベル: claim_finite_permutation_orbit_enumeration
# 有限集合と自然数だけによる厳密な検算。
from itertools import permutations


def _orbit_iterate(f, n, i):
    for _ in range(n):
        i = f[i]
    return i


def _orbit_ray(f, i):
    seen = set()
    j = i
    while j not in seen:
        seen.add(j)
        j = f[j]
    return seen


def _orbit_cases():
    for size in range(7):
        for f in permutations(range(size)):
            g = tuple(f.index(j) for j in range(size))
            for i in range(size):
                p = next(r for r in range(1, size + 1) if _orbit_iterate(f, r, i) == i)
                yield size, f, g, i, p


def _orbit_rows(size, f, g, i, p):
    e = lambda n: _orbit_iterate(f, n, i)
    C = set(e(r) for r in range(p))
    orbit = _orbit_ray(f, i) | _orbit_ray(g, i)
    yield 'zero', e(0), '=', i
    yield 'period', e(p), '=', i
    yield 'last_successor', (p - 1) + 1, '=', p
    yield 'last_lt', p - 1, '<', p
    for r in range(p):
        yield 'bounded_member', e(r), 'in', C
    for r in range(2 * size + 3):
        yield 'step_commute', f[e(r)], '=', _orbit_iterate(f, r, f[i])
        yield 'step_recursion', _orbit_iterate(f, r, f[i]), '=', e(r + 1)
    r = p - 1
    yield 'boundary_index', r + 1, '=', p
    yield 'forward_step', f[e(r)], '=', e(r + 1)
    yield 'forward_boundary', e(r + 1), '=', e(p)
    yield 'forward_return', e(p), '=', i
    yield 'forward_zero', i, '=', e(0)
    yield 'backward_zero', g[e(0)], '=', g[i]
    yield 'backward_return', g[i], '=', g[e(p)]
    yield 'backward_boundary', g[e(p)], '=', g[e((p - 1) + 1)]
    yield 'backward_step', g[e((p - 1) + 1)], '=', g[f[e(p - 1)]]
    yield 'backward_cancel', g[f[e(p - 1)]], '=', e(p - 1)
    for k in range(p - 1):
        yield 'predecessor_lt', k, '<', p
        yield 'backward_positive_step', g[e(k + 1)], '=', g[f[e(k)]]
        yield 'backward_positive_cancel', g[f[e(k)]], '=', e(k)
    for t in (f, g):
        yield 'reach_zero', _orbit_iterate(t, 0, i), '=', i
        yield 'reach_zero_point', i, '=', e(0)
        yield 'reach_zero_member', e(0), 'in', C
        for n in range(2 * size + 3):
            yield 'reach_succ_recursion', _orbit_iterate(t, n + 1, i), '=', _orbit_iterate(t, n, t[i])
            yield 'reach_succ_commute', _orbit_iterate(t, n, t[i]), '=', t[_orbit_iterate(t, n, i)]
            yield 'reach_succ_member', t[_orbit_iterate(t, n, i)], 'in', C
    for r in range(p):
        for t in range(p):
            if e(r) == e(t):
                yield 'injective', r, '=', t
    yield 'card_domain', p, '=', len(range(p))
    yield 'card_bijection', len(range(p)), '=', len(orbit)
    yield 'card_length', len(orbit), '=', len(orbit)


def _orbit_check(selected=None):
    counts = {}
    starts = 0
    for size, f, g, i, p in _orbit_cases():
        starts += 1
        for name, left, relation, right in _orbit_rows(size, f, g, i, p):
            if selected is not None and name != selected:
                continue
            valid = left == right if relation == '=' else left < right if relation == '<' else left in right
            assert valid, (name, f, i, p, left, relation, right)
            counts[name] = counts.get(name, 0) + 1
        if selected is None:
            values = [_orbit_iterate(f, r, i) for r in range(p)]
            orbit = _orbit_ray(f, i) | _orbit_ray(g, i)
            assert set(values) == orbit
            assert len(set(values)) == p
            for j in range(size):
                assert (j in orbit) == any(value == j for value in values)
    assert starts == 5039
    assert sum(1 for size in range(7) for _ in permutations(range(size))) == 874
    assert len(counts) == (30 if selected is None else 1)
    print('PASS:', counts, 'starts=', starts)
    return counts
