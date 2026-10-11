# 対象ラベル: claim_rational_square_lt_implies_lt
# 帰属: QQ の厳密計算。浮動小数点を使わない。
# 本文の行: p*p < p*p（第二の鎖の推移律、本文末尾）。
# p*p < q*q と q*q <= p*p の同時成立例は存在しない。
# 仮定の一部を外した標本や空の列挙を、この行の数値PASSに数えない。
# Lean 具体版・必要十分版の対応: hSelf。
print("RESULT: NOT_NUMERICAL (自己への狭義不等式: 数値事例なし、Leanで確認。数値PASS件数は0)")
