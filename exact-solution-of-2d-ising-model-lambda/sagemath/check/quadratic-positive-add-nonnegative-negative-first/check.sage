# 対象ラベル: claim_quadratic_positive_add_nonnegative_negative_first
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
        for ap in negative:
            for bp in positive:
                if not ap * ap < 2 * bp * bp:
                    continue
                A = a + ap
                B = b + bp
                if A >= 0:
                    assert B > 0
                    assert (A, B) != (0, 0)
                else:
                    assert ap <= A
                    assert A * A <= ap * A
                    assert ap * A <= ap * ap
                    assert A * A <= ap * ap
                    assert bp <= B
                    assert bp * bp <= B * B
                    assert A * A <= ap * ap < 2 * bp * bp <= 2 * B * B
                checked += 1

assert checked > 0
print(f"OK: 非負係数条件と負の第一係数条件の和を {checked} 組で厳密検査した")
