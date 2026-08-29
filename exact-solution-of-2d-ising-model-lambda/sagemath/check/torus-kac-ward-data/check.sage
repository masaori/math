"""向き付き辺・回転位相・四つのスピン構造を有限トーラス上で厳密検査する。"""

zeta8 = QQbar.zeta(8)


def edges(L):
    return [(kind, i, j, d) for kind in ("h", "v")
            for i in range(L) for j in range(L) for d in (0, 1)]


def reversal(edge):
    kind, i, j, d = edge
    return (kind, i, j, 1 - d)


def endpoints(L, edge):
    kind, i, j, d = edge
    boundary0 = (i, j)
    boundary1 = (i, (j + 1) % L) if kind == "h" else ((i + 1) % L, j)
    return (boundary0, boundary1) if d == 0 else (boundary1, boundary0)


def direction(edge):
    kind, _, _, d = edge
    return {("h", 0): 0, ("v", 0): 1, ("h", 1): 2, ("v", 1): 3}[(kind, d)]


def seam_parities(L, edge):
    kind, i, j, _ = edge
    return (ZZ(kind == "h" and j == L - 1), ZZ(kind == "v" and i == L - 1))


for L in range(1, 6):
    oriented = edges(L)
    assert len(oriented) == 4 * L * L
    for edge in oriented:
        assert reversal(reversal(edge)) == edge
        assert reversal(edge) != edge
        assert seam_parities(L, reversal(edge)) == seam_parities(L, edge)
        _, target = endpoints(L, edge)
        successors = [other for other in oriented
                      if endpoints(L, other)[0] == target and other != reversal(edge)]
        for other in successors:
            turn = (direction(other) - direction(edge)) % 4
            assert turn in (0, 1, 3)
            phase = {0: QQbar(1), 1: zeta8, 3: zeta8 ** (-1)}[turn]
            assert phase ** 8 == 1
    spin_structures = [(a, b) for a in (0, 1) for b in (0, 1)]
    assert len(spin_structures) == 4
    for a, b in spin_structures:
        for edge in oriented:
            ch, cv = seam_parities(L, edge)
            sign = ZZ(-1) ** (a * ch + b * cv)
            assert sign in (-1, 1)
            assert sign == ZZ(-1) ** sum(x * y for x, y in zip((a, b), seam_parities(L, reversal(edge))))

print("PASS: L=1,...,5 で向き付き辺・回転位相・四つのスピン構造を厳密検査")
