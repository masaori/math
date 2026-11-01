# 対象ラベル: real_exp_positive
# 主張 exp(x) > 0 を、本文の exp（1 行 1 列の行列の exp の成分）を囲むボールで具体の点について確かめる。
# R への脱出: exp の値は QQ に収まらないので RealBallField(512) を使う。「> 0」はボールの下端が正であることで確かめる。
# 対照: 部分和 S_N([x]) の成分は x < 0 で負になりうるので、正であることは部分和からは従わず、
# 証明の Step 1・Step 2 の論法（積公式と平方）が要る。
load("../../_shared/one_by_one_matrix.sage")

points = [QQ(0), QQ(1), QQ(-1), QQ(1) / 1000, QQ(-1) / 1000, QQ(-10), QQ(-50), QQ(-74), QQ(37) / 2]
for x0 in points:
    b = body_real_exp_ball(x0)
    assert b.lower() > 0, x0
print(f"{len(points)} 点で exp(x) のボールの下端が正（最小は x = -74 で約 {body_real_exp_ball(QQ(-74)).mid().n(20)}）")

# 対照: 負の点での部分和は負になりうる（厳密に QQ で）
neg = [(QQ(-2), 1), (QQ(-5), 3), (QQ(-10), 9)]
for x0, N in neg:
    s = entry11(matrix_partial_sum(one_by_one(QQ, x0), N))
    assert s < 0, (x0, N, s)
print("対照: S_1(-2)、S_3(-5)、S_9(-10) の成分は負")
print("RESULT: PASS")
