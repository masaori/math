# 対象ラベル: claim_quadratic_positive_mul_nonnegative_negative_second
# 帰属: QQ の厳密計算。浮動小数点を使わない。

BOUND = 6
nonneg = sorted(set(QQ(n) / QQ(d) for n in range(0, BOUND + 1) for d in range(1, BOUND + 1)))
positive = [q for q in nonneg if q > 0]

checked = 0
case_counts = {"first_B_nonneg": 0, "first_B_neg": 0, "second_A_nonneg": 0, "second_A_neg": 0}
for a in nonneg:
    for b in nonneg:
        if (a, b) == (0, 0):
            continue
        # 混合符号の排除: a*a = 2*(b*b) は起きない
        assert a * a != 2 * (b * b)
        for ap in positive:
            for u in positive:
                if not (2 * (u * u) < ap * ap):
                    continue
                bp = -u
                # 負の第二係数条件の確認
                assert ap > 0 and bp < 0 and 2 * (bp * bp) < ap * ap
                A = a * ap + 2 * (b * bp)
                B = a * bp + b * ap
                # 代入形
                assert A == a * ap - 2 * (b * u)
                assert B == b * ap - a * u
                if 2 * (b * b) < a * a:
                    # 第一の場合: 0 < A
                    assert a > 0
                    # 背理法の鎖: A <= 0 なら a*a < 2*(b*b) が出る
                    if A <= 0:
                        assert 0 < a * ap <= 2 * (b * u)
                        assert b > 0
                        assert (a * a) * (ap * ap) == (a * ap) * (a * ap)
                        assert (a * ap) * (a * ap) <= (2 * (b * u)) * (2 * (b * u))
                        assert (2 * (b * u)) * (2 * (b * u)) == (2 * (b * b)) * (2 * (u * u))
                        assert (2 * (b * b)) * (2 * (u * u)) < (2 * (b * b)) * (ap * ap)
                        assert a * a < 2 * (b * b)  # 矛盾するのでこの枝には来ない
                        raise AssertionError("第一の場合で A <= 0 が実現した")
                    assert A > 0
                    if B >= 0:
                        assert A >= 0 and B >= 0 and (A, B) != (0, 0)
                        case_counts["first_B_nonneg"] += 1
                    else:
                        V = -B
                        assert V > 0
                        # 線形比較の鎖
                        assert ap * V == a * (u * ap) - b * (ap * ap)
                        assert a * (u * ap) - b * (ap * ap) <= a * (u * ap) - b * (2 * (u * u))
                        assert a * (u * ap) - b * (2 * (u * u)) == u * A
                        assert 0 <= ap * V <= u * A
                        # 平方の鎖
                        assert 2 * (u * u) * (V * V) < (ap * ap) * (V * V)
                        assert (ap * ap) * (V * V) == (ap * V) * (ap * V)
                        assert (ap * V) * (ap * V) <= (u * A) * (u * A)
                        assert (u * A) * (u * A) == (u * u) * (A * A)
                        assert 2 * (B * B) < A * A
                        assert A > 0 and B < 0 and 2 * (B * B) < A * A
                        case_counts["first_B_neg"] += 1
                else:
                    assert a * a < 2 * (b * b)
                    # 第二の場合: 0 < B
                    assert b > 0
                    if B <= 0:
                        assert 0 < b * ap <= a * u
                        assert a > 0
                        assert 2 * ((b * b) * (ap * ap)) == 2 * ((b * ap) * (b * ap))
                        assert 2 * ((b * ap) * (b * ap)) <= 2 * ((a * u) * (a * u))
                        assert 2 * ((a * u) * (a * u)) == (a * a) * (2 * (u * u))
                        assert (a * a) * (2 * (u * u)) < (a * a) * (ap * ap)
                        assert 2 * (b * b) < a * a  # 矛盾するのでこの枝には来ない
                        raise AssertionError("第二の場合で B <= 0 が実現した")
                    assert B > 0
                    if A >= 0:
                        assert A >= 0 and B >= 0 and (A, B) != (0, 0)
                        case_counts["second_A_nonneg"] += 1
                    else:
                        C = -A
                        assert C > 0
                        # 線形比較の鎖
                        assert ap * C == 2 * (b * (u * ap)) - a * (ap * ap)
                        assert 2 * (b * (u * ap)) - a * (ap * ap) <= 2 * (b * (u * ap)) - a * (2 * (u * u))
                        assert 2 * (b * (u * ap)) - a * (2 * (u * u)) == (2 * u) * B
                        assert 0 <= ap * C <= (2 * u) * B
                        # 平方の鎖
                        assert (ap * ap) * (C * C) == (ap * C) * (ap * C)
                        assert (ap * C) * (ap * C) <= ((2 * u) * B) * ((2 * u) * B)
                        assert ((2 * u) * B) * ((2 * u) * B) == (2 * (u * u)) * (2 * (B * B))
                        assert (2 * (u * u)) * (2 * (B * B)) < (ap * ap) * (2 * (B * B))
                        assert A * A < 2 * (B * B)
                        assert A < 0 and B > 0 and A * A < 2 * (B * B)
                        case_counts["second_A_neg"] += 1
                checked += 1

assert checked > 0
assert all(count > 0 for count in case_counts.values())
print(f"OK: 非負係数条件と負の第二係数条件の積を {checked} 組で厳密検査した ({case_counts})")
