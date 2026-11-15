# 対象ラベル: angle_section_integer_of_zero_is_zero
# 証明の準備の 0 − 2·0·π = 0 − 0·π = 0 − 0 = 0 の 3 行の鎖と、0 < 2π・0 ≤ 0 から
# angle_section_existence_uniqueness の θ → 0 の整数が 0 に定まることを確かめる。
#   鎖: 2·0 = 0 は real_times_zero_is_zero (x → 2)、0·π = 0 は real_zero_times_is_zero (x → π)、
#       0 − 0 = 0 は real_minus_zero_is_self (a → 0)。2·0·π は (2·0)·π と読む。
# 帰属: 鎖は π を不定元 pi_ とする QQ[pi_] の多項式で厳密に比べる。
#       0 < 2π と整数の同定だけは π の値が要るので RIF（区間演算）の π で比べる（浮動小数点の丸めで判定しない）。
R.<pi_> = PolynomialRing(QQ)
z, two = R(0), R(2)
n = 0

def chain(rows):
    global n
    assert all(a == b for a, b in zip(rows, rows[1:])), rows
    n += len(rows) - 1

# 準備の鎖（3 行）
chain([z - (two * z) * pi_, z - z * pi_, z - z, z])
# 各行が引く主張の当てはめ: x·0 = 0 (x → 2)、0·x = 0 (x → π)、a − 0 = a (a → 0)
assert two * z == z and z * pi_ == z and z - z == z
# 0 < 2π（pi_is_positive の 0 < π と 0 < 2 の積）
PI = RIF(pi)
assert PI > 0 and 2 * PI > 0
n += 1
# 0 ≤ 0 − 2·0·π < 2π（鎖の値 0 を当てた形）
assert RIF(0) <= 0 - 2 * 0 * PI and 0 - 2 * 0 * PI < 2 * PI
n += 1
# 一意性の確認: 0 ≤ 0 − 2kπ < 2π を満たす整数は 0 だけ（k の範囲 −20..20 を走査）
sols = [k for k in range(-20, 21) if (0 - 2 * k * PI >= 0) and (0 - 2 * k * PI < 2 * PI)]
assert sols == [0], sols
n += 1
# 否定の対照: 整数を 1・−1 に取り違えると条件を満たさない。鎖の 2·0 を 2 と取り違えると 0 にならない
assert not (0 - 2 * 1 * PI >= 0)
assert not (0 - 2 * (-1) * PI < 2 * PI)
assert z - two * pi_ != z
print("angle_section_integer_of_zero_is_zero: 等号 3・0 < 2π 1・条件の成立 1・整数の同定 1（計 %d）" % n)
print("negative controls (broken lines detected): 3")
print("RESULT: PASS")
