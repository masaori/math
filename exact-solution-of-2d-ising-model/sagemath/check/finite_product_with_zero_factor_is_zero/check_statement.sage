# 対象ラベル: finite_product_with_zero_factor_is_zero
# 主張そのもの: z_n = 0 なら ∏_{j=1}^{m} z_j = 0。
# 一般の場合は check_induction_lines.sage（不定元）で確かめた。ここでは具体の複素数として
# ガウス整数・ガウス有理数（QQ(i)）の無作為でない列（固定の式で作る）を取り、z_n を 0 にして確かめる。帰属: QQ(i)。
K.<I> = QuadraticField(-1)
count = 0
for m in range(1, 9):
    base = [K(j + 1) + K(2 * j - 3) / 5 * I for j in range(m)]
    assert all(b != 0 for b in base)
    for n in range(1, m + 1):
        zs = [K(0) if j == n else base[j - 1] for j in range(1, m + 1)]
        assert prod(zs) == 0
        count += 1
    assert prod(base) != 0
print(f"checked {count} (m, n) cases")
print("RESULT: PASS")
