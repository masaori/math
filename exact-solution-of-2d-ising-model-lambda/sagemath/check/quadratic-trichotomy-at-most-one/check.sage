# 対象ラベル: claim_quadratic_trichotomy_at_most_one
# 帰属: QQ / QQbar の厳密計算。浮動小数点を使わない。
#
# 主張: s·s=2 を満たす s ∈ QQbar と任意の ξ ∈ Q_s について、
#   (i) ξ ∈ P_s、(ii) ξ = 0、(iii) -ξ ∈ P_s のうち同時に成り立つものは高々一つ。
# 検査すること:
#   main:  全標本 (a,b) と両方の根 s で、(i)(ii)(iii) のうち成り立つものが 1 個以下。
#          正錐の判定は表示 (a,b) だけに依存する（rep_s の一意性）ので、
#          (i) は三条件を (a,b) に、(iii) は (-a,-b) に当てて判定する。
#          (ii) は QQbar の厳密等号 a+b·s == 0 で判定する。
#   zero:  組 (0,0) は正錐の三条件のどれも満たさない（証明の準備の裏取り）。
#   trans: 証明の「(-a,-b) の三条件の (a,b) の言葉への書き直し」が全標本で同値
#          （第一 ⟺ a≤0 ∧ b≤0 ∧ (a,b)≠(0,0)、第二 ⟺ a<0 ∧ 0<b ∧ 2·(b·b)<a·a、
#           第三 ⟺ 0<a ∧ b<0 ∧ a·a<2·(b·b)）。
#   pairs: 証明の九つの組み合わせ（(a,b) の条件 i と (-a,-b) の条件 j）のどれも、
#          同時に満たす標本が存在しない。

def cond1(a, b):
    """def_quadratic_positive_cone の第一条件。"""
    return (0 <= a) and (0 <= b) and not (a == 0 and b == 0)


def cond2(a, b):
    """def_quadratic_positive_cone の第二条件。"""
    return (0 < a) and (b < 0) and (2 * b * b < a * a)


def cond3(a, b):
    """def_quadratic_positive_cone の第三条件。"""
    return (a < 0) and (0 < b) and (a * a < 2 * b * b)


def cone(a, b):
    """三条件の少なくとも一つ（正錐への所属の判定）。"""
    assert a in QQ and b in QQ
    return cond1(a, b) or cond2(a, b) or cond3(a, b)


# zero: 組 (0,0) は三条件のどれも満たさない。
assert not cond1(QQ(0), QQ(0)), "第一条件が (0,0) で成り立ってしまう"
assert not cond2(QQ(0), QQ(0)), "第二条件が (0,0) で成り立ってしまう"
assert not cond3(QQ(0), QQ(0)), "第三条件が (0,0) で成り立ってしまう"
checked_zero = 3

# s·s = 2 を満たす QQbar の元をすべて列挙する（t^2 - 2 の根。ちょうど 2 個）。
R.<t> = PolynomialRing(QQ)
roots = (t ** 2 - 2).roots(QQbar, multiplicities=False)
assert len(roots) == 2, "t^2 - 2 の QQbar の根がちょうど 2 個でない"

BOUND = 6
DEN = 3
samples = sorted(set(QQ(p) / QQ(q) for p in range(-BOUND, BOUND + 1)
                     for q in range(1, DEN + 1)))

checked_trans = 0
checked_pairs = 0

for a in samples:
    for b in samples:
        # trans: (-a,-b) の三条件の書き直しが同値である。
        assert cond1(-a, -b) == ((a <= 0) and (b <= 0)
                                 and not (a == 0 and b == 0)), \
            f"第一条件の書き直しが同値でない: a={a}, b={b}"
        assert cond2(-a, -b) == ((a < 0) and (0 < b)
                                 and (2 * (b * b) < a * a)), \
            f"第二条件の書き直しが同値でない: a={a}, b={b}"
        assert cond3(-a, -b) == ((0 < a) and (b < 0)
                                 and (a * a < 2 * (b * b))), \
            f"第三条件の書き直しが同値でない: a={a}, b={b}"
        checked_trans += 1

        # pairs: 九つの組み合わせのどれも同時には成り立たない。
        conds_ab = (cond1(a, b), cond2(a, b), cond3(a, b))
        conds_neg = (cond1(-a, -b), cond2(-a, -b), cond3(-a, -b))
        for i in range(3):
            for j in range(3):
                assert not (conds_ab[i] and conds_neg[j]), \
                    f"組み合わせ ({i + 1},{j + 1}) が両立してしまう: a={a}, b={b}"
        checked_pairs += 9

checked_main = 0
for s in roots:
    assert s * s == 2, "s·s = 2 が壊れている"
    for a in samples:
        for b in samples:
            xi = QQbar(a) + QQbar(b) * s
            is_pos = cone(a, b)
            is_zero = (xi == 0)
            neg_pos = cone(-a, -b)
            count = sum(1 for flag in (is_pos, is_zero, neg_pos) if flag)
            assert count <= 1, \
                f"三分律（高々一つ）が壊れている: a={a}, b={b}, s={s}, count={count}"
            checked_main += 1

print(f"OK: main={checked_main}, zero={checked_zero}, "
      f"trans={checked_trans}, pairs={checked_pairs}")
