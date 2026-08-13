# 対象ラベル: claim_quadratic_addition_mem, claim_quadratic_addition_representation
# 帰属: QQ / QQbar の厳密計算。浮動小数点を使わない。

# claim_quadratic_addition_mem: s·s=2 を満たす s ∈ QQbar、ξ,η ∈ Q_s、
#   (a,b) := rep_s(ξ)、(a',b') := rep_s(η) について、ξ+η ∈ Q_s（証人 (a+a', b+b')）。
# claim_quadratic_addition_representation: rep_s(ξ+η) = (a+a', b+b')。
# 検査すること:
#   add-compat: QQ の和と QQbar の和の一致（準備の段の裏取り）。
#   add-chain:  標本の全 ((a,b),(a',b')) で本文の鎖
#               (a+b·s)+(a'+b'·s)
#               = a+(b·s+(a'+b'·s)) = a+((b·s+a')+b'·s) = a+((a'+b·s)+b'·s)
#               = a+(a'+(b·s+b'·s)) = (a+a')+(b·s+b'·s) = (a+a')+(b+b')·s
#               を一段ずつ QQbar の厳密等号で確かめる。
#   add-rep:    (a+a', b+b') が ξ+η の表示であること（表示の一意性
#               claim_quadratic_representation_unique。別の検証で裏取り済み。のもとで、
#               鎖の終点がそのまま rep_s(ξ+η) = (a+a', b+b') を与える）。

# s·s = 2 を満たす QQbar の元をすべて列挙する（t^2 - 2 の根。ちょうど 2 個）。
R.<t> = PolynomialRing(QQ)
roots = (t ** 2 - 2).roots(QQbar, multiplicities=False)
assert len(roots) == 2, "t^2 - 2 の QQbar の根がちょうど 2 個でない"

# 四つ組を走らせるので標本は小さく取る（分子 -2..2、分母 1..2 の 7 値）。
BOUND = 2
DEN = 2
samples = sorted(set(QQ(p) / QQ(q) for p in range(-BOUND, BOUND + 1)
                     for q in range(1, DEN + 1)))
assert len(samples) == 7, f"標本数が想定と違う: {len(samples)}"

checked_add_compat = 0
checked_add_chain = 0

# add-compat: QQ の和と QQbar の和は同じ元。
for a in samples:
    for ap in samples:
        assert QQbar(a + ap) == QQbar(a) + QQbar(ap), \
            f"和の両立が壊れている: a={a}, a'={ap}"
        checked_add_compat += 1

for s in roots:
    assert s * s == 2, "s·s = 2 が壊れている"

    for a in samples:
        for b in samples:
            xi = QQbar(a) + QQbar(b) * s
            for ap in samples:
                for bp in samples:
                    eta = QQbar(ap) + QQbar(bp) * s

                    # add-chain: 本文の鎖を一段ずつ。
                    e0 = xi + eta
                    e1 = (QQbar(a) + QQbar(b) * s) + (QQbar(ap) + QQbar(bp) * s)
                    e2 = QQbar(a) + (QQbar(b) * s + (QQbar(ap) + QQbar(bp) * s))
                    e3 = QQbar(a) + ((QQbar(b) * s + QQbar(ap)) + QQbar(bp) * s)
                    e4 = QQbar(a) + ((QQbar(ap) + QQbar(b) * s) + QQbar(bp) * s)
                    e5 = QQbar(a) + (QQbar(ap) + (QQbar(b) * s + QQbar(bp) * s))
                    e6 = (QQbar(a) + QQbar(ap)) + (QQbar(b) * s + QQbar(bp) * s)
                    e7 = (QQbar(a) + QQbar(ap)) + (QQbar(b) + QQbar(bp)) * s
                    assert e0 == e1, f"表示の代入が壊れている: {(a, b, ap, bp)}"
                    assert e1 == e2, f"結合則の段 1 が壊れている: {(a, b, ap, bp)}"
                    assert e2 == e3, f"結合則の段 2 が壊れている: {(a, b, ap, bp)}"
                    assert e3 == e4, f"可換則の段が壊れている: {(a, b, ap, bp)}"
                    assert e4 == e5, f"結合則の段 3 が壊れている: {(a, b, ap, bp)}"
                    assert e5 == e6, f"結合則の段 4 が壊れている: {(a, b, ap, bp)}"
                    assert e6 == e7, f"分配則の段が壊れている: {(a, b, ap, bp)}"

                    # add-rep: 終点の表示が (a+a', b+b') であること。
                    assert e0 == QQbar(a + ap) + QQbar(b + bp) * s, \
                        f"和の表示が壊れている: {(a, b, ap, bp)}"

                    checked_add_chain += 1

print(f"add-compat: {checked_add_compat} 組を検査した")
print(f"add-chain / add-rep: {checked_add_chain} 組を検査した")
print("すべて通過した")
