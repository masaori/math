# 式ペア: m <= #E_M-2 の各項は b^2 で割れ、4 で割れる。
# 帰属: ZZ。有限和と整除性だけを使う。
load("_prelude.sage")
for M, edge_count, a, b, coefficients, P in CASES:
    assert b.valuation(2) == 1
    assert b**2 % 4 == 0
    for m in range(edge_count - 1):
        term = coefficients[m] * a**m * b**(edge_count - m)
        assert term % b**2 == 0
        assert term % 4 == 0
print("RESULT: PASS")
