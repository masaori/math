# 対象ラベル: claim_kw_self_dual_quadratic_equivalence
# 帰属: QQbar（代数的数）の厳密計算。浮動小数点を使わない。

# 双対変換 KW(xi) := (1 - xi) * (1 + xi)^{-1}（def_kw_dual_transform）。
# 主張（claim_kw_self_dual_quadratic_equivalence）:
#   1 + xi != 0 ならば、KW(xi) = xi と xi^2 + 2 xi - 1 = 0 は同値。
# 証明の鎖の中間段も突き合わせる:
#   prep:    KW(xi) * (1 + xi) = 1 - xi（仮定によらない準備の等式）
#   forward: KW(xi) = xi が成り立つ点では xi * (1 + xi) = 1 - xi、
#            および xi^2 + 2 xi - 1 = ((1 - xi) - xi) + 2 xi - 1 = 0
#   backward: (1 + xi) * (KW(xi) - xi) = -(xi^2 + 2 xi - 1)（仮定によらない恒等式）


def kw(xi):
    return (QQbar(1) - xi) * (QQbar(1) + xi) ** (-1)


# 検査点: kw-dual-transform-domain と同じ 16 点に、自己双対方程式のもう一方の根
# -1 - sqrt(2) を加えた 17 点（1 + xi = -sqrt(2) != 0 なので前提を満たす）。
# 二次方程式の 2 根（sqrt(2) - 1 と -1 - sqrt(2)）の両方で「同値」の成立側を、
# それ以外の 15 点で不成立側を検査する。
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
    sqrt2 - 1,          # 自己双対方程式の正の根（後続のセクションで x_c となる点）
    -QQbar(1) - sqrt2,  # 自己双対方程式のもう一方の根
    -sqrt2,
    QQbar(3).sqrt() / 2,
    i_unit,
    QQbar(2) * i_unit,
    zeta3,
    zeta8,
    zeta8 ** 3,
]

checked = 0
holds_count = 0
for xi in test_points:
    one_plus = QQbar(1) + xi
    assert one_plus != 0, f"検査点の前提が壊れている: 1 + {xi} = 0"

    value = kw(xi)
    quadratic = xi * xi + QQbar(2) * xi - QQbar(1)

    # prep: KW(xi) * (1 + xi) = 1 - xi
    assert value * one_plus == QQbar(1) - xi, f"準備の等式が不一致: xi = {xi}"

    # backward の恒等式: (1 + xi) * (KW(xi) - xi) = -(xi^2 + 2 xi - 1)
    assert one_plus * (value - xi) == -quadratic, f"backward の恒等式が不一致: xi = {xi}"

    # 主張: KW(xi) = xi と xi^2 + 2 xi - 1 = 0 の同値
    holds_kw = value == xi
    holds_quadratic = quadratic == 0
    assert holds_kw == holds_quadratic, (
        f"同値が不成立: xi = {xi} で KW(xi)=xi は {holds_kw}、二次方程式は {holds_quadratic}"
    )

    if holds_kw:
        holds_count += 1
        # forward の中間段: xi * (1 + xi) = 1 - xi
        assert xi * one_plus == QQbar(1) - xi, f"forward の中間段が不一致: xi = {xi}"
        # forward の鎖の終端: ((1 - xi) - xi) + 2 xi - 1 = 0
        assert ((QQbar(1) - xi) - xi) + QQbar(2) * xi - QQbar(1) == 0, (
            f"forward の終端が不一致: xi = {xi}"
        )
    checked += 1

assert holds_count == 2, f"成立側の検査点は 2 点のはずだが {holds_count} 点だった"
print(
    f"kw-self-dual-quadratic-equivalence: {checked} 点すべて通過"
    f"（成立側 {holds_count} 点、QQbar の厳密計算）"
)
