# 対象ラベル: claim_rational_square_lt_implies_lt
# 帰属: QQ の厳密計算。浮動小数点を使わない。

# 主張（claim_rational_square_lt_implies_lt）:
#   任意の p, q ∈ QQ について、0 ≤ p かつ 0 ≤ q かつ p*p < q*q ならば p < q。
# 証明の組み立てを一行ずつ突き合わせる:
#   背理法の仮定: q ≤ p（主張の仮定と両立する標本では成り立たないので、
#                 代わりに q ≤ p を満たす標本で鎖の各段を検査する）。
#   chain: q*q ≤ p*q（q ≤ p の両辺へ 0 ≤ q の q を右から掛ける）
#          p*q ≤ p*p（q ≤ p の両辺へ 0 ≤ p の p を左から掛ける）
#   推移律: q*q ≤ p*p。
#   矛盾:   p*p < q*q と q*q ≤ p*p から p*p < p*p（非反射性に矛盾）。
#   全順序: ¬(q ≤ p) と p < q の同値。

# 有理数の網羅的な標本（分子・分母 1..15 と 0。主張の仮定は 0 ≤ p, 0 ≤ q なので非負のみ）。
BOUND = 15

samples = [QQ(0)]
for num in range(1, BOUND + 1):
    for den in range(1, BOUND + 1):
        samples.append(QQ(num) / QQ(den))
samples = sorted(set(samples))

checked_claim = 0
checked_chain = 0
checked_total_order = 0
for p in samples:
    for q in samples:
        assert p >= 0 and q >= 0

        # 主張そのもの: p*p < q*q ならば p < q（QQ の順序判定は厳密）。
        if p * p < q * q:
            assert p < q, f"反例が出た: p = {p}, q = {q}"
            checked_claim += 1

        # 背理法の鎖の各段: q ≤ p を満たす標本の全点で検査する。
        if q <= p:
            assert q * q <= p * q, "右から q を掛ける段が壊れている"
            assert p * q <= p * p, "左から p を掛ける段が壊れている"
            assert q * q <= p * p, "推移律の段が壊れている"
            # 矛盾の段: このとき p*p < q*q は成り立たない
            # （成り立てば p*p < p*p となり非反射性に反する）。
            assert not (p * p < q * q), "矛盾の段が壊れている"
            checked_chain += 1

        # 全順序の段: ¬(q ≤ p) と p < q は同値。
        assert (not (q <= p)) == (p < q), "全順序の段が壊れている"
        checked_total_order += 1

print(
    f"OK: 主張を {checked_claim} 組、背理法の鎖を {checked_chain} 組、"
    f"全順序の同値を {checked_total_order} 組で厳密検査した"
)
