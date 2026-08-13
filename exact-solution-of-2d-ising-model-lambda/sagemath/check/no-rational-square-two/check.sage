# 対象ラベル: claim_no_rational_square_two
# 帰属: QQ / ZZ の厳密計算。浮動小数点を使わない。

# 主張（claim_no_rational_square_two）: 任意の q ∈ QQ について q*q ≠ 2。
# 証明の組み立てを一行ずつ突き合わせる:
#   prep:   q=0 は q*q=0≠2。q<0 は r:=-q>0 で r*r=q*q。
#   chain:  1 = 1-0 = v_2(2)-v_2(1) = w_2(2) = w_2(r*r) = (log(r·r))(2)
#             = (log r + log r)(2) = w_2(r)+w_2(r) = m+m
#   contra: 整数 m について m+m=1 は m≥1 でも m≤0 でも不可能。


def w2(q):
    """正の有理数 q の素数 2 での指数（def_rational_log の w_2）。"""
    assert q in QQ and q > 0
    a = ZZ(QQ(q).numerator())
    b = ZZ(QQ(q).denominator())
    return a.valuation(2) - b.valuation(2)


# 鎖の先頭: 1 = v_2(2) - v_2(1) = w_2(2)。
assert ZZ(2).valuation(2) == 1, "v_2(2) = 1（2 = 2^1）が壊れている"
assert ZZ(1).valuation(2) == 0, "v_2(1) = 0（空積）が壊れている"
assert ZZ(2).valuation(2) - ZZ(1).valuation(2) == 1, "v_2(2) - v_2(1) = 1 が壊れている"
assert w2(QQ(2)) == 1, "w_2(2) = 1 が壊れている"

# 有理数の網羅的な標本（分子・分母 1..40、正負の両方）で検査する。
BOUND = 40
checked_ne = 0
checked_chain = 0
for a in range(1, BOUND + 1):
    for b in range(1, BOUND + 1):
        for sign in (1, -1):
            q = QQ(sign * a) / QQ(b)
            # 主張そのもの: q*q ≠ 2（QQ の等号判定は厳密）。
            assert q * q != 2, f"反例が出た: q = {q}"

            # 準備: q=0 の場合はこの標本に無い（a≥1）。q<0 の場合の r*r = q*q。
            r = q if q > 0 else -q
            assert r > 0, "r > 0 が壊れている"
            assert r * r == q * q, "(-q)*(-q) = q*q が壊れている"

            # 鎖の中段: w_2(r·r) = w_2(r) + w_2(r)（対数の加法性の p=2 成分）。
            m = w2(r)
            assert m in ZZ, "m = w_2(r) ∈ ZZ が壊れている"
            assert w2(r * r) == m + m, "w_2(r·r) = w_2(r)+w_2(r) が壊れている"
            checked_chain += 1

            # 矛盾の段: もし r*r=2 なら 1 = m+m になるはずだが、
            # m+m は偶数（m≥1 なら ≥2、m≤0 なら ≤0）なので 1 にならない。
            assert m + m != 1, "m+m = 1 となる整数が出た（ありえない）"
            if m >= 1:
                assert m + m >= 2, "m≥1 ⇒ m+m≥2 が壊れている"
            else:
                assert m <= 0, "ZZ の三分律が壊れている"
                assert m + m <= 0, "m≤0 ⇒ m+m≤0 が壊れている"
            checked_ne += 1

# 矛盾の段を独立に: 範囲内の全整数で m+m ≠ 1。
for m in range(-2 * BOUND, 2 * BOUND + 1):
    assert ZZ(m) + ZZ(m) != 1, f"m+m = 1 となる整数が出た: m = {m}"

print(f"OK: q*q ≠ 2 を {checked_ne} 個の有理数で検査し、"
      f"鎖 w_2(r·r) = w_2(r)+w_2(r) を {checked_chain} 個で検査した")
