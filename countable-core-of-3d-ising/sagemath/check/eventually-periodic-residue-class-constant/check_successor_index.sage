# 対象ラベル: claim_eventually_periodic_residue_class_constant
# 帰属: L0, p, r, k は NN。添字の等号を ZZ で厳密に検査する。

for L0 in [1, 2, 5]:
    for p in [1, 2, 4]:
        for r in range(p):
            for k in range(8):
                left = ZZ(L0 + r + (k + 1) * p)
                right = ZZ((L0 + r + k * p) + p)
                assert left == right
                assert L0 + r + k * p >= L0

print("RESULT: PASS")
