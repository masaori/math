from itertools import permutations, product

_pdm_field = CyclotomicField(8)
_pdm_zeta = _pdm_field.gen()
_pdm_ring = PolynomialRing(_pdm_field, "x")
_pdm_x = _pdm_ring.gen()

def _pdm_sum(values):
    return sum(values, _pdm_ring.zero())

def _pdm_prod(values):
    return prod(values, _pdm_ring.one())

def _pdm_sign(sigma):
    inversions = sum(1 for i in range(len(sigma))
                     for j in range(i + 1, len(sigma)) if sigma[j] < sigma[i])
    return _pdm_ring((-1)^inversions)

_pdm_cases = []
for n in (1, 2, 3):
    x, z = _pdm_x, _pdm_zeta
    # 対角・三角、非有理係数の密行列、符号付き疎行列。
    pairs = [
        (matrix(_pdm_ring, n, lambda i, j: (i + 1) + x if i == j else 0),
         matrix(_pdm_ring, n, lambda i, j: (j + 1)*x + z^(i + j) if i <= j else 0)),
        (matrix(_pdm_ring, n, lambda i, j: z^(i + 2*j) + (i - j)*x + (j + 1)*x^2),
         matrix(_pdm_ring, n, lambda i, j: (i + 1) + z^(2*i + j)*x + (i == j)*x^2)),
        (matrix(_pdm_ring, n, lambda i, j: (-1)^i*(1 + z*x) if j == (i + 1) % n else 0),
         matrix(_pdm_ring, n, lambda i, j: z^j - x if i == j else (i - j)*x^2)),
    ]
    _pdm_cases.extend((n, A, B) for A, B in pairs)


def _pdm_sign_integer(sigma):
    return ZZ(-1)^sum(1 for i in range(len(sigma))
                     for j in range(i + 1, len(sigma)) if sigma[j] < sigma[i])

def _pdm_alpha(tau):
    return dict(enumerate(tau))

def _pdm_beta(f):
    return tuple(f[i] for i in range(len(f)))

def _pdm_comp(pi, tau):
    return tuple(pi[tau[i]] for i in range(len(tau)))

def _pdm_inverse(tau):
    return tuple(tau.index(i) for i in range(len(tau)))

def _pdm_T(tau, pi):
    return _pdm_comp(pi, tau)

def _pdm_S(tau, sigma):
    return _pdm_comp(sigma, _pdm_inverse(tau))

def _pdm_functions(n):
    return [dict(enumerate(values)) for values in product(range(n), repeat=n)]

def _pdm_injective(f):
    return all(f[i] != f[j] for i in f for j in f if i != j)

def _pdm_bijective(f):
    return len(set(f.values())) == len(f)

def _pdm_P(A, f):
    return _pdm_prod(A[i, f[i]] for i in range(A.nrows()))

def _pdm_I(B, f):
    n = B.nrows()
    return _pdm_sum(_pdm_sign(sigma)*_pdm_prod(B[f[i], sigma[i]] for i in range(n))
                    for sigma in permutations(range(n)))

def _pdm_verify(rows, name, kind="polynomial"):
    count = 0
    for lhs, rhs in rows:
        if kind == "polynomial":
            assert lhs.parent() is _pdm_ring and rhs.parent() is _pdm_ring
        else:
            assert lhs in ZZ and rhs in ZZ
        assert lhs == rhs, (name, count, lhs, rhs)
        count += 1
    assert count > 0, (name, "no tested cases")
    print("RESULT: PASS %s: %d exact %s equalities" % (name, count, kind))
