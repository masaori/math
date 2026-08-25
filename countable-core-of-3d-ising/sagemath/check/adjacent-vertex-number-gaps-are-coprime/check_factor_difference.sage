# 対象ラベル: claim_adjacent_vertex_number_gaps_are_coprime
# 3(2L+1)+3=6(L+1) を ZZ で確認する。

for L in range(1, 4097):
    left = 3 * (2 * ZZ(L) + 1) + 3
    right = 6 * ZZ(L + 1)
    assert left == right

print("RESULT: PASS")
