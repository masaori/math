# 対象ラベル: claim_plane_projection_cyclic_turning
for word, edges, total, it, ct, iw, cw in rows:
    angles = [D.index(u) for u in word]
    total_turning = sum({0: 0, 1: 1, 3: -1}[(angles[k]-angles[k-1]) % 4] for k in range(1, len(word)))
    assert total_turning + ct == it + ct
print('total_definition PASS', len(rows))
