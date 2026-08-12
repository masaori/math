# 対象ラベル: def_global_spin_reversal, claim_global_spin_reversal_preserves_broken_edge
# 帰属: スピン値は ZZ、格子と辺は有限集合。浮動小数点を使わない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))


def reverse_configuration(sigma):
    return {v: -ZZ(value) for v, value in sigma.items()}


for L in range(1, 5):
    checked = 0
    for sigma in configurations(L):
        reversed_sigma = reverse_configuration(sigma)
        assert all(value in (ZZ(1), ZZ(-1)) for value in reversed_sigma.values())
        for u, w in edges(L):
            left = reversed_sigma[u] != reversed_sigma[w]
            middle = -ZZ(sigma[u]) != -ZZ(sigma[w])
            right = sigma[u] != sigma[w]
            assert left == middle
            assert middle == right
            checked += 1
    assert checked == (2 ** (L ** 2)) * 2 * (L ** 2)
    print("L=%d: %d 本の配位つき辺ですべて通過" % (L, checked))

print("RESULT: PASS")
