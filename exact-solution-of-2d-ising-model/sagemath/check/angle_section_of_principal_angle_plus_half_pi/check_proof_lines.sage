# 対象ラベル: angle_section_of_principal_angle_plus_half_pi
# theta in [-pi/2, pi/2] なら s_[0,2pi)([theta + pi/2]) = theta + pi/2。
# 準備の第一（3 行）・第二（2 行）・第三（4 行）と、本体の 2 行を確かめる。
# 帰属: 等号は QQ[pi_, t_]（t_ は theta）の多項式で厳密に比べる。不等号の行と整数の同定は、
#       theta を [-pi/2, pi/2] の点に置き、RIF の pi で比べる（浮動小数点の丸めで判定しない）。
R.<pi_, t_> = PolynomialRing(QQ)
h = pi_ / 2
n = 0

def eq_chain(rows):
    global n
    assert all(a == b for a, b in zip(rows, rows[1:])), rows
    n += len(rows) - 1

eq_chain([(t_ + h) - 2 * 0 * pi_, (t_ + h) - 0 * pi_, (t_ + h) - 0, t_ + h])   # 準備の第一
eq_chain([R(0), (-h) + h])                                                     # 準備の第二の等号
# 準備の第三: theta + pi/2 <= pi（principal_angle_plus_half_pi_at_most_pi）= 0 + pi < pi + pi = 2pi
eq_chain([pi_, 0 + pi_])
assert (pi_ + pi_) - (0 + pi_) == pi_ - 0     # 3 行目の当てはめ（a -> 0, b -> pi, c -> pi）
eq_chain([pi_ + pi_, 2 * pi_])
PI = RIF(pi)
assert PI > 0
for k in range(-8, 9):
    th = QQ(k) / 16 * PI
    assert (-PI / 2) + PI / 2 <= th + PI / 2 or k == -8       # 準備の第二の不等号（k=-8 は等号）
    assert QQ(k) / 16 + QQ(1) / 2 <= 1                        # 準備の第三の 1 行目（QQ で判定。k=8 は等号）
    assert 0 + PI < PI + PI                                   # 準備の第三の狭義の不等号
    v = th + PI / 2
    # 一意性による同定: 0 <= v - 2 m pi < 2 pi を満たす整数 m は 0 だけ（-20..20 を走査）
    sols = [m for m in range(-20, 21) if (v - 2 * m * PI >= 0 or (k == -8 and m == 0)) and v - 2 * m * PI < 2 * PI]
    assert sols == [0], (k, sols)
n += 3
# 本体: s = (theta + pi/2) - 2*0*pi = theta + pi/2
eq_chain([(t_ + h) - 2 * 0 * pi_, t_ + h])
# 否定の対照: 整数を -1 と取り違えると上端を超える。準備の第一で 2*0 を 2 と取り違えると値が変わる。
# theta を範囲外の 2pi に置くと theta + pi/2 は 2pi 以上になり n = 0 は条件を満たさない。
assert not (QQ(1) / 4 * PI + PI / 2 + 2 * PI < 2 * PI)
assert (t_ + h) - 2 * pi_ != t_ + h
assert not (2 * PI + PI / 2 < 2 * PI)
print("angle_section_of_principal_angle_plus_half_pi: 等号 %d 行・不等号と整数の同定 3 件（17 点）" % (n - 3))
print("negative controls (broken lines detected): 3")
print("RESULT: PASS")
