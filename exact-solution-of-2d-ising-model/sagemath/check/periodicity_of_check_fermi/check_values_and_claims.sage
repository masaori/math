# 対象ラベル: periodicity_of_check_fermi
# 具体の結合定数（4 組、臨界点 2 組を含む）と M_col = 2..8 で、(1)(2)(3) の各鎖の各行と主張を厳密に確かめる。
# 角度は qπ（q ∈ QQ）で、γ_1・γ_2 は円分体 Q(ζ_{4M}) の元（_prelude.sage）。|γ_2| は根号の中を F で、P̌ は F(r, √M) の有理式で厳密に。
# 浮動小数点・ボールは使わない。全実数上の cos・sin の 2π 周期性（本文で未整備の前提）は、円分体の中では ζ の冪の指数が
#  4M を法として一致することで自明に成り立つので、Sage 組み込みの記号の cos(qπ)・sin(qπ) を QQbar へ厳密に落とした値と照合する。
load("_prelude.sage")

rep = Report("periodicity_of_check_fermi: 具体の値と主張")

fails = {}
def tick(ok, key):
    if not ok:
        fails[key] = fails.get(key, 0) + 1
keys = set()
counts = {}
def T(ok, key):
    keys.add(key); counts[key] = counts.get(key, 0) + 1; tick(ok, key)

def ang(F, q):
    return Angle(F, QQ(q))

for M in M_RANGE:
    F = field_for(M)
    # ---- 前提: cos・sin の 2π 周期性を、円分体の値と、Sage の記号の値を QQbar に落とした値で照合 ----
    for m in range(-M, 2 * M + 1):
        q = theta_tilde_over_pi(M, m)
        for k in range(-3, 4):
            a, s = ang(F, q), ang(F, q + 2 * k)
            T(a.cos == s.cos and a.sin == s.sin, "円分体: cos・sin(θ + 2πk) = cos・sin θ")
            T(QQbar(cos(pi * (q + 2 * k))) == QQbar(a.cos) and QQbar(sin(pi * (q + 2 * k))) == QQbar(a.sin),
              "Sage の記号の cos・sin(qπ + 2kπ) を QQbar に落とすと円分体の cos・sin θ と一致")
            # 準備の第一の二つの表示（cos(-x) = cos x、exp(ix) = cos x + i sin x）
            n = ang(F, -q)
            T(n.cos == a.cos, "準備: cos(-x) = cos x")
            T(a.cos + a.I * a.sin == a.Ep, "準備: cos x + i sin x = exp(ix)")
    for (Yv, Zv) in COUPLINGS:
        k = couplings(Yv, Zv)
        # ---- (1): θ = θ~_m と -θ~_m（m ∈ ZZ）、k ∈ -3..3。γ_2 の鎖を行ごとに ----
        for m in range(-M, 2 * M + 1):
            for sgn in (1, -1):
                q = sgn * theta_tilde_over_pi(M, m)
                for kk in range(-3, 4):
                    a, s = ang(F, q), ang(F, q + 2 * kk)
                    g1_lines = [gamma1(s, k), k['c1'] * k['c2s'] - k['s1'] * k['s2s'] * s.cos,
                                k['c1'] * k['c2s'] - k['s1'] * k['s2s'] * a.cos, gamma1(a, k)]
                    T(all(g1_lines[j] == g1_lines[j + 1] for j in range(3)), "(1) γ_1 の鎖の各行")
                    I_ = a.I; s2 = k['s2s']; c1 = k['c1']; sc = k['s1'] * k['c2']
                    g2_lines = [
                        gamma2(s, k),
                        I_ * s.Ep * s2 * (c1 * s.cos - I_ * s.sin - sc),
                        I_ * (s.cos + I_ * s.sin) * s2 * (c1 * s.cos - I_ * s.sin - sc),
                        I_ * (a.cos + I_ * s.sin) * s2 * (c1 * a.cos - I_ * s.sin - sc),
                        I_ * (a.cos + I_ * a.sin) * s2 * (c1 * a.cos - I_ * a.sin - sc),
                        I_ * a.Ep * s2 * (c1 * a.cos - I_ * a.sin - sc),
                        gamma2(a, k),
                    ]
                    T(all(g2_lines[j] == g2_lines[j + 1] for j in range(6)), "(1) γ_2 の鎖の各行")
        # ---- (2): μ = -2M..3M、k = -3..3 ----
        for m in range(-2 * M, 3 * M + 1):
            for kk in range(-3, 4):
                qa = theta_tilde_over_pi(M, m + kk * M); qb = theta_tilde_over_pi(M, m)
                A, B = ang(F, qa), ang(F, qb)
                An, Bn = ang(F, -qa), ang(F, -qb)
                T(gamma1(A, k) == gamma1(ang(F, qb + 2 * kk), k) == gamma1(B, k), "(2) γ_1(θ~_(μ+kM)) = γ_1(θ~_μ + 2πk) = γ_1(θ~_μ)")
                T(gamma2(A, k) == gamma2(ang(F, qb + 2 * kk), k) == gamma2(B, k), "(2) γ_2(θ~_(μ+kM)) の鎖")
                T(gamma2(An, k) == gamma2(ang(F, -qb + 2 * (-kk)), k) == gamma2(Bn, k), "(2) γ_2(-θ~_(μ+kM)) の鎖")
        # ---- (3): μ ∈ M̌ ----
        for m in range(1, M + 1):
            nu = M + 1 - m
            qm = theta_tilde_over_pi(M, m); qn = theta_tilde_over_pi(M, nu)
            Nu, NuN, Mu, MuN = ang(F, qn), ang(F, -qn), ang(F, qm), ang(F, -qm)
            a_, b_ = gamma2(Mu, k), gamma2(MuN, k)
            T(gamma2(Nu, k) == gamma2(ang(F, -qm + 2), k) == b_, "(3) γ_2(θ~_ν) の鎖")
            T(gamma2(NuN, k) == gamma2(ang(F, qm - 2), k) == a_, "(3) γ_2(-θ~_ν) の鎖")
            g1_chain = [gamma1(Nu, k), gamma1(ang(F, -qm + 2), k), gamma1(MuN, k),
                        k['c1'] * k['c2s'] - k['s1'] * k['s2s'] * MuN.cos,
                        k['c1'] * k['c2s'] - k['s1'] * k['s2s'] * Mu.cos, gamma1(Mu, k)]
            T(all(g1_chain[j] == g1_chain[j + 1] for j in range(5)), "(3) γ_1(θ~_ν) の鎖の各行")
            # γ = arccosh(γ_1): 行の中身は γ_1 の一致（上で F の中で厳密に）。arccosh の定義域に入ることだけを厳密に見る
            g1n = QQbar(gamma1(Nu, k))
            T(g1n.imag() == 0 and g1n.real() >= 1, "(3) γ_1(θ~_ν) ∈ ℝ_{≥1}（arccosh の定義域）")
            # P̌_ν（diagonalization_check_P_D の式を ν で）と主張の行列。QQbar の入れ子の平方根の等号判定は遅いので、
            # |z| = √(z conj z)（def_abs_arg）の根号の中を F で厳密に比べ（正の数の平方根は一意なので根号の中の一致で
            # |·| が一致する）、P̌ の成分は |·| を不定元 r、√M_col を不定元 sM とした F(r, sM) の有理式で比べる。
            Nn = gamma2(Nu, k) * gamma2(Nu, k).conjugate(); Nb = b_ * b_.conjugate()
            T(Nn == Nb and QQbar(Nb) > 0, "(3) |γ_2(θ~_ν)|^2 = |γ_2(-θ~_μ)|^2 > 0（F で）、ゆえに |γ_2(θ~_ν)| = |γ_2(-θ~_μ)|")
            Fr2 = PolynomialRing(F, ['r_nu', 'r_b', 'sM']).fraction_field()
            r_nu, r_b, sM = Fr2.gens()
            def Pmat(rabs, bottom):
                return matrix(Fr2, [[-rabs / (2 * sM * bottom), rabs / (2 * sM * bottom)], [1 / (2 * sM), 1 / (2 * sM)]])
            P_lines = [Pmat(r_nu, gamma2(NuN, k)), Pmat(r_b, gamma2(NuN, k)), Pmat(r_b, a_)]
            # 主張の分母: u γ_2(θ~_μ) は d_ν = u γ_2(-θ~_ν) と同じ元（u = 2√M_col ≠ 0 は sM ≠ 0 の不定元で、γ_2 の因子を F で比べる）。
            # γ_2(θ~_μ) ≠ 0 なので分母は ℂ^× に属する（diagonalization_check_P_D の Step 1 を ν で）。
            # u = 2√M_col ∈ ℂ^× はここでは不定元 sM の式なので確かめず、diagonalization_check_P_D 側の検算に任せる
            T(2 * sM * gamma2(NuN, k) == 2 * sM * a_ and a_ != 0 and gamma2(NuN, k) != 0, "(3) 主張の分母 u γ_2(θ~_μ) = d_ν ∈ ℂ^×（γ_2(-θ~_ν) = γ_2(θ~_μ) ≠ 0）")
            T(P_lines[0].subs({r_nu: r_b}) == P_lines[1], "(3) P̌_ν の鎖 第 1 → 2 行（|γ_2(θ~_ν)| = |γ_2(-θ~_μ)| を代入）")
            T(P_lines[1] == P_lines[2], "(3) P̌_ν の鎖 第 2 → 3 行（γ_2(-θ~_ν) = γ_2(θ~_μ) を F で）")
            # 対照: 入れ替えない P̌_μ（|γ_2(θ~_μ)| = |γ_2(-θ~_μ)| は relation_of_gamma_2_theta_tilde (1)）とは、γ_2(θ~_μ) ≠ γ_2(-θ~_μ) のとき一致しない
            if a_ != b_:
                T(P_lines[-1] != Pmat(r_b, b_), "(3) 対照: P̌_ν ≠ P̌_μ（γ_2(θ~_μ) ≠ γ_2(-θ~_μ) のとき）")
            if a_ != b_:
                T(gamma2(Nu, k) != a_, "(3) 対照: γ_2(θ~_ν) ≠ γ_2(θ~_μ)（γ_2(θ~_μ) ≠ γ_2(-θ~_μ) のとき）")

for key in sorted(keys):
    rep.check(fails.get(key, 0) == 0, f"{key}（{counts[key]} 件）")
rep.finish()
