# 式ペア: Z_L(2) ≡ 2 (mod 4) と 4 | Z_L(2) は両立しない。
# 帰属: ZZ。破れ数零・一の多重度と法 4 の整数計算だけを使う。
load("_prelude.sage")
for L, edge_count, Z, coefficients in COEFFICIENT_CASES:
    assert coefficients[0] == 2
    assert coefficients[1] == 0
    assert ZZ(Z(2)) % 4 == 2

for L, edge_count, value_at_two in VALUE_AT_TWO_CASES:
    assert value_at_two % 4 == 2
    # 点数乗表示を仮定すると 4 | Z_L(2) となるので、法 4 で 2 であることと両立しない。
    assert not (value_at_two % 4 == 0)

for L, edge_count, value_at_one_half, value_at_two in ONE_HALF_CASES:
    for c in [ZZ(1), ZZ(2), ZZ(3), ZZ(5), ZZ(7), ZZ(12)]:
        assert value_at_one_half != c**(L**3)
print("RESULT: PASS")
