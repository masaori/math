from itertools import permutations as _fpi_permutations

_fpi_perms = []
for size in range(7):
    points = tuple(3*k + 2 for k in range(size))
    for images in _fpi_permutations(points):
        _fpi_perms.append(dict(zip(points, images)))
assert len(_fpi_perms) == 874
_fpi_results = {}

def _fpi_iter(f, n, i):
    for _ in range(n):
        i = f[i]
    return i

def _fpi_inputs(successor=False, collision=False):
    for f in _fpi_perms:
        for n in (range(9) if successor else (0,)):
            for i in f:
                for j in f:
                    if collision and _fpi_iter(f, n + int(successor), i) != _fpi_iter(f, n + int(successor), j):
                        continue
                    yield f, n, i, j

def _fpi_check(name, rows, expected, hypothesis=False):
    count = 0
    for lhs, rhs in rows:
        assert lhs == rhs, (name, lhs, rhs)
        count += 1
    assert count == expected, (name, count, expected)
    _fpi_results[name] = count
    print('PASS: %s (%s %s)' % (name, count, 'hypothesis substitutions' if hypothesis else 'equalities'))
