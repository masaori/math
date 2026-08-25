# 対象ラベル: claim_numerator_divides_twice_base_minus_one
# 二つの整除を最大公約数でまとめて a | 2(c-1) を得る段を ZZ 上で確認する。

for L in range(2, 65):
    L = ZZ(L)
    gap = 3 * L ** 2 + 3 * L + 1
    next_gap = 3 * (L + 1) ** 2 + 3 * (L + 1) + 1
    for c in range(1, 17):
        c = ZZ(c)
        first = 2 * (c ** gap - 1)
        second = 2 * (c ** next_gap - 1)
        common_gcd = gcd(first, second)
        assert common_gcd == 2 * (c - 1)
        candidate_divisors = range(1, 129) if common_gcd == 0 else divisors(common_gcd)
        for a in candidate_divisors:
            a = ZZ(a)
            assert a.divides(first)
            assert a.divides(second)
            assert a.divides(2 * (c - 1))

print("RESULT: PASS")
