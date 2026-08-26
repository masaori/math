# 式ペア: 2^E Z_L(1/2) = Σ_m Ω_L(m) 2^{E-m} = Σ_k Ω_L(k) 2^k = Z_L(2)。
# 帰属: ZZ と QQ。有限和の添字変更と回文性だけを使う。
load("_prelude.sage")
for L, edge_count, Z, coefficients in COEFFICIENT_CASES:
    assert len(coefficients) == edge_count + 1
    # 回文性 Ω_L(m) = Ω_L(E-m)
    for m in range(edge_count + 1):
        assert coefficients[m] == coefficients[edge_count - m]
    left = ZZ(2)**edge_count * QQ(Z(QQ(1) / QQ(2)))
    reindexed = sum(coefficients[m] * ZZ(2)**(edge_count - m) for m in range(edge_count + 1))
    swapped = sum(coefficients[edge_count - m] * ZZ(2)**(edge_count - m) for m in range(edge_count + 1))
    right = sum(coefficients[k] * ZZ(2)**k for k in range(edge_count + 1))
    assert left == reindexed
    assert reindexed == swapped
    assert swapped == right
    assert right == ZZ(Z(2))

for L, edge_count, value_at_one_half, value_at_two in ONE_HALF_CASES:
    assert ZZ(2)**edge_count * value_at_one_half == value_at_two

# 係数を実データに縛らない一般の回文標本でも同じ添字変更が成り立つことを確かめる。
for edge_count in [ZZ(4), ZZ(7), ZZ(12)]:
    for seed in [ZZ(1), ZZ(3), ZZ(5)]:
        half = [ZZ((m * seed + edge_count) % 11) for m in range(edge_count // 2 + 1)]
        coefficients = [half[min(m, edge_count - m)] for m in range(edge_count + 1)]
        left = ZZ(2)**edge_count * sum(coefficients[m] * (QQ(1) / QQ(2))**m for m in range(edge_count + 1))
        right = sum(coefficients[k] * ZZ(2)**k for k in range(edge_count + 1))
        assert left == right
print("RESULT: PASS")
