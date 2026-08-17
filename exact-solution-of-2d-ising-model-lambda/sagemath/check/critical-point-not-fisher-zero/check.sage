# 対象ラベル: claim_critical_point_not_fisher_zero
# 帰属: ZZ / QQ / QQbar の厳密計算。浮動小数点を使わない。


def positive(a, b):
    return (
        (a >= 0 and b >= 0 and (a, b) != (QQ(0), QQ(0)))
        or (a > 0 and b < 0 and 2 * b * b < a * a)
        or (a < 0 and b > 0 and a * a < 2 * b * b)
    )


def broken_bond_count(config, L):
    def spin(i, j):
        return config[(i % L) * L + (j % L)]

    return sum(
        spin(i, j) != spin(i + 1, j)
        for i in range(L) for j in range(L)
    ) + sum(
        spin(i, j) != spin(i, j + 1)
        for i in range(L) for j in range(L)
    )


# 節「零元の表示は三条件のどれも満たさない」: (a,b)=(0,0) は正錐の三条件をすべて破る。
assert not positive(QQ(0), QQ(0))
assert not ((QQ(0), QQ(0)) != (QQ(0), QQ(0)))   # 第一の条件の (a,b) ≠ (0,0)
assert not (QQ(0) < QQ(0))                       # 第二の条件の 0 < a
assert not (QQ(0) > QQ(0))                       # 第三の条件の a < 0

# 節「臨界点での評価は零でない」: L = 1, 2, 3 と s の二根について
# Ev^F_{x_c}(Z_L) = Σ Ω_L(m) x_c^m が零でなく、したがって x_c ∉ F_L。
checked = 0
for L in (1, 2, 3):
    multiplicities = [ZZ(0)] * (2 * L * L + 1)
    for mask in range(2 ** (L * L)):
        config = tuple(1 if (mask >> k) & 1 else -1 for k in range(L * L))
        multiplicities[broken_bond_count(config, L)] += 1

    S = PolynomialRing(ZZ, "x")
    Z_L = S(multiplicities)

    for s in (QQbar(2).sqrt(), -QQbar(2).sqrt()):
        xc = -1 + s
        value = sum(
            QQbar(coefficient) * xc ** m
            for m, coefficient in enumerate(multiplicities)
        )
        # 評価の一致（def_qbar_polynomial_evaluation と係数表示）
        assert value == Z_L(xc)
        # 結論: 値は零でない。すなわち x_c は Z_L の根でない
        assert value != QQbar(0)
        assert xc not in [root for root, _ in Z_L.change_ring(QQbar).roots()]

        # 節「値の表示は正錐の条件を満たす」: rep_s(ξ) を QQ[y]/(y^2-2) で求め、
        # (0,0) でなく、正錐の三条件の少なくとも一つを満たすことを確認する。
        R = PolynomialRing(QQ, "y")
        y = R.gen()
        reduced = sum(
            ZZ(coefficient) * (-1 + y) ** m
            for m, coefficient in enumerate(multiplicities)
        ).mod(y ** 2 - 2)
        a = reduced[0]
        b = reduced[1] if reduced.degree() >= 1 else QQ(0)
        assert QQbar(a) + QQbar(b) * s == value
        assert (a, b) != (QQ(0), QQ(0))
        assert positive(a, b)
        checked += 1

assert checked == 6
print(f"OK: claim_critical_point_not_fisher_zero ({checked} 組)")
