# 対象ラベル: claim_self_dual_quadratic_roots_distinct
# 帰属: QQbar（代数的数）の厳密計算。浮動小数点を使わない。

# 主張（claim_self_dual_quadratic_roots_distinct）:
#   s ∈ QQbar が s*s = 2 を満たすとき、-1 + s ≠ -1 - s。
# 証明（背理法）の組み立てを一行ずつ突き合わせる:
#   prep:  2 ≠ 0（QQ ⊂ QQbar）
#   chain: 等しいと仮定すると s = -s、2*s = (1+1)*s = 1*s + 1*s = s + s = (-s) + s = 0、
#          零因子の不在から s = 0、すると 2 = s*s = 0*0 = 0 で矛盾。
# 実際には各 s で -1+s ≠ -1-s が成り立つので、背理法の仮定側は
# 「s ≠ 0 なら 2*s ≠ 0」という対偶の形で検査する。

two = QQbar(1) + QQbar(1)
assert two != QQbar(0), "2 ≠ 0（準備）が壊れている"

R = PolynomialRing(QQbar, "t")
t = R.gen()
s_candidates = (t**2 - R(two)).roots(multiplicities=False)
assert len(s_candidates) == 2, f"s*s = 2 の解の個数が 2 でない: {len(s_candidates)}"

checked = 0
for s in s_candidates:
    assert s * s == two, f"s*s = 2 が壊れている: s = {s}"

    # 主張: -1 + s ≠ -1 - s
    root_plus = -QQbar(1) + s
    root_minus = -QQbar(1) - s
    assert root_plus != root_minus, f"二根が相異なることが壊れている: s = {s}"

    # 鎖の各段（対偶側）: s ≠ 0 であること、2*s = s + s であること、2*s ≠ 0 であること。
    assert s != QQbar(0), f"s ≠ 0 が壊れている: s = {s}"
    assert two * s == (QQbar(1) + QQbar(1)) * s, "2 の定義の段が壊れている"
    assert (QQbar(1) + QQbar(1)) * s == QQbar(1) * s + QQbar(1) * s, "分配則の段が壊れている"
    assert QQbar(1) * s + QQbar(1) * s == s + s, "単位元との積の段が壊れている"
    assert two * s != QQbar(0), f"2*s ≠ 0（背理法の帰結の否定）が壊れている: s = {s}"

    # 背理法の最終段: s = 0 だったならば s*s = 0 となり 2 と矛盾するはずである。
    assert QQbar(0) * QQbar(0) == QQbar(0), "零元との積の段が壊れている"
    assert two != QQbar(0) * QQbar(0), "矛盾の段（2 ≠ 0*0）が壊れている"

    checked += 1

print(
    f"self-dual-quadratic-roots-distinct: s の {checked} 通りすべてで"
    f"二根の相異と鎖の各段を厳密検査して通過（QQbar の厳密計算）"
)
