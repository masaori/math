# 対象ラベル: claim_finitely_many_values_gives_eventually_constant
# 帰属: 部分列の値と極限候補は QQ、添字は NN。
# 相異なる有理数 v と alpha の定数部分列が同じ極限を持てない有限算術部分を検査する。

examples = [
    (QQ(1), QQ(2)),
    (QQ(3) / QQ(2), QQ(7) / QQ(3)),
    (QQ(-5), QQ(0)),
]

for value, limit_value in examples:
    assert value != limit_value
    radius = abs(value - limit_value) / QQ(3)
    assert radius > 0
    assert abs(value - value) < radius
    assert not abs(value - limit_value) < radius

print("RESULT: PASS")
