# 対象ラベル: def_kw_dual_transform, claim_kw_dual_transform_domain
# 帰属: QQbar。検査点と各行の厳密等号判定を共有する。

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

def check_calculation_step(label, left, right):
    one = QQbar(1)
    checked = 0
    for xi in test_points:
        assert one + xi != 0, f"検査点の前提が壊れている: xi = {xi}"
        inverse = (one + xi) ** (-1)
        assert left(xi, one, inverse) == right(xi, one, inverse), (
            f"{label}: xi = {xi}"
        )
        checked += 1
    assert checked == 16
    print(f"{label}: {checked} 点の等号判定を通過（QQbar）; RESULT: PASS")
