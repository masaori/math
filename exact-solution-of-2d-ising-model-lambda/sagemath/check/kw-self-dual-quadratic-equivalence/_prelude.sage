# 対象ラベル: claim_kw_self_dual_quadratic_equivalence
# 代数的数の等号を QQbar で厳密に判定する。浮動小数点は使わない。

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


one = QQbar(1)
zero = QQbar(0)
two = one + one
assert len(test_points) == 17
assert all(one + xi != zero for xi in test_points)
self_dual_points = [xi for xi in test_points if kw(xi) == xi]
quadratic_points = [xi for xi in test_points if xi**2 + two*xi - one == zero]
assert len(self_dual_points) == 2
assert len(quadratic_points) == 2
