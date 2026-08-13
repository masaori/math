# 対象ラベル: claim_quadratic_trichotomy_at_least_one
# 帰属: QQ / QQbar の厳密計算。浮動小数点を使わない。
#
# 主張: s·s=2 を満たす s ∈ QQbar と任意の ξ ∈ Q_s について、
#   (i) ξ ∈ P_s、(ii) ξ = 0、(iii) -ξ ∈ P_s の少なくとも一つが成り立つ。
# 検査すること:
#   main:  全標本 (a,b) と両方の根 s で、(i)(ii)(iii) の少なくとも一つが成り立つ。
#          正錐の判定は表示 (a,b) だけに依存する（rep_s の一意性）ので、
#          (i) は cone(a,b)、(iii) は cone(-a,-b) で判定する。
#          (ii) は QQbar の厳密等号 a+b·s == 0 で判定する。
#   cover: 証明の四つの場合（0≤a∧0≤b、a≤0∧b≤0、0<a∧b<0、a<0∧0<b）が
#          すべての標本を覆う（証明の場合分けの網羅性の裏取り）。
#   neg:   -(a+b·s) == (-a)+(-b)·s（QQbar の厳密等号。
#          claim_quadratic_negation_representation の表示の裏取り）。
#   mixed: 符号が混合する標本（0<a∧b<0 または a<0∧0<b）では b≠0 であり、
#          a·a ≠ 2·(b·b)（claim_rational_square_ne_double_square の再確認）。
#          さらに証明の二本の鎖の各段:
#            (-a)·(-a) = a·a、2·(b·b) = 2·((-b)·(-b)) = 2·(-b)·(-b)
#          と、大小が小さい側の場合に対応する正錐の条件が成り立つこと。

def cone(a, b):
    """def_quadratic_positive_cone の三条件（QQ の順序だけを使う）。"""
    assert a in QQ and b in QQ
    c1 = (0 <= a) and (0 <= b) and not (a == 0 and b == 0)
    c2 = (0 < a) and (b < 0) and (2 * b * b < a * a)
    c3 = (a < 0) and (0 < b) and (a * a < 2 * b * b)
    return c1 or c2 or c3


# s·s = 2 を満たす QQbar の元をすべて列挙する（t^2 - 2 の根。ちょうど 2 個）。
R.<t> = PolynomialRing(QQ)
roots = (t ** 2 - 2).roots(QQbar, multiplicities=False)
assert len(roots) == 2, "t^2 - 2 の QQbar の根がちょうど 2 個でない"

BOUND = 6
DEN = 3
samples = sorted(set(QQ(p) / QQ(q) for p in range(-BOUND, BOUND + 1)
                     for q in range(1, DEN + 1)))

checked_main = 0
checked_cover = 0
checked_neg = 0
checked_mixed = 0

for a in samples:
    for b in samples:
        # cover: 証明の四つの場合がこの標本を覆う。
        case1 = (0 <= a) and (0 <= b)
        case2 = (a <= 0) and (b <= 0)
        case3 = (0 < a) and (b < 0)
        case4 = (a < 0) and (0 < b)
        assert case1 or case2 or case3 or case4, \
            f"四つの場合が覆わない標本がある: a={a}, b={b}"
        checked_cover += 1

        # mixed: 符号が混合する場合の鎖の各段と正錐の条件。
        if case3 or case4:
            assert b != 0
            assert a * a != 2 * (b * b), \
                f"混合符号の排除が壊れている: a={a}, b={b}"
            assert (-a) * (-a) == a * a, f"負号どうしの積: a={a}"
            assert 2 * (b * b) == 2 * ((-b) * (-b)) == 2 * (-b) * (-b), \
                f"負号どうしの積と結合則: b={b}"
            if case3:
                if 2 * (b * b) < a * a:
                    assert cone(a, b), f"第二条件のはず: a={a}, b={b}"
                else:
                    assert a * a < 2 * (b * b)
                    assert (-a) < 0 and 0 < (-b)
                    assert (-a) * (-a) < 2 * (-b) * (-b)
                    assert cone(-a, -b), f"第三条件のはず: -a={-a}, -b={-b}"
            if case4:
                if a * a < 2 * (b * b):
                    assert cone(a, b), f"第三条件のはず: a={a}, b={b}"
                else:
                    assert 2 * (b * b) < a * a
                    assert 0 < (-a) and (-b) < 0
                    assert 2 * (-b) * (-b) < (-a) * (-a)
                    assert cone(-a, -b), f"第二条件のはず: -a={-a}, -b={-b}"
            checked_mixed += 1

for s in roots:
    assert s * s == 2, "s·s = 2 が壊れている"
    for a in samples:
        for b in samples:
            xi = QQbar(a) + QQbar(b) * s

            # neg: 加法逆元の表示。
            assert -xi == QQbar(-a) + QQbar(-b) * s, \
                f"加法逆元の表示が壊れている: a={a}, b={b}, s={s}"
            checked_neg += 1

            # main: 少なくとも一つ。
            is_pos = cone(a, b)
            is_zero = (xi == 0)
            neg_pos = cone(-a, -b)
            assert is_pos or is_zero or neg_pos, \
                f"三分律（少なくとも一つ）が壊れている: a={a}, b={b}, s={s}"
            checked_main += 1

print(f"OK: main={checked_main}, cover={checked_cover}, "
      f"neg={checked_neg}, mixed={checked_mixed}")
