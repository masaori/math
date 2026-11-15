# 対象ラベル: real_negation_of_zero_is_zero
# -0 = -0 + 0 = 0 + (-0) = 0 の 3 行の鎖を確かめる。
# 計算する環では -0 = 0 が既に成り立つので、-0 を QQ[n] の不定元 n に置き、
# -0 = 0 を前提にしない形で、どの行にどの規則を当てたかを確かめる（足す側の 0 は環のもの）。
# n が 0 の加法の逆元であるという条件 0 + n = 0 は、商環 QQ[n]/(0 + n) で課す。
# 帰属: 多項式環 QQ[n] とその商環。浮動小数点は使わない。

R.<n> = QQ[]
ZERO = R(0)

lines = [
    n,              # 1 行目の左辺 -0
    n + ZERO,       # 加法の単位元を右辺から左辺へ
    ZERO + n,       # 加法の可換則
    ZERO,           # 加法の逆元 z + (-z) = 0（z → 0）
]

# 加法の単位元と可換則の段は、n を不定元にしたまま恒等的に等しい。
identity_steps = [0, 1]
for k in identity_steps:
    assert lines[k] == lines[k + 1], (k, lines[k], lines[k + 1])

# 加法の逆元の段: 3 行目 0 + n は、逆元の条件 0 + n = 0 そのものの左辺である。
inverse_condition = ZERO + n
assert lines[2] == inverse_condition
Q = R.quotient(R.ideal(inverse_condition))
assert Q(lines[2]) == Q(lines[3])
# 鎖の両端: 逆元の条件の下で -0（= n）は 0 に等しい。
assert Q(lines[0]) == Q(ZERO)
# 否定コントロール: 逆元の条件を課さなければ最後の段は成り立たない。
assert lines[2] != lines[3]
# 否定コントロール: 逆元の条件を 1 + n = 0（1 の逆元）に取り違えると、n は 0 にならない。
Q_wrong = R.quotient(R.ideal(R(1) + n))
assert Q_wrong(n) != Q_wrong(ZERO)
# QQ の符号反転でも -0 = 0。
assert -QQ(0) == QQ(0)

print(f"QQ[n] で恒等的な段 {len(identity_steps)} 個と、逆元の条件 0 + n = 0 の下で成り立つ段 1 個を確かめた（等号 {len(identity_steps) + 1} 個）")
print("negative controls (broken lines detected): 2")
print("RESULT: PASS")
