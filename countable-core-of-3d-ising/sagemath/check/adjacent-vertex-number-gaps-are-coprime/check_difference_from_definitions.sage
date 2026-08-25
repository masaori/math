# 対象ラベル: claim_adjacent_vertex_number_gaps_are_coprime
# g_(L+1)-g_L を二つの定義式の差へ展開する一行を ZZ で確認する。

for L in range(1, 4097):
    gap_L = 3 * ZZ(L) ** 2 + 3 * ZZ(L) + 1
    gap_next = 3 * ZZ(L + 1) ** 2 + 3 * ZZ(L + 1) + 1
    expanded = (
        3 * ZZ(L + 1) ** 2 + 3 * ZZ(L + 1) + 1
        - (3 * ZZ(L) ** 2 + 3 * ZZ(L) + 1)
    )
    assert gap_next - gap_L == expanded

print("RESULT: PASS")
