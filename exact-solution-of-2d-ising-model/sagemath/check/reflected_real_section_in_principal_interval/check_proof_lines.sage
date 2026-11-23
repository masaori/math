# 対象ラベル: reflected_real_section_in_principal_interval
# pi < x < 2pi なら -pi/2 <= (pi + pi/2) - x <= pi/2。準備の第一（符号反転 2 件）・第二（4 行）、
# 右側の鎖（5 行）・左側の鎖（13 行）を確かめる。不等号の行は、加法の可換律で足す数を右へ移し、
# real_less_than_preserved_by_adding_on_right（x < y ⇒ x + c < y + c）を当て、可換律で戻す 3 行である。
# 帰属: 等号は QQ[pi_, x_] で厳密。不等号の行は差の多項式で当てはめを確かめ、x = q*pi（1 < q < 2）の点で符号を QQ で判定する。
R.<pi_, x_> = PolynomialRing(QQ)
h = pi_ / 2
c = pi_ + h
n = 0
def eq_chain(rows):
    global n
    assert all(a == b for a, b in zip(rows, rows[1:])), rows
    n += len(rows) - 1
# 準備の第一: -x < -pi、-(2pi) < -x（差が仮定の差と一致する）
assert (-pi_) - (-x_) == x_ - pi_ and (-x_) - (-(2 * pi_)) == 2 * pi_ - x_
# 準備の第二
eq_chain([c + (-pi_), (h + pi_) + (-pi_), h + (pi_ + (-pi_)), h + 0, h])
# 右側
eq_chain([c - x_, c + (-x_), (-x_) + c])                 # def_real_difference、加法の交換律
assert ((-pi_) + c) - ((-x_) + c) == (-pi_) - (-x_)     # 3 行目の当てはめ（x -> -x, y -> -pi, c -> pi + pi/2 を右から足す）
eq_chain([(-pi_) + c, c + (-pi_), h])                   # 加法の交換律、準備の第二
# 左側
eq_chain([c - x_, c + (-x_), (-x_) + c])                 # def_real_difference、加法の交換律
assert ((-x_) + c) - ((-(2 * pi_)) + c) == (-x_) - (-(2 * pi_))   # 3 行目の当てはめ（x -> -(2pi), y -> -x, c -> pi + pi/2 を右から足す）
eq_chain([(-(2 * pi_)) + c, c + (-(2 * pi_)), c + (-(pi_ + pi_)), c + ((-pi_) + (-pi_)),
          (c + (-pi_)) + (-pi_), h + (-pi_), h + (-(h + h)), h + ((-h) + (-h)),
          (h + (-h)) + (-h), 0 + (-h), -h])
for k in range(1, 16):
    q = 1 + QQ(k) / 16
    v = QQ(3) / 2 - q                       # ((pi + pi/2) - x)/pi
    assert q - 1 > 0 and 2 - q > 0          # 仮定 pi < x < 2pi
    assert QQ(1) / 2 - v > 0 and v - (-QQ(1) / 2) > 0     # 主張（狭義）
# 否定の対照: 準備の第二で -pi の代わりに -pi/2 を足すと pi/2 にならない。
# x = pi/2（pi < x を外す）では右側が、x = 9pi/4（x < 2pi を外す）では左側が崩れる。
assert c + (-h) != h
assert not (QQ(1) / 2 - (QQ(3) / 2 - QQ(1) / 2) > 0)
assert not ((QQ(3) / 2 - QQ(9) / 4) - (-QQ(1) / 2) > 0)
print("reflected_real_section_in_principal_interval: 等号 %d 行・不等号 4 件の当てはめ（15 点）" % n)
print("negative controls (broken lines detected): 3")
print("RESULT: PASS")
