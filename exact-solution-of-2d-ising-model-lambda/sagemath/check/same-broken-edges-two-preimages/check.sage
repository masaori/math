# 対象ラベル: claim_same_broken_edges_equal_or_global_reversal
# 帰属: スピン値は ZZ、格子・辺・配位は有限集合。浮動小数点を使わない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))


def broken_signature(L, sigma):
    return tuple(sigma[u] != sigma[w] for u, w in edges(L))


def reverse_configuration(sigma):
    return {v: -ZZ(value) for v, value in sigma.items()}


for L in range(1, 4):
    fibers = {}
    all_configurations = list(configurations(L))
    for sigma in all_configurations:
        fibers.setdefault(broken_signature(L, sigma), []).append(sigma)

    assert sum(len(fiber) for fiber in fibers.values()) == 2 ** (L ** 2)
    for fiber in fibers.values():
        assert len(fiber) == 2
        sigma, tau = fiber
        assert tau == reverse_configuration(sigma)
        assert broken_signature(L, sigma) == broken_signature(L, tau)

    print("L=%d: %d 配位・%d 個の破れ集合、各原像は全スピン反転の対" %
          (L, len(all_configurations), len(fibers)))

print("RESULT: PASS")
