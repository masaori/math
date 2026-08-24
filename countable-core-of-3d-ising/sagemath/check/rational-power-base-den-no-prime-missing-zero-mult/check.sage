# 対象ラベル: claim_rational_power_base_den_no_prime_missing_zero_mult
# 本文の背理法を、ZZ の整除性と有限個の素因子指数だけで一行ずつ確認する。

print("== 段 1: 底の分母の素因子に対する非整除条件 ==")
checked_prime_data = 0
for p in prime_range(2, 20):
    for a in range(1, 20):
        for b in range(1, 20):
            if gcd(ZZ(a), ZZ(b)) != 1 or ZZ(b) % p != 0:
                continue
            for u in range(1, 20):
                for v in range(1, 20):
                    if gcd(ZZ(u), ZZ(v)) != 1 or ZZ(v) % p != 0:
                        continue
                    assert ZZ(a) % p != 0
                    assert ZZ(u) % p != 0
                    checked_prime_data += 1
assert checked_prime_data > 0
print("  PASS（既約な分子・分母の標本", checked_prime_data, "件）")

print("== 段 2: 法 b の合同式から p が P_M を割らないこと ==")
checked_congruences = 0
for p in prime_range(2, 20):
    for b in range(1, 20):
        if ZZ(b) % p != 0:
            continue
        for a in range(1, 20):
            if gcd(ZZ(a), ZZ(b)) != 1:
                continue
            for omega_zero in range(1, 10):
                if ZZ(omega_zero) % p == 0:
                    continue
                for edge_count in range(1, 30):
                    residue = ZZ(omega_zero) * ZZ(a) ** edge_count
                    for multiple in range(0, 4):
                        P = residue + multiple * ZZ(b)
                        assert (P - residue) % b == 0
                        assert P % p != 0
                        checked_congruences += 1
assert checked_congruences > 0
print("  PASS（合同式の標本", checked_congruences, "件）")

print("== 段 3: 整数等式の両辺で p の指数を取ること ==")
checked_valuations = 0
for p in prime_range(2, 12):
    for point_count in range(1, 20):
        for edge_count in range(1, 30):
            for e_v in range(1, 5):
                for e_b in range(1, 5):
                    u = ZZ(1)
                    P = ZZ(1)
                    v = ZZ(p) ** e_v
                    b = ZZ(p) ** e_b
                    left = P * v ** point_count
                    right = u ** point_count * b ** edge_count
                    if left != right:
                        continue
                    assert left.valuation(p) == point_count * e_v
                    assert right.valuation(p) == edge_count * e_b
                    assert point_count * e_v == edge_count * e_b
                    checked_valuations += 1
assert checked_valuations > 0
print("  PASS（整数等式を満たす標本", checked_valuations, "件）")

print("== 段 4: 隣接する二箱の指数等式は正の指数と両立しない ==")
checked_adjacent_boxes = 0
for L in range(2, 20):
    for e_v in range(1, 20):
        for e_b in range(1, 20):
            first = L * e_v == 3 * (L - 1) * e_b
            second = (L + 1) * e_v == 3 * L * e_b
            assert not (first and second)
            if first or second:
                checked_adjacent_boxes += 1
assert checked_adjacent_boxes > 0
print("  PASS（片方の指数等式を満たす標本", checked_adjacent_boxes, "件）")
print("ALL PASS")
