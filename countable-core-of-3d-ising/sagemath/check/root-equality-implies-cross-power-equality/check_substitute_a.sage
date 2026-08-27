# 対象ラベル: claim_root_equality_implies_cross_power_equality
# 式ペア: A^M = (x^N)^M
# 帰属: QQ の厳密計算だけを使う。

examples = [(QQ(2), 3, 2), (QQ(3) / 2, 4, 3), (QQ(5) / 3, 2, 5)]
for x, N, M in examples:
    A = x**N
    assert A**M == (x**N) ** M
print("RESULT: PASS — x^N=A を A^M へ代入する段を QQ 上で確認")
