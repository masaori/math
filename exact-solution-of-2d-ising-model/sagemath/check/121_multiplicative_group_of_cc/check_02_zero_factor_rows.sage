# 対象ラベル: multiplicative_group_of_cc
# 証明の三つの鎖のうち、0 を因子にもつ積を real_times_zero_is_zero・real_zero_times_is_zero の参照へ替えた行を、
# QQ[a, b] の多項式として一行ずつ比べる（浮動小数点を使わない）。
#   積の単位元:          (a,b)·1_C = (a,b)(1,0) = (a·1 − b·0, a·0 + b·1) = (a − b·0, a·0 + b) = (a − 0, 0 + b) = (a, b)
#   a = b = 0 の平方和:  a² + b² = 0² + 0² = 0·0 + 0·0 = 0 + 0 = 0
#   1_C の平方和:        1² + 0² = 1·1 + 0·0 = 1 + 0·0 = 1 + 0 = 1
R.<a, b> = PolynomialRing(QQ)

def cmul(z, w):
    # definition_of_cc の積 (a,b)(c,d) = (ac − bd, ad + bc)
    return (z[0] * w[0] - z[1] * w[1], z[0] * w[1] + z[1] * w[0])

# 積の単位元の鎖
rows = [cmul((a, b), (R(1), R(0))),
        (a * 1 - b * 0, a * 0 + b * 1),
        (a - b * 0, a * 0 + b),        # 1 は積の単位元を 2 箇所へ
        (a - 0, 0 + b),                # real_times_zero_is_zero (x -> b, x -> a)
        (a, b)]                        # 0 は和の単位元を 2 箇所へ
assert all(x == y for x, y in zip(rows, rows[1:]))
assert b * 0 == 0 and a * 0 == 0       # real_times_zero_is_zero の二つの具体化

# a = b = 0 の平方和の鎖
h = {a: 0, b: 0}
rows = [(a^2 + b^2).subs(h), R(0)^2 + R(0)^2, R(0) * 0 + R(0) * 0, R(0) + 0, R(0)]
assert all(x == y for x, y in zip(rows, rows[1:]))
assert a^2 + b^2 != 0                  # 対照: 仮定なしでは 0 でない

# 1_C の平方和の鎖
rows = [R(1)^2 + R(0)^2, R(1) * 1 + R(0) * 0, R(1) + R(0) * 0, R(1) + 0, R(1)]
assert all(x == y for x, y in zip(rows, rows[1:]))
assert rows[-1] > 0

print("unit, zero-sum-of-squares and 1_C chains as identities in QQ[a, b]")
print("RESULT: PASS")
