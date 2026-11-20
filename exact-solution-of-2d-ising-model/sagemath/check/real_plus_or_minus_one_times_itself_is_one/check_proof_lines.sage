# 対象ラベル: real_plus_or_minus_one_times_itself_is_one
# 主張: σ ∈ {-1,1} ⊂ ℝ なら σ·σ = 1。
# 証明の行:
#   σ = 1 :  1·1 = 1                       （ℝ の乗法の単位元 p·1 = p、p → 1。set_and_algebra_notation）
#   σ = -1:  (-1)·(-1) = 1·1               （real_negation_times_negation_is_product、a → 1, b → 1）
#                      = 1                 （ℝ の乗法の単位元 p·1 = p、p → 1。set_and_algebra_notation）
# 帰属: QQ と QQ[n]（n は -1 を表す不定元。計算する環で既に成り立つ (-1)(-1) = 1 を前提にしないため）。ℝ への脱出は無い。
count = 0
neg = 0

# ---- σ = 1 の 1 行 ----
one = QQ(1)
assert one * one == one                            # p·1 = p（p → 1）
count += 1

# ---- σ = -1 の 2 行 ----
R.<n> = QQ[]
line0 = n * n                                      # (-1)·(-1)
# 1 行目: real_negation_times_negation_is_product（a → 1, b → 1）の与える等式 (-1)(-1) = 1·1。
# n を -1 の不定元に置くと、その等式は n·n = 1·1 である。1 行目の左辺と右辺の差が、この等式の両辺の差と
# ちょうど一致すること（主張の等式をそのまま当てた段であること）を確かめる。
claim_lhs = n * n                                  # (-a)(-b)（a → 1, b → 1）
claim_rhs = R(1) * R(1)                            # ab（a → 1, b → 1）
line1 = R(1) * R(1)                                # 1·1
assert line0 - line1 == claim_lhs - claim_rhs
assert line0.subs({n: -1}) == line1                # 主張の等式は n = -1 で成り立つ
count += 2
assert line0 != line1                               # 主張を当てずには成り立たない（n は不定元）
neg += 1
line2 = R(1)
assert line1 == line2                              # p·1 = p（p → 1）
count += 1
# 不定元 n を本来の値 -1 に置くと、全ての行が 1 になる
assert line0.subs({n: -1}) == line1 == line2 == 1
count += 1

# ---- 主張そのもの（σ ∈ {-1,1}）----
for sigma in [QQ(1), QQ(-1)]:
    assert sigma * sigma == 1
    count += 1

# ---- 否定コントロール: {-1,1} の外の元では成り立たない ----
for sigma in [QQ(0), QQ(2), QQ(-2), QQ(1)/2]:
    assert sigma * sigma != 1
    neg += 1

print(f"checked {count} equalities, {neg} negative controls")
print("RESULT: PASS")
