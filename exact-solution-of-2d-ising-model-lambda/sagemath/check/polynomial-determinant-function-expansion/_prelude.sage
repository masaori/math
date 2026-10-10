from itertools import permutations, product

_dfe_field = CyclotomicField(8)
_dfe_zeta = _dfe_field.gen()
_dfe_ring = PolynomialRing(_dfe_field, "x")
_dfe_x = _dfe_ring.gen()

def _dfe_sum(values):
    return sum(values, _dfe_ring.zero())

def _dfe_prod(values):
    return prod(values, _dfe_ring.one())

def _dfe_sign(sigma):
    inversions = sum(1 for i in range(len(sigma))
                     for j in range(i + 1, len(sigma)) if sigma[j] < sigma[i])
    return _dfe_ring((-1)^inversions)

_dfe_cases = []
for n in (1, 2, 3):
    x, z = _dfe_x, _dfe_zeta
    # 対角・三角、非有理係数の密行列、符号付き疎行列。
    pairs = [
        (matrix(_dfe_ring, n, lambda i, j: (i + 1) + x if i == j else 0),
         matrix(_dfe_ring, n, lambda i, j: (j + 1)*x + z^(i + j) if i <= j else 0)),
        (matrix(_dfe_ring, n, lambda i, j: z^(i + 2*j) + (i - j)*x + (j + 1)*x^2),
         matrix(_dfe_ring, n, lambda i, j: (i + 1) + z^(2*i + j)*x + (i == j)*x^2)),
        (matrix(_dfe_ring, n, lambda i, j: (-1)^i*(1 + z*x) if j == (i + 1) % n else 0),
         matrix(_dfe_ring, n, lambda i, j: z^j - x if i == j else (i - j)*x^2)),
    ]
    _dfe_cases.extend((n, A, B) for A, B in pairs)

def _dfe_verify(rows, name):
    count = 0
    for lhs, rhs in rows:
        assert lhs.parent() is _dfe_ring and rhs.parent() is _dfe_ring
        assert lhs == rhs, (name, count, lhs, rhs)
        count += 1
    assert count > 0
    print("RESULT: PASS %s: %d exact polynomial equalities" % (name, count))
