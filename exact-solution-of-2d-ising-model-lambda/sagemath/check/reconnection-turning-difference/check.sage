"""接続の組み替え（二入辺・二出辺の対応の入れ替え）の回転差が -4, 0, 4 に限ることを厳密検査する。"""

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

Z4 = Integers(4)
quadruple_total = 0
seen_values = set()
for L in range(1, 4):
    oriented = edges(L)
    succ = {edge: successors(L, oriented, edge) for edge in oriented}
    for e in oriented:
        for e2 in oriented:
            common = [f for f in succ[e] if f in succ[e2]]
            for f in common:
                for f2 in common:
                    s1 = step_turning(e, f) + step_turning(e2, f2)
                    s2 = step_turning(e, f2) + step_turning(e2, f)
                    difference = s1 - s2
                    # π₄ による合同（一歩は方向番号を回転数だけ進めるので両組の和は合同）
                    assert Z4(s1) == Z4(s2)
                    assert difference % 4 == 0
                    assert -4 <= difference <= 4
                    assert difference in (-4, 0, 4)
                    seen_values.add(difference)
                    quadruple_total += 1

assert quadruple_total > 0
assert seen_values == {ZZ(-4), ZZ(0), ZZ(4)}
print(f"PASS: 組み替え四つ組 {quadruple_total} 件で回転差 ∈ {{-4, 0, 4}} を確認（三値とも出現）")
