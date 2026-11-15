# 対象ラベル: sqrt_expansion_via_polar
# r = 0 の場合の冒頭に置いた 0 − 2·0·π = 0 の鎖と、左辺の鎖の s_{[0,2π)}([0]) から 0 へ移る 2 行を
# QQ[pi_] の多項式として一行ずつ比べる（π は不定元 pi_ で表し、浮動小数点を使わない）。
#   準備:   0 − 2·0·π = 0 − 0·π = 0 − 0 = 0
#           （2·0 = 0 は real_times_zero_is_zero (x → 2)、0·π = 0 は real_zero_times_is_zero (x → π)、
#             最後は a − 0 = a (a → 0)。2·0·π は (2·0)·π と読む）
#   左辺:   (1/2)·(0 − 2·0·π) = (1/2)·0（準備の鎖）= 0（real_times_zero_is_zero (x → 1/2)）
#   整数:   0 ≤ 0 − 2·n·π < 2π を満たす整数 n は 0 だけ（RIF の π で区間演算により厳密に比べる）
R.<pi_> = PolynomialRing(QQ)
z = R(0)
two = R(2)
half = R(1/2)
n = 0

def chain(rows):
    global n
    assert all(a == b for a, b in zip(rows, rows[1:])), rows
    n += len(rows) - 1

chain([z - (two * z) * pi_, z - z * pi_, z - z, z])
chain([half * (z - (two * z) * pi_), half * z, z])
assert two * z == 0 and z * pi_ == 0 and z - z == 0 and half * z == 0
# 整数の同定: RIF の π で 0 ≤ −2kπ < 2π を満たす k を探すと 0 だけ
PI = RIF(pi)
assert PI > 0
sols = [k for k in range(-5, 6) if (0 - 2 * k * PI >= 0) and (0 - 2 * k * PI < 2 * PI)]
assert sols == [0], sols
n += 1
assert z - two * pi_ != 0              # 対照: 整数を 0 でなく 1 とすると 0 にならない

print("zero-radius rows of sqrt_expansion_via_polar in QQ[pi_]: %d checks" % n)
print("RESULT: PASS")
