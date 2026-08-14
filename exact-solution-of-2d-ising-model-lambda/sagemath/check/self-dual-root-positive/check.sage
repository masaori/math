# 対象ラベル: claim_self_dual_root_plus_mem / claim_self_dual_root_plus_representation /
#             claim_self_dual_root_minus_mem / claim_self_dual_root_minus_representation /
#             claim_self_dual_root_plus_positive / claim_self_dual_root_minus_not_positive /
#             claim_self_dual_positive_root_unique / def_critical_point
# 帰属: QQ / QQbar の厳密計算。浮動小数点を使わない。

# 主張の組み立てを一行ずつ突き合わせる:
#   plus_mem / plus_rep:   -1+s = (-1) + 1*s、表示は (-1, 1)
#   minus_mem / minus_rep: -1-s = (-1) + (-1)*s、表示は (-1, -1)
#   plus_positive:         (-1, 1) は正錐の第三条件を満たす
#                          （a = -1 < 0、0 < 1 = b、a*a = 1 < 2 = 2*(b*b)）
#   minus_not_positive:    (-1, -1) は三条件をどれも満たさない
#   unique:                根 {-1+s, -1-s} のうち正錐に属するのは -1+s だけ
#   critical_point:        x_c := -1+s。実数の言葉では sqrt(2)-1（照合のみ。定義には使わない）

two = QQbar(1) + QQbar(1)

# s*s = 2 を満たす s は 2 つある。主張は「任意の s」についてなので両方で検査する。
R = PolynomialRing(QQbar, "t")
t = R.gen()
s_candidates = (t**2 - R(two)).roots(multiplicities=False)
assert len(s_candidates) == 2, f"s*s = 2 の解の個数が 2 でない: {len(s_candidates)}"


def positive_cone_condition_first(a, b):
    return a >= 0 and b >= 0 and (a, b) != (QQ(0), QQ(0))


def positive_cone_condition_second(a, b):
    return a > 0 and b < 0 and 2 * (b * b) < a * a


def positive_cone_condition_third(a, b):
    return a < 0 and b > 0 and a * a < 2 * (b * b)


def positive_cone_member(a, b):
    return (
        positive_cone_condition_first(a, b)
        or positive_cone_condition_second(a, b)
        or positive_cone_condition_third(a, b)
    )


checked = 0
for s in s_candidates:
    assert s * s == two, f"s*s = 2 が壊れている: s = {s}"

    root_plus = -QQbar(1) + s   # -1 + s
    root_minus = -QQbar(1) - s  # -1 - s

    # plus_mem / plus_rep: -1+s = (-1) + 1*s（鎖の各段）
    assert root_plus == QQbar(-1) + s
    assert QQbar(-1) + s == QQbar(-1) + QQbar(1) * s  # 単位元との積
    a_plus, b_plus = QQ(-1), QQ(1)
    assert root_plus == QQbar(a_plus) + QQbar(b_plus) * s  # 表示 (-1, 1)

    # minus_mem / minus_rep: -1-s = (-1) + (-1)*s（鎖の各段）
    assert root_minus == QQbar(-1) + (-s)
    assert QQbar(-1) + (-s) == QQbar(-1) + (-(QQbar(1) * s))  # 単位元との積
    assert QQbar(-1) + (-(QQbar(1) * s)) == QQbar(-1) + QQbar(-1) * s  # 積の加法逆元
    a_minus, b_minus = QQ(-1), QQ(-1)
    assert root_minus == QQbar(a_minus) + QQbar(b_minus) * s  # 表示 (-1, -1)

    # 表示の一意性の照合: 別の表示 (a', b') が同じ元を表すなら (a', b') は一致する
    #（有理数の小さな格子で対偶を確かめる）
    for a2 in [QQ(x) for x in range(-3, 4)]:
        for b2 in [QQ(x) for x in range(-3, 4)]:
            if QQbar(a2) + QQbar(b2) * s == root_plus:
                assert (a2, b2) == (a_plus, b_plus)
            if QQbar(a2) + QQbar(b2) * s == root_minus:
                assert (a2, b2) == (a_minus, b_minus)
            checked += 1

    # plus_positive: 第三条件の各比較（すべて QQ の順序）
    assert a_plus < 0
    assert 0 < b_plus
    assert a_plus * a_plus == QQ(1)          # (-1)*(-1) = 1
    assert 2 * (b_plus * b_plus) == QQ(2)    # 2*(1*1) = 2
    assert QQ(1) < QQ(2)
    assert a_plus * a_plus < 2 * (b_plus * b_plus)
    assert positive_cone_condition_third(a_plus, b_plus)
    assert positive_cone_member(a_plus, b_plus)

    # minus_not_positive: 三条件がすべて破れる
    assert not positive_cone_condition_first(a_minus, b_minus)   # 0 <= a が破れる
    assert not positive_cone_condition_second(a_minus, b_minus)  # 0 < a が破れる
    assert not positive_cone_condition_third(a_minus, b_minus)   # 0 < b が破れる
    assert not positive_cone_member(a_minus, b_minus)

    # unique: 自己双対方程式の根の全体は {-1+s, -1-s}（claim_self_dual_quadratic_roots）で、
    # 正錐に属するのは -1+s だけ
    roots = (t**2 + R(two) * t - R(QQbar(1))).roots(multiplicities=False)
    assert sorted(roots) == sorted([root_plus, root_minus])
    positive_roots = [
        r for r, (ar, br) in [(root_plus, (a_plus, b_plus)), (root_minus, (a_minus, b_minus))]
        if positive_cone_member(ar, br)
    ]
    assert positive_roots == [root_plus]

    # critical_point: x_c := -1+s。実数の平方根との照合（照合のみ。定義には使わない）
    x_c = root_plus
    assert x_c * x_c + two * x_c - QQbar(1) == QQbar(0)
    sqrt2 = QQbar(2).sqrt()
    assert x_c == sqrt2 - QQbar(1) or x_c == -sqrt2 - QQbar(1)

print(f"PASS: 2 つの s について全段を検査した（一意性の照合 {checked} 組）")
