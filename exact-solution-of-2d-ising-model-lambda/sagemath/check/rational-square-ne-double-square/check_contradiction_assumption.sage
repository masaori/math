# 対象ラベル: claim_rational_square_ne_double_square
# 対象: main-text.ts の有理数の平方と二倍の平方、背理法の仮定の代入
# 式ペア: (a * a) * (binv * binv) = (QQ(2) * (b * b)) * (binv * binv)
# 帰属: a, b, binv, r は QQ、b != 0、binv = b^(-1)、r = a*binv。
# a*a = 2*(b*b) と b != 0 を満たす有理数の数値事例は存在しない。
# 既存回帰検算の偽同士の同値も、この行の代入の検証には数えない。
# Lean の hSquare を congrArg で代入する一行が、この段の確認を担う。
print('RESULT: NOT_NUMERICAL (数値事例なし、Leanの仮定代入で確認。数値PASS件数は0)')
