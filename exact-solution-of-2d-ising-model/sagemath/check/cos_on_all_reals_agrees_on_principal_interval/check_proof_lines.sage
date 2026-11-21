# 対象ラベル: cos_on_all_reals_agrees_on_principal_interval
# theta in [-pi/2, pi/2] なら cos_R(theta) = cos(theta)。準備の 3 行と本体の 6 行を確かめる。
# 帰属: 引数の等号は QQ[pi_, t_] で厳密。xi_theta と場合分けは theta = q*pi（q は有理数）について QQ で厳密に求める
#       （xi_theta = (q + 1/2 - 2m) pi、m = floor((q + 1/2)/2)。場合は xi_theta/pi <= 1 かで決める）。
#       値の比較だけは RealBallField(256) で行う。本文の弧の長さの cos（def_cos）が標準の cos と一致することは
#       arcsin_is_bijection の検算に依る。
R.<pi_, t_> = PolynomialRing(QQ)
h = pi_ / 2
n = 0
def eq_chain(rows):
    global n
    assert all(a == b for a, b in zip(rows, rows[1:])), rows
    n += len(rows) - 1
# 本体の引数の鎖: (theta + pi/2) - pi/2 = (theta + pi/2) + (-pi/2) = theta + (pi/2 + (-pi/2)) = theta + 0 = theta
eq_chain([(t_ + h) - h, (t_ + h) + (-h), t_ + (h + (-h)), t_ + 0, t_])
B = RealBallField(256)
PI = B.pi()
def xi_over_pi(q):
    m = floor((q + QQ(1) / 2) / 2)
    return q + QQ(1) / 2 - 2 * m
def cos_R(q):
    # def_cos_on_all_reals の場合分けをそのまま書く
    r = xi_over_pi(q)
    x = B(r) * PI
    return (x - PI / 2).cos() if r <= 1 else -((PI + PI / 2) - x).cos()
for k in range(-8, 9):
    q = QQ(k) / 16
    r = xi_over_pi(q)
    assert r == q + QQ(1) / 2            # 準備の 1・2 行目（xi_theta = theta + pi/2）
    assert r <= 1                        # 準備の 3 行目（一つ目の場合。k = 8 は境目 xi_theta = pi）
    d = cos_R(q) - (B(q) * PI).cos()
    assert d.contains_zero() and d.rad() < 1e-60, k     # 主張
n += 2
# 主張の範囲外の裏取り: 二つ目の場合の点と負の点でも、定義の関数は標準の cos の値になる
for k in [9, 13, 17, 23, 30, -9, -20, -27]:
    q = QQ(k) / 16
    d = cos_R(q) - (B(q) * PI).cos()
    assert d.contains_zero() and d.rad() < 1e-60, k
# 否定の対照: 本体の引数の鎖で -pi/2 を落とすと theta にならない。
# 一つ目の場合（theta = pi/4、xi = 3pi/4）に二つ目の場合の引数 (pi + pi/2) - xi を使うと 3pi/4 になり、
# 主値区間 [-pi/2, pi/2] を外れる（場合分けが要る理由）。
assert (t_ + h) != t_
assert not (QQ(3) / 2 - xi_over_pi(QQ(1) / 4) <= QQ(1) / 2)
print("cos_on_all_reals_agrees_on_principal_interval: 等号 %d 行・準備と主張を 17 点（端点を含む）" % (n - 2))
print("negative controls (broken lines detected): 2")
print("RESULT: PASS")
