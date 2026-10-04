# 対象ラベル: claim_plane_projection_cyclic_turning
for word, edges, total, it, ct, iw, cw in rows:
    assert total == it + ct
print('cyclic_definition PASS', len(rows))
