# 対象ラベル: constant_c_value_even_sector（準備の c^{-1}・t・r、Step 3 の二つの積の鎖と二つのトレースの鎖、Step 4 の三つの鎖、
#   Step 5 の三つの鎖と ρ = a、主張）
# 本文の ψ̌（def_check_fermi の式どおりの行列）から ň_μ := ψ̌_μ^†ψ̌_{M_col+1−μ}（def_check_number_operator）を作り
# （check_joint_eigenspace_decomposition/_number_operators.sage の本物の ψ̌ の設定。数体 E_1）、
#   V̌' := exp(X̌) = Σ_ε exp(Σ_μ γ_μ(ε_μ − 1/2)) Q̌_ε、(V̌')^{-1} = Σ_ε exp(−Σ_μ γ_μ(ε_μ − 1/2)) Q̌_ε
# （Q̌_ε := Π_μ R_μ^{(ε_μ)}、R^{(1)} := ň、R^{(0)} := I − ň。eigenvalues_of_check_Vprime・eigenvalues_of_inverse_of_check_Vprime の主張の形）で作る。
# γ_μ := γ(θ̃_μ) は exp(γ_μ) = g + √(g^2 − 1)（g := γ_1(θ̃_μ) ∈ AA、def_gamma_theta・def_arccosh）、exp(γ_μ/2) := √(exp(γ_μ)) として AA で厳密に持つ。
# V^(+) は同じ数体の V^(+) := (exp(X)V_2)exp(X)（def_V_plus）。c は V^(+) = cV̌' を満たす数として、V̌' の 0 でない成分の比で作り、
# 全成分で V^(+) = cV̌' を確かめてから使う（V_plus_eq_c_check_Vprime の c。主張 c = a を前提にしない）。
# τ・τ' は check_steps1_2_exact.sage と同じ作り方（射影の y^λ・(√t)^{-λ}）で同じ (x, y) について作る。
# 結合定数は (x, y) ∈ {(2, 2), (3, 3/2), (5/4, 3)}（K_2 = log x、K_1 = 2 log y）、M_col = 2, 3。成分は QQbar・AA（厳密）。
# ℝ への脱出は K_1・K_2 の選び方と、γ_μ を arccosh の実対数の式から作る一点だけで、以後の等号は全て厳密計算である。
USE_CHECK_PSI = True
CHECK_PSI_MS = [2, 3]
load("../check_joint_eigenspace_decomposition/_number_operators.sage")
load("_prelude.sage")

n_eq = 0
n_neg = 0


def rpow(a, m):
    """def_power_of_real_number: a^0 := 1、a^{m+1} := a^m a（Sage の ** は使わない）。"""
    p = a.parent()(1)
    for _ in range(m):
        p = p * a
    return p


def cpow(z, m):
    """def_power_of_complex_number: z^0 := 1_C、z^{m+1} := z^m z（Sage の ** は使わない）。"""
    p = QQbar(1)
    for _ in range(m):
        p = p * z
    return p


def chain(lines, what):
    global n_eq
    for k in range(len(lines) - 1):
        assert lines[k] == lines[k + 1], f"{what}: {k+1} 行目と {k+2} 行目"
        n_eq += 1


def to_qqbar_factory(s):
    """E_1 → QQbar（to_cb_factory と同じ埋め込み。E = F(R) の元 c_0 + c_1R は emb(c_0) + emb(c_1) r_1）。"""
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
        ns = [maps[m](st.dag[m]) * maps[m](st.psi_sig[m]) for m in st.J]
        toq = to_qqbar_factory(s1)
        q = lambda A: matrix(QQbar, A.nrows(), A.ncols(), [toq(z) for z in A.list()])
        nsq = [q(nm) for nm in ns]
        n = f.n
        Id = body_identity(QQbar, n)
        # γ_μ の exp（AA）
        eh = []
        for m in st.J:
            g = st.S[m].g1_AA
            assert g >= 1
            eg = g + (g**2 - 1).sqrt()
            eh.append(eg.sqrt())                       # exp(γ_μ/2)
        # V̌' と (V̌')^{-1}
        Vc = matrix(QQbar, n, n, 0)
        Vci = matrix(QQbar, n, n, 0)
        for eps in cartesian_product([[0, 1]] * M):
            Q = Id
            w = AA(1)
            for mu in range(M):
                Q = body_product(Q, nsq[mu] if eps[mu] == 1 else Id - nsq[mu])
                w = w * (eh[mu] if eps[mu] == 1 else 1 / eh[mu])   # exp(γ_μ(ε_μ − 1/2))
            Vc = Vc + QQbar(w) * Q
            Vci = Vci + QQbar(1 / w) * Q
        assert body_product(Vc, Vci) == Id and body_product(Vci, Vc) == Id   # def_check_Vprime (2)
        # V^(+)（def_V_plus）。check_steps1_2_exact.sage の作り方（AA）とも一致することを見る
        Vp = q(body_product(body_product(f.expX.change_ring(F1), f.V2.change_ring(F1)), f.expX.change_ring(F1)))
        B = exp_V1_half_exact(M, y, +1).change_ring(AA)
        assert Vp == to_qqbar_matrix(body_product(body_product(B, V2_components_exact(M, x)), B))
        Vpinv = Vp.inverse()
        # c: V^(+) = cV̌'（V_plus_eq_c_check_Vprime）
        k0, l0 = next((k, l) for k in range(n) for l in range(n) if Vc[k, l] != 0)
        c = Vp[k0, l0] / Vc[k0, l0]
        assert c != 0 and Vp == body_scalar(c, Vc)
        n_eq += 1
        cinv = 1 / c
        assert c * cinv == 1
        # 準備: t、r、a
        t = prod(e + 1 / e for e in eh)                 # Π_μ 2cosh(γ_μ/2) = Π_μ (exp(γ_μ/2) + exp(−γ_μ/2))（def_cosh_sinh）
        assert t > 0
        assert trace_body(Vc) == QQbar(t) and trace_body(Vci) == QQbar(t)    # trace_of_check_Vprime
        trV = trace_body(Vp)
        assert trV.imag() == 0 and AA(trV.real()) > 0                       # trace_V_plus_is_positive
        r = AA(trV.real())
        a = prefactor_exact(M, x)
        assert QQbar(a) == toq(F1(f.a))
        ainv = 1 / a
        tq = QQbar(t)
        # τ と τ'
        N1 = iH1_plus_integer_matrix(M)
        N2 = iH2_integer_matrix(M)
        ES1 = to_qqbar_matrix(exp_of_log_multiple(2 * N1, y, QQ))
        EmS1 = to_qqbar_matrix(exp_of_log_multiple(-2 * N1, y, QQ))
        rt = AA(f.t).sqrt()
        Ap = to_qqbar_matrix(exp_by_spectral_projectors(N2, lambda lam: rt ** (-lam), AA))
        Am = to_qqbar_matrix(exp_by_spectral_projectors(-N2, lambda lam: rt ** (-lam), AA))
        tau = trace_body(body_product(ES1, Ap))
        taup = trace_body(body_product(EmS1, Am))
        assert trV == QQbar(a) * tau and trace_body(Vpinv) == QQbar(ainv) * taup and taup == tau   # Step 1・Step 2 の結論
        # Step 3: W := c^{-1}(V̌')^{-1} と二つの積
        W = body_scalar(cinv, Vci)
        cV = body_scalar(c, Vc)
        chain([body_product(Vp, W), body_product(cV, W),
               body_scalar(c, body_product(Vc, W)),
               body_scalar(c, body_scalar(cinv, body_product(Vc, Vci))),
               body_scalar(c * cinv, body_product(Vc, Vci)),
               body_scalar(QQbar(1), body_product(Vc, Vci)),
               body_scalar(QQbar(1), Id), Id], f"M={M}, (x,y)=({x},{y}): Step 3 V^(+)W")
        chain([body_product(W, Vp), body_product(W, cV),
               body_scalar(cinv, body_product(Vci, cV)),
               body_scalar(cinv, body_scalar(c, body_product(Vci, Vc))),
               body_scalar(cinv * c, body_product(Vci, Vc)),
               body_scalar(QQbar(1), body_product(Vci, Vc)),
               body_scalar(QQbar(1), Id), Id], f"M={M}, (x,y)=({x},{y}): Step 3 WV^(+)")
        assert Vpinv == W; n_eq += 1                    # 逆元の一意性（Sage の inverse と一致）
        chain([trV, trace_body(cV), c * trace_body(Vc), c * tq], f"M={M}: Step 3 tr(V^(+))")
        chain([trace_body(Vpinv), trace_body(W), cinv * trace_body(Vci), cinv * tq], f"M={M}: Step 3 tr((V^(+))^{{-1}})")
        # Step 4: w の鎖
        w = trace_body(Vpinv)
        aq, ainvq, rq = QQbar(a), QQbar(ainv), QQbar(r)
        chain([w, ainvq * taup, ainvq * tau, ainvq * (QQbar(1) * tau), ainvq * (QQbar(ainv * a) * tau),
               ainvq * ((ainvq * aq) * tau), ainvq * (ainvq * (aq * tau)), ainvq * (ainvq * trV),
               ainvq * (ainvq * rq), ainvq * QQbar(ainv * r), QQbar(ainv * (ainv * r))], f"M={M}: Step 4 w")
        qv = ainv * (ainv * r)
        assert qv > 0 and w != 0
        winv = 1 / w
        c2 = cpow(c, 2)
        a2 = rpow(a, 2)
        one = QQbar(1)
        chain([c2 * w, (cpow(c, 1) * c) * w, ((cpow(c, 0) * c) * c) * w, ((one * c) * c) * w, (c * c) * w,
               (c * c) * (cinv * tq), c * (c * (cinv * tq)), c * ((c * cinv) * tq), c * (QQbar(1) * tq),
               c * tq, trV, aq * tau, aq * (QQbar(1) * tau), aq * (QQbar(a * ainv) * tau),
               aq * ((aq * ainvq) * tau), aq * (aq * (ainvq * tau)), aq * (aq * (ainvq * taup)),
               aq * (aq * w), (aq * aq) * w, QQbar(a * a) * w, QQbar(a2) * w], f"M={M}: Step 4 c^2w")
        chain([c2, c2 * QQbar(1), c2 * (w * winv), (c2 * w) * winv, (QQbar(a2) * w) * winv,
               QQbar(a2) * (w * winv), QQbar(a2) * QQbar(1), QQbar(a2)], f"M={M}: Step 4 c^2")
        # Step 5
        tinv = 1 / t
        rho = r * tinv
        assert rho > 0
        chain([c, c * QQbar(1), c * QQbar(t * tinv), c * (tq * QQbar(tinv)), (c * tq) * QQbar(tinv),
               trV * QQbar(tinv), rq * QQbar(tinv), QQbar(r * tinv), QQbar(rho)], f"M={M}: Step 5 c = ρ_C")
        chain([QQbar(rho * rho), QQbar(rho) * QQbar(rho), c * c, (one * c) * c, (cpow(c, 0) * c) * c,
               cpow(c, 1) * c, c2, QQbar(a2), QQbar(a * a)], f"M={M}: Step 5 (ρρ, 0)")
        assert rho * rho == a * a; n_eq += 1            # (ρρ, 0) = (aa, 0) の成分ごとの等号
        chain([rpow(rho, 2), rho * rho, a * a, rpow(a, 2)], f"M={M}: Step 5 ρ^2 = a^2")
        assert rho == a                                 # positive_real_square_injective
        n_eq += 1
        s2 = f.s2
        chain([c, QQbar(rho), QQbar(a), QQbar(AA(2 * s2).sqrt() ** M)], f"M={M}: Step 5 c の値")
        chain([Vp, body_scalar(c, Vc), body_scalar(QQbar(a), Vc)], f"M={M}: 主張 V^(+) = a_C V̌'")
        # 否定コントロール
        assert Vp != body_scalar(-QQbar(a), Vc); n_neg += 1                 # 符号を負に取った c = −a は主張を満たさない
        assert cpow(-QQbar(a), 2) == QQbar(a2) and -a < 0                      # 参考（否定コントロールに数えない）: −a も c^2 = (a^2)_C を満たすので、Step 5 の符号の確定が要る
        assert QQbar(a) * tau != w; n_neg += 1                              # Step 4 の w の係数を a^{-1} から a に取り違えると w に一致しない
        Vbad = matrix(QQbar, n, n, 0)                                     # γ_μ を 2γ_μ にした V̌' では V^(+) の定数倍にならない
        for eps in cartesian_product([[0, 1]] * M):
            Q = Id; w2 = AA(1)
            for mu in range(M):
                Q = body_product(Q, nsq[mu] if eps[mu] == 1 else Id - nsq[mu])
                w2 = w2 * (eh[mu]**2 if eps[mu] == 1 else 1 / eh[mu]**2)
            Vbad = Vbad + QQbar(w2) * Q
        assert Vp != body_scalar(Vp[k0, l0] / Vbad[k0, l0], Vbad); n_neg += 1
        print(f"M_col = {M}, (x, y) = ({x}, {y}): Step 3〜5 と主張を QQbar で厳密に確かめた（c = a = {AA(a).n(digits=12)}）", flush=True)

print(f"等号 {n_eq} 個、否定コントロール {n_neg} 件")
print("RESULT: PASS")
