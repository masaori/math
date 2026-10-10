# 対象ラベル: claim_rational_square_ne_double_square
# 帰属: QQ の厳密計算。浮動小数点を使わない。

# 主張（claim_rational_square_ne_double_square）:
#   任意の a, b ∈ QQ について、b ≠ 0 ならば a*a ≠ 2*(b*b)。
# 回帰検算として主張・恒等変形・両辺が偽の同値を調べる。行別対応は check_*.sage。
#   prep:  b ≠ 0 から乗法逆元 b^{-1}（b*b^{-1} = 1）を取り、r := a*b^{-1} と置く。
#   chain: r*r = (a*b^{-1})*(a*b^{-1}) = (a*a)*(b^{-1}*b^{-1})
#             = (2*(b*b))*(b^{-1}*b^{-1})   ← 背理法の仮定の段。標本では仮定が成り立たないので
#                                             「a*a=2*(b*b) と r*r=2 の同値」を別の回帰検算として調べる
#                                             （背理仮定の代入行の検証ではない）
#             = 2*((b*b^{-1})*(b*b^{-1})) = 2*(1*1) = 2
#   contra: r*r = 2 は claim_no_rational_square_two（検証 no-rational-square-two）と矛盾。

# 有理数の網羅的な標本（分子・分母 1..20、正負と 0）で検査する。
BOUND = 20

samples = [QQ(0)]
for num in range(1, BOUND + 1):
    for den in range(1, BOUND + 1):
        samples.append(QQ(num) / QQ(den))
        samples.append(QQ(-num) / QQ(den))

checked_ne = 0
checked_regression = 0
for a in samples:
    for b in samples:
        if b == 0:
            continue
        # 主張そのもの: a*a ≠ 2*(b*b)（QQ の等号判定は厳密）。
        assert a * a != 2 * (b * b), f"反例が出た: a = {a}, b = {b}"
        checked_ne += 1

        # 準備: 乗法逆元と r の定義。
        binv = b ** (-1)
        assert b * binv == 1, "b*b^{-1} = 1 が壊れている"
        r = a * binv
        assert r in QQ, "r = a*b^{-1} ∈ QQ が壊れている"

        # 鎖の恒等変形の段（仮定によらず成り立つ段）を検査する。
        assert r * r == (a * binv) * (a * binv), "r の定義の段が壊れている"
        assert (a * binv) * (a * binv) == (a * a) * (binv * binv), "可換則と結合則の段が壊れている"
        assert (b * b) * (binv * binv) == (b * binv) * (b * binv), "可換則と結合則の段が壊れている"
        assert (b * binv) * (b * binv) == 1 * 1, "乗法逆元の段が壊れている"
        assert QQ(2) * (QQ(1) * QQ(1)) == 2, "乗法単位元の段が壊れている"

        # 別の回帰検算: a*a = 2*(b*b) と r*r = 2 は同値（仮定代入行の検証ではない）
        # （鎖はこの同値の「⇒」の向きをつないでいる）。標本では両辺とも偽である。
        assert (a * a == 2 * (b * b)) == (r * r == 2), "回帰検算の同値が壊れている"
        checked_regression += 1

print(f"RESULT: PASS (既存回帰: 主張 {checked_ne} 組、恒等変形と偽同士の同値 {checked_regression} 組。仮定代入行の検証は含まない)")
