# 式ペア: Z_L(2) = 2 + Σ_{m>=2} Omega_L(m) 2^m ≡ 2 (mod 4)。
# 帰属: ZZ。有限和と法 4 の整数計算だけを使う。
load("_prelude.sage")
for L, Z, coefficients in COEFFICIENT_CASES:
    value = ZZ(Z(2))
    tail = sum(coefficients[m] * ZZ(2)**m for m in range(2, len(coefficients)))
    assert value == ZZ(2) + tail
    assert tail % 4 == 0
    assert value % 4 == 2

for L, value in VALUE_CASES:
    assert value % 4 == 2

# 係数を実データに縛らない一般の標本でも同じ簡約が成り立つことを確かめる。
for edge_count in [ZZ(4), ZZ(7), ZZ(12)]:
    for seed in [ZZ(1), ZZ(3), ZZ(5)]:
        coefficients = [ZZ(2), ZZ(0)] + [ZZ((m * seed + edge_count) % 11) for m in range(2, edge_count + 1)]
        value = sum(coefficients[m] * ZZ(2)**m for m in range(edge_count + 1))
        assert value % 4 == 2
print("RESULT: PASS")
