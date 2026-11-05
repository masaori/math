# 対象ラベル: check_number_operator_is_hermitian
# 証明の (3)（(ψ̌_μ^†)^* = ψ̌_{M+1-μ}）と (4)（ň_μ^* = ň_μ、Q̌_ε^* = Q̌_ε、x^*Q̌_εx = ‖Q̌_εx‖^2 ≥ 0）の全ての鎖と、
# 主張の結びの式を、本文の ψ̌（def_check_fermi の式どおりの行列）で厳密に確かめる。
# ψ̌ は def_check_number_operator の検算の準備（../def_check_number_operator/_prelude.sage の NumberOperatorSetting）が作る:
#   K_1 = 2 log y、K_2 = log x と選び、Ž_μ・Y̌_μ・位相・γ_2(±θ̃_μ)・(√M_col)_C を一つの数体 F に、
#   ψ̌_μ^†・ψ̌_μ を E_μ := F(r_μ)（r_μ := |γ_2(θ̃_μ)|、R^2 = γ_2(θ̃_μ)conj(γ_2(θ̃_μ))）に置き、ψ̌_{σ(μ)}（σ(μ) := M_col+1-μ）を
#   E_μ へ移す（R ↦ R。r_{σ(μ)} = r_μ を確かめてから）。
# 複素共役: F の自己同型のうち、F → QQbar の埋め込み emb（embedding_to_qqbar）について emb∘c = conj∘emb となるもの c_F を選ぶ
#（F の生成元で確かめる）。E_μ = F(R) では R^2 ∈ F が c_F で動かないことを確かめ、c(c_0 + c_1R) := c_F(c_0) + c_F(c_1)R と延ばす
#（R ↦ +r_μ の埋め込みで本物の複素共役であることを R と F の生成元で確かめる）。
# (4) の Q̌_ε の鎖は全ての μ の ň_μ を一つの体 E_1 に移して行う（移し方は check_joint_eigenspace_decomposition/_number_operators.sage と同じ）。
# 範囲: 結合定数 3 組 × M_col = 2, 3（引数で M_col を絞れる）× μ ∈ M̌ の全て × ε ∈ {0,1}^{M̌} の全て。
# 帰属: 成分はすべて数体 F・E_μ の元（厳密計算。浮動小数点は使わない）。x^*Q̌_εx ≥ 0 は値を QQbar へ移して AA の元として判定する。
load("../def_check_number_operator/_prelude.sage")
load("../../_shared/matrix_negation_and_difference_by_definition.sage")
load("_conjugate_transpose.sage")

Ms = [int(a) for a in sys.argv[1:]] or [2, 3]
rep = Counter("check_number_operator_is_hermitian (3)(4): 本物の ψ̌ での (ψ̌_μ^†)^*・ň_μ^*・Q̌_ε^*・x^*Q̌_εx（厳密）")


def conj_on_F(f):
    F = f.F
    emb = embedding_to_qqbar(f)
    g = F.gen()
    cs = [c for c in F.automorphisms() if emb(c(g)) == emb(g).conjugate()]
    assert len(cs) == 1
    return cs[0], emb


def conj_and_emb_on(s, cF, emb):
    """E_μ（= F か F(R)）の複素共役と、R ↦ +r_μ の QQbar への埋め込み。"""
    F = s.f.F
    if s.E is F:
        return cF, emb
    E = s.E
    R = E.gen()
    n2 = R**2
    l2 = E(n2).list()
    assert l2[1] == 0 and cF(l2[0]) == l2[0]                       # R^2 ∈ F は c_F で動かない（実数）
    rA = QQbar(s.r_AA)

    def embE(e):
        l = E(e).list()
        return emb(l[0]) + emb(l[1]) * rA

    def cE(e):
        l = E(e).list()
        return E(cF(l[0])) + E(cF(l[1])) * R
    assert rA**2 == emb(l2[0]) and rA > 0                           # R ↦ +r_μ は R^2 = emb(R^2) を満たす（環準同型になる）
    assert embE(cE(R)) == embE(R).conjugate()
    assert embE(cE(E(F.gen()))) == embE(E(F.gen())).conjugate()
    return cE, embE


def prod_left(Fs):
    P = Fs[0]
    for X in Fs[1:]:
        P = body_product(P, X)
    return P


def scalar_transport(tr, v, E_from):
    return tr(matrix(E_from, 1, 1, [v]))[0, 0]


for (x, y) in COUPLINGS:
    for M in Ms:
        f = Factors(M, x, y)
        st = NumberOperatorSetting(f)
        cF, emb = conj_on_F(f)
        rep.eq(emb(cF(f.i)), QQbar(I).conjugate(), f"(x,y)=({x},{y}) M={M}: c_F(i) = -i")
        n = f.n
        nmu = {}
        transpose_differs = False
        for mu in st.J:
            tag = f"(x,y)=({x},{y}) M={M} μ={mu}"
            s = st.S[mu]
            nu_ = st.sigma[mu]
            t = st.S[nu_]
            E = s.E
            c, embE = conj_and_emb_on(s, cF, emb)
            star = lambda A, c=c: body_star(A, c)
            tr = transport(t, s)
            a, b, r, sg = E(s.a), E(s.b), s.r, s.sigma
            # 準備の値
            rep.eq(c(sg), sg, f"{tag}: (√M)_C は実数（c で動かない）")
            rep.truth(embE(sg) > 0 and embE(sg)**2 == M, f"{tag}: (√M)_C の値")
            rep.eq(c(r), r, f"{tag}: r は実数")
            rep.truth(AA(embE(r)) > 0 and embE(r) == QQbar(s.r_AA), f"{tag}: r = |γ_2(θ̃_μ)| > 0（gamma_2_theta_tilde_nonzero）")
            rep.eq(r * r, a * c(a), f"{tag}: r^2 = |γ_2(θ̃_μ)|^2 = γ_2(θ̃_μ)conj(γ_2(θ̃_μ))")
            rep.eq(b, -c(a), f"{tag}: relation_of_gamma_2_theta_tilde (1) γ_2(-θ̃_μ) = -conj(γ_2(θ̃_μ))")
            rep.eq(c(b), -a, f"{tag}: その複素共役 conj(γ_2(-θ̃_μ)) = -γ_2(θ̃_μ)")
            rep.eq(b * c(b), a * c(a), f"{tag}: |γ_2(-θ̃_μ)| = |γ_2(θ̃_μ)|（平方で）")
            a_nu = scalar_transport(tr, E_from=t.E, v=t.E(t.a))
            b_nu = scalar_transport(tr, E_from=t.E, v=t.E(t.b))
            r_nu = scalar_transport(tr, E_from=t.E, v=t.r)
            sg_nu = scalar_transport(tr, E_from=t.E, v=t.sigma)
            rep.eq(a_nu, b, f"{tag}: periodicity_of_check_fermi (3) γ_2(θ̃_ν) = γ_2(-θ̃_μ)")
            rep.eq(b_nu, a, f"{tag}: periodicity_of_check_fermi (3) γ_2(-θ̃_ν) = γ_2(θ̃_μ)")
            rep.eq(r_nu, r, f"{tag}: r = |γ_2(θ̃_ν)|")
            rep.eq(sg_nu, sg, f"{tag}: (√M)_C は ν でも同じ元")
            alpha = (-r) / (2 * sg * b)
            alpha_nu = (-r_nu) / (2 * sg_nu * b_nu)
            beta = 1 / (2 * sg)
            rep.eq(c(beta), beta, f"{tag}: β は実数")
            Zm, Ym = s.Z, s.Y
            Zn, Yn = tr(t.Z), tr(t.Y)
            dag = st.dag[mu]
            psi_nu = st.psi_sig[mu]
            rep.eq(dag, body_sum(body_scalar(alpha, Zm), body_scalar(beta, Ym)), f"{tag}: ψ̌_μ^† = α_μŽ_μ + βY̌_μ")
            rep.eq(psi_nu, body_sum(body_scalar(-alpha_nu, Zn), body_scalar(beta, Yn)), f"{tag}: ψ̌_ν = -α_νŽ_ν + βY̌_ν")
            # (2) を E_μ で（(3) の鎖が引く）
            rep.eq(star(Zm), Zn, f"{tag}: (2) Ž_μ^* = Ž_ν（E_μ で）")
            rep.eq(star(Ym), Yn, f"{tag}: (2) Y̌_μ^* = Y̌_ν（E_μ で）")
            # conj(α_μ) = -α_ν の 6 行
            rep.chain([
                ("conj(α_μ)", c(alpha)),
                ("conj(-r/(2√M γ_2(-θ̃_μ)))", c((-r) / (2 * sg * b))),
                ("-r/(2√M conj(γ_2(-θ̃_μ)))", (-r) / (2 * sg * c(b))),
                ("-r/(2√M(-γ_2(θ̃_μ)))", (-r) / (2 * sg * (-a))),
                ("r/(2√M γ_2(θ̃_μ))", r / (2 * sg * a)),
                ("r/(2√M γ_2(-θ̃_ν))", r / (2 * sg * b_nu)),
                ("-α_ν", -alpha_nu),
            ], f"{tag}: conj(α_μ) の鎖")
            # (ψ̌_μ^†)^* の 5 行
            rep.chain([
                ("(ψ̌_μ^†)^*", star(dag)),
                ("(α_μŽ_μ + βY̌_μ)^*", star(body_sum(body_scalar(alpha, Zm), body_scalar(beta, Ym)))),
                ("conj(α_μ)Ž_μ^* + conj(β)Y̌_μ^*", body_sum(body_scalar(c(alpha), star(Zm)), body_scalar(c(beta), star(Ym)))),
                ("conj(α_μ)Ž_ν + βY̌_ν", body_sum(body_scalar(c(alpha), Zn), body_scalar(beta, Yn))),
                ("-α_νŽ_ν + βY̌_ν", body_sum(body_scalar(-alpha_nu, Zn), body_scalar(beta, Yn))),
                ("ψ̌_ν", psi_nu),
            ], f"{tag}: (3) の鎖")
            # (4) の準備: (ψ̌_ν)^* = ψ̌_μ^†（(3) の転置共役と (X^*)^* = X）
            rep.eq(star(star(dag)), dag, f"{tag}: (X^*)^* = X（ψ̌_μ^†）")
            rep.eq(star(psi_nu), dag, f"{tag}: (ψ̌_ν)^* = ψ̌_μ^†")
            # ň_μ の 4 行
            nm = body_product(dag, psi_nu)                   # def_check_number_operator
            rep.chain([
                ("ň_μ^*", star(nm)),
                ("(ψ̌_μ^†ψ̌_ν)^*", star(body_product(dag, psi_nu))),
                ("(ψ̌_ν)^*(ψ̌_μ^†)^*", body_product(star(psi_nu), star(dag))),
                ("ψ̌_μ^†ψ̌_ν", body_product(dag, psi_nu)),
                ("ň_μ", nm),
            ], f"{tag}: (4) ň_μ の鎖")
            # 否定コントロール
            if nu_ != mu:
                rep.neq(star(dag), dag, f"{tag}: ψ̌_μ^† はエルミートでない")
                rep.neq(c(alpha), alpha_nu, f"{tag}: conj(α_μ) は α_ν でない（符号が要る）")
            transpose_differs = transpose_differs or (body_transpose(nm) != nm)
            nmu[mu] = nm
        rep.control(transpose_differs, f"(x,y)=({x},{y}) M={M}: ある ň_μ は転置だけ（複素共役なし）では動く（複素共役が要る）")
        # ---- Q̌_ε（全ての μ を E_1 へ移す）----
        s1 = st.S[1]
        E1 = s1.E
        c1, emb1 = conj_and_emb_on(s1, cF, emb)
        star1 = lambda A: body_star(A, c1)
        maps = {}
        for m in st.J:
            s = st.S[m]
            if m == 1:
                maps[m] = lambda X: X
            elif s.E is f.F:
                maps[m] = lambda X: X.change_ring(E1)
            else:
                assert m == st.sigma[1], (M, m)
                maps[m] = transport(s, s1)
        ns = {m: maps[m](nmu[m]) for m in st.J}
        Id = body_identity(E1, n)
        rep.eq(star1(Id), Id, f"(x,y)=({x},{y}) M={M}: I^* = I")
        for m in st.J:
            rep.eq(star1(ns[m]), ns[m], f"(x,y)=({x},{y}) M={M} μ={m}: ň_μ^* = ň_μ（E_1 で）")
            rep.eq(star1(body_difference(Id, ns[m])), body_difference(Id, ns[m]), f"(x,y)=({x},{y}) M={M} μ={m}: (I - ň_μ)^* = I - ň_μ")
        iE = E1(f.i)
        xs = [matrix(E1, n, 1, lambda k, _: 1 if k == 0 else 0),
              matrix(E1, n, 1, lambda k, _: 1),
              matrix(E1, n, 1, lambda k, _: (k + 1) + (k * k - 2) * iE),
              matrix(E1, n, 1, lambda k, _: s1.r * (k % 3) - iE * (k % 2) + 1 / (k + 2))]
        for eps in cartesian_product([[0, 1]] * M):
            tag = f"(x,y)=({x},{y}) M={M} ε={tuple(eps)}"
            R = [ns[m] if eps[m - 1] == 1 else body_difference(Id, ns[m]) for m in st.J]   # R_μ^(ε_μ)
            Q = prod_left(R)                                 # check_joint_eigenspace_decomposition の Q̌_ε
            rep.chain([
                ("Q̌_ε^*", star1(Q)),
                ("(R_1⋯R_M)^*", star1(prod_left(R))),
                ("(R_M)^*⋯(R_1)^*", prod_left([star1(X) for X in reversed(R)])),
                ("R_M⋯R_1", prod_left(list(reversed(R)))),
                ("R_1⋯R_M", prod_left(R)),
                ("Q̌_ε", Q),
            ], f"{tag}: (4) Q̌_ε の鎖")
            rep.eq(body_product(Q, Q), Q, f"{tag}: Q̌_ε^2 = Q̌_ε（check_joint_eigenspace_decomposition (1)）")
            nonzero_seen = False
            for xi, xv in enumerate(xs):
                w = body_product(Q, xv)                                    # w := Q̌_εx（mat_mult の行列と数ベクトルの積）
                Qs = star1(Q)
                xc = [c1(xv[k, 0]) for k in range(n)]
                rng = range(n)
                lines = [
                    ("x^*Q̌_εx", body_bilinear(xv, Q, xv, c1)),
                    ("x^*Q̌_ε^2x", body_bilinear(xv, body_product(Q, Q), xv, c1)),
                    ("x^*(Q̌_ε^*Q̌_ε)x", body_bilinear(xv, body_product(Qs, Q), xv, c1)),
                    ("Σ_kΣ_l conj(x_k)(Q̌^*Q̌)_kl x_l", sum(sum(xc[k] * body_product(Qs, Q)[k, l] * xv[l, 0] for l in rng) for k in rng)),
                    ("Σ_kΣ_l conj(x_k)(Σ_m conj(Q_mk)Q_ml) x_l",
                     sum(sum(xc[k] * sum(c1(Q[m, k]) * Q[m, l] for m in rng) * xv[l, 0] for l in rng) for k in rng)),
                    ("Σ_m (Σ_k conj(Q_mk)conj(x_k))(Σ_l Q_ml x_l)",
                     sum(sum(c1(Q[m, k]) * xc[k] for k in rng) * sum(Q[m, l] * xv[l, 0] for l in rng) for m in rng)),
                    ("Σ_m (Σ_k conj(Q_mk x_k))(Σ_l Q_ml x_l)",
                     sum(sum(c1(Q[m, k] * xv[k, 0]) for k in rng) * sum(Q[m, l] * xv[l, 0] for l in rng) for m in rng)),
                    ("Σ_m conj(Σ_k Q_mk x_k)(Σ_l Q_ml x_l)",
                     sum(c1(sum(Q[m, k] * xv[k, 0] for k in rng)) * sum(Q[m, l] * xv[l, 0] for l in rng) for m in rng)),
                    ("Σ_m conj(w_m)w_m", body_vector_star_times(w, w, c1)),
                ]
                rep.chain(lines, f"{tag} x{xi}: 結びの鎖（数体の中の等号）")
                v4 = lines[-1][1]
                # Σ_m conj(w_m)w_m = Σ_m (|w_m|^2)_C = (Σ_m |w_m|^2)_C = ((√Σ|w_m|^2)^2)_C = (‖w‖^2)_C ≥ 0。
                # 各 conj(w_m)w_m が実数（c で動かない）であることと和の一致は数体の中で、非負は値の符号として AA で判定する。
                # 値が 0 の項は数体の中で 0 と判定してから AA を使わない（AA で 0 を厳密に示すのは重いため）。
                # c が本物の複素共役であることは生成元で確かめてあり、体の自己同型なので全ての w_m で成り立つ。
                total = E1(0)
                for k in range(n):
                    zk = c1(w[k, 0]) * w[k, 0]
                    rep.eq(c1(zk), zk, f"{tag} x{xi} k={k}: conj(w_k)w_k は実数")
                    rep.truth(zk == 0 or AA(emb1(zk)) > 0, f"{tag} x{xi} k={k}: |w_k|^2 ≥ 0")
                    rep.truth((zk == 0) == (w[k, 0] == 0), f"{tag} x{xi} k={k}: |w_k|^2 = 0 と w_k = 0 は同値")
                    total = total + zk                                     # Σ_k |w_k|^2（左から足す）
                rep.eq(v4, total, f"{tag} x{xi}: Σ_m conj(w_m)w_m = (Σ_m |w_m|^2)_C")
                rep.truth(total == 0 or AA(emb1(total)) > 0, f"{tag} x{xi}: ‖Q̌_εx‖^2 = (√Σ_m|w_m|^2)^2 = Σ_m|w_m|^2 ≥ 0（Σ ≥ 0 なので平方根の平方は Σ）")
                vA = 0 if total == 0 else 1
                nonzero_seen = nonzero_seen or vA > 0
            rep.truth(nonzero_seen, f"{tag}: どれかの x で ‖Q̌_εx‖^2 > 0（等号が自明でない）")
        print(f"  (x,y)=({x},{y}) M={M}: 済（累計 等号 {rep.n_eq} 件）", flush=True)

# ---- 否定コントロール（QQ(i)）----
KGc = QuadraticField(-1, 'i'); ic = KGc.gen(); conjc = KGc.hom([-ic], KGc)
I4 = identity_matrix(KGc, 4)
sz1 = matrix(KGc, [[1, 0], [0, -1]]).tensor_product(identity_matrix(KGc, 2))
sx1 = matrix(KGc, [[0, 1], [1, 0]]).tensor_product(identity_matrix(KGc, 2))
P1, P2 = (I4 + sz1) / 2, (I4 + sx1) / 2                  # エルミートな冪等行列で可換でないもの
PP = P1 * P2
rep.eq(body_star(PP, conjc), P2 * P1, "対照: (P_1P_2)^* = P_2P_1")
rep.neq(body_star(PP, conjc), PP, "対照: 可換でないエルミートな冪等行列の積はエルミートでない（Q̌_ε の鎖の 4 行目に可換性が要る）")
Pn = matrix(KGc, [[1, 1], [0, 0]]).tensor_product(identity_matrix(KGc, 2))   # エルミートでない冪等行列
rep.eq(Pn * Pn, Pn, "対照: P' は冪等")
xc = matrix(KGc, 4, 1, [1, 0, ic, 0])
val = body_bilinear(xc, Pn, xc, conjc)
rep.neq(conjc(val), val, "対照: エルミートでない冪等行列 P' では x^*P'x が実数でない（Q̌_ε^* = Q̌_ε が要る）")

rep.finish()
