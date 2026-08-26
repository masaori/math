# 式ペア: 候補のうち q = 1/2 と q = 2 では点数乗表示が末尾でも成り立たない。
# 帰属: ZZ と QQ。法 4 の整数計算と、底の有限標本での不一致だけを使う。
load("_prelude.sage")
for L, value_at_two in VALUE_AT_TWO_CASES:
    # 点数乗表示 Z_L(2) = c^{#V_L} を仮定すると 4 | Z_L(2) だが、法 4 で 2 になる。
    assert value_at_two % 4 == 2
    assert value_at_two % 4 != 0

for L, edge_count, Z in COEFFICIENT_CASES:
    value_at_one_half = QQ(Z(QQ(1) / QQ(2)))
    value_at_two = ZZ(Z(ZZ(2)))
    # 回文性による有限箱の等式。
    assert ZZ(2) ** edge_count * value_at_one_half == value_at_two
    for c in BASE_SAMPLES:
        assert value_at_one_half != QQ(c) ** (L ** 3)
        assert value_at_two != QQ(c) ** (L ** 3)
print("RESULT: PASS")
