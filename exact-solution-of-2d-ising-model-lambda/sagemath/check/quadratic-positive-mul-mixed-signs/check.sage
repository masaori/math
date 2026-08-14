# 対象ラベル: claim_quadratic_positive_mul_mixed_signs
# 帰属: QQ の厳密計算。浮動小数点を使わない。

BOUND = 6
positive = sorted(set(QQ(n) / QQ(d) for n in range(1, BOUND + 1) for d in range(1, BOUND + 1)))

# 負の第二係数条件を満たす表示 (a, b) = (a, -u) の列挙
negative_second = [(a, u) for a in positive for u in positive if 2 * (u * u) < a * a]
# 負の第一係数条件を満たす表示 (a', b') = (-c', b') の列挙
negative_first = [(cp, bp) for cp in positive for bp in positive if cp * cp < 2 * (bp * bp)]

checked = 0
for (a, u) in negative_second:
    b = -u
    assert 0 < a and b < 0 and 2 * (b * b) < a * a
    for (cp, bp) in negative_first:
        ap = -cp
        assert ap < 0 and 0 < bp and ap * ap < 2 * (bp * bp)
        A = a * ap + 2 * (b * bp)
        B = a * bp + b * ap
        # 代入形
        assert A == -(a * cp + 2 * (u * bp))
        assert B == a * bp + u * cp
        # 第一係数の負値: C = a*c' + 2*(u*b') は正どうしの積の和
        C = a * cp + 2 * (u * bp)
        assert 0 < a * cp
        assert 0 < 2 * (u * bp)
        assert 0 < C
        assert A == -C
        assert A < 0
        # 第二係数の正値: 正どうしの積の和
        assert 0 < a * bp
        assert 0 < u * cp
        assert 0 < B
        # 中間比較の鎖: D = a*a - 2*(u*u) > 0
        D = a * a - 2 * (u * u)
        assert 0 < D
        assert (a * a) * (cp * cp) - (2 * (u * u)) * (cp * cp) == D * (cp * cp)
        assert D * (cp * cp) < D * (2 * (bp * bp))
        assert D * (2 * (bp * bp)) == (a * a) * (2 * (bp * bp)) - (2 * (u * u)) * (2 * (bp * bp))
        # 移項した形
        assert (a * a) * (cp * cp) + (2 * (u * u)) * (2 * (bp * bp)) < \
            (a * a) * (2 * (bp * bp)) + (2 * (u * u)) * (cp * cp)
        # 最終鎖
        assert A * A == C * C
        assert C * C == (a * a) * (cp * cp) + 4 * ((a * cp) * (u * bp)) + (2 * (u * u)) * (2 * (bp * bp))
        assert (a * a) * (cp * cp) + 4 * ((a * cp) * (u * bp)) + (2 * (u * u)) * (2 * (bp * bp)) < \
            (a * a) * (2 * (bp * bp)) + (2 * (u * u)) * (cp * cp) + 4 * ((a * cp) * (u * bp))
        assert (a * a) * (2 * (bp * bp)) + (2 * (u * u)) * (cp * cp) + 4 * ((a * cp) * (u * bp)) == 2 * (B * B)
        assert A * A < 2 * (B * B)
        # 正錐の負の第一係数条件
        assert A < 0 and 0 < B and A * A < 2 * (B * B)
        checked += 1

assert checked > 0
print(f"OK: 二つの混合符号条件の積を {checked} 組で厳密検査した")
