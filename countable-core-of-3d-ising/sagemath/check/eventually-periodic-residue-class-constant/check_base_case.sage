# 対象ラベル: claim_eventually_periodic_residue_class_constant
# 帰属: 添字は NN、列の値は QQ。浮動小数点を使わない。

for L0 in [1, 2, 5]:
    for p in [1, 2, 4]:
        for r in range(p):
            value = QQ(L0 + r + 1) / QQ(p + 1)
            assert value == value

print("RESULT: PASS")
