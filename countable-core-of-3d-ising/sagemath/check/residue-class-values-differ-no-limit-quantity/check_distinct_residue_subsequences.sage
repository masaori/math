# 対象ラベル: claim_residue_class_values_differ_no_limit_quantity
# 帰属: 添字は NN、列の値は QQ。二つの剰余類部分列が相異なる定数列になることを検査する。

for L0 in [1, 2, 5]:
    for p in [2, 3, 5]:
        residue_values = [QQ(r + 1) / QQ(p + 1) for r in range(p)]

        def a(L):
            if L < L0:
                return QQ(L + 1)
            return residue_values[(L - L0) % p]

        r = 0
        s = p - 1
        c_r = a(L0 + r)
        c_s = a(L0 + s)
        assert c_r != c_s
        for k in range(12):
            assert a(L0 + r + k * p) == c_r
            assert a(L0 + s + k * p) == c_s

print("RESULT: PASS")
