"""方向番号の射影 π₄ による一歩の更新・端の差・循環総回転数の 4 の倍数性を厳密検査する。"""


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


Z4 = Integers(4)

# claim_step_advances_direction:
# L=1,...,5 の全非後退接続 (e,f) について dir(f) = dir(e) + π₄(τ(e,f)) を ℤ/4ℤ で検査。
step_total = 0
for L in range(1, 6):
    oriented = edges(L)
    for edge in oriented:
        for successor in successors(L, oriented, edge):
            lhs = Z4(direction_number(successor))
            rhs = Z4(direction_number(edge)) + Z4(step_turning(edge, successor))
            assert lhs == rhs
            step_total += 1
assert step_total > 0

# claim_walk_direction_difference / claim_cyclic_total_turning_multiple_of_four:
# L=1,2,3、辺 1〜5 本の全非後退辺列について dir(e_m) = dir(e_1) + π₄(t(γ)) を、
# 閉じたものについてはさらに π₄(t_circ(γ)) = 0（すなわち 4 | t_circ(γ)）を厳密検査。
walk_total = 0
closed_total = 0
for L in range(1, 4):
    oriented = edges(L)
    frontier = [[edge] for edge in oriented]
    for length in range(1, 6):
        for walk in frontier:
            turning = ZZ(0)
            for k in range(len(walk) - 1):
                turning = turning + step_turning(walk[k], walk[k + 1])
            assert Z4(direction_number(walk[-1])) == \
                Z4(direction_number(walk[0])) + Z4(turning)
            walk_total += 1
            if walk[0] in successors(L, oriented, walk[-1]):
                cyclic_turning = turning + step_turning(walk[-1], walk[0])
                assert Z4(cyclic_turning) == Z4(0)
                assert cyclic_turning % 4 == 0
                closed_total += 1
        if length < 5:
            frontier = [walk + [nxt] for walk in frontier
                        for nxt in successors(L, oriented, walk[-1])]
assert walk_total > 0
assert closed_total > 0

print(f"PASS: 非後退接続 {step_total} 件で一歩の更新、"
      f"非後退辺列 {walk_total} 件で端の方向番号差、"
      f"閉歩道 {closed_total} 件で循環総回転数の 4 の倍数性を確認")
