# 対象ラベル: claim_quadratic_positive_add_mixed_signs
# 帰属: QQ の厳密計算。浮動小数点を使わない。

BOUND = 6
positive = sorted(set(QQ(n) / QQ(d) for n in range(1, BOUND + 1) for d in range(1, BOUND + 1)))
negative = [-q for q in positive]

checked = 0
first = 0
second = 0
third = 0
for a in positive:
    for b in negative:
        if not 2 * b * b < a * a:
            continue
        for ap in negative:
            for bp in positive:
                if not ap * ap < 2 * bp * bp:
                    continue
                c = -ap
                u = -b
                A = a + ap
                B = b + bp
                assert c > 0
                assert u > 0
                # 交差積の平方比較を本文の各段に合わせて検査する。
                assert (c * u) * (c * u) == (c * c) * (u * u)
                assert (c * c) * (u * u) < (2 * bp * bp) * (u * u)
                assert (2 * bp * bp) * (u * u) == (2 * u * u) * (bp * bp)
                assert (2 * u * u) * (bp * bp) < (a * a) * (bp * bp)
                assert (a * a) * (bp * bp) == (a * bp) * (a * bp)
                assert c * u < a * bp

                if A >= 0 and B >= 0:
                    assert (A, B) != (0, 0)
                    first += 1
                elif B < 0:
                    assert A > 0
                    U = u - bp
                    assert U > 0
                    assert a * U < u * A
                    assert (a * U) * (a * U) < (u * A) * (u * A)
                    assert (u * u) * (2 * U * U) < (u * u) * (A * A)
                    assert 2 * B * B < A * A
                    second += 1
                else:
                    assert A < 0
                    assert B > 0
                    C = c - a
                    assert C > 0
                    assert bp * C < c * B
                    assert (bp * C) * (bp * C) < (c * B) * (c * B)
                    assert (bp * bp) * (C * C) < (bp * bp) * (2 * B * B)
                    assert A * A < 2 * B * B
                    third += 1
                checked += 1

assert checked > 0
assert first > 0 and second > 0 and third > 0
print(f"OK: 二つの混合符号条件の和を {checked} 組で厳密検査した "
      f"(第一条件 {first}, 第二条件 {second}, 第三条件 {third})")
