# 対象ラベル: claim_integer_point_numerator_divides_twice_zero_multiplicity_minus_one
# 分配多項式を定数項と a の倍数へ分ける二段を ZZ 上の多項式恒等式として確認する。

R = PolynomialRing(ZZ, names=("a",) + tuple("omega%s" % m for m in range(13)))
a = R.gen(0)
omega = R.gens()[1:]

partition_value = sum(omega[m] * a ** m for m in range(13))
tail_quotient = sum(omega[m] * a ** (m - 1) for m in range(1, 13))

assert partition_value == omega[0] * a ** 0 + sum(omega[m] * a ** m for m in range(1, 13))
assert sum(omega[m] * a ** m for m in range(1, 13)) == a * tail_quotient
assert partition_value == omega[0] + a * tail_quotient

print("RESULT: PASS")
