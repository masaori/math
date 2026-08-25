# 対象ラベル: claim_numerator_divides_twice_base_minus_one
# 隣接指数の互いに素性から箱に依存しない最大公約数へ至る三段を ZZ 上で確認する。

for L in range(2, 129):
    L = ZZ(L)
    gap = 3 * L ** 2 + 3 * L + 1
    next_gap = 3 * (L + 1) ** 2 + 3 * (L + 1) + 1
    assert gcd(gap, next_gap) == 1
    for c in range(1, 33):
        c = ZZ(c)
        scaled_gcd = gcd(2 * (c ** gap - 1), 2 * (c ** next_gap - 1))
        twice_power_gcd = 2 * (c ** gcd(gap, next_gap) - 1)
        final_value = 2 * (c - 1)
        assert scaled_gcd == twice_power_gcd
        assert twice_power_gcd == final_value

print("RESULT: PASS")
