# 対象ラベル: claim_plane_projection_cyclic_turning
for word, edges, total, it, ct, iw, cw in rows:
    adjacent = sum(weight(word[j], word[j+1]) for j in range(len(word)-1)) + weight(word[-1], word[0])
    assert iw + cw == adjacent
print('adjacent_definition PASS', len(rows))
