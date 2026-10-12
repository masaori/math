from itertools import product

# 0〜4 点の全自己写像。ラベルには連続しない自然数を使う。
_fma_cases = []
for size in range(5):
    points = tuple(3*k + 2 for k in range(size))
    for values in product(points, repeat=size):
        _fma_cases.append((points, dict(zip(points, values))))
assert len(_fma_cases) == 289
assert sum(len(points) for points, f in _fma_cases) == 1114
assert _fma_cases[0] == ((), {})
assert any(len(set(f.values())) < len(points) for points, f in _fma_cases)
assert any(len(set(f.values())) == len(points) for points, f in _fma_cases if points)
_fma_results = {}

def _fma_iter(f, count, point):
    # 回数の加法則を用いず、一歩ずつ進む。
    for _ in range(count):
        point = f[point]
    return point

def _fma_inputs(successor):
    for points, f in _fma_cases:
        for i in points:
            for m in range(7):
                for n in (range(7) if successor else (0,)):
                    yield f, m, n, i

def _fma_record(name, count, expected):
    assert count == expected, (name, count, expected)
    assert name not in _fma_results
    _fma_results[name] = count
    print('PASS %s: %d exact equalities' % (name, count))
