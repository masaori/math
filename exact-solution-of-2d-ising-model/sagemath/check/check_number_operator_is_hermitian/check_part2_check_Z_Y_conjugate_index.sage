# 対象ラベル: check_number_operator_is_hermitian
# 証明の (2)（Ž_μ^* = Ž_{M_col+1-μ}、Y̌_μ^* = Y̌_{M_col+1-μ}）の鎖 5 行と、その前の二つの等式
#   conj(exp(-i(j_R θ̃_μ)_C)) = exp(i(j_R θ̃_μ)_C)（euler_formula_cos_sin と θ̃_μ ∈ ℝ）、
#   exp(-i(j_R θ̃_{M_col+1-μ})_C) = exp(i(j_R θ̃_μ)_C)（conjugate_index_of_check_Z_Y (2)）
# を、円分体 L := QQ(ζ_{4M}) の行列で厳密に確かめる。
#  - Z_j・Y_j は pauli_sites_exact.sage の本文の経路（def_jordan_wigner_*_matrices）で KG に作り、i ↦ ζ^M で L へ移す。
#  - 位相 exp(s·i(θ̃_μ)_C) は ζ_{4M}^{2(2μ-1)s}（half_integer_check_operators.sage の phase）。この表し方が本文の位相の値であることは
#    QQbar の E(sθ̃_μ/(2π))（half_integer_phase_exact.sage）との一致で毎回確かめる。
#  - Ž_μ・Y̌_μ は def_half_integer_checkZ・def_half_integer_checkY の Σ_j exp(-i(j_R θ̃_μ)_C) Z_j（スカラー倍と有限和は本文の成分の式）。
#  - L の複素共役は ζ ↦ ζ^{-1}。ζ ↦ exp(2πi/(4M)) の埋め込みで本物の複素共役であることを確かめる。
# 範囲: M_col = 2..6、μ ∈ M̌ = {1, …, M_col} の全て。
# 帰属: 全て L の元（厳密計算。浮動小数点は使わない）。ℝ への脱出は位相を 1 の冪根で表す一点だけで、QQbar で照合する。
load("../../_shared/half_integer_check_operators.sage")
load("../../_shared/pauli_sites_exact.sage")
load("_conjugate_transpose.sage")

rep = Counter("check_number_operator_is_hermitian (2): Ž_μ^* = Ž_{M+1-μ}、Y̌_μ^* = Y̌_{M+1-μ}（円分体で厳密）")

for M in range(2, 7):
    L = CyclotomicField(4 * M, 'z')
    zeta = L.gen()
    iL = zeta**M
    rep.eq(iL**2, L(-1), f"M={M}: ζ^M は i")
    conjL = L.hom([zeta**(-1)], L)
    embL = L.hom([QQbar.zeta(4 * M)], QQbar)
    rep.eq(embL(conjL(zeta)), embL(zeta).conjugate(), f"M={M}: ζ ↦ ζ^-1 は本物の複素共役")
    rep.eq(embL(iL), QQbar(I), f"M={M}: ζ^M の像は i")
    star = lambda A: body_star(A, conjL)

    def toL(A):
        return matrix(L, A.nrows(), A.ncols(), lambda r, c: L(KG(A[r, c]).list()[0]) + L(KG(A[r, c]).list()[1]) * iL)

    Z = {j: toL(jw(M, j, 'z')) for j in range(1, M + 1)}
    Y = {j: toL(jw(M, j, 'y')) for j in range(1, M + 1)}
    for j in range(1, M + 1):
        rep.eq(star(Z[j]), Z[j], f"M={M} j={j}: (1) Z_j^* = Z_j（L の中で）")
        rep.eq(star(Y[j]), Y[j], f"M={M} j={j}: (1) Y_j^* = Y_j（L の中で）")
    ph = lambda mu, s: phase(L, zeta, M, mu, s)
    for mu in range(1, M + 1):
        for s in (1, -1):
            rep.truth(phase_qqbar_crosscheck(L, zeta, M, mu, s), f"M={M} μ={mu} s={s}: 位相 ζ^(2(2μ-1)s) は exp(s i θ̃_μ)")
    Mcheck = list(range(1, M + 1))                              # def_check_index_set の M̌
    for mu in Mcheck:
        sm = M + 1 - mu
        rep.truth(sm in Mcheck, f"M={M} μ={mu}: M+1-μ ∈ M̌（def_check_index_set (2)）")
        coef = {j: ph(mu, -j) for j in range(1, M + 1)}         # exp(-i(j_R θ̃_μ)_C) = exp(i θ̃_μ)^(-j)
        for j in range(1, M + 1):
            rep.eq(conjL(coef[j]), ph(mu, j), f"M={M} μ={mu} j={j}: conj(exp(-ijθ̃_μ)) = exp(ijθ̃_μ)")
            rep.eq(ph(sm, -j), ph(mu, j), f"M={M} μ={mu} j={j}: exp(-ijθ̃_(M+1-μ)) = exp(ijθ̃_μ)（conjugate_index_of_check_Z_Y (2)）")
        for name, F in (("Ž", Z), ("Y̌", Y)):
            check_mu = body_finite_sum([body_scalar(coef[j], F[j]) for j in range(1, M + 1)])
            check_nu = body_finite_sum([body_scalar(ph(sm, -j), F[j]) for j in range(1, M + 1)])
            lines = [
                (f"{name}_μ^*", star(check_mu)),
                ("(Σ_j exp(-ijθ̃_μ) F_j)^*", star(body_finite_sum([body_scalar(coef[j], F[j]) for j in range(1, M + 1)]))),
                ("Σ_j conj(exp(-ijθ̃_μ)) F_j^*", body_finite_sum([body_scalar(conjL(coef[j]), star(F[j])) for j in range(1, M + 1)])),
                ("Σ_j exp(ijθ̃_μ) F_j", body_finite_sum([body_scalar(ph(mu, j), F[j]) for j in range(1, M + 1)])),
                ("Σ_j exp(-ijθ̃_(M+1-μ)) F_j", body_finite_sum([body_scalar(ph(sm, -j), F[j]) for j in range(1, M + 1)])),
                (f"{name}_(M+1-μ)", check_nu),
            ]
            rep.chain(lines, f"M={M} μ={mu} {name} の鎖")
            # 否定コントロール
            if sm != mu:
                rep.neq(star(check_mu), check_mu, f"M={M} μ={mu}: {name}_μ はエルミートでない（添字が M+1-μ へ移るのが要る）")
                rep.neq(body_finite_sum([body_scalar(coef[j], star(F[j])) for j in range(1, M + 1)]), check_nu,
                        f"M={M} μ={mu}: 係数を共役しない Σ_j exp(-ijθ̃_μ) F_j^* は {name}_(M+1-μ) でない")
    print(f"  M={M}: 済（累計 等号 {rep.n_eq} 件）", flush=True)

rep.finish()
