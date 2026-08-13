# 対象ラベル: claim_quadratic_positive_add_nonnegative_negative_second
# 帰属: QQ の厳密計算。浮動小数点を使わない。

BOUND = 6
nonnegative = sorted(set(QQ(n) / QQ(d) for n in range(0, BOUND + 1) for d in range(1, BOUND + 1)))
positive = [q for q in nonnegative if q > 0]
negative = [-q for q in positive]

checked = 0
for a in nonnegative:
    for b in nonnegative:
        if (a, b) == (0, 0):
            continue
        for ap in positive:
            for bp in negative:
                if not 2 * bp * bp < ap * ap:
                    continue
                A = a + ap
                B = b + bp
                if B >= 0:
                    assert A > 0
                    assert (A, B) != (0, 0)
                else:
                    assert bp <= B
                    assert B * B <= bp * bp
                    assert ap <= A
                    assert ap * ap <= A * A
                    assert 2 * B * B <= 2 * bp * bp < ap * ap <= A * A
                checked += 1

assert checked > 0
print(f"OK: 非負係数条件と負の第二係数条件の和を {checked} 組で厳密検査した")
