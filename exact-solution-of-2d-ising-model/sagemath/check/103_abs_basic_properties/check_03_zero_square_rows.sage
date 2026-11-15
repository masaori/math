# 対象ラベル: abs_basic_properties
# (1) の x = 0 の三つの場合・(3) の |z| = 0 の場合・(6) の鎖のうち、0^2 を
# square_of_real_number_is_product（r → 0）で 0·0 に開き、real_zero_times_is_zero（x → 0）で 0 にする行を、
# QQ[x, y] の多項式として一行ずつ比べる（浮動小数点を使わない。平方根の中身だけを比べる）。
#   x = 0, y ≷ 0:  x^2 + y^2 = 0^2 + y^2 = 0·0 + y^2 = 0 + y^2 = y^2
#   x = y = 0:     x^2 + y^2 = 0^2 + 0^2 = 0·0 + 0·0 = 0 + 0 = 0
#   (3):           |z|^2 = 0^2 = 0·0 = 0
#   (6):           x^2 + 0^2 = x^2 + 0·0 = x^2 + 0 = x^2
R.<x, y> = PolynomialRing(QQ)
z = R(0)
n = 0

def chain(rows):
    global n
    assert all(a == b for a, b in zip(rows, rows[1:])), rows
    n += len(rows) - 1

# x = 0, y > 0 と x = 0, y < 0（平方根の中身は同じ鎖）
chain([(x^2 + y^2).subs({x: 0}), z^2 + y^2, z * z + y^2, z + y^2, y^2])
# x = 0, y = 0
chain([(x^2 + y^2).subs({x: 0, y: 0}), z^2 + z^2, z * z + z * z, z + z, z])
# (3) |z| = 0 のとき |z|^2 = 0^2 = 0·0 = 0
chain([z^2, z * z, z])
# (6) |ι(x)| の平方根の中身
chain([x^2 + z^2, x^2 + z * z, x^2 + z, x^2])
assert z^2 == z * z and z * z == 0     # square_of_real_number_is_product (r → 0)、real_zero_times_is_zero (x → 0)
assert x^2 + y^2 != y^2                # 対照: x = 0 を代入しなければ y^2 にならない
assert x^2 + y^2 != x^2                # 対照: (6) は第 2 成分が 0 であることを使う

print("zero-square rows of abs_basic_properties as identities in QQ[x, y]: %d equalities" % n)
print("RESULT: PASS")
