# 対象ラベル: claim_plane_projection_cyclic_turning
count = 0
for L, u, v, e, f in local_rows():
    assert tau(L, e, f) == weight(u, v)
    count += 1
print('local_turn_table PASS', count)
