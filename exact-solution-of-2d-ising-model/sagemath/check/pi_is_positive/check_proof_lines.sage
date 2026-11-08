# 対象ラベル: pi_is_positive
# 0 < π の証明の鎖を一行ずつ確かめる。
#   準備の arcsin(-1) の鎖 3 行: def_arcsin の第二の式（y' → -1）・ℝ で -(-a) = a（a → 1）・arcsin(1) = π/2
#   準備の -π/2 < π/2 の鎖 3 行: 上の鎖・-1 < 1 と arcsin の狭義単調増加・arcsin(1) = π/2
#   本体の 0 < π の鎖 3 行: -a + a = 0（a → π/2）・順序と加法の両立（c → π/2）・a/2 + a/2 = a（a → π）
# 帰属: 等号は Sage の記号計算（SR）と QQ で厳密。不等号は RealBallField(256) のボールの比較で確かめる
#       （π と arcsin の値が実数なので ℝ へ脱出する。ボールの比較は真と判定できたときだけ真を返す）。
# 本文の arcsin（弧の長さ）が標準の arcsin に等しいことは arcsin_is_bijection の検算が扱う。

R = RealBallField(256)
pi_b = R.pi()
eq_count = 0
ineq_count = 0

def arcsin_b(y):
    return R(y).arcsin()

# 準備の arcsin(-1) の鎖
# 1 行目: arcsin(-1) = -arcsin(-(-1))（def_arcsin の第二の式。-1 ≤ -1 < 0）
assert QQ(-1) >= -1 and QQ(-1) < 0
assert bool(arcsin(SR(-1)) == -arcsin(-(SR(-1))))
eq_count += 1
# 2 行目: -(-1) = 1
assert -(QQ(-1)) == QQ(1); eq_count += 1
# 3 行目: arcsin(1) = π/2
assert bool(-arcsin(SR(1)) == -(pi / 2)); eq_count += 1

# 準備の -π/2 < π/2 の鎖
assert bool(-(pi / 2) == arcsin(SR(-1))); eq_count += 1
assert QQ(-1) < QQ(1)
assert arcsin_b(-1) < arcsin_b(1); ineq_count += 1
assert bool(arcsin(SR(1)) == pi / 2); eq_count += 1
assert -(pi_b / 2) < pi_b / 2; ineq_count += 1

# 本体の 0 < π の鎖
assert bool(SR(0) == -(pi / 2) + pi / 2); eq_count += 1
assert -(pi_b / 2) + pi_b / 2 < pi_b / 2 + pi_b / 2; ineq_count += 1
assert bool(pi / 2 + pi / 2 == pi); eq_count += 1
# 主張: 0 < π
assert R(0) < pi_b; ineq_count += 1

# 否定コントロール
broken = 0
# arcsin(-1) の符号を取り違えて +π/2 とすると、-π/2 < π/2 の鎖の 2 行目（arcsin(-1) < arcsin(1)）が成り立たない
if not (pi_b / 2 < arcsin_b(1)):
    broken += 1
# 本体の 2 行目で両辺に同じ c を足さず、左辺に π/2・右辺に -π/2 を足すと不等号が成り立たない
if not (-(pi_b / 2) + pi_b / 2 < pi_b / 2 + (-(pi_b / 2))):
    broken += 1
# 本体の 3 行目で a/2 + a/2 を a/2 と取り違えると π/2 ≠ π
if not bool(pi / 2 == pi):
    broken += 1
assert broken == 3

print(f"等号 {eq_count} 個・不等号 {ineq_count} 件を確かめた（等号は SR と QQ で厳密、不等号は RealBallField(256)）")
print(f"negative controls (broken lines detected): {broken}")
print("RESULT: PASS")
