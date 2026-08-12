# 対象ラベル: claim_low_temperature_polynomial_identity
# 帰属: 格子・辺・配位は有限集合、多項式は ZZ['x']。浮動小数点を使わない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))


def broken_edge_set(L, sigma):
    return frozenset(e for e in range(1, 2 * L * L + 1)
                     if sigma[endpoints(L, e)[0]] != sigma[endpoints(L, e)[1]])


def low_temperature_polynomial(L):
    attainable = {broken_edge_set(L, sigma) for sigma in configurations(L)}
    return sum((x ** len(B) for B in attainable), PolynomialRingZx(0))


for L in range(1, 4):
    all_configurations = list(configurations(L))
    fibers = {}
    for sigma in all_configurations:
        fibers.setdefault(broken_edge_set(L, sigma), []).append(sigma)

    for B, fiber in fibers.items():
        assert len(fiber) == 2
        assert all(broken_bond_count(L, sigma) == len(B) for sigma in fiber)

    left = partition_polynomial(L)
    right = 2 * low_temperature_polynomial(L)
    assert left == right
    print("L=%d: %d 個の破れ集合、各原像 2 配位、Z_L = 2 D_L" % (L, len(fibers)))

print("RESULT: PASS")
