# 対象ラベル: claim_quadratic_positive_mul_nonnegative_negative_first
# 帰属: QQ の厳密計算。浮動小数点を使わない。

BOUND = 6
nonneg = sorted(set(QQ(n) / QQ(d) for n in range(0, BOUND + 1) for d in range(1, BOUND + 1)))
positive = [q for q in nonneg if q > 0]

checked = 0
case_counts = {"first_A_nonneg": 0, "first_A_neg": 0, "second_B_nonneg": 0, "second_B_neg": 0}
for a in nonneg:
    for b in nonneg:
        if (a, b) == (0, 0):
            continue
        # 混合符号の排除: a*a = 2*(b*b) は起きない
        assert a * a != 2 * (b * b)
        for c in positive:
            for bp in positive:
                if not (c * c < 2 * (bp * bp)):
                    continue
                ap = -c
                # 負の第一係数条件の確認
                assert ap < 0 and bp > 0 and ap * ap < 2 * (bp * bp)
                A = a * ap + 2 * (b * bp)
                B = a * bp + b * ap
                # 代入形
                assert A == 2 * (b * bp) - a * c
                assert B == a * bp - b * c
                if 2 * (b * b) < a * a:
                    # 第一の場合: 0 < B
                    assert a > 0
                    # 背理法の鎖: B <= 0 なら a*a < 2*(b*b) が出る
                    if B <= 0:
                        assert 0 < a * bp <= b * c
                        assert b > 0
                        assert (a * a) * (bp * bp) == (a * bp) * (a * bp)
                        assert (a * bp) * (a * bp) <= (b * c) * (b * c)
                        assert (b * c) * (b * c) == (b * b) * (c * c)
                        assert (b * b) * (c * c) < (b * b) * (2 * (bp * bp))
                        assert a * a < 2 * (b * b)  # 矛盾するのでこの枝には来ない
                        raise AssertionError("第一の場合で B <= 0 が実現した")
                    assert B > 0
                    if A >= 0:
                        assert A >= 0 and B >= 0 and (A, B) != (0, 0)
                        case_counts["first_A_nonneg"] += 1
                    else:
                        C = -A
                        assert C > 0
                        # 線形比較の鎖
                        assert bp * C == a * (c * bp) - 2 * (b * (bp * bp))
                        assert a * (c * bp) - 2 * (b * (bp * bp)) <= a * (c * bp) - b * (c * c)
                        assert a * (c * bp) - b * (c * c) == c * B
                        assert 0 <= bp * C <= c * B
                        # 平方の鎖
                        assert (bp * bp) * (C * C) == (bp * C) * (bp * C)
                        assert (bp * C) * (bp * C) <= (c * B) * (c * B)
                        assert (c * B) * (c * B) == (c * c) * (B * B)
                        assert (c * c) * (B * B) < (2 * (bp * bp)) * (B * B)
                        assert A * A < 2 * (B * B)
                        assert A < 0 and B > 0 and A * A < 2 * (B * B)
                        case_counts["first_A_neg"] += 1
                else:
                    assert a * a < 2 * (b * b)
                    # 第二の場合: 0 < A
                    assert b > 0
                    if A <= 0:
                        assert 0 < 2 * (b * bp) <= a * c
                        assert a > 0
                        assert (2 * (b * b)) * (2 * (bp * bp)) == (2 * (b * bp)) * (2 * (b * bp))
                        assert (2 * (b * bp)) * (2 * (b * bp)) <= (a * c) * (a * c)
                        assert (a * c) * (a * c) == (a * a) * (c * c)
                        assert (a * a) * (c * c) < (a * a) * (2 * (bp * bp))
                        assert 2 * (b * b) < a * a  # 矛盾するのでこの枝には来ない
                        raise AssertionError("第二の場合で A <= 0 が実現した")
                    assert A > 0
                    if B >= 0:
                        assert A >= 0 and B >= 0 and (A, B) != (0, 0)
                        case_counts["second_B_nonneg"] += 1
                    else:
                        V = -B
                        assert V > 0
                        # 線形比較の鎖
                        assert (2 * bp) * V == 2 * (b * (c * bp)) - a * (2 * (bp * bp))
                        assert 2 * (b * (c * bp)) - a * (2 * (bp * bp)) <= 2 * (b * (c * bp)) - a * (c * c)
                        assert 2 * (b * (c * bp)) - a * (c * c) == c * A
                        assert 0 <= (2 * bp) * V <= c * A
                        # 平方の鎖
                        assert (2 * (bp * bp)) * (2 * (V * V)) == ((2 * bp) * V) * ((2 * bp) * V)
                        assert ((2 * bp) * V) * ((2 * bp) * V) <= (c * A) * (c * A)
                        assert (c * A) * (c * A) == (c * c) * (A * A)
                        assert (c * c) * (A * A) < (2 * (bp * bp)) * (A * A)
                        assert 2 * (B * B) < A * A
                        assert A > 0 and B < 0 and 2 * (B * B) < A * A
                        case_counts["second_B_neg"] += 1
                checked += 1

assert checked > 0
assert all(count > 0 for count in case_counts.values())
print(f"OK: 非負係数条件と負の第一係数条件の積を {checked} 組で厳密検査した ({case_counts})")
