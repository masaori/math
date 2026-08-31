"""非後退辺列の平面持ち上げの座標式を厳密検査する。

対象:
- claim_plane_lift_coordinates: 非後退辺列 γ の平面持ち上げ P_k(γ) が、
  各 k について（tgt(e_k) の代表座標）＋ L×（切断線指示値の符号付き部分和）
  に一致する（L=1,2,3、長さ 6 までの全非後退辺列、全時点 k）。

すべて ZZ の加減乗除と有限列挙であり、浮動小数点は使わない。
"""


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


def seam_h(L, edge):
    kind, i, j, d = edge
    return ZZ(1) if kind == "h" and j == L - 1 else ZZ(0)


def seam_v(L, edge):
    kind, i, j, d = edge
    return ZZ(1) if kind == "v" and i == L - 1 else ZZ(0)


def displacement_row(edge):
    kind, i, j, d = edge
    return ZZ(1 - 2 * d) if kind == "v" else ZZ(0)


def displacement_col(edge):
    kind, i, j, d = edge
    return ZZ(1 - 2 * d) if kind == "h" else ZZ(0)


def successors(L, oriented, edge):
    return [other for other in oriented
            if endpoints(L, edge)[1] == endpoints(L, other)[0]
            and other != reversal(edge)]


# claim_plane_lift_coordinates: L=1,2,3、長さ 6 までの全非後退辺列 γ と
# 全時点 k について、P_k(γ) の各成分が
#   s(i'_k) + L·Σ_{t≤k} c_v(1-2d_t)、 s(j'_k) + L·Σ_{t≤k} c_h(1-2d_t)
# に一致する（P_k は def_plane_lift の漸化式で計算する）。
walk_total = 0
point_total = 0
for L in range(1, 4):
    oriented = edges(L)
    frontier = [[edge] for edge in oriented]
    for length in range(1, 7):
        for walk in frontier:
            src_row, src_col = endpoints(L, walk[0])[0]
            lift = (ZZ(src_row), ZZ(src_col))
            partial_v = ZZ(0)
            partial_h = ZZ(0)
            for edge in walk:
                kind, i, j, d = edge
                sign = ZZ(1 - 2 * d)
                lift = (lift[0] + displacement_row(edge),
                        lift[1] + displacement_col(edge))
                partial_v += seam_v(L, edge) * sign
                partial_h += seam_h(L, edge) * sign
                tgt_row, tgt_col = endpoints(L, edge)[1]
                assert lift[0] == ZZ(tgt_row) + ZZ(L) * partial_v
                assert lift[1] == ZZ(tgt_col) + ZZ(L) * partial_h
                point_total += 1
            walk_total += 1
        if length < 6:
            frontier = [walk + [nxt] for walk in frontier
                        for nxt in successors(L, oriented, walk[-1])]
print(f"PASS: plane lift coordinates for {walk_total} nonbacktracking walks "
      f"({point_total} lift points, L=1,2,3, length<=6)")
