# 対象ラベル: claim_rational_power_base_den_two_exponent_one_impossible
# 本文の法 4 と整除性の各段を有限な整数標本で検査する。
CASES = []
for M in [ZZ(2), ZZ(3), ZZ(4)]:
    edge_count = ZZ(3) * M**2 * (M - 1)
    for a in [ZZ(1), ZZ(3), ZZ(5)]:
        for b in [ZZ(2), ZZ(6), ZZ(10)]:
            coefficients = [ZZ(2)] + [ZZ((m + M) % 7) for m in range(1, edge_count - 1)] + [ZZ(0), ZZ(2)]
            P = sum(coefficients[m] * a**m * b**(edge_count - m) for m in range(edge_count + 1))
            CASES.append((M, edge_count, a, b, coefficients, P))
