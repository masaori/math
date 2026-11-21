# 対象ラベル: real_section_minus_half_pi_in_principal_interval
# 0 <= x <= pi なら -pi/2 <= x - pi/2 <= pi/2。左側の 3 行・右側の 6 行の鎖を確かめる。
# 帰属: 等号は QQ[pi_, x_] で厳密。不等号の行は「大きい側 − 小さい側 = 仮定の大きい側 − 小さい側」を多項式で確かめ
#       （順序と加法の両立の当てはめ）、x = q*pi の点（0 <= q <= 1）で仮定と主張の符号を QQ で判定する。
R.<pi_, x_> = PolynomialRing(QQ)
h = pi_ / 2
n = 0
def eq_chain(rows):
    global n
    assert all(a == b for a, b in zip(rows, rows[1:])), rows
    n += len(rows) - 1
# 左側: -pi/2 = 0 + (-pi/2) <= x + (-pi/2) = x - pi/2
eq_chain([-h, 0 + (-h)])
assert (x_ + (-h)) - (0 + (-h)) == x_ - 0     # 2 行目の当てはめ（a -> 0, b -> x, c -> -pi/2）
eq_chain([x_ + (-h), x_ - h])
# 右側: x - pi/2 = x + (-pi/2) <= pi + (-pi/2) = (pi/2 + pi/2) + (-pi/2) = pi/2 + (pi/2 + (-pi/2)) = pi/2 + 0 = pi/2
eq_chain([x_ - h, x_ + (-h)])
assert (pi_ + (-h)) - (x_ + (-h)) == pi_ - x_  # 2 行目の当てはめ（a -> x, b -> pi, c -> -pi/2）
eq_chain([pi_ + (-h), (h + h) + (-h), h + (h + (-h)), h + 0, h])
for k in range(0, 17):
    q = QQ(k) / 16
    assert q >= 0 and 1 - q >= 0                                     # 仮定 0 <= x <= pi
    assert (q - QQ(1) / 2) - (-QQ(1) / 2) >= 0 and QQ(1) / 2 - (q - QQ(1) / 2) >= 0   # 主張
# 否定の対照: 右側 3 行目で pi/2 + pi/2 を pi/2 と取り違えると等号が崩れる。
# x = -pi/4（0 <= x を外す）で左側が、x = 5pi/4（x <= pi を外す）で右側が崩れる。
assert pi_ + (-h) != h + (-h)
assert not ((-QQ(1) / 4 - QQ(1) / 2) - (-QQ(1) / 2) >= 0)
assert not (QQ(1) / 2 - (QQ(5) / 4 - QQ(1) / 2) >= 0)
print("real_section_minus_half_pi_in_principal_interval: 等号 %d 行・不等号 2 行の当てはめ（17 点）" % n)
print("negative controls (broken lines detected): 3")
print("RESULT: PASS")
