# 対象ラベル: claim_quadratic_positive_mul_negative_second_negative_second
# 帰属: QQ の厳密計算。浮動小数点を使わない。

BOUND = 6
positive = sorted(set(QQ(n) / QQ(d) for n in range(1, BOUND + 1) for d in range(1, BOUND + 1)))

# 負の第二係数条件を満たす表示 (a, b) = (a, -u) の列挙
negative_second = [(a, u) for a in positive for u in positive if 2 * (u * u) < a * a]

checked = 0
for (a, u) in negative_second:
    b = -u
    assert a > 0 and b < 0 and 2 * (b * b) < a * a
    for (ap, up) in negative_second:
        bp = -up
        assert ap > 0 and bp < 0 and 2 * (bp * bp) < ap * ap
        A = a * ap + 2 * (b * bp)
        B = a * bp + b * ap
        # 代入形
        assert A == a * ap + 2 * (u * up)
        assert B == -(a * up + u * ap)
        # 第一係数の正値: 正どうしの積の和
        assert 0 < a * ap
        assert 0 < 2 * (u * up)
        assert 0 < A
        # 第二係数の負値
        V = a * up + u * ap
        assert 0 < V
        assert B == -V
        assert B < 0
        # 中間比較の鎖: D = a*a - 2*(u*u) > 0
        D = a * a - 2 * (u * u)
        assert 0 < D
        assert (a * a) * (2 * (up * up)) - (2 * (u * u)) * (2 * (up * up)) == D * (2 * (up * up))
        assert D * (2 * (up * up)) < D * (ap * ap)
        assert D * (ap * ap) == (a * a) * (ap * ap) - (2 * (u * u)) * (ap * ap)
        # 移項した形
        assert (a * a) * (2 * (up * up)) + (2 * (u * u)) * (ap * ap) < \
            (a * a) * (ap * ap) + (2 * (u * u)) * (2 * (up * up))
        # 最終鎖
        assert 2 * (B * B) == 2 * (V * V)
        assert 2 * (V * V) == (a * a) * (2 * (up * up)) + 4 * ((a * ap) * (u * up)) + (2 * (u * u)) * (ap * ap)
        assert (a * a) * (2 * (up * up)) + 4 * ((a * ap) * (u * up)) + (2 * (u * u)) * (ap * ap) < \
            (a * a) * (ap * ap) + (2 * (u * u)) * (2 * (up * up)) + 4 * ((a * ap) * (u * up))
        assert (a * a) * (ap * ap) + (2 * (u * u)) * (2 * (up * up)) + 4 * ((a * ap) * (u * up)) == A * A
        assert 2 * (B * B) < A * A
        # 正錐の負の第二係数条件
        assert A > 0 and B < 0 and 2 * (B * B) < A * A
        checked += 1

assert checked > 0
print(f"OK: 負の第二係数条件どうしの積を {checked} 組で厳密検査した")
