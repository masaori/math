# 対象ラベル: claim_root_equality_implies_cross_power_equality
# 式ペア: (x^M)^N = B^N
# 帰属: QQ の厳密計算だけを使う。

examples = [(QQ(2), 3, 2), (QQ(3) / 2, 4, 3), (QQ(5) / 3, 2, 5)]
for x, N, M in examples:
    B = x**M
    assert (x**M) ** N == B**N
print("RESULT: PASS — x^M=B を B^N へ代入する段を QQ 上で確認")
