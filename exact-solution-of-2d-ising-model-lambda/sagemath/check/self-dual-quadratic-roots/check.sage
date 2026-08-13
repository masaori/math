# 対象ラベル: claim_self_dual_quadratic_roots
# 帰属: QQbar（代数的数）の厳密計算。浮動小数点を使わない。

# 主張（claim_self_dual_quadratic_roots）:
#   s ∈ QQbar が s*s = 2 を満たすとき、任意の xi ∈ QQbar について
#   xi^2 + 2 xi - 1 = 0  ⟺  xi = -1 + s または xi = -1 - s。
# 証明の組み立てを一行ずつ突き合わせる:
#   prep:     ((xi+1) - s) * ((xi+1) + s) = xi^2 + 2 xi - 1（仮定 s*s=2 のもとで xi によらない）
#   forward:  xi = -1+s では第一因子が 0、xi = -1-s では第二因子が 0
#   backward: 積が 0 のとき、第一因子が 0 なら xi = -1+s、
#             第一因子が非 0 なら零因子の不在で第二因子が 0、xi = -1-s

two = QQbar(1) + QQbar(1)

# s*s = 2 を満たす s は 2 つある（claim_sqrt_two_exists の SageMath 検証と同じ列挙）。
# 主張は「s*s = 2 を満たす任意の s」についてなので、両方の s で全体を検査する。
R = PolynomialRing(QQbar, "t")
t = R.gen()
s_candidates = (t**2 - R(two)).roots(multiplicities=False)
assert len(s_candidates) == 2, f"s*s = 2 の解の個数が 2 でない: {len(s_candidates)}"

# 検査点: kw-self-dual-quadratic-equivalence と同じ 17 点
#（二次方程式の 2 根 sqrt(2)-1 と -1-sqrt(2) を含む）。
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
for s in s_candidates:
    assert s * s == two, f"s*s = 2 が壊れている: s = {s}"
    root_plus = -QQbar(1) + s   # -1 + s
    root_minus = -QQbar(1) - s  # -1 - s

    holds_count = 0
    for xi in test_points + [root_plus, root_minus]:
        quadratic = xi * xi + two * xi - QQbar(1)
        factor_first = (xi + QQbar(1)) - s
        factor_second = (xi + QQbar(1)) + s

        # prep: 因数分解の等式（鎖の中間段も含めて突き合わせる）
        assert factor_first * factor_second == (xi + 1) * (xi + 1) - s * s, \
            f"準備の鎖の中間段（(xi+1)^2 - s*s）が不一致: s = {s}, xi = {xi}"
        assert (xi + 1) * (xi + 1) - s * s == (xi + 1) * (xi + 1) - two, \
            f"準備の鎖の s*s = 2 の段が不一致: s = {s}, xi = {xi}"
        assert (xi + 1) * (xi + 1) - two == quadratic, \
            f"準備の鎖の展開の段が不一致: s = {s}, xi = {xi}"
        assert factor_first * factor_second == quadratic, \
            f"準備の因数分解が不一致: s = {s}, xi = {xi}"

        # 主張: 同値
        holds_quadratic = quadratic == 0
        holds_roots = (xi == root_plus) or (xi == root_minus)
        assert holds_quadratic == holds_roots, (
            f"同値が不成立: s = {s}, xi = {xi} で二次方程式は {holds_quadratic}、"
            f"根への一致は {holds_roots}"
        )

        # forward の中間段: 各根で対応する因子が零になる
        if xi == root_plus:
            assert factor_first == 0, f"forward の第一因子が零でない: s = {s}"
        if xi == root_minus:
            assert factor_second == 0, f"forward の第二因子が零でない: s = {s}"

        # backward の場合分け: 積が零のとき、第一因子が零か、そうでなければ第二因子が零
        if holds_quadratic:
            holds_count += 1
            if factor_first != 0:
                assert factor_second == 0, f"backward の場合分けが壊れている: s = {s}, xi = {xi}"

        checked += 1

    # 成立側は root_plus と root_minus のちょうど 2 点
    #（test_points の中の 2 根と重複するが、集合としては 2 点）。
    assert holds_count == 4, (
        f"成立側の検査は 4 回（17 点中の 2 根 + 追加の 2 根）のはずだが {holds_count} 回だった"
    )

print(
    f"self-dual-quadratic-roots: s の 2 通り × 19 点 = {checked} 検査すべて通過"
    f"（QQbar の厳密計算）"
)
