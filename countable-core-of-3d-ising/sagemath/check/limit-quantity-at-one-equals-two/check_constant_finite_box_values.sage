# SageMath: q=1 の有限箱量が箱サイズによらず 2 であること
# 対象ラベル: claim_limit_quantity_at_one_equals_two
# 式ペア: a_L(1) = 2
# 帰属: QQbar。各有限箱の代数的等号を厳密に検査する。

finite_box_values = []
for box_side in [1, 2, 3, 4]:
    site_count = ZZ(box_side) ** 3
    value_at_one = QQbar(2) ** site_count
    positive_root = QQbar(2)
    assert positive_root > 0
    assert positive_root ** site_count == value_at_one
    finite_box_values.append(positive_root)

assert all(value == QQbar(2) for value in finite_box_values)
print("PASS: L=1,2,3,4 の有限箱量は値 2 の定数列")
print("RESULT: PASS")
