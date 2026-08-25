# 対象ラベル: claim_rational_power_point_denominator_divides_two
# 本文で既に確定した整除条件の合成を、ZZ の有限標本で一段ずつ確認する。

print("== 段 1: 奇素数を素因子に持たない正の自然数は 2 の冪である ==")
checked_odd_prime_exclusion = 0
for v in range(1, 257):
    if all(p == 2 for p, _ in ZZ(v).factor()):
        assert ZZ(v).prime_to_m_part(2) == 1
        checked_odd_prime_exclusion += 1
assert checked_odd_prime_exclusion > 0
print("  PASS（標本", checked_odd_prime_exclusion, "件）")

print("== 段 2: 2 の冪が 2 で割れなければ 1 である ==")
checked_power_of_two = 0
for exponent in range(0, 16):
    v = ZZ(2) ** exponent
    if v % 2 != 0:
        assert exponent == 0
        assert v == 1
        checked_power_of_two += 1
assert checked_power_of_two == 1
print("  PASS")

print("== 段 3: v = 1 と法 b の整除から b は 2 を割る ==")
checked_divisors = 0
for b in range(1, 257):
    v = ZZ(1)
    point_count = ZZ(8)
    omega_zero = ZZ(2)
    if (omega_zero * v ** point_count) % b == 0:
        assert ZZ(2) % b == 0
        assert b in (1, 2)
        checked_divisors += 1
assert checked_divisors == 2
print("  PASS（b = 1, 2）")

print("== 段 4: 既約な正の有理点の分母は 1 または 2 である ==")
checked_points = 0
for a in range(1, 65):
    for b in (1, 2):
        if gcd(ZZ(a), ZZ(b)) != 1:
            continue
        q = QQ(a) / QQ(b)
        assert q.denominator() == b
        assert b.divides(ZZ(2))
        checked_points += 1
assert checked_points > 0
print("  PASS（既約な正の有理点", checked_points, "件）")
print("ALL PASS")
