# 対象ラベル: max_eigenvalue_of_V_plus_simple
# max_eigenvalue_of_V_plus_simple (2) の二つの鎖を一行ずつ確かめる。
#  (A) ǧ(1,…,1) − ǧ(ε) = Σγ(1−½) − Σγ(ε−½) = Σ(γ(1−½) − γ(ε−½)) = Σγ((1−½)−(ε−½)) = Σγ(1−ε) = Σa ≥ a_{μ0}
#      = γ_{μ0}(1−ε_{μ0}) = γ_{μ0}·1 = γ_{μ0} > 0
#  (B) Λ̌_ε = (2 sinh 2K_2)^{M/2}exp(Σγ(ε−½)) = (2s_2)^{M/2}exp(Σγ(ε−½)) = (2s_2)^{M/2}exp(ǧ(ε))
#      < (2s_2)^{M/2}exp(ǧ(1,…,1)) = (2s_2)^{M/2}exp(Σγ(1−½)) = (2 sinh 2K_2)^{M/2}exp(Σγ(1−½)) = Λ̌_{(1,…,1)} = Λ̌_max
# (A) の等号の行は γ_μ を不定元に置いた QQ 上の多項式環で、ε を全列挙して恒等式として確かめる。
#     不等号の行は γ_μ を正の有理数の組に置いて厳密に確かめる（鎖が使う γ の性質は γ_μ > 0 だけ）。
#     有限和は def_finite_sum_of_real_numbers のとおり左から足す。
# (B) と、物理の γ(θ̃_μ) = arccosh(γ_1(θ̃_μ)) での (A) は、exp・arccosh・実数冪を含むので RealField(200) で確かめる
#     （ℝ 脱出: 超越関数の値の比較。差が 10^{-50} より十分大きいことを確かめる）。
#     (B) の定義の行（Λ̌_ε・s_2・ǧ の定義の展開）は、同じ定義から組むので構成上一致する。実質の比較は、
#     狭義不等号の行と、最後の行の Λ̌_max = (2 sinh 2K_2)^{M/2}exp(½Σγ)（eigenvalues_of_V_plus (2) の表式）との一致である。
# (A) の不等号の行は、差が仮定で 0 以上とされる量（a_μ (μ ≠ μ0) の和、γ_{μ0}）に恒等的に一致することも多項式環で確かめる。
# 否定コントロール: γ のどれかが 0 なら (A) の最後の狭義不等号が外れる ε がある。

set_random_seed(20261104)   # 試す正の有理数の組を実行ごとに同じにする（ログの再現のため）

def fsum(rs):
    s = rs[0]
    for r in rs[1:]:
        s = s + r
    return s


def chain_A(gam, eps, mu0):
    M = len(gam)
    a = [gam[m] * (1 - eps[m]) for m in range(M)]
    half = QQ(1) / 2
    gcheck = lambda e: fsum([gam[m] * (e[m] - half) for m in range(M)])
    return [
        ("ǧ(1)−ǧ(ε)", gcheck([1] * M) - gcheck(eps), "="),
        ("Σγ(1−½) − Σγ(ε−½)", fsum([gam[m] * (1 - half) for m in range(M)]) - fsum([gam[m] * (eps[m] - half) for m in range(M)]), "="),
        ("Σ(γ(1−½) − γ(ε−½))", fsum([gam[m] * (1 - half) - gam[m] * (eps[m] - half) for m in range(M)]), "="),
        ("Σγ((1−½)−(ε−½))", fsum([gam[m] * ((1 - half) - (eps[m] - half)) for m in range(M)]), "="),
        ("Σγ(1−ε)", fsum([gam[m] * (1 - eps[m]) for m in range(M)]), "="),
        ("Σa", fsum(a), ">="),
        ("a_{μ0}", a[mu0], "="),
        ("γ_{μ0}(1−ε_{μ0})", gam[mu0] * (1 - eps[mu0]), "="),
        ("γ_{μ0}·1", gam[mu0] * 1, "="),
        ("γ_{μ0}", gam[mu0], ">"),
        ("0", 0, None),
    ]


eq_count = 0
ineq_count = 0
for M in range(2, 7):
    R = PolynomialRing(QQ, [f"g{m}" for m in range(M)])
    for eps in cartesian_product([[0, 1]] * M):
        eps = list(eps)
        if eps == [1] * M:
            continue
        for mu0 in [m for m in range(M) if eps[m] == 0]:
            lines = chain_A(list(R.gens()), eps, mu0)
            for (n1, v1, rel), (n2, v2, _) in zip(lines, lines[1:]):
                if rel == "=":
                    assert v1 == v2, (M, eps, mu0, n1, n2)
                    eq_count += 1
            g = list(R.gens())
            assert lines[5][1] - lines[6][1] == sum(g[m] * (1 - eps[m]) for m in range(M) if m != mu0)   # Σa − a_{μ0}
            assert lines[9][1] - 0 == g[mu0]                                                          # γ_{μ0} − 0
            eq_count += 2
            for trial in range(3):
                gam = [QQ(randint(1, 40)) / randint(1, 9) for _ in range(M)]
                lines = chain_A(gam, eps, mu0)
                for (n1, v1, rel), (n2, v2, _) in zip(lines, lines[1:]):
                    if rel == "=":
                        assert v1 == v2
                    elif rel == ">=":
                        assert v1 >= v2, (n1, n2); ineq_count += 1
                    elif rel == ">":
                        assert v1 > v2, (n1, n2); ineq_count += 1
                assert all(gam[m] * (1 - eps[m]) >= 0 for m in range(M))   # a_μ ≥ 0（鎖の前置き）

# 否定コントロール: γ_{μ0} = 0 だと最後の狭義不等号が外れる
lines = chain_A([QQ(0), QQ(1)], [0, 1], 0)
assert not (lines[-2][1] > 0)

# 物理の γ(θ̃_μ) で (A) の端と (B) を RealField(200) で
RF = RealField(200)
couplings = [(QQ(1) / 3, QQ(1) / 2), (QQ(1) / 2, QQ(1) / 5), (QQ(3) / 4, QQ(3) / 4)]
# 臨界点 sinh 2K_1 sinh 2K_2 = 1 を 1 組
Kc = RF(log(1 + sqrt(2)) / 2)
phys = 0
for (K1, K2) in [(RF(k1), RF(k2)) for (k1, k2) in couplings] + [(Kc, Kc)]:
    K2s = RF(atanh(exp(-2 * K2)))                        # 双対結合定数 K_2^*（tanh K_2^* = e^{−2K_2}）
    s2 = sinh(2 * K2)
    for M in range(2, 7):
        th = [2 * RF(pi) * (mu - RF(1) / 2) / M for mu in range(1, M + 1)]
        gam = [arccosh(cosh(2 * K1) * cosh(2 * K2s) - sinh(2 * K1) * sinh(2 * K2s) * cos(t)) for t in th]
        assert min(gam) > RF(10) ** (-50)
        gch = lambda e: sum(gam[m] * (e[m] - RF(1) / 2) for m in range(M))
        Lam = lambda e: (2 * s2) ** (RF(M) / 2) * exp(gch(e))
        top = [1] * M
        for eps in cartesian_product([[0, 1]] * M):
            eps = list(eps)
            if eps == top:
                continue
            mu0 = eps.index(0)
            diff = gch(top) - gch(eps)
            assert abs(diff - sum(gam[m] * (1 - eps[m]) for m in range(M))) < RF(10) ** (-50)
            assert diff >= gam[mu0] - RF(10) ** (-50) and gam[mu0] > 0
            assert exp(gch(eps)) < exp(gch(top))                                  # real_exp_strictly_increasing
            half = RF(1) / 2
            linesB = [
                (2 * sinh(2 * K2)) ** (RF(M) / 2) * exp(sum(gam[m] * (eps[m] - half) for m in range(M))),   # Λ̌_ε の定義
                (2 * s2) ** (RF(M) / 2) * exp(sum(gam[m] * (eps[m] - half) for m in range(M))),            # s_2 = sinh 2K_2
                (2 * s2) ** (RF(M) / 2) * exp(gch(eps)),                                                  # ǧ の定義
                (2 * s2) ** (RF(M) / 2) * exp(gch(top)),                                                  # < 正の実数を掛ける
                (2 * s2) ** (RF(M) / 2) * exp(sum(gam[m] * (1 - half) for m in range(M))),                # ǧ の定義（ε → (1,…,1)）
                (2 * sinh(2 * K2)) ** (RF(M) / 2) * exp(sum(gam[m] * (1 - half) for m in range(M))),       # s_2 = sinh 2K_2
                Lam(top),                                                                                 # Λ̌_{(1,…,1)}
                (2 * sinh(2 * K2)) ** (RF(M) / 2) * exp(sum(gam) / 2),                                    # Λ̌_max（(2) の表式）
            ]
            assert abs(Lam(eps) - linesB[0]) < RF(10) ** (-50)
            for t in range(len(linesB) - 1):
                if t == 2:
                    assert linesB[2] < linesB[3] and linesB[3] - linesB[2] > RF(10) ** (-40)
                else:
                    assert abs(linesB[t] - linesB[t + 1]) < RF(10) ** (-50) * (1 + abs(linesB[t])), t
            phys += 1

print(f"(A) 等号 {eq_count} 段（多項式環）、不等号 {ineq_count} 段（正の有理数）、物理の結合定数で (A)(B) を {phys} 通り確かめた")
print("RESULT: PASS")
