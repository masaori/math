# 対象ラベル: claim_plane_dual_ray_height_zero_left
# 行方向の有限台の外側の零を隣接行の等式で全行へ運ぶ結論を検算する。
checks = 0
for edges in even_sets:
    lower = min((edge[2] for edge in edges), default=ZZ(0))
    rows = frozenset(edge[1] for edge in edges)
    outside = ZZ(3)
    assert outside not in rows
    for column in range(int(lower) - 3, int(lower)):
        assert height(edges, outside, ZZ(column)) == 0
        for row in range(-1, 4):
            assert height(edges, ZZ(row), ZZ(column)) == height(edges, outside, ZZ(column))
            checks += 1
print("PASS: %s left-bound cases" % checks)
