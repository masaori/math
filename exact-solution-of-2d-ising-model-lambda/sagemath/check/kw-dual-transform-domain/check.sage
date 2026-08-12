# 対象ラベル: def_kw_dual_transform, claim_kw_dual_transform_domain
# 帰属: QQbar（代数的数）の厳密計算。浮動小数点を使わない。

# 双対変換 KW(xi) := (1 - xi) * (1 + xi)^{-1}（def_kw_dual_transform）。
# 主張（claim_kw_dual_transform_domain）: 1 + xi != 0 ならば 1 + KW(xi) != 0。
# 証明の鎖の中間段 1 + KW(xi) = 2 * (1 + xi)^{-1} も突き合わせる。


def kw(xi):
    return (QQbar(1) - xi) * (QQbar(1) + xi) ** (-1)


# 検査点: 有理数、無理な実代数的数、虚の代数的数（1 の冪根を含む）を混ぜる。
# いずれも 1 + xi != 0 を満たす点である。
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
    # 鎖の中間段: 1 + KW(xi) = 2 * (1 + xi)^{-1}
    lhs = QQbar(1) + value
    rhs = QQbar(2) * one_plus ** (-1)
    assert lhs == rhs, f"中間段が不一致: xi = {xi}"
    # 主張: 1 + KW(xi) != 0
    assert lhs != 0, f"主張が不成立: xi = {xi} で 1 + KW(xi) = 0"
    checked += 1

# 定義域の境界の外の確認（主張の対偶側ではなく、仮定 1 + xi != 0 の必要性の説明）:
# xi = -1 では 1 + xi = 0 で逆元が取れず、KW は定義されない。ここでは何も計算しない。

print(f"kw-dual-transform-domain: {checked} 点すべて通過（QQbar の厳密計算）")
