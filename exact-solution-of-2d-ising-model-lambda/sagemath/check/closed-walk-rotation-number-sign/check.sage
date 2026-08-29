"""閉歩道の循環総回転数を 4 で割り、回転位相積がその符号になることを厳密検査する。"""

def edges(L):
    return [(kind, i, j, direction) for kind in ("h", "v")
            for i in range(L) for j in range(L) for direction in (0, 1)]

def reversal(edge):
    kind, i, j, direction = edge
    return (kind, i, j, 1 - direction)

def endpoints(L, edge):
    kind, i, j, direction = edge
    p0 = (i, j)
    p1 = (i, (j + 1) % L) if kind == "h" else ((i + 1) % L, j)
    return (p0, p1) if direction == 0 else (p1, p0)

def direction_number(edge):
    kind, _, _, direction = edge
    return {("h", 0): 0, ("v", 0): 1, ("h", 1): 2, ("v", 1): 3}[(kind, direction)]

def successors(L, oriented, edge):
    return [other for other in oriented
            if endpoints(L, edge)[1] == endpoints(L, other)[0]
            and other != reversal(edge)]

def step_turning(edge, successor):
    residue = (direction_number(successor) - direction_number(edge)) % 4
    return {0: ZZ(0), 1: ZZ(1), 3: ZZ(-1)}[residue]

zeta8 = QQbar.zeta(8)
assert zeta8 ** 4 == -1
closed_total = 0
for L in range(1, 4):
    oriented = edges(L)
    frontier = [[edge] for edge in oriented]
    for length in range(1, 6):
        for walk in frontier:
            if walk[0] not in successors(L, oriented, walk[-1]):
                continue
            cyclic_turning = sum((step_turning(walk[k], walk[(k + 1) % len(walk)])
                                  for k in range(len(walk))), ZZ(0))
            assert cyclic_turning % 4 == 0
            rotation_number = cyclic_turning // 4
            assert cyclic_turning == 4 * rotation_number
            phase_product = prod((zeta8 ** step_turning(walk[k], walk[(k + 1) % len(walk)])
                                  for k in range(len(walk))), QQbar(1))
            assert phase_product == zeta8 ** cyclic_turning
            assert zeta8 ** cyclic_turning == QQbar(-1) ** rotation_number
            closed_total += 1
        if length < 5:
            frontier = [walk + [nxt] for walk in frontier
                        for nxt in successors(L, oriented, walk[-1])]

assert closed_total > 0
print(f"PASS: 閉じた非後退辺列 {closed_total} 件で循環総回転数 = 4×回転数と位相積 = (-1)^回転数を確認")
