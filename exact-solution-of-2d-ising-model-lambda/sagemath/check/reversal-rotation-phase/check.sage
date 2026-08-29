"""反転辺対の回転位相の積が 1 になることを有限トーラス上で厳密検査する。"""

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


def phase(edge, successor):
    turn = (direction(successor) - direction(edge)) % 4
    return {0: QQbar(1), 1: zeta8, 3: zeta8 ** (-1)}[turn]


total = 0
for L in range(1, 6):
    oriented = edges(L)
    for edge in oriented:
        successors = [other for other in oriented
                      if endpoints(L, edge)[1] == endpoints(L, other)[0]
                      and other != reversal(edge)]
        for successor in successors:
            reversed_edge = reversal(successor)
            reversed_successor = reversal(edge)
            assert endpoints(L, reversed_edge)[1] == endpoints(L, reversed_successor)[0]
            assert reversed_successor != reversal(reversed_edge)
            assert phase(reversed_edge, reversed_successor) * phase(edge, successor) == 1
            total += 1

print(f"PASS: L=1,...,5 の全 {total} 非後退接続で逆順反転辺対の回転位相積が 1")
