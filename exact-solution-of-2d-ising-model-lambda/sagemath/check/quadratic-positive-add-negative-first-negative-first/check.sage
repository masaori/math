# 対象ラベル: claim_quadratic_positive_add_negative_first_negative_first
# 帰属: QQ の厳密計算。浮動小数点を使わない。

BOUND = 6
positive = sorted(set(QQ(n) / QQ(d) for n in range(1, BOUND + 1) for d in range(1, BOUND + 1)))
negative = [-q for q in positive]

checked = 0
for a in negative:
    for b in positive:
        if not a * a < 2 * b * b:
            continue
        for ap in negative:
            for bp in positive:
                if not ap * ap < 2 * bp * bp:
                    continue
                A = a + ap
                B = b + bp
                cross_left = a * ap
                cross_right = 2 * b * bp
                assert A < 0
                assert B > 0
                assert cross_left >= 0
                assert cross_right >= 0
                # 交差項の平方比較の鎖を一段ずつ検査する（本文の四段に対応）
                assert cross_left * cross_left == (a * a) * (ap * ap)
                assert (a * a) * (ap * ap) < (2 * b * b) * (ap * ap)
                assert (2 * b * b) * (ap * ap) < (2 * b * b) * (2 * bp * bp)
                assert (2 * b * b) * (2 * bp * bp) == cross_right * cross_right
                assert cross_left < cross_right
                # 和の平方展開の鎖を一段ずつ検査する（本文の五段に対応）
                assert A * A == a * a + 2 * cross_left + ap * ap
                assert a * a + 2 * cross_left + ap * ap < 2 * b * b + 2 * cross_left + ap * ap
                assert 2 * b * b + 2 * cross_left + ap * ap < 2 * b * b + 2 * cross_right + ap * ap
                assert 2 * b * b + 2 * cross_right + ap * ap < 2 * b * b + 2 * cross_right + 2 * bp * bp
                assert 2 * b * b + 2 * cross_right + 2 * bp * bp == 2 * B * B
                assert A * A < 2 * B * B
                checked += 1

assert checked > 0
print(f"OK: 負の第一係数条件どうしの和を {checked} 組で厳密検査した")
