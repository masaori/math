# 対象ラベル: claim_adjacent_vertex_number_gaps_are_coprime
# 3L^2+3L+1 = 3L(L+1)+1 を ZZ で確認する。

for L in range(1, 4097):
    left = 3 * ZZ(L) ** 2 + 3 * ZZ(L) + 1
    right = 3 * ZZ(L) * ZZ(L + 1) + 1
    assert left == right

print("RESULT: PASS")
