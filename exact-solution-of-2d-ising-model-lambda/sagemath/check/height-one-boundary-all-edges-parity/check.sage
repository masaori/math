# 対象ラベル: claim_height_one_boundary_all_edges_parity
# 四つの局所場合が全ての基底辺を重複なく覆うことを検算する。
for L in range(1, 6):
    edges = {(side, i, j) for side in (0, 1) for i in range(L) for j in range(L)}
    horizontal_seam = {(0, 0, j) for j in range(L)}
    horizontal_internal = {(0, i, j) for i in range(1, L) for j in range(L)}
    vertical_seam = {(1, i, 0) for i in range(L)}
    vertical_internal = {(1, i, j) for i in range(L) for j in range(1, L)}
    classes = (horizontal_seam, horizontal_internal, vertical_seam, vertical_internal)
    assert set().union(*classes) == edges
    assert sum(len(part) for part in classes) == len(edges)
    assert len(edges) == 2 * L * L
print("PASS: 辺長一から五まで四場合が全基底辺を重複なく覆う")
