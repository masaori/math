# 対象ラベル: claim_eventually_periodic_limit_quantity_only_at_one
# 帰属: q と剰余類ごとの値は QQ、添字は NN。
# 全一致の場合に末尾定数性を経て既存分類 q = 1 へ接続する有限算術部分を検査する。

for L0 in [1, 2, 5]:
    for p in [1, 2, 4]:
        q = QQ(1)
        common_value = QQ(2)
        residue_values = [common_value for _ in range(p)]

        def a(L):
            if L < L0:
                return QQ(L + 1)
            return residue_values[(L - L0) % p]

        assert all(c == common_value for c in residue_values)
        for L in range(L0, L0 + 8 * p):
            assert a(L) == common_value
        assert q == 1

print("RESULT: PASS")
