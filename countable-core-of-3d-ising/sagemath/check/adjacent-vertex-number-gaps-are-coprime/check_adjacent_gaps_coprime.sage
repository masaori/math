# 対象ラベル: claim_adjacent_vertex_number_gaps_are_coprime
# g_L=3L^2+3L+1 と g_(L+1) の最大公約数が 1 であることを ZZ で確認する。

for L in range(1, 4097):
    gap_L = 3 * ZZ(L) ** 2 + 3 * ZZ(L) + 1
    gap_next = 3 * ZZ(L + 1) ** 2 + 3 * ZZ(L + 1) + 1
    assert gcd(gap_L, gap_next) == 1

print("RESULT: PASS")
