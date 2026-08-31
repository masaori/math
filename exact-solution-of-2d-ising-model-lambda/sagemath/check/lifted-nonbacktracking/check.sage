"""平面へ持ち上げた隣接二歩が逆ベクトルにならないことを厳密検査する。

対象:
- claim_lifted_steps_do_not_reverse: f in Next(e) ならば
  u(dir(f)) != -u(dir(e))（L=1,...,4 の全非後退接続）

すべて有限集合の列挙と ZZ の等式比較であり、浮動小数点は使わない。
"""


def vertices(L):
    return [(i, j) for i in range(L) for j in range(L)]


def edges(L):
    return [(kind, i, j, d) for kind in ("h", "v")
            for i in range(L) for j in range(L) for d in (0, 1)]


def endpoints(L, edge):
    kind, i, j, d = edge
    if kind == "h":
        boundary_0 = (i, j)
        boundary_1 = (i, (j + 1) % L)
    else:
        boundary_0 = (i, j)
        boundary_1 = ((i + 1) % L, j)
    return (boundary_0, boundary_1) if d == 0 else (boundary_1, boundary_0)


def reversal(edge):
    kind, i, j, d = edge
    return (kind, i, j, 1 - d)


def direction(edge):
    kind, i, j, d = edge
    if kind == "h" and d == 0:
        return Zmod(4)(0)
    if kind == "v" and d == 0:
        return Zmod(4)(1)
    if kind == "h" and d == 1:
        return Zmod(4)(2)
    return Zmod(4)(3)


def unit_vector(direction_class):
    return {
        Zmod(4)(0): (ZZ(0), ZZ(1)),
        Zmod(4)(1): (ZZ(1), ZZ(0)),
        Zmod(4)(2): (ZZ(0), ZZ(-1)),
        Zmod(4)(3): (ZZ(-1), ZZ(0)),
    }[direction_class]


def negate(vector):
    return (-vector[0], -vector[1])


total = 0
for L in range(1, 5):
    oriented_edges = edges(L)
    for edge in oriented_edges:
        source, target = endpoints(L, edge)
        for successor in oriented_edges:
            successor_source, successor_target = endpoints(L, successor)
            if successor_source != target or successor == reversal(edge):
                continue
            assert unit_vector(direction(successor)) != negate(unit_vector(direction(edge))), (
                L, edge, successor,
            )
            total += 1

print(f"claim_lifted_steps_do_not_reverse: PASS ({total} nonbacktracking connections, L=1..4)")
