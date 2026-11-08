# <positive_real_square_injective> の検算。有理数で厳密に行う（浮動小数点を使わない）。
# 主張: a, b ∈ ℝ_{>0} について a^2 = b^2 ⟺ a = b。二乗は冪（def_power_of_real_number、m = 2）で、積 aa とは別に組む。
# 逆向きの鎖（人手の 8 行）:
#   (a-b)(a+b) = (a-b)a + (a-b)b = (aa - ba) + (ab - bb) = (aa - ab) + (ab - bb) = aa - bb
#              = a^2 - bb = a^2 - b^2 = b^2 - b^2 = 0
# 含意の段: a+b > 0、(a-b)(a+b) = 0 かつ a+b ≠ 0 ⟹ a-b = 0 ⟹ a = b。
def power(r, m):
    # def_power_of_real_number: r^0 := 1、r^{m+1} := r^m r
    out = QQ(1)
    for _ in range(m):
        out = out * r
    return out
vals = sorted(set(QQ(p)/QQ(q) for p in range(1, 13) for q in range(1, 9)))
checked = 0
chain_eqs = 0
for a in vals:
    for b in vals:
        # 鎖の 1〜6 行目（a^2 = b^2 を使わない等号）
        rows = [
            (a - b) * (a + b),
            (a - b) * a + (a - b) * b,          # ℝ の分配法則
            (a * a - b * a) + (a * b - b * b),  # ℝ の分配法則
            (a * a - a * b) + (a * b - b * b),  # 乗法の交換法則 ba = ab
            a * a - b * b,                      # -ab と ab が打ち消し合う
            power(a, 2) - b * b,                # square_of_real_number_is_product (r → a)
            power(a, 2) - power(b, 2),          # square_of_real_number_is_product (r → b)
        ]
        for k in range(len(rows) - 1):
            assert rows[k] == rows[k + 1], ("鎖の行", k + 1, a, b)
            chain_eqs += 1
        assert a + b > 0, ("正の和の段", a, b)
        assert (power(a, 2) == power(b, 2)) == (a == b), ("主張", a, b)
        if power(a, 2) == power(b, 2):
            # 鎖の 7・8 行目: a^2 = b^2 の代入と b^2 - b^2 = 0
            assert rows[-1] == power(b, 2) - power(b, 2), ("a^2 = b^2 の代入", a, b)
            assert power(b, 2) - power(b, 2) == 0, ("b^2 - b^2 = 0", a, b)
            chain_eqs += 2
            assert (a - b) * (a + b) == 0 and a + b != 0 and a - b == 0, ("整域の段", a, b)
        if a == b:
            # a = b ⟹ a^2 = b^2（代入）
            assert power(a, 2) == power(b, 2), ("代入の向き", a, b)
        checked += 1
# 正値性の仮定が要ること: 符号を許すと (−a)^2 = a^2 だが −a ≠ a。
necessity = 0
for a in vals:
    assert power(-a, 2) == power(a, 2) and -a != a
    necessity += 1
print("positive_real_square_injective: 組 %d 件で主張と各段が成立（鎖の等号 %d 個）、仮定の必要性の反例 %d 件を確認" % (checked, chain_eqs, necessity))
print("PASS")
