# 対象ラベル: trace_of_epsilon_V_plus_via_check_eigenvalues（Step 3 の 7 行の鎖と Step 5 の 8 行の鎖）
# Step 3（各 ϵ）:
#   η_ϵ(Λ̌_ϵ)_C = (η_{(1,…,1)}(−1_C)^{M−|ϵ|})(Λ̌_ϵ)_C           (epsilon_eigenvalue_on_check_Q (3))
#              = (η_{(1,…,1)}(Π_μ ǔ^{(ϵ_μ)})_C)(Λ̌_ϵ)_C         (Step 2 の k = M を右辺から左辺へ)
#              = (ȟ_C(Π_μ ǔ^{(ϵ_μ)})_C)(Λ̌_ϵ)_C                (ȟ の取り方)
#              = (ȟΠ_μ ǔ^{(ϵ_μ)})_C(Λ̌_ϵ)_C                     (real_inclusion_preserves_product)
#              = ((ȟΠ_μ ǔ^{(ϵ_μ)})Λ̌_ϵ)_C                      (real_inclusion_preserves_product)
#              = (((Π_μ ǔ^{(ϵ_μ)})Λ̌_ϵ)ȟ)_C                    (ℝ で (ab)c = (bc)a)
#              = (ť_ϵȟ)_C                                     (ť_ϵ の置き方)
# Step 5:
#   tr(εV) = Σ_ϵ η_ϵ(Λ̌_ϵ)_C = Σ_ϵ(ť_ϵȟ)_C = (Σ_ϵ ť_ϵȟ)_C = ((Σ_ϵ ť_ϵ)ȟ)_C = (ϰȟ)_C = (ȟϰ)_C = ȟ_Cϰ_C = η_{(1,…,1)}ϰ_C
# 二つの部で確かめる。
#   厳密な部: η_ϵ は本文の ψ̌ と ε から作った値（_prelude.sage の EpsilonSetting。E_1 の元で、±1 であることも確かめる）。
#     実数の量は E_1 上のローラン多項式環 R := E_1[C^{±1}, a_1^{±1}, …] に置き（C ↔ (2sinh 2K_2)^{M/2}、a_μ ↔ exp(γ(θ̃_μ)/2)、
#     Λ̌_ϵ = C·Π_μ a_μ^{2ϵ_μ−1}、2sinh(γ(θ̃_μ)/2) = a_μ − a_μ^{-1}、ϰ = C·Π_μ(a_μ − a_μ^{-1})）、包含は R の元をそのまま ℂ 側の環 R の元とする。
#     この部は行の並びの代数（どの因子をどこへ動かしたか、Step 2 の値を入れたか）を確かめ、包含が積と和を保つ行は自明に通る。
#   球の部: 包含の行を値で確かめるため（Step 3 の 7 行と Step 5 の 8 行）、ℂ を ComplexBallField(512)、包含を r ↦ r + 0i とし、C = (√(2sinh 2K_2))^{M}（def_second_transfer_matrix_prefactor）、
#     γ(θ̃_μ) の球（def_gamma_theta・def_arccosh。ℝ への脱出: 実対数・cos・cosh・sinh・tanh の値）で、Step 3 の 7 行（全ての ϵ）と Step 5 の 8 行を組んで隣どうしが重なることを見る。
#     和は def_sum_over_binary_words_of_complex_numbers・_of_real_numbers の帰納法どおりに組む。
# 範囲: 結合定数 3 組 × M_col = 2, 3。
load("_prelude.sage")

count = 0
ball_count = 0
negatives = 0
for st in trace_settings([2, 3]):
    M = st.M
    R = LaurentPolynomialRing(st.F, ["C"] + ["a%d" % mu for mu in range(1, M + 1)])
    C, a = R.gens()[0], R.gens()[1:]
    top = tuple([1] * M)
    eta = {w: R(st.eta[w]) for w in st.words}
    eta1 = eta[top]
    assert eta1 in (R(1), R(-1))
    h = 1 if eta1 == R(1) else -1                                   # ȟ ∈ {1, −1}、ȟ_C = η_{(1,…,1)}
    assert R(h) == eta1
    Lam = lambda w: C * prod(a[mu] ** (2 * w[mu] - 1) for mu in range(M))
    U = lambda w: left_product([u_sign(e) for e in w])               # Π_μ ǔ^{(ϵ_μ)}
    t = lambda w: U(w) * Lam(w)                                       # ť_ϵ
    kappa = C * left_product([a[mu] - a[mu] ** -1 for mu in range(M)])
    for w in st.words:
        lines = [
            eta[w] * Lam(w),
            (eta1 * R(-1) ** (M - sum(w))) * Lam(w),
            (eta1 * R(U(w))) * Lam(w),
            (R(h) * R(U(w))) * Lam(w),
            R(h * U(w)) * Lam(w),
            (R(h * U(w)) * Lam(w)),
            (R(U(w)) * Lam(w)) * R(h),
            t(w) * R(h),
        ]
        for x, y in zip(lines, lines[1:]):
            assert x == y, (st.tag, w)
            count += 1
    # Step 4 の結論 Σ_ϵ ť_ϵ = ϰ（a の形）を前提として確かめる（値での確認は check_step4_*.sage）
    assert binary_word_sum(M, t) == kappa, st.tag
    lines5 = [
        binary_word_sum(M, lambda w: eta[w] * Lam(w)),
        binary_word_sum(M, lambda w: t(w) * R(h)),
        binary_word_sum(M, lambda w: t(w) * R(h)),
        binary_word_sum(M, t) * R(h),
        kappa * R(h),
        R(h) * kappa,
        R(h) * kappa,
        eta1 * kappa,
    ]
    for x, y in zip(lines5, lines5[1:]):
        assert x == y, st.tag
        count += 1
    # 否定コントロール: Step 3 の 2 行目で指数を |ϵ| にすると（M_col が奇数のとき）外れる ϵ がある
    if M % 2 == 1:
        assert any(eta[w] * Lam(w) != (eta1 * R(-1) ** sum(w)) * Lam(w) for w in st.words)
        negatives += 1
    # 否定コントロール: ȟ を −η_{(1,…,1)} に取り違えると最後の行と外れる
    assert lines5[0] != R(-h) * kappa
    negatives += 1

    # 球の部（Step 5 の包含の行を値で）
    Cb = (2 * (2 * st.K2).sinh()).sqrt() ** M
    ab = [(g / 2).exp() for g in st.gam]
    Lb = lambda w: Cb * ((left_product([st.gam[mu] * (RB(w[mu]) - RB(1) / 2) for mu in range(M)], lambda x, y: x + y)).exp())
    tb = lambda w: RB(U(w)) * Lb(w)
    kb = Cb * left_product([2 * (g / 2).sinh() for g in st.gam])
    inc = lambda r: CB(r)
    etab = {w: CB(st.to_cb(st.eta[w])) for w in st.words}
    b5 = [
        binary_word_sum(M, lambda w: etab[w] * inc(Lb(w))),
        binary_word_sum(M, lambda w: inc(tb(w) * RB(h))),
        inc(binary_word_sum(M, lambda w: tb(w) * RB(h))),
        inc(binary_word_sum(M, tb) * RB(h)),
        inc(kb * RB(h)),
        inc(RB(h) * kb),
        inc(RB(h)) * inc(kb),
        etab[top] * inc(kb),
    ]
    for x, y in zip(b5, b5[1:]):
        assert x.overlaps(y) and max(x.real().rad(), x.imag().rad()) < 1e-100 and max(y.real().rad(), y.imag().rad()) < 1e-100, st.tag
        ball_count += 1
    # 球の部（Step 3 の 7 行を値で。包含 r ↦ r + 0i を通すので、real_inclusion_preserves_product の 2 行が値として試される）
    for w in st.words:
        b3 = [
            etab[w] * inc(Lb(w)),
            (etab[top] * CB(-1) ** (M - sum(w))) * inc(Lb(w)),
            (etab[top] * inc(RB(U(w)))) * inc(Lb(w)),
            (inc(RB(h)) * inc(RB(U(w)))) * inc(Lb(w)),
            inc(RB(h) * RB(U(w))) * inc(Lb(w)),
            inc((RB(h) * RB(U(w))) * Lb(w)),
            inc((RB(U(w)) * Lb(w)) * RB(h)),
            inc(tb(w) * RB(h)),
        ]
        for x, y in zip(b3, b3[1:]):
            assert x.overlaps(y) and max(x.real().rad(), x.imag().rad()) < 1e-100 and max(y.real().rad(), y.imag().rad()) < 1e-100, (st.tag, w)
            ball_count += 1
        assert b3[-1].imag().contains_zero() and b3[0].imag().contains_zero()
    # 否定コントロール（球）: Step 3 の 2 行目の指数を |ϵ| にすると（M_col が奇数のとき）重ならない ϵ がある
    if M % 2 == 1:
        assert any(not (etab[w] * inc(Lb(w))).overlaps((etab[top] * CB(-1) ** sum(w)) * inc(Lb(w))) for w in st.words)
        negatives += 1
    # 否定コントロール: ϰ の sinh を cosh にすると 5 行目と重ならない
    assert not inc(Cb * left_product([2 * (g / 2).cosh() for g in st.gam]) * RB(h)).overlaps(b5[4])
    negatives += 1
    print(f"  {st.tag}: 厳密 {count} 段、球 {ball_count} 段まで", flush=True)
print(f"checked {count} exact lines, {ball_count} ball lines")
print(f"negative controls: {negatives}")
print("RESULT: PASS")
