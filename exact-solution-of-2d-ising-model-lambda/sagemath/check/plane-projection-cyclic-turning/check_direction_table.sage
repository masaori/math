# 対象ラベル: claim_plane_projection_cyclic_turning
count = 0
for L, base, u in product(range(1, 5), ((0, 0), (-3, 5)), D):
    assert direction(L, project(L, base, u)) == D.index(u)
    count += 1
print('direction_table PASS', count)
