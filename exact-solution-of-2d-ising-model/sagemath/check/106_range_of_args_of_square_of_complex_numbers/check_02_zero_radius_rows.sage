# 対象ラベル: range_of_args_of_square_of_complex_numbers
# r = 0 の場合の鎖のうち、主張の参照に替えた行を QQ[pi_] の多項式として一行ずつ比べる
# （π は不定元 pi_ で表し、浮動小数点を使わない）。
#   arg(z):   s_{[0,2π)}([0]) = 0（angle_section_of_zero_is_zero）。s([θ]) := θ − 2nπ に θ → 0 と
#             angle_section_integer_of_zero_is_zero の n = 0 を当てた値が 0 であることを確かめる
#             （その主張自身の鎖は sagemath/check/angle_section_of_zero_is_zero/ が確かめる）。
#   arg(z^2): pr_2 の中の半径 0·0 = 0（real_zero_times_is_zero (x → 0)）、
#             s_{[0,2π)}([0]) = 0（angle_section_of_zero_is_zero）、0 = 2·0（real_times_zero_is_zero (x → 2) を右辺から左辺へ）
R.<pi_> = PolynomialRing(QQ)
z = R(0)
two = R(2)
n = 0

def section(theta, n_int):
    return theta - (two * R(n_int)) * pi_

def chain(rows):
    global n
    assert all(a == b for a, b in zip(rows, rows[1:])), rows
    n += len(rows) - 1

chain([section(z, 0), z])      # arg(z) の鎖の最後の行 s([0]) = 0
chain([section(z, 0), z])      # arg(z^2) の鎖の同じ行 s([0]) = 0
chain([z * z, z])
chain([z, two * z])
assert z - two * pi_ != 0              # 対照: 整数 n → 0 でなく n → 1 なら 0 にならない

print("zero-radius rows of range_of_args_of_square_of_complex_numbers in QQ[pi_]: %d checks" % n)
print("RESULT: PASS")
