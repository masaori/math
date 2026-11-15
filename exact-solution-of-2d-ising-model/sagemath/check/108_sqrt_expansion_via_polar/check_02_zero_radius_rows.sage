# 対象ラベル: sqrt_expansion_via_polar
# r = 0 の場合の左辺の鎖のうち、s_{[0,2π)}([0]) から 0 へ移る行と (1/2)·0 = 0 の行を
# QQ[pi_] の多項式として一行ずつ比べる（π は不定元 pi_ で表し、浮動小数点を使わない）。
#   左辺:   (1/2)·s_{[0,2π)}([0]) = (1/2)·0（angle_section_of_zero_is_zero）= 0（real_times_zero_is_zero (x → 1/2)）
#           s([θ]) := θ − 2nπ に θ → 0 と angle_section_integer_of_zero_is_zero の n = 0 を当てて計算する
#           （その主張自身の鎖は sagemath/check/angle_section_of_zero_is_zero/ が確かめる）。
R.<pi_> = PolynomialRing(QQ)
z = R(0)
two = R(2)
half = R(1/2)
n = 0

def section(theta, n_int):
    return theta - (two * R(n_int)) * pi_

def chain(rows):
    global n
    assert all(a == b for a, b in zip(rows, rows[1:])), rows
    n += len(rows) - 1

chain([half * section(z, 0), half * z, z])
assert half * z == 0
assert half * section(z, 1) != 0       # 対照: 整数を 0 でなく 1 とすると 0 にならない

print("zero-radius rows of sqrt_expansion_via_polar in QQ[pi_]: %d checks" % n)
print("RESULT: PASS")
