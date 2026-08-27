# 対象ラベル: claim_residue_class_values_agree_gives_eventually_constant
# 帰属: 添字は NN、列の値は QQ。剰余類ごとの等号を QQ で検査する。

for L0 in [1, 2, 5]:
    for p in [1, 2, 4]:
        c = QQ(11) / QQ(5)

        def a(L):
            if L < L0:
                return QQ(L + 2)
            r = (L - L0) % p
            residue_values = [c for _ in range(p)]
            return residue_values[r]

        for L in range(L0, L0 + 8 * p):
            difference = ZZ(L - L0)
            k = difference // p
            r = difference % p
            assert a(L) == a(L0 + r + k * p)
            assert a(L0 + r + k * p) == a(L0 + r)
            assert a(L0 + r) == c
            assert a(L) == c

print("RESULT: PASS")
