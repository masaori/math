# 対象ラベル: claim_plane_projection_cyclic_turning
for word, edges, total, it, ct, iw, cw in rows:
    assert iw + ct == iw + cw
print('closing_substitution PASS', len(rows))
