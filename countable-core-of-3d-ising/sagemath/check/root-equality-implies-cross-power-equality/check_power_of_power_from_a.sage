# 対象ラベル: claim_root_equality_implies_cross_power_equality
# 式ペア: (x^N)^M = x^(N M)
# 帰属: QQ と ZZ の厳密計算だけを使う。

examples = [(QQ(2), 3, 2), (QQ(3) / 2, 4, 3), (QQ(5) / 3, 2, 5)]
assert all((x**N) ** M == x ** (N * M) for x, N, M in examples)
print("RESULT: PASS — 自然数べきの積の法則を QQ 上で確認")
