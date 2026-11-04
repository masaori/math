# 対象ラベル: max_eigenvector_in_even_sector（主張 (1) η_{(1,…,1)} = +1 と、証明の (1) の含意の鎖 3 行）
# 結合定数 K_1 := 2 log y、K_2 := log x（(x, y) ∈ COUPLINGS）、M_col = 2, 3 で、すべて厳密に（E_1・QQ・AA）確かめる。
#   1 行目: tr(εV^(+)) = r_ℂ かつ r ∈ ℝ_{>0}。tr(εV^(+)) は実際の V^(+)（def_V_plus）と ε を本文の積で掛け、def_trace の和で取る（E_1）。
#           r := (2exp(−K_2)cosh K_1)^M + (2exp(K_2)sinh K_1)^M は QQ（K の選び方で exp・cosh・sinh が有理数になる）。
#   2 行目: z > 0 の定め方（trace_of_epsilon_V_plus_via_check_eigenvalues）の「z = r_ℂ なる r ∈ ℝ_{>0} がある」を、証人 r で。
#   3 行目: η_{(1,…,1)} = +1。η は ψ̌ の側から epsilon_eigenvalue_on_check_Q の (1) の作り方で求めた値（V^(+) を使わない）。
#           引いた同値の当てはめ: 同じ設定で trace_of_epsilon_V_plus_via_check_eigenvalues (1) の tr(εV^(+)) = η_{(1,…,1)}ϰ_ℂ を、
#           ϰ := (2s_2)^{M/2}Π_μ 2sinh(γ(θ̃_μ)/2) を AA で作って確かめ（2sinh(γ/2) = exp(γ/2) − exp(γ/2)^{-1}、exp(γ) = γ_1 + √(γ_1^2 − 1)）、ϰ > 0。
#   独立の確認: tr(εV^(+)) = Σ_ϵ η_ϵΛ̌_ϵ（Λ̌_ϵ は V^(+)Q̌_ϵ = Λ̌_ϵQ̌_ϵ の比。ψ̌ の η と V^(+) の tr が同じ体の中で噛み合うこと）。
# 否定コントロール: r の和を差にしたもの、tr(V^(+))（ε を落としたもの）は tr(εV^(+)) に一致しない。η を −1 にした −ϰ は負で、tr(εV^(+)) に一致しない。
load("_prelude.sage")

Ms = [int(a) for a in sys.argv[1:]] or [2, 3]
rep = Report("max_eigenvector_in_even_sector (1): η_(1,…,1) = +1（厳密）")

for s in max_settings(Ms):
    M, F, x, y = s.M, s.F, s.x, s.y
    tag = s.tag
    T = body_trace(P_(s.E, s.V))                                   # tr(εV^(+))
    r = r_of(M, x, y)
    # 1 行目
    rep.check(r in QQ and r > 0, f"{tag}: r ∈ ℝ_{{>0}}")
    rep.check(T == F(r), f"{tag}: tr(εV^(+)) = r_ℂ")
    rep.negative(T != F((2 * x**(-1) * (y**2 + y**(-2)) / 2)**M - (2 * x * (y**2 - y**(-2)) / 2)**M), f"{tag}: r の和を差にしたもの")
    rep.negative(T != body_trace(s.V), f"{tag}: tr(V^(+))（ε を落とす）")
    # 2 行目: z > 0 の定め方。証人 r
    witness = [rr for rr in [r] if rr > 0 and T == F(rr)]
    rep.check(len(witness) == 1, f"{tag}: tr(εV^(+)) > 0（証人 r）")
    # 3 行目
    e1 = s.eta[s.ones]
    rep.check(e1 == F(1), f"{tag}: η_(1,…,1) = +1")
    a = prefactor_exact(M, x)                                      # (2s_2)^{M/2}（def_second_transfer_matrix_prefactor）
    eh = [(g + (g**2 - 1).sqrt()).sqrt() for g in s.g1]           # exp(γ(θ̃_μ)/2)
    kappa = a * prod(e - 1 / e for e in eh)                        # ϰ
    rep.check(kappa > 0, f"{tag}: ϰ > 0")
    rep.check(QQbar(r) == s.to_qqbar(e1) * QQbar(kappa), f"{tag}: tr(εV^(+)) = η_(1,…,1)ϰ_ℂ（via_check_eigenvalues (1)）")
    rep.negative(-kappa < 0 and QQbar(r) != -QQbar(kappa), f"{tag}: η = −1 なら tr = −ϰ < 0 で一致しない")
    # 独立の確認
    rep.check(T == sum(s.eta[w] * s.lam[w] for w in s.words), f"{tag}: tr(εV^(+)) = Σ η_ϵ Λ̌_ϵ")
    print(f"  {tag}: tr(εV^(+)) = {r}、ϰ ≈ {RR(kappa):.6f}、η_(1,…,1) = {e1}（累計 {rep.n} 件）", flush=True)

rep.finish()
