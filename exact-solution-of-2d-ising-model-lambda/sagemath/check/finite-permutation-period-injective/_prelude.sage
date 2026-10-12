from itertools import permutations

def _fpi_iter(sigma, n, i):
    value = i
    for unused in range(n):
        value = sigma[value]
    return value

_fpi_data = []
_fpi_permutations = 0
for size in range(7):
    points = tuple(3 * k + 2 for k in range(size))
    for images in permutations(points):
        _fpi_permutations += 1
        sigma = dict(zip(points, images))
        for i in points:
            values = tuple(_fpi_iter(sigma, n, i) for n in range(2 * size + 1))
            period = next(n for n in range(1, size + 1) if values[n] == i)
            assert all(value in points for value in values)
            _fpi_data.append((sigma, i, period, values))
assert _fpi_permutations == 874 and len(_fpi_data) == 5039

def _fpi_pairs(short=False, collision=False):
    for sigma, i, p, values in _fpi_data:
        for t in range(1, p if short else len(values)):
            for r in range(t):
                if not collision or values[r] == values[t]:
                    yield sigma, i, p, r, t, t-r, values

_fpi_totals = {}
def _fpi_check(name, predicate, short=False, collision=False):
    checked = 0
    for args in _fpi_pairs(short=short, collision=collision):
        assert predicate(*args), (name, args)
        checked += 1
    assert checked > 0
    _fpi_totals[name] = checked
    print('PASS: {} ({} 確認)'.format(name, checked))
