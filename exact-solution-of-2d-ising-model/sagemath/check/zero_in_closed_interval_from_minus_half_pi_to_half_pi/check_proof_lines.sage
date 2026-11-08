# 対象ラベル: zero_in_closed_interval_from_minus_half_pi_to_half_pi
# 0 ∈ [-π/2, π/2] の証明の鎖を一行ずつ確かめる。
#   0 < π/2 の鎖 2 行: 0/x = 0（x → 2）・pi_is_positive の 0 < π と x < y, c > 0 ⇒ x/c < y/c（c → 2）
#   -π/2 < 0 の鎖 3 行: a + 0 = a（a → -π/2）・順序と加法の両立（c → -π/2）・-a + a = 0（a → π/2）
# 0 < π の鎖は主張 pi_is_positive の検算 sagemath/check/pi_is_positive/ が扱う。
# 帰属: 等号は Sage の記号計算（SR）と QQ で厳密。不等号は RealBallField(256) のボールの比較で確かめる
#       （π が実数なので ℝ へ脱出する。ボールの比較は真と判定できたときだけ真を返す）。

R = RealBallField(256)
pi_b = R.pi()
eq_count = 0
ineq_count = 0

# 根拠に引く pi_is_positive の 0 < π（検算は sagemath/check/pi_is_positive/）
assert R(0) < pi_b

# 0 < π/2 の鎖
assert QQ(0) == QQ(0) / 2; eq_count += 1
assert R(0) / 2 < pi_b / 2; ineq_count += 1

# -π/2 < 0 の鎖
assert bool(-(pi / 2) == -(pi / 2) + 0); eq_count += 1
assert -(pi_b / 2) + 0 < -(pi_b / 2) + pi_b / 2; ineq_count += 1
assert bool(-(pi / 2) + pi / 2 == 0); eq_count += 1

# 結論: -π/2 ≤ 0 ≤ π/2
assert -(pi_b / 2) <= 0 and R(0) <= pi_b / 2; ineq_count += 2

# 否定コントロール
broken = 0
# 0 < π/2 の鎖で 2 の代わりに -2 で割ると不等号の向きが逆になり 0 < π/(-2) が成り立たない
if not (R(0) < pi_b / (-2)):
    broken += 1
# 区間を [π/2, 3π/2] に取り違えると 0 は入らない
if not (pi_b / 2 <= 0):
    broken += 1
assert broken == 2

print(f"等号 {eq_count} 個・不等号 {ineq_count} 件を確かめた（等号は SR と QQ で厳密、不等号は RealBallField(256)）")
print(f"negative controls (broken lines detected): {broken}")
print("RESULT: PASS")
