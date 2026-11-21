# 対象ラベル: principal_angle_plus_half_pi_at_most_pi
# theta <= pi/2 なら theta + pi/2 <= pi/2 + pi/2 = pi。
# 帰属: 等号は QQ[pi_, t_] で厳密。不等号の行は「右辺 − 左辺 = 仮定の右辺 − 仮定の左辺」を多項式で確かめ
#       （順序と加法の両立の a -> theta, b -> pi/2, c -> pi/2 の当てはめ）、theta = q*pi の点で符号を QQ で判定する。
R.<pi_, t_> = PolynomialRing(QQ)
h = pi_ / 2
assert (h + h) - (t_ + h) == h - t_          # 1 行目の当てはめ
assert h + h == pi_                           # 2 行目（real_half_plus_half_is_original の b -> pi）
for k in range(-32, 9):
    q = QQ(k) / 16                            # theta = q*pi、q <= 1/2
    assert (QQ(1) / 2 - q) >= 0 and (1 - (q + QQ(1) / 2)) >= 0
# 否定の対照: theta = pi（仮定を外す）では theta + pi/2 <= pi が崩れる。2 行目を h と取り違えると pi にならない
assert not (1 - (1 + QQ(1) / 2) >= 0)
assert h != pi_
print("principal_angle_plus_half_pi_at_most_pi: 等号 1 行・不等号 1 行の当てはめ（41 点）")
print("negative controls (broken lines detected): 2")
print("RESULT: PASS")
