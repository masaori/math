# SageMath: 2 が 2^{#V_L} の正の #V_L 乗根であること
# 対象ラベル: claim_limit_quantity_at_one_equals_two
# 式ペア: (2^{#V_L})^{1/#V_L} = 2
# 帰属: QQbar。代数的数の厳密等号だけを使い、浮動小数点は使わない。

for box_side in [1, 2, 3, 4]:
    site_count = ZZ(box_side) ** 3
    candidate = QQbar(2)
    radicand = QQbar(2) ** site_count
    assert candidate > 0
    assert candidate ** site_count == radicand
    print("PASS: L=%d で正の候補 2 の #V_L 乗が 2^{#V_L}" % box_side)

print("RESULT: PASS")
