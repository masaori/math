"""平面変位が方向番号の方向単位ベクトルに等しいことを厳密検査する。

対象:
- claim_displacement_is_direction_unit: すべての向き付き辺について
  (δ_row, δ_col) = u(dir)（L=1,...,4 の全向き付き辺）

方向番号は右・下・左・上の順に 0,1,2,3 ∈ Z/4Z、方向単位ベクトルは
u(0)=(0,1), u(1)=(1,0), u(2)=(0,-1), u(3)=(-1,0)。
すべて ZZ の等式比較と有限列挙であり、浮動小数点は使わない。
"""


def edges(L):
    return [(kind, i, j, d) for kind in ("h", "v")
            for i in range(L) for j in range(L) for d in (0, 1)]


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
    table = {
        Zmod(4)(0): (ZZ(0), ZZ(1)),
        Zmod(4)(1): (ZZ(1), ZZ(0)),
        Zmod(4)(2): (ZZ(0), ZZ(-1)),
        Zmod(4)(3): (ZZ(-1), ZZ(0)),
    }
    return table[direction_class]


def displacement_row(edge):
    kind, i, j, d = edge
    return ZZ(1 - 2 * d) if kind == "v" else ZZ(0)


def displacement_col(edge):
    kind, i, j, d = edge
    return ZZ(1 - 2 * d) if kind == "h" else ZZ(0)


# u の四つの値が相異なること（定義の well-defined 性の裏取り）。
values = [unit_vector(Zmod(4)(k)) for k in range(4)]
assert len(set(values)) == 4, "u の四つの値が相異なっていない"

total = 0
for L in range(1, 5):
    for edge in edges(L):
        got = (displacement_row(edge), displacement_col(edge))
        expected = unit_vector(direction(edge))
        assert got == expected, (L, edge, got, expected)
        total += 1

print(f"claim_displacement_is_direction_unit: PASS ({total} oriented edges, L=1..4)")
