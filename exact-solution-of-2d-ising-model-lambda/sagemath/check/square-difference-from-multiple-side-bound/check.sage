# 対象ラベル: claim_square_difference_from_multiple_side_bound
# 帰属: ZZ だけを使う厳密計算。浮動小数点は使わない。

count = 0
for a in range(1, 9):
    for k in range(1, 9):
        for L in range(k * a, k * a + a + 1):   # ka ≤ L ≤ ka + a
            a_, k_, L_ = ZZ(a), ZZ(k), ZZ(L)
            b = k_ * a_
            assert b <= L_ <= b + a_
            # 主張
            assert b ** 2 <= L_ ** 2
            assert L_ ** 2 - b ** 2 <= 2 * a_ * L_
            # 証明の七段の鎖を一段ずつ
            s1 = L_ * L_                          # 冪の定義
            s2 = (b + a_) * L_                    # L ≤ ka+a に L を掛ける
            s3 = b * L_ + a_ * L_                 # 分配則
            s4 = b * (b + a_) + a_ * L_           # L ≤ ka+a に ka を掛ける
            s5 = b ** 2 + a_ * b + a_ * L_        # 分配則・可換性・冪の定義
            s6 = b ** 2 + a_ * L_ + a_ * L_       # ka ≤ L に a を掛ける
            s7 = b ** 2 + 2 * a_ * L_             # N の四則
            assert L_ ** 2 == s1
            assert s1 <= s2 and s2 == s3 and s3 <= s4 and s4 == s5 and s5 <= s6 and s6 == s7
            count += 8

print("PASS: square-difference-from-multiple-side-bound (%d checks)" % count)
