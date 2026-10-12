from itertools import permutations, combinations

def _fpm_iter(f, n, i):
    for _ in range(n):
        i = f[i]
    return i

_fpm_permutations = []
_fpm_cases = []
_fpm_collisions = []
_fpm_periods = []
for size in range(7):
    points = tuple(3*k + 2 for k in range(size))
    for values in permutations(points):
        sigma = dict(zip(points, values))
        _fpm_permutations.append((points, sigma))
        for i in points:
            orbit_values = tuple(_fpm_iter(sigma, k, i) for k in range(size + 1))
            _fpm_cases.append((points, sigma, i, orbit_values))
            for r, t in combinations(range(size + 1), 2):
                if orbit_values[t] == orbit_values[r]:
                    _fpm_collisions.append((sigma, i, r, t, t-r))
            returns = [n for n in range(1, size + 1) if orbit_values[n] == i]
            period = min(returns) if returns else None
            _fpm_periods.append((points, sigma, i, period))
assert len(_fpm_permutations) == 874
assert len(_fpm_cases) == 5039
assert _fpm_permutations[0] == ((), {})
_fpm_results = {}

def _fpm_record(name, count):
    assert count > 0
    assert name not in _fpm_results
    _fpm_results[name] = count
    print('PASS %s: %d checks' % (name, count))
