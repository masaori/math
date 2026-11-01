"""四つの Kac--Ward 行列式の定数項が 1 であることを厳密検査する。"""

R = PolynomialRing(QQbar, "x")
x = R.gen()
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


def transition_entry(L, a, b, edge, successor):
    if endpoints(L, edge)[1] != endpoints(L, successor)[0] or successor == reversal(edge):
        return QQbar(0)
    turn = (direction(successor) - direction(edge)) % 4
    phase = {0: QQbar(1), 1: zeta8, 3: zeta8 ** (-1)}[turn]
    ch, cv = seam_parities(L, successor)
    return QQbar(ZZ(-1) ** (a * ch + b * cv)) * phase


for L in (1, 2):
    oriented = edges(L)
    size = len(oriented)
    for a in (0, 1):
        for b in (0, 1):
            M = matrix(QQbar, size, size,
                       lambda i, j: transition_entry(L, a, b, oriented[i], oriented[j]))
            K = identity_matrix(R, size) - x * M.change_ring(R)
            assert K(x=0) == identity_matrix(QQbar, size)
            D = K.determinant()
            assert D[0] == 1

print("PASS: L=1,2 の四つの Kac--Ward 行列式の定数項は 1")
