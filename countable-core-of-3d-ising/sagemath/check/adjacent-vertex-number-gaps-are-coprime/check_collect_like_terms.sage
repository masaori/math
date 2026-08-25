# 対象ラベル: claim_adjacent_vertex_number_gaps_are_coprime
# 定義式の差で同類項をまとめる一行を ZZ で確認する。

for L in range(1, 4097):
    expanded = (
        3 * ZZ(L + 1) ** 2 + 3 * ZZ(L + 1) + 1
        - (3 * ZZ(L) ** 2 + 3 * ZZ(L) + 1)
    )
    collected = 3 * (ZZ(L + 1) ** 2 - ZZ(L) ** 2) + 3 * (ZZ(L + 1) - ZZ(L))
    assert expanded == collected

print("RESULT: PASS")
