# <inverse_of_sqrt_cc>: 証明の第四の φ_polar(1_C) の鎖のうち、根号の中の ℝ の計算の行を ℚ で厳密に確かめる。
# 1^2 + 0^2 → 1 + 0^2（power_of_real_one_is_one, m → 2）→ 1 + 0·0（square_of_real_number_is_product, r → 0）
# → 1 + 0（real_zero_times_is_zero, x → 0）→ 1（0 は ℝ の加法の単位元、set_and_algebra_notation）→ √1 = 1（sqrt_of_real_one_is_one）→ 0/1 = 0（real_zero_divided_is_zero, x → 1。1 ≠ 0 は体の公理 0 ≠ 1）。
# 鎖の最後の行 arctan 0 = 0 は主張 arctan_zero の参照で、その検算は sagemath/check/arctan_zero/。
load("../../_shared/operators.sage")
rep = CheckReport("inverse_of_sqrt_cc: φ_polar(1_C) の鎖の ℝ の計算")
one, zero = QQ(1), QQ(0)
rep.truth(one**2 + zero**2 == one + zero**2, "1^2 + 0^2 = 1 + 0^2（1^2 = 1）")
rep.truth(one + zero**2 == one + zero * zero, "1 + 0^2 = 1 + 0·0（0^2 = 0·0）")
rep.truth(one + zero * zero == one + zero, "1 + 0·0 = 1 + 0（real_zero_times_is_zero の x → 0）")
rep.truth(one + zero == one, "1 + 0 = 1（0 は ℝ の加法の単位元）")
y = AA(one).sqrt()
rep.truth(y >= 0 and y**2 == one and y == one, "√1 = 1（y ≥ 0 かつ y^2 = 1 のただ一つの y）")
rep.truth(one != zero, "1 ≠ 0（体の公理 0 ≠ 1）")
rep.truth(zero / one == zero, "0/1 = 0（real_zero_divided_is_zero の x → 1）")
rep.finish()
