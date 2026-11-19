# 対象ラベル: zero_in_closed_interval_from_minus_half_pi_to_half_pi
# 0 ∈ [-π/2, π/2] の証明の鎖を一行ずつ確かめる。
#   準備: 2 は def_real_two の 1 + 1。real_two_is_nonzero の 2 ≠ 0 で 2^{-1} が在り、real_zero_less_than_two の 0 < 2 に real_inverse_of_positive_is_positive（a → 2）を当てて 0 < 2^{-1}
#   （real_two_is_nonzero・real_zero_less_than_two・real_inverse_of_positive_is_positive の証明はそれぞれの検算が扱う）
#   0 < π/2 の鎖 2 行: pi_is_positive の 0 < π と準備の 0 < 2^{-1} と正の数どうしの積は正・def_real_quotient（y → π, z → 2）を右辺から左辺へ
#   -π/2 < 0 の鎖 4 行: 加法の単位元（-π/2 + 0 = -π/2）を右辺から左辺へ・順序と加法の両立（c → -π/2）・加法の可換律・def_real_difference の加法の逆元（z → π/2）
# 0 < π の鎖は主張 pi_is_positive の検算 sagemath/check/pi_is_positive/ が扱う。
# 帰属: 等号は Sage の記号計算（SR）と QQ で厳密。不等号は RealBallField(256) のボールの比較で確かめる
#       （π が実数なので ℝ へ脱出する。ボールの比較は真と判定できたときだけ真を返す）。

R = RealBallField(256)
pi_b = R.pi()
eq_count = 0
ineq_count = 0

# 根拠に引く pi_is_positive の 0 < π（検算は sagemath/check/pi_is_positive/）
assert R(0) < pi_b

# 準備: 2 = 1 + 1（def_real_two）、2 ≠ 0（real_two_is_nonzero）で 2^{-1} は 2 の乗法の逆元、
# 0 < 2（real_zero_less_than_two）と real_inverse_of_positive_is_positive（a → 2）から 0 < 2^{-1}
assert QQ(1) + QQ(1) == QQ(2) and QQ(2) != 0
two_inv = QQ(2)**(-1)
assert QQ(2) * two_inv == 1; eq_count += 1
assert 0 < QQ(2) and 0 < two_inv; ineq_count += 2

# 0 < π/2 の鎖
# 1 行目: 0 < π と 0 < 2^{-1} から 0 < π·2^{-1}（正の数どうしの積は正）
assert R(0) < pi_b * R(two_inv); ineq_count += 1
# 2 行目: π·2^{-1} = π/2（def_real_quotient）
assert bool(pi * two_inv == pi / 2); eq_count += 1

# -π/2 < 0 の鎖
assert bool(-(pi / 2) == -(pi / 2) + 0); eq_count += 1
assert -(pi_b / 2) + 0 < -(pi_b / 2) + pi_b / 2; ineq_count += 1
assert bool(-(pi / 2) + pi / 2 == pi / 2 + (-(pi / 2))); eq_count += 1   # 加法の可換律
assert bool(pi / 2 + (-(pi / 2)) == 0); eq_count += 1                     # def_real_difference の加法の逆元

# 結論: -π/2 ≤ 0 ≤ π/2
assert -(pi_b / 2) <= 0 and R(0) <= pi_b / 2; ineq_count += 2

# 否定コントロール
broken = 0
# 準備の逆数を -2 の逆数に取り違えると、0 < π·(-2)^{-1} が成り立たない
if not (R(0) < pi_b * R(QQ(-2)**(-1))):
    broken += 1
# 区間を [π/2, 3π/2] に取り違えると 0 は入らない
if not (pi_b / 2 <= 0):
    broken += 1
assert broken == 2

print(f"等号 {eq_count} 個・不等号 {ineq_count} 件を確かめた（等号は SR と QQ で厳密、不等号は RealBallField(256)）")
print(f"negative controls (broken lines detected): {broken}")
print("RESULT: PASS")
