# 対象ラベル: claim_quadratic_positive_mul_negative_first_negative_first
# 帰属: QQ の厳密計算。浮動小数点を使わない。

BOUND = 6
positive = sorted(set(QQ(n) / QQ(d) for n in range(1, BOUND + 1) for d in range(1, BOUND + 1)))

# 負の第一係数条件を満たす表示 (a, b) = (-c, b) の列挙
negative_first = [(c, b) for c in positive for b in positive if c * c < 2 * (b * b)]

checked = 0
for (c, b) in negative_first:
    a = -c
    assert a < 0 and 0 < b and a * a < 2 * (b * b)
    for (cp, bp) in negative_first:
        ap = -cp
        assert ap < 0 and 0 < bp and ap * ap < 2 * (bp * bp)
        A = a * ap + 2 * (b * bp)
        B = a * bp + b * ap
        # 代入形
        assert A == c * cp + 2 * (b * bp)
        assert B == -(c * bp + b * cp)
        # 第一係数の正値: 正どうしの積の和
        assert 0 < c * cp
        assert 0 < 2 * (b * bp)
        assert 0 < A
        # 第二係数の負値
        V = c * bp + b * cp
        assert 0 < V
        assert B == -V
        assert B < 0
        # 中間比較の鎖: D = 2*(b*b) - c*c > 0
        D = 2 * (b * b) - c * c
        assert 0 < D
        assert (2 * (b * b)) * (cp * cp) - (c * c) * (cp * cp) == D * (cp * cp)
        assert D * (cp * cp) < D * (2 * (bp * bp))
        assert D * (2 * (bp * bp)) == (2 * (b * b)) * (2 * (bp * bp)) - (c * c) * (2 * (bp * bp))
        # 移項した形
        assert (2 * (b * b)) * (cp * cp) + (c * c) * (2 * (bp * bp)) < \
            (2 * (b * b)) * (2 * (bp * bp)) + (c * c) * (cp * cp)
        # 最終鎖
        assert 2 * (B * B) == 2 * (V * V)
        assert 2 * (V * V) == (c * c) * (2 * (bp * bp)) + 4 * ((c * cp) * (b * bp)) + (2 * (b * b)) * (cp * cp)
        assert (c * c) * (2 * (bp * bp)) + 4 * ((c * cp) * (b * bp)) + (2 * (b * b)) * (cp * cp) < \
            (2 * (b * b)) * (2 * (bp * bp)) + (c * c) * (cp * cp) + 4 * ((c * cp) * (b * bp))
        assert (2 * (b * b)) * (2 * (bp * bp)) + (c * c) * (cp * cp) + 4 * ((c * cp) * (b * bp)) == A * A
        assert 2 * (B * B) < A * A
        # 正錐の負の第二係数条件
        assert A > 0 and B < 0 and 2 * (B * B) < A * A
        checked += 1

assert checked > 0
print(f"OK: 負の第一係数条件どうしの積を {checked} 組で厳密検査した")
