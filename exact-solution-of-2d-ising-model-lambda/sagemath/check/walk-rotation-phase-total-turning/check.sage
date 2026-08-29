"""回転位相が一歩の回転数の冪であり、非後退辺列の位相積が総回転数の冪になることを厳密検査する。"""

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


def successors(L, oriented, edge):
    return [other for other in oriented
            if endpoints(L, edge)[1] == endpoints(L, other)[0]
            and other != reversal(edge)]


def step_turning(edge, successor):
    turn = (direction(successor) - direction(edge)) % 4
    assert turn in (0, 1, 3)
    return {0: ZZ(0), 1: ZZ(1), 3: ZZ(-1)}[turn]


def phase(edge, successor):
    turn = (direction(successor) - direction(edge)) % 4
    return {0: QQbar(1), 1: zeta8, 3: zeta8 ** (-1)}[turn]


# claim_rotation_phase_as_turning_power:
# L=1,...,5 の全非後退接続で ρ(e,f) = ζ₈^τ(e,f) を QQbar で厳密に確認する。
pair_total = 0
for L in range(1, 6):
    oriented = edges(L)
    for edge in oriented:
        for successor in successors(L, oriented, edge):
            assert phase(edge, successor) == zeta8 ** step_turning(edge, successor)
            pair_total += 1

# claim_walk_rotation_phase_total_turning:
# L=1,2,3 の全非後退辺列（辺 1〜4 本）で Πρ = ζ₈^{t(γ)} を QQbar で厳密に確認する。
walk_total = 0
for L in range(1, 4):
    oriented = edges(L)
    frontier = [[edge] for edge in oriented]
    for length in range(1, 5):
        for walk in frontier:
            product = QQbar(1)
            turning = ZZ(0)
            for k in range(len(walk) - 1):
                product = product * phase(walk[k], walk[k + 1])
                turning = turning + step_turning(walk[k], walk[k + 1])
            assert product == zeta8 ** turning
            walk_total += 1
        if length < 4:
            frontier = [walk + [nxt] for walk in frontier
                        for nxt in successors(L, oriented, walk[-1])]

print(f"PASS: 非後退接続 {pair_total} 件で ρ=ζ₈^τ、非後退辺列 {walk_total} 件で Πρ=ζ₈^t(γ)")
