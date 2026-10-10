# 対象ラベル: claim_quadratic_trichotomy_at_least_one
# 対象: main-text.ts の二次体の三分律（少なくとも一つ）、非正の場合の第一成分の背理仮定の代入
# 式ペア: -(-a)=-0
# 帰属: a, b は QQ。比較も QQ の順序を使い、浮動小数点を使わない。
# (a,b) != (0,0) と (-a,-b) == (0,0) を同時に満たす数値事例は存在しない。
# 非零条件を外した零の例や、空の標本の列挙を数値PASSとして数えない。
# Lean の hzero の成分を congrArg Neg.neg で代入する行が、この段を確認する。
print('RESULT: NOT_NUMERICAL (数値事例なし、Leanの仮定代入で確認。数値PASS件数は0)')
