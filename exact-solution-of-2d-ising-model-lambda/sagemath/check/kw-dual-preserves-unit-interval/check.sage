# 対象ラベル: def_unit_interval_rationals, claim_kw_dual_preserves_unit_interval
# 帰属: QQ（有理数）の厳密計算。浮動小数点を使わない。
# KW(q) の計算だけ QQbar を併用し、QQ の中の計算と一致することを突き合わせる。

# 主張（claim_kw_dual_preserves_unit_interval）:
#   q ∈ QQ, 0 < q < 1 ならば 1 + q != 0 であって KW(q) が定義され、
#   KW(q) ∈ QQ かつ 0 < KW(q) < 1。
# 証明の各段（準備と 3 つの鎖）を一段ずつ確かめる。


def kw_in_qqbar(xi):
    # def_kw_dual_transform の定義どおり QQbar の中で計算する
    return (QQbar(1) - xi) * (QQbar(1) + xi) ** (-1)


# 検査点: 0 < a/b < 1 の既約分数を系統的に走る（分母 2..40 の全既約分数）。
test_points = []
for b in range(2, 41):
    for a in range(1, b):
        if gcd(a, b) == 1:
            test_points.append(QQ(a) / QQ(b))

checked = 0
for q in test_points:
    # 前提: q ∈ QQ_{(0,1)}
    assert q in QQ and 0 < q and q < 1, f"検査点の前提が壊れている: q = {q}"

    # 準備: 1 < 1 + q、0 < 1 + q、1 + q != 0
    one_plus = 1 + q
    assert 1 < one_plus, f"準備 1<1+q が不成立: q = {q}"
    assert 0 < one_plus, f"準備 0<1+q が不成立: q = {q}"
    assert one_plus != 0, f"準備 1+q!=0 が不成立: q = {q}"

    # 準備: t := (1+q)^{-1} ∈ QQ、(1+q)·t = 1、QQbar の逆元と一致
    t = one_plus ** (-1)
    assert t in QQ, f"準備 t∈QQ が不成立: q = {q}"
    assert one_plus * t == 1, f"準備 (1+q)t=1 が不成立: q = {q}"
    assert QQbar(t) == (QQbar(1) + QQbar(q)) ** (-1), f"逆元の一致が不成立: q = {q}"

    # 準備: 0 < t、0 < 1-q、1-q < 1+q
    assert 0 < t, f"準備 0<t が不成立: q = {q}"
    one_minus = 1 - q
    assert 0 < one_minus, f"準備 0<1-q が不成立: q = {q}"
    assert one_minus < one_plus, f"準備 1-q<1+q が不成立: q = {q}"

    # 鎖 1: KW(q) = (1-q)·t ∈ QQ（QQbar の定義どおりの値との一致も確かめる）
    value_in_qq = one_minus * t
    assert value_in_qq in QQ, f"鎖 1 KW(q)∈QQ が不成立: q = {q}"
    assert QQbar(value_in_qq) == kw_in_qqbar(QQbar(q)), f"鎖 1 QQbar との一致が不成立: q = {q}"

    # 鎖 2: 0 < KW(q)
    assert 0 < value_in_qq, f"鎖 2 0<KW(q) が不成立: q = {q}"

    # 鎖 3: KW(q) < (1+q)·t = 1
    assert value_in_qq < one_plus * t, f"鎖 3 中間比較が不成立: q = {q}"
    assert value_in_qq < 1, f"鎖 3 KW(q)<1 が不成立: q = {q}"

    # 結論: KW(q) ∈ QQ_{(0,1)}
    assert value_in_qq in QQ and 0 < value_in_qq and value_in_qq < 1, f"結論が不成立: q = {q}"
    checked += 1

print(f"kw-dual-preserves-unit-interval: {checked} 点すべて通過（QQ の厳密計算）")
