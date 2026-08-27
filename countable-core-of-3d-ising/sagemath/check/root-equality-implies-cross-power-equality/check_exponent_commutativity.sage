# 対象ラベル: claim_root_equality_implies_cross_power_equality
# 式ペア: x^(N M) = x^(M N)
# 帰属: QQ と ZZ の厳密計算だけを使う。

examples = [(QQ(2), 3, 2), (QQ(3) / 2, 4, 3), (QQ(5) / 3, 2, 5)]
assert all(N * M == M * N and x ** (N * M) == x ** (M * N) for x, N, M in examples)
print("RESULT: PASS — 自然数の乗法の可換性を指数へ適用する段を確認")
