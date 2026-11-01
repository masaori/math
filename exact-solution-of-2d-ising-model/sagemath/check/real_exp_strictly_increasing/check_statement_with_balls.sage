# 対象ラベル: real_exp_strictly_increasing
# 主張「x < y なら exp(x) < exp(y)」を、本文の exp を囲むボールで具体の点の組について確かめる。
# R への脱出: exp の値は QQ に収まらないので RealBallField(512) を使い、「<」は exp(x) のボールの上端が
# exp(y) のボールの下端より小さいことで確かめる。
# 対照: 部分和の成分は x < y でも大小が逆になりうる（S_1 は単調でも S_2 は x < 0 で減る区間がある）。
load("../../_shared/one_by_one_matrix.sage")

pairs = [(QQ(0), QQ(1) / 10^6), (QQ(-1) / 10^6, QQ(0)), (QQ(-1) / 3, QQ(1) / 7), (QQ(-74), QQ(-73)),
         (QQ(5), QQ(11) / 2), (QQ(-3), QQ(30)), (QQ(1), QQ(1) + QQ(1) / 10^9)]
for x0, y0 in pairs:
    assert x0 < y0
    assert body_real_exp_ball(x0).upper() < body_real_exp_ball(y0).lower(), (x0, y0)
print(f"{len(pairs)} 組の点で exp(x) < exp(y)")

# 対照: S_2(z) = 1 + z + z^2/2 は z = -3 で 5/2、z = -2 で 1 なので、-3 < -2 なのに S_2(-3) > S_2(-2)（QQ で厳密）
s2 = lambda z: entry11(matrix_partial_sum(one_by_one(QQ, z), 2))
assert s2(QQ(-3)) > s2(QQ(-2))
print("対照: 部分和 S_2 は -3 < -2 で大小が逆になる")
print("RESULT: PASS")
