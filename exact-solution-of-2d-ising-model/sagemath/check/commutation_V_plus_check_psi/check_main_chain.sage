# 対象ラベル: commutation_V_plus_check_psi
# 証明の本体の鎖（17 式）と、両辺の成分を取り出す二本の鎖（exp の行を除く各 4 式）、主張そのものを確かめる。
# 各行を別々に組む: T は def_T_V_plus の三つの共役の合成、組と 2×2 行列の積は def_pair_of_matrices_times_two_by_two_matrix・
#   def_pair_of_matrices_times_column_of_numbers、行列の積・和・スカラー倍は本文の成分の式、ψ̌_μ^†・ψ̌_μ は def_check_fermi の
#   第二の式（P̌_μ との積を使わない形）、A(θ̃_μ) は def_A_theta の成分の式、P̌_μ・Ď_μ は diagonalization_check_P_D の式、
#   λ_{±,μ} = γ_1 ± r_μ は eigenvector_of_A_theta_tilde の式、P̌_μ^{-1} は Sage の inverse（P̌^{-1}P̌ = P̌P̌^{-1} = I を本文の積で確かめる）。
# 範囲: 結合定数 3 組 × M_col = 2, 3, 4 × 全 μ。数体 E の中で厳密（浮動小数点なし）。
# 独立な経路: 主張の両辺を Sage の `*`・inverse・スカラー倍で作った V^(+) ψ (V^(+))^{-1} と λ ψ でも比べる。
# exp(±γ(θ̃_μ)) の行: def_arccosh の arccosh(g) = log(g + √(g^2-1)) から exp(±γ) = g ± √(g^2-1) を AA で λ_{±,μ}（r_μ > 0 の値）と比べ、
#   RealBallField の exp(±acosh(g)) が λ_{±,μ} を囲むことも見る（ℝ への脱出: 実数の exp。精度 256 ビット）。
# 対照: T(ψ̌^†) ≠ λ_- ψ̌^†、(Ž, Y̌)(P̌A) ≠ (Ž, Y̌)(AP̌)、行で読んだ組の積は第 2 式と一致しない。
load("_prelude.sage")

Ms = [int(a) for a in sys.argv[1:]] or [2, 3, 4]
rep = Report("commutation_V_plus_check_psi: 本体の鎖と主張")
RB256 = RealBallField(256)

for (x, y) in COUPLINGS:
    for M in Ms:
        f = Factors(M, x, y)
        for mu in range(1, M + 1):
            s = PsiSetting(f, mu)
            E, n = s.E, s.n
            tag = f"(x,y)=({x},{y}) M={M} μ={mu}"
            cT = s.T_composite
            cZ, cY, cA, cP, cD = s.Z, s.Y, s.A, s.P, s.D
            psid, psi = s.psid, s.psi
            cI2 = body_identity(E, 2)
            cO = matrix(E, n, n, 0)
            cPinv = cP.inverse()
            rep.check(body_product(cPinv, cP) == cI2 and body_product(cP, cPinv) == cI2, f"{tag}: P̌^-1 P̌ = P̌ P̌^-1 = I", quiet=True)
            cZY = (cZ, cY)
            cPD = body_product(cP, cD)
            rows = [
                (cT(psid), cT(psi)),
                (cT(pr(1, pair_times_two_by_two(cZY, cP))), cT(pr(2, pair_times_two_by_two(cZY, cP)))),
                pair_times_two_by_two((cT(cZ), cT(cY)), cP),
                pair_times_two_by_two(pair_times_two_by_two(cZY, cA), cP),
                pair_times_two_by_two(cZY, body_product(cA, cP)),
                pair_times_two_by_two(cZY, body_product(body_product(cPD, cPinv), cP)),
                pair_times_two_by_two(cZY, body_product(cPD, body_product(cPinv, cP))),
                pair_times_two_by_two(cZY, body_product(cPD, cI2)),
                pair_times_two_by_two(cZY, cPD),
                pair_times_two_by_two(pair_times_two_by_two(cZY, cP), cD),
                pair_times_two_by_two((psid, psi), cD),
                (pr(1, pair_times_two_by_two((psid, psi), cD)), pr(2, pair_times_two_by_two((psid, psi), cD))),
                (body_sum(body_scalar(cD[0, 0], psid), body_scalar(cD[1, 0], psi)),
                 body_sum(body_scalar(cD[0, 1], psid), body_scalar(cD[1, 1], psi))),
                (body_sum(body_scalar(s.lp, psid), body_scalar(0, psi)),
                 body_sum(body_scalar(0, psid), body_scalar(s.lm, psi))),
                (body_sum(body_scalar(s.lp, psid), cO), body_sum(cO, body_scalar(s.lm, psi))),
                (body_scalar(s.lp, psid), body_sum(cO, body_scalar(s.lm, psi))),
                (body_scalar(s.lp, psid), body_scalar(s.lm, psi)),
            ]
            assert len(rows) == 17
            for k in range(len(rows) - 1):
                rep.check(pair_eq(rows[k], rows[k + 1]), f"{tag}: 本体 第 {k+1} 式 = 第 {k+2} 式", quiet=True)
            # 成分を取り出す二本の鎖（第 1・3 式は pr の定め方、第 2 式は本体の鎖の両端）
            for l, lam in ((1, s.lp), (2, s.lm)):
                lhs = (cT(psid), cT(psi))[l - 1]
                c = [lhs, pr(l, rows[0]), pr(l, rows[-1]), body_scalar(lam, (psid, psi)[l - 1])]
                for k in range(3):
                    rep.check(c[k] == c[k + 1], f"{tag}: 第 {l} 成分の鎖 第 {k+1} 式 = 第 {k+2} 式", quiet=True)
            # 主張（Sage の演算による独立な経路）
            cV = (s.S * s.V2) * s.S
            cVi = cV.inverse()
            rep.check(cV * psid * cVi == s.lp * psid and cV * psi * cVi == s.lm * psi, f"{tag}: 主張（Sage の積・inverse）", quiet=True)
            # 対照
            rep.check(cT(psid) != s.lm * psid, f"対照 {tag}: T(ψ̌^†) ≠ λ_- ψ̌^†", quiet=True)
            rep.check(not pair_eq(pair_times_two_by_two(cZY, body_product(cP, cA)), rows[4]), f"対照 {tag}: (Ž,Y̌)(P̌A) ≠ (Ž,Y̌)(AP̌)", quiet=True)
            rowread = (body_sum(body_scalar(cP[0, 0], cZ), body_scalar(cP[0, 1], cY)), body_sum(body_scalar(cP[1, 0], cZ), body_scalar(cP[1, 1], cY)))
            rep.check(not pair_eq((cT(rowread[0]), cT(rowread[1])), rows[1]), f"対照 {tag}: 行で読んだ組の積は第 2 式と異なる", quiet=True)
            # λ_{±,μ} = exp(±γ(θ̃_μ))（r_μ > 0 の値で）
            g = s.g1_AA
            lpA, lmA = g + s.r_AA, g - s.r_AA
            w = (g**2 - 1).sqrt()
            rep.check(lpA == g + w and lmA == g - w, f"{tag}: λ_± = γ_1 ± √(γ_1^2-1) = exp(±arccosh γ_1)（AA）", quiet=True)
            gb = RB256(g)
            rep.check(((gb.arccosh()).exp() - RB256(lpA)).contains_zero(), f"{tag}: exp(+acosh γ_1) は λ_+ を囲む（ボール）", quiet=True)
            rep.check(((-(gb.arccosh())).exp() - RB256(lmA)).contains_zero(), f"{tag}: exp(-acosh γ_1) は λ_- を囲む（ボール）", quiet=True)
            rep.check(not ((gb.arccosh()).exp() - RB256(lmA)).contains_zero(), f"対照 {tag}: exp(+acosh γ_1) は λ_- を囲まない", quiet=True)
            print(f"  {tag}: 済（累計 {rep.n} 件、失敗 {rep.fail} 件）")

rep.finish()
