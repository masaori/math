# <positive_real_square_injective> の検算。有理数で厳密に行う（浮動小数点を使わない）。
# 主張: a, b ∈ ℝ_{>0} について a^2 = b^2 ⟺ a = b。
# 証明の各段: (a-b)(a+b) = a^2 - b^2、a+b > 0、(a-b)(a+b) = 0 かつ a+b ≠ 0 ⟹ a-b = 0。
vals = sorted(set(QQ(p)/QQ(q) for p in range(1, 13) for q in range(1, 9)))
checked = 0
for a in vals:
    for b in vals:
        assert (a - b) * (a + b) == a**2 - b**2, ("因数分解の段", a, b)
        assert a + b > 0, ("正の和の段", a, b)
        assert (a**2 == b**2) == (a == b), ("主張", a, b)
        if a**2 == b**2:
            assert (a - b) * (a + b) == 0 and a + b != 0 and a - b == 0, ("整域の段", a, b)
        checked += 1
# 正値性の仮定が要ること: 符号を許すと (−a)^2 = a^2 だが −a ≠ a。
necessity = 0
for a in vals:
    assert (-a)**2 == a**2 and -a != a
    necessity += 1
print("positive_real_square_injective: 組 %d 件で主張と各段が成立、仮定の必要性の反例 %d 件を確認" % (checked, necessity))
print("PASS")
