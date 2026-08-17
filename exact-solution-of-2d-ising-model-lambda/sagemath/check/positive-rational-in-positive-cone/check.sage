# 対象ラベル: claim_positive_rational_in_positive_cone
# 帰属: QQ / QQbar の厳密計算。浮動小数点を使わない。

# 主張の組み立てを一行ずつ突き合わせる:
#   所属:   q = q + 0 = q + 0*s なので組 (q, 0) が Q_s の存在条件の証人
#   表示:   rep_s(q) = (q, 0)（一意性は他の表示 (a, b) が (q, 0) に一致することで確認）
#   正錐:   (q, 0) は第一条件（0 <= q かつ 0 <= 0 かつ (q, 0) != (0, 0)）を満たす
#   非空虚: q = 0 と q < 0 では第一条件のこの確かめ方が壊れる箇所を確認
#           （0 は三条件のどれも満たさず、負の有理数も三条件のどれも満たさない）

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


positive_rationals = [QQ(1), QQ(2), QQ(1) / 2, QQ(2) / 3, QQ(7), QQ(22) / 7]
nonpositive_rationals = [QQ(0), QQ(-1), QQ(-1) / 2, QQ(-3)]

checked = 0
for s in s_candidates:
    assert s * s == two, f"s*s = 2 が壊れている: s = {s}"

    for q in positive_rationals:
        # 所属の鎖: q = q + 0 = q + 0*s（加法単位元と零元の乗法）
        assert QQbar(q) == QQbar(q) + QQbar(0)
        assert QQbar(q) + QQbar(0) == QQbar(q) + QQbar(0) * s

        # 表示の一意性: q = a + b*s なら (a, b) = (q, 0)。
        # b != 0 なら s = (q - a)/b が有理数になり s*s = 2 に反する。
        # ここでは QQbar の厳密比較で、証人 (q, 0) が表示であることと、
        # 例として (q, 1)、(q - 1, 1) が表示でないことを確認する。
        assert QQbar(q) == QQbar(q) + QQbar(0) * s
        assert QQbar(q) != QQbar(q) + QQbar(1) * s
        assert QQbar(q) != QQbar(q - 1) + QQbar(1) * s

        # 正錐の第一条件（すべて QQ の順序）
        a, b = q, QQ(0)
        assert a >= 0, f"0 <= a が壊れている: q = {q}"
        assert b >= 0
        assert (a, b) != (QQ(0), QQ(0)), f"(q,0) != (0,0) が壊れている: q = {q}"
        assert positive_cone_condition_first(a, b)
        assert positive_cone_member(a, b)
        checked += 1

    # 非空虚性: q = 0 と負の有理数では三条件のどれも成り立たない
    for q in nonpositive_rationals:
        a, b = q, QQ(0)
        assert not positive_cone_member(a, b), f"q = {q} が正錐に入ってしまう"

assert checked == len(s_candidates) * len(positive_rationals)
print(f"OK: claim_positive_rational_in_positive_cone "
      f"(s 2 通り x 正の有理数 {len(positive_rationals)} 個、"
      f"非正 {len(nonpositive_rationals)} 個の排除)")
