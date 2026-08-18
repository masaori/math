# 対象ラベル: claim_leading_distance_pinching_implies_predicate
#
# R のモデルを AA に取り、本文の合成（η の取り方、二距離の表示、式変形の各行）を厳密に検査する。
# 浮動小数点は使わない。


def main():
    # 恒等式の段（式変形の 2〜3 行目）は多項式環で記号的に確認する。
    P = PolynomialRing(QQ, ["alpha", "beta", "xc", "q", "eta"])
    alpha, beta, xc, q, eta = P.gens()
    u = alpha - xc
    v = xc - q
    lhs = 4 * eta - ((alpha - q) * (alpha - q) + beta * beta)
    mid = 4 * eta - ((u + v) * (u + v) + beta * beta)
    rhs = (
        2 * (eta - (u * u + beta * beta))
        + 2 * (eta - v * v)
        + (2 * (u * u) + 2 * (v * v) - (u + v) * (u + v))
        + beta * beta
    )
    assert u + v == alpha - q
    assert lhs == mid
    assert mid == rhs

    # 数値の段: 実閉体のモデル AA で、L=2 の Fisher 零点と実際の証人を追う。
    # 平方証人そのものを重ねて構成すると根体が膨らむため、各証人の平方を厳密な AA 元として追う。
    xc_v = AA(2).sqrt() - 1
    x = polygen(QQ, "x")
    Z2 = sum(
        x ** sum(
            1
            for e in [
                ((0, 0), (0, 1)), ((0, 1), (0, 0)),
                ((1, 0), (1, 1)), ((1, 1), (1, 0)),
                ((0, 0), (1, 0)), ((1, 0), (0, 0)),
                ((0, 1), (1, 1)), ((1, 1), (0, 1)),
            ]
            if sigma[e[0]] != sigma[e[1]]
        )
        for sigma in [
            {(i, j): s
             for (i, j), s in zip([(0, 0), (0, 1), (1, 0), (1, 1)], bits)}
            for bits in cartesian_product([[1, -1]] * 4)
        ]
    )
    zeros = [r for r, m in Z2.roots(QQbar)]
    assert len(zeros) > 0

    for eps in [QQ(3), QQ(2), QQ(3) / 2]:
        eta = eps * eps / 4
        assert eta > 0
        # 先頭距離の詰め寄りの仮定に相当する部分: L=2 の零点の中で
        # dsq_c が最小のものを取り、dsq_c(xi) < eta が成り立つ標本だけを検査する
        # （本文は仮定として受けるので、成り立つ ε で各行を追えばよい）。
        dsqc_list = []
        for z in zeros:
            a = AA((z + z.conjugate()) / 2)
            b_sq = AA(-((z - z.conjugate()) ** 2) / 4)  # β^2 = (Im z)^2 を厳密に
            dsqc_list.append(((a - xc_v) ** 2 + b_sq, a, b_sq))
        dsqc_list.sort(key=lambda t: t[0])
        d1, a, b_sq = dsqc_list[0]
        assert d1 < AA(eta), "この ε では仮定の標本にならない"

        # 有理近似（tick 423 の主張の実体）: (xc - q)^2 < eta なる q ∈ Q_{>0}
        N = 1
        while QQ(1) / (N * N) >= eta:
            N += 1
        k = 0
        while AA(QQ(k + 1) / N) <= xc_v:
            k += 1
        q_v = QQ(k + 1) / N
        assert q_v > 0
        assert (xc_v - AA(q_v)) ** 2 < AA(eta)

        # 証人の平方を追う。
        u_v = a - xc_v
        v_v = xc_v - AA(q_v)
        c1_sq = AA(eta) - (u_v ** 2 + b_sq)
        c2_sq = AA(eta) - v_v ** 2
        g_sq = 2 * u_v ** 2 + 2 * v_v ** 2 - (u_v + v_v) ** 2
        assert c1_sq > 0 and c2_sq > 0 and g_sq >= 0
        assert g_sq == (u_v - v_v) ** 2

        # 2 = t·t（t = sqrt(2) ∈ AA）で 2·c² = (t·c)²。
        z1_sq = 2 * c1_sq + 2 * c2_sq
        z2_sq = z1_sq + g_sq
        z3_sq = z2_sq + b_sq
        assert z1_sq > 0 and z2_sq > 0 and z3_sq > 0

        # 式変形の鎖の最終確認: ε² − dsq(ξ,q) = z3² と、詰め寄りの述語の不等式。
        dsq_v = (a - AA(q_v)) ** 2 + b_sq
        assert AA(eps * eps) - dsq_v == z3_sq
        assert dsq_v < AA(eps * eps)

    print("先頭距離の詰め寄りは詰め寄りの述語を導く: 恒等式を QQ 記号で、合成を AA で厳密検査して通過")


main()
