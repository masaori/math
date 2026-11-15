# 対象ラベル: angle_section_of_zero_is_zero
# s_{[0,2π)}([0]) = 0 − 2n_0π = 0 − 2·0·π = 0 − 0·π = 0 − 0 = 0 の 5 行の鎖を確かめる。
#   1 行目: section_of_angle_representation の θ → 0, n → n_0。定義 s([θ]) := θ − 2nπ を (θ, n) の関数として書き、
#           n_0 を不定元に置いて (0, n_0) を当てたものが 1 行目の右辺と一致する。
#   2 行目: angle_section_integer_of_zero_is_zero の n_0 = 0（n_0 を 0 に置き換える段）。
#   3〜5 行目: real_times_zero_is_zero (x → 2)・real_zero_times_is_zero (x → π)・real_minus_zero_is_self (a → 0)。
# 帰属: π を不定元 pi_ とする QQ[pi_] の多項式で厳密に比べる。浮動小数点は使わない。
R.<pi_, n0> = PolynomialRing(QQ)
z, two = R(0), R(2)

def section(theta, n_int):
    # section_of_angle_representation の値 θ − 2nπ（n は θ について angle_section_existence_uniqueness が定める整数）
    return theta - (two * R(n_int)) * pi_

def section_sym(theta, n_val):
    return theta - (two * n_val) * pi_

line1 = z - two * n0 * pi_
assert section_sym(z, n0) == line1
# 定義の値の関数が整数ごとに 1 行目の n_0 の置き換えと一致する（整数 0・1・−1）
for k in (0, 1, -1):
    assert section(z, k) == line1.subs(n0=k)
count = 1
assert line1.subs(n0=0) == z - (two * z) * pi_ and section(z, 0) == line1.subs(n0=0)
count += 1
assert line1 != z - (two * z) * pi_   # 対照: n_0 を 0 に置き換えなければ 2 段目は成り立たない
rows = [z - (two * z) * pi_, z - z * pi_, z - z, z]
for a, b in zip(rows, rows[1:]):
    assert a == b
    count += 1
assert two * z == z and z * pi_ == z and z - z == z
# 否定の対照: 整数を 1 に取り違えると 0 にならない。θ を π に取り違えると 0 にならない
assert section(z, 1) != z
assert section(pi_, 0) != z
print("angle_section_of_zero_is_zero: 等号 %d" % count)
print("negative controls (broken lines detected): 3")
print("RESULT: PASS")
