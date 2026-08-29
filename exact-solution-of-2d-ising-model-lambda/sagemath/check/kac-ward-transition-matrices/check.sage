"""四つの Kac--Ward 遷移行列の成分が零か 1 の 8 乗根であることを厳密検査する。"""

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


def rotation_phase(edge, successor):
    turn = (direction(successor) - direction(edge)) % 4
    return {0: QQbar(1), 1: zeta8, 3: zeta8 ** (-1)}[turn]


def transition_entry(L, a, b, edge, successor):
    if endpoints(L, edge)[1] != endpoints(L, successor)[0]:
        return QQbar(0)
    if successor == reversal(edge):
        return QQbar(0)
    ch, cv = seam_parities(L, successor)
    twist = QQbar(ZZ(-1) ** (a * ch + b * cv))
    return twist * rotation_phase(edge, successor)


for L in range(1, 4):
    oriented = edges(L)
    for a in (0, 1):
        for b in (0, 1):
            for edge in oriented:
                for successor in oriented:
                    entry = transition_entry(L, a, b, edge, successor)
                    assert entry == 0 or entry ** 8 == 1

print("PASS: L=1,2,3 の四つの遷移行列の全成分が零か 1 の 8 乗根")
