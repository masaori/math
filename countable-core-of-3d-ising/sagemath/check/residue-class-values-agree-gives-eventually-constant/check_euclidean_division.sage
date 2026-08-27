# 対象ラベル: claim_residue_class_values_agree_gives_eventually_constant
# 帰属: L, L0, p, k, r は NN。自然数の除法と添字の等式を ZZ で検査する。

for L0 in [1, 2, 5]:
    for p in [1, 2, 4]:
        for L in range(L0, L0 + 8 * p):
            difference = ZZ(L - L0)
            k = difference // p
            r = difference % p
            assert difference == k * p + r
            assert 0 <= r < p
            assert ZZ(L) == ZZ(L0 + r + k * p)

print("RESULT: PASS")
