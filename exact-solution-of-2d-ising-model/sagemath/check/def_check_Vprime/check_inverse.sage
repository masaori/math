# 対象ラベル: def_check_Vprime
# 証明 (2) の鎖を確かめる: -X̌ ∈ R、V̌' exp(-X̌) の 3 等号、exp(-X̌) V̌' の 2 等号、V̌' ∈ R^×、(V̌')^{-1} = exp(-X̌)、T_{(V̌')} の定義。
# 厳密（級数の段）: X̌ を r_λ・γ(θ~_λ) を不定元 ρ_λ・g_λ に置いた L 上の多項式環 P の成分で組み（全ての値について一度に）、
#   -X̌（def_matrix_negation の成分の式）、-(-X̌) = X̌（matrix_double_negation の行）を確かめる。
#   exp_of_negative_is_left_inverse の当てはめ（A → X̌ と A → -X̌）は、def_exp の部分和の積の k 次の部分
#   Σ_{a+b=k} (1/(a! b!)) (-A)^a A^b が k = 1..N で零行列、k = 0 で I になることを P の中で確かめる（冪は mat_mult の成分の式）。
# ℝ への脱出（exp の値）: γ(θ~_λ) = arccosh(γ_1) と r_λ = √(a_λ conj(a_λ)) を RealBallField(512) で囲み、X̌ を複素ボールの行列で組む。
#   exp(±X̌) は def_exp の部分和に尾の上界 s^{N+1}/(N+1)!/(1 - s/(N+2))（s は成分の 2 乗和の平方根の上界）を
#   半径として足したボールの行列で作り、Sage の ComplexBallField の行列の exp と重なることを見る。
#   等号の行はボールが重なること、I との等号は各成分のボールが δ_{ij} を含むことで見る。
# 対照: V̌' V̌' は I を含まない成分を持つ。級数の段で符号を取り違えた Σ_{a+b=k} A^a A^b / (a! b!) は k = 1 で零にならない。
# 範囲: 級数の段は M_col = 2（N = 8）と M_col = 3（N = 4）。ボールの段は結合定数 4 組 × M_col = 2..5。
load("_prelude.sage")

rep = Report("def_check_Vprime (2): V̌' ∈ R^× と (V̌')^{-1} = exp(-X̌)")


def build_X_exact(S, k):
    L = S.L; J = S.J; M = S.M; n = S.n
    P = PolynomialRing(L, [f"rho{l}" for l in J] + [f"g{l}" for l in J])
    rho = {l: P.gen(l - 1) for l in J}
    g = {l: P.gen(M + l - 1) for l in J}
    b = {l: S.gamma2(-1, l, k) for l in J}
    dag = {}; psi = {}
    for l in J:
        dag[l], psi[l] = fermi_pair(P, S, l, rho[l], b[l])
    halfI = body_scalar(P(QQ(1) / 2), body_identity(P, n))
    return P, body_finite_sum([body_scalar(g[mu], body_difference(body_product(dag[mu], psi[M + 1 - mu]), halfI)) for mu in J])


def series_left_inverse_ok(A, N, label):
    """def_exp の部分和どうしの積の k 次の部分: Σ_{a+b=k} (1/(a! b!)) (-A)^a A^b。k = 0 で I、k = 1..N で O。"""
    R = A.base_ring(); n = A.nrows()
    I_ = body_identity(R, n); O = matrix(R, n, n, 0)
    negA = body_negation(A)
    pw = [I_]; npw = [I_]
    for p in range(N):
        pw.append(body_product(pw[-1], A))
        npw.append(body_product(npw[-1], negA))
    ok = True
    for kdeg in range(N + 1):
        part = body_finite_sum([body_scalar(R(QQ(1) / (factorial(a) * factorial(kdeg - a))), body_product(npw[a], pw[kdeg - a]))
                                for a in range(kdeg + 1)])
        ok = ok and (part == (I_ if kdeg == 0 else O))
    rep.check(ok, label)
    # 対照: (-A) を A にすると k = 1 の部分は 2A ≠ O
    wrong = body_sum(body_product(I_, pw[1]), body_product(pw[1], I_))
    rep.check(wrong != O, "対照 " + label + ": 符号を取り違えると k = 1 の部分が O にならない", quiet=True)


# ---- 級数の段（厳密） ----
for M, N in [(2, 8), (3, 4)]:
    S = Setting(M)
    for kk in COUPLINGS[:2]:
        k = couplings(*kk)
        P, X = build_X_exact(S, k)
        negX = body_negation(X)
        rep.check(negX == -X and negX.dimensions() == X.dimensions(), f"-X̌ ∈ R（def_matrix_negation） M={M} {kk}")
        rep.check(body_negation(negX) == X, f"鎖 1 の第 2 行 -(-X̌) = X̌ M={M} {kk}")
        series_left_inverse_ok(X, N, f"鎖 2 の第 2 行 exp(-X̌)exp(X̌) の k ≤ {N} 次 M={M} {kk}")
        series_left_inverse_ok(negX, N, f"鎖 1 の第 3 行 exp(-(-X̌))exp(-X̌) の k ≤ {N} 次 M={M} {kk}")


# ---- ボールの段（ℝ への脱出） ----
def body_exp_ball_cb(A):
    n = A.nrows()
    s = sum((z.real()**2 + z.imag()**2) for z in A.list()).sqrt()
    s = RB(s.upper())
    N = 20
    while not (s < N + 2 and (s**(N + 1) / factorial(N + 1)) < RB(2)**(-300)):
        N += 10
    E = matrix(CB, n, n, 0); Pw = body_identity(CB, n)
    for p in range(N + 1):
        E = body_sum(E, body_scalar(CB(1) / factorial(p), Pw))
        if p < N:
            Pw = body_product(Pw, A)
    rad = (s**(N + 1) / factorial(N + 1) / (1 - s / (N + 2))).upper()
    return matrix(CB, n, n, lambda r, c: CB(E[r, c].real().add_error(rad), E[r, c].imag().add_error(rad)))


def contains_identity(A):
    n = A.nrows()
    return all(A[r, c].contains_exact(1 if r == c else 0) for r in range(n) for c in range(n))


for M in range(2, 6):
    S = Setting(M)
    J = S.J; n = S.n
    Zcb = {l: S.checkZ[l].apply_map(S.to_CB) for l in J}
    Ycb = {l: S.checkY[l].apply_map(S.to_CB) for l in J}
    sig = S.to_CB(S.s)
    Icb = body_identity(CB, n)
    for kk in COUPLINGS:
        k = couplings(*kk)
        a = {l: S.gamma2(+1, l, k) for l in J}
        b = {l: S.to_CB(S.gamma2(-1, l, k)) for l in J}
        r = {l: CB(RB(AA(S.emb(a[l] * a[l].conjugate()))).sqrt()) for l in J}
        gam = {}
        for l in J:
            g1 = RB(AA(S.emb(S.gamma1(l, k))))
            gam[l] = CB((g1 + (g1**2 - 1).sqrt()).log())
        dag = {l: body_sum(body_scalar(-r[l] / (2 * sig * b[l]), Zcb[l]), body_scalar(1 / (2 * sig), Ycb[l])) for l in J}
        psi = {l: body_sum(body_scalar(r[l] / (2 * sig * b[l]), Zcb[l]), body_scalar(1 / (2 * sig), Ycb[l])) for l in J}
        halfI = body_scalar(CB(1) / 2, Icb)
        X = body_finite_sum([body_scalar(gam[mu], body_difference(body_product(dag[mu], psi[M + 1 - mu]), halfI)) for mu in J])
        negX = body_negation(X)
        Vp = body_exp_ball_cb(X)                    # V̌' := exp(X̌)
        Em = body_exp_ball_cb(negX)                 # exp(-X̌)
        Edn = body_exp_ball_cb(body_negation(negX)) # exp(-(-X̌))
        tag = f"M={M} {kk}"
        rep.check(balls_overlap(Vp, X.exp()) and balls_overlap(Em, negX.exp()), f"exp の部分和のボールと Sage の exp が重なる {tag}", quiet=True)
        # 鎖 1: V̌' exp(-X̌) = exp(X̌)exp(-X̌) = exp(-(-X̌))exp(-X̌) = I
        L1 = body_product(Vp, Em); L2 = body_product(Edn, Em)
        rep.check(balls_overlap(L1, L2), f"鎖 1 の第 2 行 {tag}", quiet=True)
        rep.check(contains_identity(L2) and contains_identity(L1), f"鎖 1 の第 3 行（I を含む） {tag}", quiet=True)
        # 鎖 2: exp(-X̌) V̌' = exp(-X̌)exp(X̌) = I
        R1 = body_product(Em, Vp)
        rep.check(contains_identity(R1), f"鎖 2 の第 2 行（I を含む） {tag}", quiet=True)
        # V̌' ∈ R^×、(V̌')^{-1} = exp(-X̌): Sage の逆行列（独立な経路）が exp(-X̌) と重なる
        Vinv = Vp.inverse()
        rep.check(balls_overlap(Vinv, Em), f"(V̌')^{{-1}} = exp(-X̌) {tag}", quiet=True)
        # T_{(V̌')}(W) = V̌' W (V̌')^{-1} の値（W = Ž_1, Y̌_1）
        for W in [Zcb[1], Ycb[1]]:
            rep.check(balls_overlap(body_product(body_product(Vp, W), Em), Vp * W * Vinv), f"T_(V̌') の値 {tag}", quiet=True)
        # 対照: V̌' V̌' は I を含まない成分を持つ
        rep.check(not contains_identity(body_product(Vp, Vp)), f"対照 V̌'V̌' ≠ I {tag}", quiet=True)
        rep.check(max(abs(z).upper() for z in X.list()) > 1e-3, f"X̌ は零から離れている {tag}", quiet=True)
    print(f"M={M}: 結合定数 4 組で済み")

rep.finish()
