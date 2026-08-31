"""閉歩道の平面変位の三主張を厳密検査する。

対象:
- claim_representative_increment: s(y+1̄) の値（L=1,...,6 の全剰余類）
- claim_edge_representative_displacement: 辺ごとの代表座標の差
  （L=1,...,4 の全向き付き辺）
- claim_closed_walk_plane_displacement: 閉じた非後退辺列の変位の総和が
  巻き付き数の L 倍（L=1,2,3、長さ 8 までの全閉じた非後退辺列）

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


# claim_representative_increment: L=1,...,6 の全剰余類 y について、
# s(y+1̄) が「s(y)≤L-2 なら s(y)+1、s(y)=L-1 なら 0」に一致する。
increment_total = 0
for L in range(1, 7):
    for r in range(L):
        expected = ZZ(r + 1) if r <= L - 2 else ZZ(0)
        assert ZZ((r + 1) % L) == expected
        increment_total += 1
print(f"PASS: representative increment for {increment_total} residues (L=1,...,6)")

# claim_edge_representative_displacement: L=1,...,4 の全向き付き辺について、
# s(i')-s(i) = δ_row - L·c_v·(1-2d)、s(j')-s(j) = δ_col - L·c_h·(1-2d)。
edge_total = 0
for L in range(1, 5):
    for edge in edges(L):
        kind, i0, j0, d = edge
        (i, j), (i2, j2) = endpoints(L, edge)
        sign = ZZ(1 - 2 * d)
        assert ZZ(i2) - ZZ(i) == displacement_row(edge) - ZZ(L) * seam_v(L, edge) * sign
        assert ZZ(j2) - ZZ(j) == displacement_col(edge) - ZZ(L) * seam_h(L, edge) * sign
        edge_total += 1
print(f"PASS: edge representative displacement for {edge_total} oriented edges (L=1,...,4)")

# claim_closed_walk_plane_displacement: L=1,2,3、長さ 8 までの
# 全閉じた非後退辺列について、Σδ_row = L·w_v、Σδ_col = L·w_h。
closed_total = 0
for L in range(1, 4):
    oriented = edges(L)
    frontier = [[edge] for edge in oriented]
    for length in range(1, 9):
        for walk in frontier:
            if walk[0] not in successors(L, oriented, walk[-1]):
                continue
            winding_h = sum(seam_h(L, edge) * ZZ(1 - 2 * edge[3]) for edge in walk)
            winding_v = sum(seam_v(L, edge) * ZZ(1 - 2 * edge[3]) for edge in walk)
            total_row = sum(displacement_row(edge) for edge in walk)
            total_col = sum(displacement_col(edge) for edge in walk)
            assert total_row == ZZ(L) * winding_v
            assert total_col == ZZ(L) * winding_h
            closed_total += 1
        if length < 8:
            frontier = [walk + [nxt] for walk in frontier
                        for nxt in successors(L, oriented, walk[-1])]
print(f"PASS: closed walk plane displacement for {closed_total} closed walks (L=1,2,3, length<=8)")
