# 対象ラベル: range_of_args_of_square_of_complex_numbers
# r = 0 の場合の鎖のうち、0 を因子にもつ積を real_times_zero_is_zero・real_zero_times_is_zero の参照へ替えた行を、
# QQ[pi_] の多項式として一行ずつ比べる（π は不定元 pi_ で表し、浮動小数点を使わない）。
#   arg(z):   0 − 2·0·π = 0 − 0·π = 0 − 0 = 0
#             （2·0 = 0 は real_times_zero_is_zero (x → 2)、0·π = 0 は real_zero_times_is_zero (x → π)、
#               最後は a − 0 = a (a → 0)。2·0·π は (2·0)·π と読む）
#   arg(z^2): pr_2 の中の半径 0·0 = 0（real_zero_times_is_zero (x → 0)）、0 = 2·0（real_times_zero_is_zero (x → 2) を右辺から左辺へ）
R.<pi_> = PolynomialRing(QQ)
z = R(0)
two = R(2)
n = 0

def chain(rows):
    global n
    assert all(a == b for a, b in zip(rows, rows[1:])), rows
    n += len(rows) - 1

chain([z - (two * z) * pi_, z - z * pi_, z - z, z])
chain([z * z, z])
chain([z, two * z])
assert two * z == 0 and z * pi_ == 0 and z - z == 0
assert z - two * pi_ != 0              # 対照: 整数 n → 0 でなく n → 1 なら 0 にならない

print("zero-radius rows of range_of_args_of_square_of_complex_numbers in QQ[pi_]: %d equalities" % n)
print("RESULT: PASS")
