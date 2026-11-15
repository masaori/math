# 対象ラベル: angle_section_integer_of_pi_is_zero
# 証明の準備の π < 2π の 5 行の鎖、π − 2·0·π = π の 3 行の鎖、0 ≤ π から
# angle_section_existence_uniqueness の θ → π の整数が 0 に定まることを確かめる。
#   π < 2π の鎖: π = 0 + π（0 + a = a を右辺から左辺へ）、0 + π < π + π（0 < π の両辺に π を足す）、
#       π + π = 1·π + 1·π（1·x = x を 2 箇所へ右辺から左辺へ）、(1 + 1)π（分配律）、2π（def_real_two の 2 := 1 + 1 を右辺から左辺へ）。
#   π − 2·0·π = π の鎖: 2·0 = 0 は real_times_zero_is_zero (x → 2)、0·π = 0 は real_zero_times_is_zero (x → π)、
#       π − 0 = π は real_minus_zero_is_self (a → π)。2·0·π は (2·0)·π と読む。
# 帰属: 等号は π を不定元 pi_ とする QQ[pi_] の多項式で厳密に比べる。
#       不等号（0 < π、π < 2π、0 ≤ π）と整数の同定だけは π の値が要るので RIF（区間演算）の π で比べる
#       （浮動小数点の丸めで判定しない）。
R.<pi_> = PolynomialRing(QQ)
z, one, two = R(0), R(1), R(2)
n = 0

def chain(rows):
    global n
    assert all(a == b for a, b in zip(rows, rows[1:])), rows
    n += len(rows) - 1

PI = RIF(pi)
# π < 2π の鎖。等号の 4 行は QQ[π] で、不等号の 1 行は RIF で。
assert pi_ == z + pi_; n += 1
assert PI > 0 and 0 + PI < PI + PI; n += 1
chain([pi_ + pi_, one * pi_ + one * pi_, (one + one) * pi_, two * pi_])
assert one + one == two
# 鎖の両端: π < 2π
assert PI < 2 * PI
# π − 2·0·π = π の鎖（3 行）
chain([pi_ - (two * z) * pi_, pi_ - z * pi_, pi_ - z, pi_])
# 各行が引く主張の当てはめ: x·0 = 0 (x → 2)、0·x = 0 (x → π)、a − 0 = a (a → π)
assert two * z == z and z * pi_ == z and pi_ - z == pi_
# 0 ≤ π（0 < π から）
assert RIF(0) <= PI
n += 1
# 0 ≤ π − 2·0·π < 2π（鎖の値 π を当てた形）
assert RIF(0) <= PI - 2 * 0 * PI and PI - 2 * 0 * PI < 2 * PI
n += 1
# 一意性の確認: 0 ≤ π − 2kπ < 2π を満たす整数は 0 だけ（k の範囲 −20..20 を走査）
sols = [k for k in range(-20, 21) if (PI - 2 * k * PI >= 0) and (PI - 2 * k * PI < 2 * PI)]
assert sols == [0], sols
n += 1
# 否定の対照: 整数を 1・−1 に取り違えると条件を満たさない。鎖の 2·0 を 2 と取り違えると π にならない。
# 1 + 1 を 1 と取り違えると 2π にならない
assert not (PI - 2 * 1 * PI >= 0)
assert not (PI - 2 * (-1) * PI < 2 * PI)
assert pi_ - two * pi_ != pi_
assert one * pi_ != two * pi_
print("angle_section_integer_of_pi_is_zero: π < 2π の鎖 5・π − 2·0·π の鎖 3・0 ≤ π 1・条件の成立 1・整数の同定 1（計 %d）" % n)
print("negative controls (broken lines detected): 4")
print("RESULT: PASS")
