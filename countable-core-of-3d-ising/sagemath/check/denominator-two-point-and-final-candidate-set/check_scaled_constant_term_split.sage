# 対象ラベル: claim_denominator_two_point_and_final_candidate_set
# 分配多項式へ a/2 を代入して 2^E を掛けた有限和が、定数項と a の倍数へ分かれることを確認する。

E = 12
R = PolynomialRing(QQ, names=("a",) + tuple("omega%s" % m for m in range(E + 1)))
a = R.gen(0)
omega = R.gens()[1:]

half_value = sum(omega[m] * (a / 2) ** m for m in range(E + 1))
scaled_value = sum(omega[m] * a ** m * 2 ** (E - m) for m in range(E + 1))
tail_quotient = sum(omega[m] * a ** (m - 1) * 2 ** (E - m) for m in range(1, E + 1))

assert 2 ** E * half_value == scaled_value
assert scaled_value == 2 ** E * omega[0] + sum(omega[m] * a ** m * 2 ** (E - m) for m in range(1, E + 1))
assert sum(omega[m] * a ** m * 2 ** (E - m) for m in range(1, E + 1)) == a * tail_quotient
assert 2 ** E * half_value == 2 ** E * omega[0] + a * tail_quotient

# くくり出した有限和は整数係数である（各項の 2 の冪指数 E-m は 1<=m<=E で非負）。
for m in range(1, E + 1):
    assert E - m >= 0

print("RESULT: PASS")
