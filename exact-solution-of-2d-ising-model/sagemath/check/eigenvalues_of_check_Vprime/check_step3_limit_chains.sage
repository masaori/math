# 対象ラベル: eigenvalues_of_check_Vprime
# eigenvalues_of_check_Vprime の Step 3（V̌'Q̌_ε）と Step 3'（Q̌_εV̌'）の極限の鎖の行を確かめる。
# 模型の分岐（既定）は check_step3_partial_sum_chains.sage と同じ ň_μ・γ_μ（_vprime_settings.sage の chain_settings。
# Jordan–Wigner の n_μ := c_μ^T c_μ、Q̌_ε := Π_μ R_μ^{(ε_μ)}、X̌ := Σ_μ γ_μ(n_μ − ½I)、有理数 γ_μ、M = 2, 3、ε を全列挙）で、
# 以下の (0)〜(e) を RealField(256) で確かめる。
# (0) 1 行目 E_K → V̌': ‖E_K − V̌'‖ が K ≥ 5 で狭義に減り、K = 20 で 10^{-8} を下回る（RealField(256)）。
# (a) 「(1/k!)z = z/k! を各項へ」の行: 部分和 Σ_{k≤K}(1/k!)ǧ^k と Σ_{k≤K}ǧ^k/k! が QQ で等しい（厳密、K = 0..20）。
# (b) 前の行の鎖の両端: E_KQ̌_ε = Q̌_εE_K = (Σ_{k≤K}ǧ^k/k!)Q̌_ε（QQ で厳密、K = 0..20）。
# (c) 極限の行（ℝ への脱出。理由: 極限と exp の値。RealField(256) で評価する）:
#     ‖E_KQ̌_ε − V̌'Q̌_ε‖ ≤ ‖E_K − V̌'‖‖Q̌_ε‖（matrix_multiplication_continuity の評価）と、右からの形の同じ評価、
#     ‖c_KQ̌_ε − exp(ǧ)Q̌_ε‖ = |c_K − exp(ǧ)|‖Q̌_ε‖（scalar_sequence_times_matrix_converges の 2 行目）、
#     |c_K − exp(ǧ)| が K = 60 で 10^{-40} を下回ること（scalar_exp_is_limit_of_partial_sums の極限）。
#     V̌' は X̌ が対角なので、対角成分の実数の exp で組む（部分和からは組まない。独立な経路）。
# (a) と (d) は、Sage の中ではほぼ恒等的に成り立つ比較であり、写し間違いの検出だけに効く。
# (d) 最後の行（complex_exp_of_real_argument）: ComplexField(256) の exp(ǧ + 0i) と実数の exp(ǧ) が一致する。
# (e) 鎖を直した理由の記録: 模型に ǧ(ε) < 0 の ε が在る（real_exp_series_converges は a ∈ ℝ_{≥0} だけを述べる）。
# 本文の ψ̌ の分岐（check_with_check_psi.sage から USE_CHECK_PSI = True で読み込んだとき）: ň_μ は本文の ψ̌ の ň_μ（数体 F の厳密な行列）、
# γ_μ は γ(θ̃_μ) の実際の値の球（_vprime_settings.sage の ball_settings。RealBallField(512)）。X̌ は対角でないので、
# V̌' は Sage の球の行列の exp（部分和を経ない。独立な経路）で作る。同じ (0)・(b)〜(e) を球で確かめる。
#   (0) は ‖E_K − V̌'‖ が K ≥ K_0 := max(5, ⌈‖X̌‖⌉) で狭義に減り、10^{-8} を下回るまで（K_max）続ける。
#   (b) は球の重なり（両辺の半径 < 10^{-100}）。(b) の厳密な等号は check_step3_partial_sum_chains.sage が本文の ψ̌ の ň_μ と有理数の γ_μ で K = 0..4 について確かめる。
#   (c) の不等号は、左辺の球の下端が右辺の球の上端を超えないこと（球の半径 < 10^{-100}）。(c) のスカラー倍の列の等号と (d) は、
#   球の重なりと両辺の半径 < 10^{-100}。
#   (a) は ň_μ を含まない数の恒等式なので、模型の分岐だけで確かめる。
RF = RealField(256)
CF = ComplexField(256)
load("_vprime_settings.sage")


def nrm(A):
    return sqrt(sum(RF(a) ** 2 for a in A.list()))


count = 0
neg_seen = False
if not USE_CHECK_PSI:
    for (tag, M, R, n, gammas) in chain_settings([2, 3]):
        Id = identity_matrix(QQ, 2 ** M)
        X = sum(gammas[mu] * (n[mu] - Id / 2) for mu in range(M))
        assert X.is_diagonal()
        Vp = diagonal_matrix(RF, [exp(RF(X[i, i])) for i in range(2 ** M)])
        for eps in cartesian_product([[0, 1]] * M):
            eps = [QQ(e) for e in eps]
            Q = joint_projector(n, eps, Id)
            g = sum(gammas[mu] * (eps[mu] - QQ(1) / 2) for mu in range(M))
            neg_seen = neg_seen or g < 0
            eg = exp(RF(g))
            QR = Q.change_ring(RF)
            prev_dE = None
            for K in range(21):
                E = sum((QQ(1) / factorial(k)) * X ** k for k in range(K + 1))
                c1 = sum((QQ(1) / factorial(k)) * g ** k for k in range(K + 1))
                c2 = sum(g ** k / factorial(k) for k in range(K + 1))
                assert c1 == c2                                          # (a)
                assert E * Q == c2 * Q and Q * E == c2 * Q               # (b)
                ER = E.change_ring(RF)
                dE = nrm(ER - Vp)
                if K >= 5:
                    assert dE < prev_dE                                  # 1 行目: ‖E_K − V̌'‖ が減る
                prev_dE = dE
                assert nrm(ER * QR - Vp * QR) <= dE * nrm(QR) * (1 + RF(2) ** -200) + RF(2) ** -200   # (c) 左の因子が動く形
                assert nrm(QR * ER - QR * Vp) <= nrm(QR) * dE * (1 + RF(2) ** -200) + RF(2) ** -200   # (c) 右の因子が動く形
                lhs = nrm(RF(c2) * QR - eg * QR)
                rhs = abs(RF(c2) - eg) * nrm(QR)
                assert abs(lhs - rhs) <= RF(2) ** -200 * (1 + rhs)       # (c) スカラー倍の列の評価
                count += 4
            assert prev_dE < RF(10) ** -8                                # 1 行目: K = 20 で ‖E_K − V̌'‖ < 10^{-8}
            c60 = sum(RF(g) ** k / factorial(k) for k in range(61))
            assert abs(c60 - eg) < RF(10) ** -40                         # (c) 数の exp の部分和の極限
            assert nrm(Vp * QR - eg * QR) < RF(10) ** -60 and nrm(QR * Vp - eg * QR) < RF(10) ** -60   # 主張の両辺（独立な経路）
            assert abs(exp(CF(g, 0)) - CF(eg, 0)) < RF(10) ** -70        # (d)
            count += 3
    assert neg_seen                                                       # (e)
    print(f"checked {count} relations (model M = 2, 3 with all eps, K = 0..20); a model eps with gcheck(eps) < 0 exists")
else:
    tiny = RBv(10) ** -100
    for (tag, M, F, ns, gams, to_cb, g1s) in ball_settings([2, 3]):
        N = 2 ** M
        IdF = identity_matrix(F, N)
        IdC = identity_matrix(CBv, N)
        nC = [mat_to_cb(A, to_cb) for A in ns]
        X = sum(CBv(gams[mu]) * (nC[mu] - IdC / 2) for mu in range(M))
        Vp = X.exp()                                                      # V̌' = exp(X̌)（Sage の exp。部分和を経ない）
        sX = frobenius_norm_ball(X).upper()
        K0 = max(5, ceil(sX))
        Es, P, E = [], IdC, matrix(CBv, N, N, 0)
        dEs = []
        K = 0
        while True:
            E = E + (CBv(1) / factorial(K)) * P                            # E_K = Σ_{k=0}^{K} (1/k!) X̌^k
            P = P * X
            Es.append(E)
            dEs.append(frobenius_norm_ball(E - Vp))
            if K > K0 and dEs[-1] < RBv(10) ** -8:
                break
            K += 1
            assert K < 400
        for K in range(K0 + 1, len(Es)):
            assert dEs[K] < dEs[K - 1], (tag, K)                           # 1 行目: ‖E_K − V̌'‖ が K ≥ K_0 で狭義に減る
        Kmax = len(Es) - 1
        for eps in cartesian_product([[0, 1]] * M):
            Q = joint_projector(ns, eps, IdF)
            QC = mat_to_cb(Q, to_cb)
            nQ = frobenius_norm_ball(QC)
            g = gcheck_ball(gams, eps)
            neg_seen = neg_seen or g < 0
            eg = g.exp()
            for K in range(Kmax + 1):
                cK = sum(g ** k / factorial(k) for k in range(K + 1))
                EQ, QE, cQ = Es[K] * QC, QC * Es[K], CBv(cK) * QC
                assert balls_overlap_mat(EQ, cQ) and balls_overlap_mat(QE, cQ)               # (b)
                assert max(max_radius(EQ), max_radius(QE), max_radius(cQ)) < tiny
                l1 = frobenius_norm_ball(EQ - Vp * QC)
                l2 = frobenius_norm_ball(QE - QC * Vp)
                assert l1.lower() <= (dEs[K] * nQ).upper() and l2.lower() <= (nQ * dEs[K]).upper()   # (c) 左右の因子が動く形
                assert RBv(max(l1.rad(), l2.rad(), (dEs[K] * nQ).rad())) < tiny
                lhs = frobenius_norm_ball(cQ - CBv(eg) * QC)
                rhs = abs(cK - eg) * nQ
                assert lhs.overlaps(rhs) and RBv(max(lhs.rad(), rhs.rad())) < tiny                                   # (c) スカラー倍の列の評価
                count += 5
            Kc = 60
            while not (abs(sum(g ** k / factorial(k) for k in range(Kc + 1)) - eg) < RBv(10) ** -40):
                Kc += 20
                assert Kc < 400
            assert frobenius_norm_ball(Vp * QC - CBv(eg) * QC) < RBv(10) ** -60               # 主張の両辺（独立な経路）
            assert frobenius_norm_ball(QC * Vp - CBv(eg) * QC) < RBv(10) ** -60
            ce = CBv(g).exp()
            assert ce.overlaps(CBv(eg)) and RBv(max(ce.real().rad(), ce.imag().rad(), eg.rad())) < tiny   # (d)
            count += 3
        print(f"  {tag}: K_0 = {K0}, K_max = {Kmax}", flush=True)
    assert neg_seen                                                       # (e)
    print(f"checked {count} relations (check psi, M = 2, 3 with all eps); an eps with gcheck(eps) < 0 exists")
print("RESULT: PASS")
