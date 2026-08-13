# 対象ラベル: claim_quadratic_positive_add_nonnegative
# 帰属: QQ の厳密計算。浮動小数点を使わない。

BOUND = 8
samples = sorted(set(QQ(n) / QQ(d) for n in range(0, BOUND + 1) for d in range(1, BOUND + 1)))

checked = 0
for a in samples:
    for b in samples:
        if (a, b) == (0, 0):
            continue
        for ap in samples:
            for bp in samples:
                if (ap, bp) == (0, 0):
                    continue
                A = a + ap
                B = b + bp
                assert A >= 0
                assert B >= 0
                assert (A, B) != (0, 0)
                checked += 1

print(f"OK: 非負係数条件どうしの和を {checked} 組で厳密検査した")
