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

one = QQbar(1)
zero = QQbar(0)
two = one + one
