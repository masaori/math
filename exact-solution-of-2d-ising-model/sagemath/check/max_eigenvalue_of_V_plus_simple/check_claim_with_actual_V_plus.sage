# 対象ラベル: max_eigenvalue_of_V_plus_simple（主張 (1)(2)(3) そのものと、(2)(3) の鎖を実際の V^(+) と本文の ψ̌ で）
# 結合定数を K_1 := 2 log y、K_2 := log x と選び、(x, y) ∈ {(2, 2), (3, 3/2), (5/4, 3)}、M_col = 2, 3 で次を QQbar・AA で厳密に確かめる。
#   - V^(+) は def_V_plus の ((V_1^(+))^{1/2}V_2)(V_1^(+))^{1/2}（射影の y^λ と V_2 の成分 x^n。成分は QQ）。
#   - 行列の計算は ψ̌ の数体 E_1 の中で行う。V^(+)Q̌_ε = Λ̌_εQ̌_ε の Λ̌_ε は、Q̌_ε の成分の比で作った E_1 の元 lE[ε] として持ち、
#     その QQbar での像が AA の Λ̌_ε に等しいことを厳密に確かめてから行列に掛ける。
#   - ň_μ は本文の ψ̌（def_check_fermi の式どおりの行列）から ň_μ := ψ̌_μ^†ψ̌_{M_col+1−μ}（def_check_number_operator）、
#     Q̌_ε := Π_μ R_μ^{(ε_μ)}（R^{(1)} := ň、R^{(0)} := I − ň。check_joint_eigenspace_decomposition の定義の形）。
#   - Λ̌_ε := a·Π_μ exp(γ_μ(ε_μ − 1/2))（eigenvalues_of_V_plus の定義。a := (2s_2)^{M_col/2}、exp(γ_μ/2) := √(γ_1 + √(γ_1^2 − 1))、
#     γ_1 = γ_1(θ̃_μ) は _number_operators.sage の g1_AA）。
#   - Λ^{(1/2)}_{M_col} は def_Lambda_delta_M の a·exp(½Σγ(θ^{(1/2)}_{M_col,μ}))を、角 θ^{(1/2)}_{M_col,μ} = 2π(μ − 1/2)/M_col（def_Theta_delta_M）から
#     _prelude.sage の gamma_exp_independent で結合定数と 1 の冪根から直接作る（g1_AA とは独立な経路）。
# 確かめること:
#   上流の主張（前提）: eigenvalues_of_V_plus (1) の V^(+)Q̌_ε = Q̌_εV^(+) = Λ̌_εQ̌_ε（全 ε）、gamma_theta_tilde_mu_positive の γ_μ > 0（exp(γ_μ) > 1）、
#     check_joint_eigenspace_decomposition (1)(2)(4) の Q̌_ε^2 = Q̌_ε、Σ_εQ̌_ε = I、rank Q̌_ε = 1。
#   (1) 角の行（θ̃_μ/π = (2μ − 1)/M_col と θ^{(1/2)}_{M_col,μ}/π = 2(μ − 1/2)/M_col が QQ で一致）、Λ̌_max := Λ̌_{(1,…,1)} = Λ^{(1/2)}_{M_col}（AA）。
#   (2) ε ≠ (1,…,1) で、ǧ(1,…,1) − ǧ(ε) の鎖の exp を取った値 exp(ǧ(1,…,1) − ǧ(ε)) = Π_μ exp(a_μ) ≥ exp(a_{μ_0}) = exp(γ_{μ_0}) > 1、
#       Λ̌_ε の鎖の両端 Λ̌_ε = a·exp(ǧ(ε)) < a·exp(ǧ(1,…,1)) = Λ̌_max（AA。ℝ の exp の値は全て代数的数）。
#   (3) {x | V^(+)x = Λ̌_max x} の次元が 1（V^(+) − Λ̌_max I の核を E_1 で。Λ̌_max は E_1 の元 lE[(1,…,1)] として持つ）、その基底 v が im Q̌_{(1,…,1)} に入る（Q̌v = v）、
#       rank Q̌_{(1,…,1)} = 1（二つの空間の一致）。固有方程式に左から Q̌_{ε'} を掛ける 5 行、d の鎖 4 行、割り算の鎖 5 行、項を消す 4 行、
#       逆向きの Q̌y = y の 8 行と V^(+)y = Λ̌_max y の 6 行を、x := v、y := Q̌z（z は有理数の列）で括弧どおりに一行ずつ。
#   主張の読み: V^(+) の固有多項式（QQ）の根（AA）の最大が Λ̌_max で重複度 1、根の全体（重複込み）が {Λ̌_ε} に一致する。
# 否定コントロール: Λ^{(0)}_{M_col}（δ = 0）は Λ̌_max に一致しない。固有ベクトルでない x（有理数の列）では左から掛ける鎖の固有方程式の行が外れる。
#   im Q̌_{(1,…,1)} に入らない y では Q̌y = y の最後の行が外れる。(1,…,1) 以外には重複度 2 以上の固有値があり、重複度 1 の比較が外れる。
# ℝ への脱出は K_1・K_2 の選び方と γ を arccosh の実対数の式から作る一点だけで、以後の等号・不等号は全て厳密計算である。浮動小数点は使わない。
USE_CHECK_PSI = True
CHECK_PSI_MS = [2, 3]
load("../check_joint_eigenspace_decomposition/_number_operators.sage")
load("_prelude.sage")

n_eq = 0
n_ineq = 0
n_neg = 0


def chain(lines, what):
    global n_eq
    for k in range(len(lines) - 1):
        assert lines[k] == lines[k + 1], f"{what}: {k+1} 行目と {k+2} 行目"
        n_eq += 1


def to_qqbar_factory(s):
    """E_1 → QQbar（constant_c_value_even_sector の検算と同じ埋め込み）。"""
    emb, rA = s.embF, QQbar(s.r_AA)

    def f(e):
        if s.E is s.f.F:
            return emb(e)
        c = s.E(e).list()
        return emb(c[0]) + emb(c[1]) * rA
    assert f(s.r) == rA and s.r_AA > 0
    return f


for (x, y) in COUPLINGS:
    for M in CHECK_PSI_MS:
        x, y = QQ(x), QQ(y)
        tag = f"M_col={M}, (x,y)=({x},{y})"
        f = Factors(M, x, y)
        st = NumberOperatorSetting(f)
        s1 = st.S[1]
        F1 = s1.E
        maps = {}
        for m in st.J:
            s = st.S[m]
            if m == 1:
                maps[m] = lambda X: X
            elif s.E is st.f.F:
                maps[m] = lambda X, F1=F1: X.change_ring(F1)
            else:
                maps[m] = transport(s, s1)
        toq = to_qqbar_factory(s1)
        ns = [maps[m](st.dag[m]) * maps[m](st.psi_sig[m]) for m in st.J]
        n = 2**M
        Id = identity_matrix(F1, n)
        O_col = matrix(F1, n, 1, 0)
        epss = [tuple(e) for e in cartesian_product([[0, 1]] * M)]
        one = tuple([1] * M)

        def Qc(eps):
            Q = Id
            for mu in range(M):
                Q = Q * (ns[mu] if eps[mu] == 1 else Id - ns[mu])
            return Q
        Qs = {e: Qc(e) for e in epss}

        # V^(+)（def_V_plus）。exp(±X) は射影の y^λ、V_2 の成分は x^n なので成分は QQ
        B = exp_V1_half_exact(M, y, +1)
        V2q = V2_components_exact(M, x)
        assert all(z in QQ for z in V2q.list())
        VQ = (B * matrix(QQ, n, n, [QQ(z) for z in V2q.list()])) * B
        VE = VQ.change_ring(F1)
        a = prefactor_exact(M, x)
        # exp(γ_μ)・exp(γ_μ/2)（AA）
        eg = []
        for m in st.J:
            g = st.S[m].g1_AA
            eg.append(g + (g**2 - 1).sqrt())
        eh = [e.sqrt() for e in eg]

        def Lam(eps):
            w = AA(1)
            for mu in range(M):
                w = w * (eh[mu] if eps[mu] == 1 else 1 / eh[mu])     # exp(γ_μ(ε_μ − 1/2))
            return a * w
        Ls = {e: Lam(e) for e in epss}
        Lmax = Ls[one]                                               # eigenvalues_of_V_plus (2) の Λ̌_max = Λ̌_{(1,…,1)}

        # 前提。V^(+)Q̌_ε = Λ̌_εQ̌_ε の Λ̌_ε を、行列の計算を E_1 の中で行うために E_1 の元 lE[ε] として持つ:
        # Q̌_ε の 0 でない成分の比で lE[ε] を作り、V^(+)Q̌_ε = lE[ε]Q̌_ε・Q̌_εV^(+) = lE[ε]Q̌_ε を E_1 で全成分、
        # lE[ε] の QQbar での像が Λ̌_ε（AA）に等しいことを厳密に確かめる。以後の行列の鎖では Λ̌_ε を lE[ε] で掛ける。
        lE = {}
        for e in epss:
            Q = Qs[e]
            assert Q * Q == Q and Q.rank() == 1                      # check_joint_eigenspace_decomposition (1)(4)
            VQe = VE * Q
            k0, l0 = next((k, l) for k in range(n) for l in range(n) if Q[k, l] != 0)
            lam = VQe[k0, l0] / Q[k0, l0]
            assert VQe == lam * Q and Q * VE == lam * Q              # eigenvalues_of_V_plus (1)
            assert toq(lam) == QQbar(Ls[e])
            lE[e] = lam
            n_eq += 3
        assert fsum_left([Qs[e] for e in epss]) == Id                # check_joint_eigenspace_decomposition (2)
        assert all(e > 1 for e in eg)                                # gamma_theta_tilde_mu_positive（γ_μ > 0 ⇔ exp(γ_μ) > 1）

        # (1)
        for mu in range(1, M + 1):
            tt = QQ(2 * mu - 1) / M                                  # θ̃_μ/π（antiperiodic_exp_sum）
            th = 2 * (QQ(mu) - QQ(1) / 2) / M                        # θ^{(1/2)}_{M_col,μ}/π（def_Theta_delta_M）
            assert tt == th; n_eq += 1
        egh = [gamma_exp_independent(x, y, 2 * (QQ(mu) - QQ(1) / 2) / M) for mu in range(1, M + 1)]
        assert egh == eg; n_eq += 1                                  # 独立な経路の exp(γ) が g1_AA からの値に一致
        Lhalf = a * prod(e.sqrt() for e in egh)                      # def_Lambda_delta_M（δ → 1/2）: a·exp(½Σγ) = a·Π exp(γ_μ/2)
        chain([Lmax, a * prod(eh), Lhalf], f"{tag}: (1)")
        eg0 = [gamma_exp_independent(x, y, 2 * QQ(mu) / M) for mu in range(1, M + 1)]
        L0 = a * prod(e.sqrt() for e in eg0)                         # Λ^{(0)}_{M_col}
        assert L0 != Lmax; n_neg += 1

        # (2)
        for e in epss:
            if e == one:
                continue
            mu0 = next(mu for mu in range(M) if e[mu] == 0)
            expa = [eg[mu] if e[mu] == 0 else AA(1) for mu in range(M)]   # exp(a_μ) = exp(γ_μ(1 − ε_μ))
            lhs = Ls[one] / Ls[e]                                    # exp(ǧ(1,…,1) − ǧ(ε))
            chain([lhs, prod(expa)], f"{tag}: (2) exp(ǧ(1)−ǧ(ε)) = Πexp(a_μ)")
            assert prod(expa) >= expa[mu0] and eg[mu0] > 1; n_ineq += 2
            assert expa[mu0] == eg[mu0]                              # 構成上一致する（a_{μ_0} = γ_{μ_0}。件数に数えない）
            gch = prod(eh[mu] if e[mu] == 1 else 1 / eh[mu] for mu in range(M))   # exp(ǧ(ε))
            assert a > 0; n_ineq += 1                                # def_second_transfer_matrix_prefactor の (2s_2)^{M_col/2} ∈ ℝ_{>0}
            assert a * gch < a * prod(eh); n_ineq += 1               # Λ̌_ε の鎖の狭義不等号の行
            assert Ls[e] == a * gch and a * prod(eh) == Lmax         # 鎖の両端の定義の展開。同じ積から作るので構成上一致する（件数に数えない）

        # 主張の読み: 固有多項式の根（V^(+) は QQ の行列）
        cp = VQ.charpoly()
        mult = {}
        for (r, k) in cp.roots(AA):
            mult[r] = mult.get(r, 0) + k
        assert sum(mult.values()) == n
        expected = {}
        for e in epss:
            expected[Ls[e]] = expected.get(Ls[e], 0) + 1
        assert mult == expected; n_eq += 1
        rs = sorted(mult.keys())
        assert rs[-1] == Lmax and mult[Lmax] == 1; n_eq += 1
        # 否定コントロール: 単純性の比較 mult[Λ̌_max] == 1 が自明でないこと。θ̃_μ と θ̃_{M_col+1−μ} の γ が等しいので、
        # (1,…,1) 以外には重複度が 2 以上の固有値がある（同じ比較をそこへ当てると外れる）
        assert any(mult[Ls[e]] >= 2 for e in epss if e != one); n_neg += 1

        # (3) 固有空間（E_1 の中で）
        lm = lE[one]
        Kr = (VE - lm * Id).right_kernel()
        assert Kr.dimension() == 1; n_eq += 1
        xv = body_column(F1, list(Kr.basis()[0]))
        Q1 = Qs[one]
        assert Q1 * xv == xv and Q1.rank() == 1; n_eq += 2
        assert VE * xv == lm * xv
        for ep in epss:
            Q = Qs[ep]
            le = lE[ep]
            chain([le * (Q * xv), (le * Q) * xv, (Q * VE) * xv, Q * (VE * xv), Q * (lm * xv), lm * (Q * xv)],
                  f"{tag}: (3) 左から Q̌ を掛ける ε'={ep}")
            if ep == one:
                continue
            d = le - lm
            assert d != 0
            dinv = 1 / d
            chain([d * (Q * xv), (le - lm) * (Q * xv), le * (Q * xv) - lm * (Q * xv),
                   lm * (Q * xv) - lm * (Q * xv), O_col], f"{tag}: (3) d の鎖 ε'={ep}")
            chain([Q * xv, F1(1) * (Q * xv), (dinv * d) * (Q * xv), dinv * (d * (Q * xv)), dinv * O_col, O_col],
                  f"{tag}: (3) 割り算の鎖 ε'={ep}")
        terms = [Qs[e] * xv for e in epss]
        chain([xv, Id * xv, fsum_left([Qs[e] for e in epss]) * xv, fsum_left(terms), Q1 * xv], f"{tag}: (3) 項を消す")
        z = body_column(F1, [QQ(k + 1) / (k + 2) for k in range(n)])
        yv = Q1 * z
        chain([Q1 * yv, Q1 * (Q1 * z), (Q1 * Q1) * z, ((Id * Q1) * Q1) * z, ((Q1**0 * Q1) * Q1) * z,
               (Q1**1 * Q1) * z, (Q1**2) * z, Q1 * z, yv], f"{tag}: (3) Q̌y = y")
        chain([VE * yv, VE * (Q1 * yv), (VE * Q1) * yv, (lE[one] * Q1) * yv, (lm * Q1) * yv,
               lm * (Q1 * yv), lm * yv], f"{tag}: (3) V^(+)y = Λ̌_max y")
        # 否定コントロール
        assert VE * z != lm * z; n_neg += 1                          # 固有ベクトルでない列では固有方程式の行が外れる
        e0 = tuple([0] * M)
        assert Qs[e0] * (VE * z) != Qs[e0] * (lm * z); n_neg += 1   # 左から掛ける鎖の 4 行目→5 行目が外れる
        assert Q1 * z != z; n_neg += 1                               # im Q̌ に入らない z では Q̌y = y の最後の行が外れる
        print(f"{tag}: (1)(2)(3) と主張を E_1・QQbar・AA で厳密に確かめた（Λ̌_max = {Lmax.n(digits=12)}、2 番目の根 = {rs[-2].n(digits=12)}）", flush=True)

print(f"等号 {n_eq} 個、不等号 {n_ineq} 個、否定コントロール {n_neg} 件")
print("RESULT: PASS")
