# 対象ラベル: claim_residue_class_values_agree_gives_eventually_constant
# 帰属: 添字は NN、列の値は QQ。浮動小数点を使わない。

for L0 in [1, 2, 5]:
    for p in [1, 2, 4]:
        c = QQ(7) / QQ(3)

        def a(L):
            if L < L0:
                return QQ(L + 1)
            return c

        for r in range(p):
            assert a(L0 + r) == c
            for k in range(8):
                assert a(L0 + r + k * p) == a(L0 + r)

print("RESULT: PASS")
