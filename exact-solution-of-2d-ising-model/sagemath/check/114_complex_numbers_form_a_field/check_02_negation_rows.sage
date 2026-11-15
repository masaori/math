# 対象ラベル: complex_numbers_form_a_field
# 加法逆元と (-1_C)·z の一致の鎖を QQ[a, b] の多項式として一行ずつ比べる（浮動小数点を使わない）。
#   (-1_C)·(a,b) = (-1,0)(a,b) = ((−1)a − 0·b, (−1)b + 0·a)
#                = ((−1)a − 0, (−1)b + 0)   real_zero_times_is_zero (x -> b, x -> a)
#                = ((−1)a, (−1)b + 0)       real_minus_zero_is_self (a -> (−1)a)
#                = ((−1)a, (−1)b)           0 は和の単位元
#                = (−a, −b)                 real_minus_one_times_is_negation (a -> a, a -> b)
R.<a, b> = PolynomialRing(QQ)

def cmul(z, w):
    # definition_of_cc の積 (a,b)(c,d) = (ac − bd, ad + bc)
    return (z[0] * w[0] - z[1] * w[1], z[0] * w[1] + z[1] * w[0])

rows = [cmul((R(-1), R(0)), (a, b)),
        ((-1) * a - 0 * b, (-1) * b + 0 * a),
        ((-1) * a - 0, (-1) * b + 0),
        ((-1) * a, (-1) * b + 0),
        ((-1) * a, (-1) * b),
        (-a, -b)]
assert all(x == y for x, y in zip(rows, rows[1:]))
assert 0 * b == 0 and 0 * a == 0       # real_zero_times_is_zero の二つの具体化
assert (-1) * a - 0 == (-1) * a        # real_minus_zero_is_self の具体化 (a -> (−1)a)
assert (-1) * a == -a and (-1) * b == -b  # real_minus_one_times_is_negation の二つの具体化 (a -> a, a -> b)
# 鎖の終点が加法逆元であること: (a,b) + (−a,−b) = (0,0)
assert (a + rows[-1][0], b + rows[-1][1]) == (0, 0)

print("(-1_C)·z = -z chain as identities in QQ[a, b]")
print("RESULT: PASS")
