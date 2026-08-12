# 対象ラベル: claim_dual_edge_map_bijective
# 帰属: 有限集合と NN。浮動小数点を使わない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))


def dual_edge_map(L):
    image = {}
    inverse = {}
    for i in range(L):
        for j in range(L):
            horizontal = edge_number_horizontal(L, i, j)
            vertical = edge_number_vertical(L, i, j)
            image[horizontal] = edge_number_vertical(L, i, j + 1)
            image[vertical] = edge_number_horizontal(L, i + 1, j)
            inverse[horizontal] = edge_number_vertical(L, i - 1, j)
            inverse[vertical] = edge_number_horizontal(L, i, j - 1)
    return image, inverse


for L in (1, 2, 3, 4, 5):
    edges = set(range(1, 2 * L * L + 1))
    image, inverse = dual_edge_map(L)
    assert set(image) == edges
    assert set(image.values()) == edges
    assert set(inverse) == edges
    assert set(inverse.values()) == edges
    for edge in edges:
        assert inverse[image[edge]] == edge
        assert image[inverse[edge]] == edge
    print("L=%d: %d 本の辺で二つの往復律と全単射性を確認" % (L, len(edges)))

print("RESULT: PASS")
