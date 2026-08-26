# 式ペア: q = 1 では c = 2 として Z_L(1) = 2^{#V_L} がすべての箱で成り立つ（逆向き）。
# 帰属: ZZ。有限箱の値の等式だけを使う。
load("_prelude.sage")
for L, value_at_one in VALUE_AT_ONE_CASES:
    vertex_count = L ** 3
    assert value_at_one == ZZ(2) ** vertex_count
    # 底は 2 に限られる（非零自然数乗の単射性の有限標本での確認）。
    for c in BASE_SAMPLES:
        if c != ZZ(2):
            assert QQ(c) ** vertex_count != QQ(value_at_one)
print("RESULT: PASS")
