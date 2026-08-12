# 対象ラベル: claim_kw_dual_transform_involution
# 帰属: QQbar（代数的数）の厳密計算。浮動小数点を使わない。

# 双対変換 KW(xi) := (1 - xi) * (1 + xi)^{-1}（def_kw_dual_transform）。
# 主張（claim_kw_dual_transform_involution）: 1 + xi != 0 ならば KW(KW(xi)) = xi。
# 証明の鎖の中間段も突き合わせる:
#   h1: 1 + KW(xi) = 2 * (1 + xi)^{-1}
#   h2: 1 - KW(xi) = 2 * xi * (1 + xi)^{-1}
#   chainA: KW(KW(xi)) * (1 + KW(xi)) = 1 - KW(xi)
#   chainB: xi * (1 + KW(xi)) = 1 - KW(xi)
#   difference: (1 + KW(xi)) * (KW(KW(xi)) - xi) = 0


def kw(xi):
    return (QQbar(1) - xi) * (QQbar(1) + xi) ** (-1)


# 検査点: kw-dual-transform-domain と同じ 16 点
# （有理数、無理な実代数的数、虚の代数的数。いずれも 1 + xi != 0）。
sqrt2 = QQbar(2).sqrt()
i_unit = QQbar(QQ[I].gen())
zeta3 = QQbar.zeta(3)
zeta8 = QQbar.zeta(8)
test_points = [
    QQbar(0),
    QQbar(1),
    QQbar(2),
    QQbar(-2),
    QQbar(1) / 2,
    QQbar(-1) / 3,
    QQbar(7) / 5,
    sqrt2,
    sqrt2 - 1,          # 後続のセクションで自己双対点となる点
    -sqrt2,
    QQbar(3).sqrt() / 2,
    i_unit,
    QQbar(2) * i_unit,
    zeta3,
    zeta8,
    zeta8 ** 3,
]

checked = 0
for xi in test_points:
    one_plus = QQbar(1) + xi
    assert one_plus != 0, f"検査点の前提が壊れている: 1 + {xi} = 0"

    value = kw(xi)
    one_plus_kw = QQbar(1) + value
    one_minus_kw = QQbar(1) - value
    # claim_kw_dual_transform_domain: KW(KW(xi)) が定義できること
    assert one_plus_kw != 0, f"定義域が壊れている: xi = {xi} で 1 + KW(xi) = 0"
    double = kw(value)

    # h1: 1 + KW(xi) = 2 * (1 + xi)^{-1}
    assert one_plus_kw == QQbar(2) * one_plus ** (-1), f"h1 が不一致: xi = {xi}"
    # h2: 1 - KW(xi) = 2 * xi * (1 + xi)^{-1}
    assert one_minus_kw == QQbar(2) * xi * one_plus ** (-1), f"h2 が不一致: xi = {xi}"
    # chainA: KW(KW(xi)) * (1 + KW(xi)) = 1 - KW(xi)
    assert double * one_plus_kw == one_minus_kw, f"chainA が不一致: xi = {xi}"
    # chainB: xi * (1 + KW(xi)) = 1 - KW(xi)
    assert xi * one_plus_kw == one_minus_kw, f"chainB が不一致: xi = {xi}"
    # difference: (1 + KW(xi)) * (KW(KW(xi)) - xi) = 0
    assert one_plus_kw * (double - xi) == 0, f"差の消去が不一致: xi = {xi}"
    # 主張: KW(KW(xi)) = xi
    assert double == xi, f"主張が不成立: xi = {xi} で KW(KW(xi)) != xi"
    checked += 1

print(f"kw-dual-transform-involution: {checked} 点すべて通過（QQbar の厳密計算）")
