# 対象ラベル: claim_finitely_many_values_gives_eventually_constant
# 帰属: 値は QQ、例外添字と閾値は NN。
# 有限個の有限例外集合の合併より大きい閾値を取れば、以後に例外が無いことを検査する。

examples = [
    {},
    {QQ(2): {ZZ(1), ZZ(4)}},
    {QQ(2): {ZZ(2), ZZ(7)}, QQ(3): {ZZ(1), ZZ(5), ZZ(9)}},
]

for exceptional_indices_by_value in examples:
    exceptional_union = set().union(*exceptional_indices_by_value.values()) if exceptional_indices_by_value else set()
    threshold = ZZ(1) if not exceptional_union else max(exceptional_union) + ZZ(1)
    assert threshold >= 1
    assert all(index < threshold for index in exceptional_union)
    assert all(index not in exceptional_union for index in range(threshold, threshold + 20))

print("RESULT: PASS")
