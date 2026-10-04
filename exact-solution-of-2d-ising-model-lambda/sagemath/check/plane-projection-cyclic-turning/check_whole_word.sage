# 対象ラベル: claim_plane_projection_cyclic_turning
for word, edges, total, it, ct, iw, cw in rows:
    assert total == sum(weight(word[j], word[(j+1)%len(word)]) for j in range(len(word)))
assert any(len(word) == 1 for word, *_ in rows)
assert any(sum(u[0] for u in word) != 0 for word, *_ in rows)
print('whole_word PASS', len(rows))
