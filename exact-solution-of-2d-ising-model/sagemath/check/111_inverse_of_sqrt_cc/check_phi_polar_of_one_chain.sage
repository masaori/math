# <inverse_of_sqrt_cc>: 証明の第四の φ_polar(1_C) の鎖のうち、根号の中の ℝ の計算の行を ℚ で厳密に確かめる。
# 1^2 + 0^2 → 1 + 0^2（power_of_real_one_is_one, m → 2）→ 1 + 0·0（square_of_real_number_is_product, r → 0）
# → 1 + 0（0·x = 0）→ 1（a + 0 = a）→ √1 = 1（sqrt_of_real_one_is_one）→ 0/1 = 0。
# 鎖の最後の行 arctan 0 = 0 は主張 arctan_zero の参照で、その検算は sagemath/check/arctan_zero/。
load("../../_shared/operators.sage")
rep = CheckReport("inverse_of_sqrt_cc: φ_polar(1_C) の鎖の ℝ の計算")
one, zero = QQ(1), QQ(0)
rep.truth(one**2 + zero**2 == one + zero**2, "1^2 + 0^2 = 1 + 0^2（1^2 = 1）")
rep.truth(one + zero**2 == one + zero * zero, "1 + 0^2 = 1 + 0·0（0^2 = 0·0）")
rep.truth(one + zero * zero == one + zero, "1 + 0·0 = 1 + 0（0·0 = 0）")
rep.truth(one + zero == one, "1 + 0 = 1")
y = AA(one).sqrt()
rep.truth(y >= 0 and y**2 == one and y == one, "√1 = 1（y ≥ 0 かつ y^2 = 1 のただ一つの y）")
rep.truth(zero / one == zero, "0/1 = 0")
rep.finish()
