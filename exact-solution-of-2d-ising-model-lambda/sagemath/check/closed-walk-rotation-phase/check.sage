"""閉じた非後退辺列の循環位相積が循環総回転数の冪になることを厳密検査する。"""

zeta8 = QQbar.zeta(8)


def edges(L):
    return [(kind, i, j, direction) for kind in ("h", "v")
            for i in range(L) for j in range(L) for direction in (0, 1)]


def reversal(edge):
    kind, i, j, direction = edge
    return (kind, i, j, 1 - direction)


def endpoints(L, edge):
    kind, i, j, direction = edge
    boundary0 = (i, j)
    boundary1 = (i, (j + 1) % L) if kind == "h" else ((i + 1) % L, j)
    return (boundary0, boundary1) if direction == 0 else (boundary1, boundary0)


def direction_number(edge):
    kind, _, _, direction = edge
    return {("h", 0): 0, ("v", 0): 1, ("h", 1): 2, ("v", 1): 3}[(kind, direction)]


def successors(L, oriented, edge):
    return [other for other in oriented
            if endpoints(L, edge)[1] == endpoints(L, other)[0]
            and other != reversal(edge)]


def step_turning(edge, successor):
    turn = (direction_number(successor) - direction_number(edge)) % 4
    assert turn in (0, 1, 3)
    return {0: ZZ(0), 1: ZZ(1), 3: ZZ(-1)}[turn]


def phase(edge, successor):
    turn = (direction_number(successor) - direction_number(edge)) % 4
    return {0: QQbar(1), 1: zeta8, 3: zeta8 ** (-1)}[turn]


# claim_closed_walk_rotation_phase:
# L=1,2,3、辺 1〜5 本の全閉じた非後退辺列について、
# (Π_{k=1}^{m-1} ρ(e_k,e_{k+1}))ρ(e_m,e_1) = ζ₈^{t(γ)+τ(e_m,e_1)}
# を QQbar と ZZ で厳密に確認する。
closed_walk_total = 0
for L in range(1, 4):
    oriented = edges(L)
    frontier = [[edge] for edge in oriented]
    for length in range(1, 6):
        for walk in frontier:
            if walk[0] not in successors(L, oriented, walk[-1]):
                continue
            product = QQbar(1)
            turning = ZZ(0)
            for k in range(len(walk) - 1):
                product = product * phase(walk[k], walk[k + 1])
                turning = turning + step_turning(walk[k], walk[k + 1])
            cyclic_product = product * phase(walk[-1], walk[0])
            cyclic_turning = turning + step_turning(walk[-1], walk[0])
            assert cyclic_product == zeta8 ** cyclic_turning
            closed_walk_total += 1
        if length < 5:
            frontier = [walk + [nxt] for walk in frontier
                        for nxt in successors(L, oriented, walk[-1])]

assert closed_walk_total > 0
print(f"PASS: 閉じた非後退辺列 {closed_walk_total} 件で循環位相積 = ζ₈^循環総回転数")
