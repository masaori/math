# 対象ラベル: claim_eventually_periodic_residue_class_constant
# 帰属: 添字は NN、列の値は QQ。浮動小数点を使わない。

for L0 in [1, 2, 5]:
    for p in [1, 2, 4]:
        residue_values = [QQ(2 * r + 1) / QQ(r + 1) for r in range(p)]

        def a(L):
            if L < L0:
                return QQ(L + 1)
            return residue_values[(L - L0) % p]

        for L in range(L0, L0 + 8 * p):
            assert a(L + p) == a(L)
        for r in range(p):
            for k in range(8):
                assert a(L0 + r + k * p) == a(L0 + r)

print("RESULT: PASS")
