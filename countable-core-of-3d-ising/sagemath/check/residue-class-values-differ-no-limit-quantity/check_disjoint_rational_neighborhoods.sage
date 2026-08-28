# 対象ラベル: claim_residue_class_values_differ_no_limit_quantity
# 帰属: c_r, c_s, epsilon は QQ。浮動小数点を使わない。
# 相異なる二定数が同じ極限を持てない有限算術の核を検査する。

examples = [
    (QQ(1) / QQ(3), QQ(2) / QQ(3)),
    (QQ(7) / QQ(5), QQ(11) / QQ(5)),
    (QQ(3), QQ(19) / QQ(4)),
]

for c_r, c_s in examples:
    distance = abs(c_r - c_s)
    epsilon = distance / QQ(3)
    assert distance > 0
    assert epsilon > 0
    assert 2 * epsilon < distance
    # 一つの値 alpha が両方の epsilon 近傍へ入れば三角不等式に反する。
    midpoint = (c_r + c_s) / QQ(2)
    assert not (abs(c_r - midpoint) < epsilon and abs(c_s - midpoint) < epsilon)

print("RESULT: PASS")
