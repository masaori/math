# 対象ラベル: claim_adjacent_vertex_number_gaps_are_coprime
# (L+1)^2-L^2=2L+1 を代入する一行を ZZ で確認する。

for L in range(1, 4097):
    before = 3 * (ZZ(L + 1) ** 2 - ZZ(L) ** 2) + 3 * (ZZ(L + 1) - ZZ(L))
    after = 3 * (2 * ZZ(L) + 1) + 3
    assert before == after

print("RESULT: PASS")
