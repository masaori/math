# 対象ラベル: claim_plane_projection_cyclic_turning
for word, edges, total, it, ct, iw, cw in rows:
    assert it + ct == iw + ct
print('internal_substitution PASS', len(rows))
