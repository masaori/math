# 対象ラベル: relation_of_gamma_2_theta_tilde
# 具体の結合定数と全ての μ で、準備の鎖の値と主張 (1)〜(5) を厳密に確かめる。
# γ_2 は円分体 Q(ζ_{4M}) の元、偏角・平方根は AA × AA の対と角度 a + bπ（_shared/polar_trigonometry_exact.sage）で計算する。
load("_prelude.sage")

rep = Report("relation_of_gamma_2_theta_tilde: 具体の値と主張")

# ---- 準備の第五: sin(π/2) = 1、cos(π/2) = 0、0 < π（pi_is_positive）、角度 0・π の整数（arctan 0 = 0 は主張 arctan_zero の検算 sagemath/check/arctan_zero/） ----
rep.check(bool(arcsin(SR(1)) == pi / 2), "Sage の arcsin(1) = π/2（π の定め方）")
rep.check(cos_sin(pi_ / 2) == (AA(0), AA(1)), "cos(π/2) = 0、sin(π/2) = 1（1 の 4 乗根の実部・虚部）")
rep.check(AA(1)**2 == 1, "cos(π/2) の鎖 第 3 行: √(1 - 1^2) = √(1 - 1)（power_of_real_one_is_one の m → 2）")
rep.check(AA(1) - AA(1) == 0, "cos(π/2) の鎖 第 4 行: √(1 - 1) = √0（ℝ で a - a = 0 の a → 1）")
rep.check(sqrt_aa(AA(0)) == 0, "cos(π/2) の鎖 第 5 行: √0 = 0（sqrt_of_real_zero_is_zero。検算 sagemath/check/sqrt_of_real_zero_is_zero/）")
rep.check(1 - AA(1)**2 != 1 - AA(2)**2 and AA(2) - AA(1) != 0, "cos(π/2) の鎖 否定の対照: 1^2 を 2^2 に、a - a を 2 - 1 に取り違えると等号が崩れる")
rep.check(cos_sin(Ang(0)) == (AA(1), AA(0)), "cos 0 = 1、sin 0 = 0")
rep.check(bool(pi > 0) and RealBallField(256)(0) < RealBallField(256).pi(), "0 < π（pi_is_positive の参照。鎖の検算は sagemath/check/pi_is_positive/）")
rep.check(Ang(0) + pi_ == pi_, "(3) φ_polar((-r)_C) の鎖 第 12 行: [(r, 0+π)] = [(r, π)]（ℝ で 0 + a = a の a → π。第 11 行 arctan 0 = 0 は sagemath/check/arctan_zero/）")
rep.check(Ang(1) + pi_ != pi_, "(3) φ_polar((-r)_C) の鎖 第 12 行 否定の対照: 0 を 1 に取り違えると 1 + π ≠ π")
rep.check(n_of_section(Ang(0)) == 0 and n_of_section(pi_) == 0, "角度 0 と π の angle_section_existence_uniqueness の整数は 0")

n_cases = 0
fail_lines = {}
def tick(ok, key):
    if not ok:
        fail_lines[key] = fail_lines.get(key, 0) + 1

for (Yv, Zv) in COUPLINGS:
    k = couplings(Yv, Zv)
    for M in M_RANGE:
        for mu in range(1, M + 1):
            n_cases += 1
            F, I_, Ep, Em, co, si = cyclotomic_angle(M, mu, 1)
            _, _, Ep_m, Em_m, co_m, si_m = cyclotomic_angle(M, mu, -1)   # φ = -θ
            # 準備の第一
            tick(co_m == co, "cos(-θ) = cos θ")
            tick(si_m == -si, "sin(-θ) = -sin θ")
            tick(Ep_m == Em, "exp(i(-θ)) = exp(-iθ)")
            tick(co + I_ * si == Ep, "cos θ + i sin θ = exp(iθ)")
            tick(QQbar(co) == QQbar(cos(pi * (2 * mu - 1) / M)) and QQbar(si) == QQbar(sin(pi * (2 * mu - 1) / M)),
                 "euler の式の cos・sin は Sage 組み込みの cos・sin と一致")
            # 準備の第二
            tick(I_.conjugate() == -I_, "ī = -i（円分体の共役）")
            tick(Ep.conjugate() == Em, "conj(exp(iθ)) = exp(-iθ)")
            tick(cc_conj(to_pair(Ep)) == to_pair(Em), "conj(exp(iθ)) = exp(-iθ)（def_complex_conjugate の対で）")
            # 準備の第三: γ_2(-θ) の表示
            g = gamma2_by_definition(I_, Ep, co, si, k)
            gm = gamma2_by_definition(I_, Ep_m, co_m, si_m, k)
            w = k['c1'] * co - I_ * si - k['s1'] * k['c2']
            wp = k['c1'] * co + I_ * si - k['s1'] * k['c2']
            gm_lines = [
                I_ * Ep_m * k['s2s'] * (k['c1'] * co_m - I_ * si_m - k['s1'] * k['c2']),
                I_ * Em * k['s2s'] * (k['c1'] * co_m - I_ * si_m - k['s1'] * k['c2']),
                I_ * Em * k['s2s'] * (k['c1'] * co - I_ * si_m - k['s1'] * k['c2']),
                I_ * Em * k['s2s'] * (k['c1'] * co - I_ * (-si) - k['s1'] * k['c2']),
                I_ * Em * k['s2s'] * wp,
            ]
            tick(gm == gm_lines[0], "γ_2(-θ) の鎖 第 1 行は定義")
            for j in range(len(gm_lines) - 1):
                tick(gm_lines[j] == gm_lines[j + 1], f"γ_2(-θ) の鎖 第 {j+1} 行 = 第 {j+2} 行")
            # 準備の第四: conj(γ_2(θ)) の鎖を円分体の共役で
            s2s = F(k['s2s']); cj = lambda a: F(a).conjugate()
            cg_lines = [
                cj(g),
                cj(I_ * Ep * s2s) * cj(w),
                cj(I_ * Ep) * cj(s2s) * cj(w),
                cj(I_) * cj(Ep) * cj(s2s) * cj(w),
                (-I_) * cj(Ep) * cj(s2s) * cj(w),
                (-I_) * Em * cj(s2s) * cj(w),
                (-I_) * Em * s2s * cj(w),
                (-I_) * Em * s2s * (cj(k['c1'] * co - I_ * si) - cj(k['s1'] * k['c2'])),
                (-I_) * Em * s2s * (cj(k['c1'] * co) - cj(I_ * si) - cj(k['s1'] * k['c2'])),
                (-I_) * Em * s2s * (cj(k['c1'] * co) - cj(I_) * cj(si) - cj(k['s1'] * k['c2'])),
                (-I_) * Em * s2s * (k['c1'] * co - cj(I_) * si - k['s1'] * k['c2']),
                (-I_) * Em * s2s * (k['c1'] * co - (-I_) * si - k['s1'] * k['c2']),
                (-I_) * Em * s2s * wp,
                -(I_ * Em * s2s * wp),
                -gm,
            ]
            for j in range(len(cg_lines) - 1):
                tick(cg_lines[j] == cg_lines[j + 1], f"conj(γ_2(θ)) の鎖 第 {j+1} 行 = 第 {j+2} 行")
            tick(cj(co) == co and cj(si) == si and cj(k['c1'] * co) == k['c1'] * co, "cos θ・sin θ・c_1 cos θ は実数（共役で不変）")
            # (1)
            tick(gm == -(-gm) == -cj(g), "(1) γ_2(-θ) = -(-γ_2(-θ)) = -conj(γ_2(θ))")
            tick(gm != cj(g), "(1) 対照: γ_2(-θ) ≠ +conj(γ_2(θ))")
            # (2)
            gp = to_pair(g)
            abs2 = gp[0]**2 + gp[1]**2                      # abs_basic_properties (2)
            absg = cc_abs_aa(gp)                            # |γ_2(θ)|
            m1 = F(-1)
            two_lines = [g * gm, g * (-cj(g)), g * (m1 * cj(g)), (g * m1) * cj(g), (m1 * g) * cj(g),
                         m1 * (g * cj(g)), m1 * (cj(g) * g)]
            for j in range(len(two_lines) - 1):
                tick(two_lines[j] == two_lines[j + 1], "(2) の鎖 左辺 = 第 1 行" if j == 0 else f"(2) の鎖 第 {j} 行 = 第 {j+1} 行")
            tick(to_pair(cj(g) * g) == (abs2, AA(0)), "(2) complex_conjugate_times_self: conj(γ)γ = (|γ|^2)_C")
            tick(to_pair(g * gm) == (-abs2, AA(0)), "(2) γ_2(θ)γ_2(-θ) = (-|γ_2(θ)|^2)_C")
            tick(g != 0 and absg != 0 and absg > 0, "(2) |γ| ≠ 0、|γ| > 0")
            tick(absg**2 == abs2, "(2) |γ|^2（def_power_of_real_number の冪）は abs_basic_properties (2) の x^2+y^2")
            # 0 < |γ|^2 の鎖 3 行
            tick(AA(0) == AA(0) * absg, "(2) 0 < |γ|^2 の鎖 第 1 行: 0 = 0·|γ|")
            tick(AA(0) * absg < absg * absg, "(2) 0 < |γ|^2 の鎖 第 2 行: 0·|γ| < |γ||γ|")
            tick(absg * absg == absg**2, "(2) 0 < |γ|^2 の鎖 第 3 行: |γ||γ| = |γ|^2（square_of_real_number_is_product を右辺から左辺へ）")
            # -|γ|^2 < 0 の鎖 2 行
            tick(-(absg**2) < -AA(0), "(2) -|γ|^2 < 0 の鎖 第 1 行: -|γ|^2 < -0")
            tick(-AA(0) == AA(0), "(2) -|γ|^2 < 0 の鎖 第 2 行: -0 = 0")
            tick(gm != 0, "(2) γ_2(-θ) ≠ 0_C")
            tick(cc_conj(cc_conj(gp)) == gp, "(2) 背理の鎖の二重の共役")
            # (3)
            r = abs2
            # (3) φ_polar((-r)_C) の鎖 第 2〜9 行（根号の中身と arctan の引数の対）
            three_polar = [
                ((-r)**2 + 0**2, AA(0) / (-r)),
                ((-r) * (-r) + 0**2, AA(0) / (-r)),   # square_of_real_number_is_product (r → -r)
                (r * r + 0**2, AA(0) / (-r)),         # (-a)(-b) = ab (a, b → r)
                (r**2 + 0**2, AA(0) / (-r)),          # square_of_real_number_is_product (r → r) を右辺から左辺へ
                (r**2 + 0 * 0, AA(0) / (-r)),         # square_of_real_number_is_product (r → 0)
                (r**2 + 0, AA(0) / (-r)),             # 0·x = 0 (x → 0)
                (r**2, AA(0) / (-r)),                 # a + 0 = a (a → r^2)
                (r**2, AA(0)),                        # 0/x = 0 (x → -r ≠ 0)
            ]
            for j in range(len(three_polar) - 1):
                tick(three_polar[j] == three_polar[j + 1], f"(3) φ_polar((-r)_C) の鎖 第 {j+2} 行 = 第 {j+3} 行")
            tick(-r < 0 and -r != 0, "(3) φ_polar((-r)_C) の鎖 第 9 行の前提: -r < 0 より -r ≠ 0")
            tick((-r) * (-r) != -(r * r), "(3) φ_polar((-r)_C) の鎖 第 4 行 否定の対照: (-a)(-b) を -(ab) に取り違えると等号が崩れる")
            tick(sqrt_aa(r**2) == r, "(3) φ_polar((-r)_C) の鎖 第 10 行: √(r^2) = r（r ≥ 0、r^2 = r^2）")
            tick(phi_polar_equals((-r, AA(0)), (r, pi_)), "(3) φ_polar((-r)_C) = [(r, π)]")
            t2 = pi_ if r != 0 else Ang(0)                 # first_and_second_projections
            tick(section(t2) == pi_ and section_by_floor(t2) == pi_, "(3) arg = s_{[0,2π)}([π]) = π - 2·0·π = π")
            three_main = [pi_ - (2 * 0) * pi_, pi_ - 0 * pi_, pi_ - Ang(0), pi_]
            for j in range(len(three_main) - 1):
                tick(three_main[j] == three_main[j + 1], f"(3) 主張の鎖 第 {j+5} 行 = 第 {j+6} 行（x·0 = 0、0·x = 0、a - 0 = a）")
            tick(pi_ - (2 * 1) * pi_ != pi_, "(3) 主張の鎖 否定の対照: 整数 n を 1 に取り違えると π - 2·1·π ≠ π")
            # (4)
            tick(-(g * gm) == F(-1) * (g * gm), "(4) 準備 第 1 行: -z = (-1_C) z")
            tick(to_pair(F(-1) * (g * gm)) == cc_mul(iota(-1, AA), (-r, AA(0))) == (r, AA(0)), "(4) -γ_2(θ)γ_2(-θ) = (-1_C)(-r)_C = r_C")
            tick((-1) * (-r) == 1 * r and 1 * r == r, "(4) -γγ' の鎖 第 4・5 行: ((-1)(-r))_C = (1·r)_C = r_C（(-a)(-b) = ab、1·x = x）")
            tick((-1) * (-r) != -r, "(4) -γγ' の鎖 否定の対照: (-1)(-r) を -r に取り違えると等号が崩れる")
            four_polar = [
                (r**2 + 0**2, AA(0) / r),
                (r**2 + 0 * 0, AA(0) / r),            # square_of_real_number_is_product (r → 0)
                (r**2 + 0, AA(0) / r),                # 0·x = 0 (x → 0)
                (r**2, AA(0) / r),                    # a + 0 = a (a → r^2)
                (r**2, AA(0)),                        # 0/x = 0 (x → r ≠ 0)
            ]
            for j in range(len(four_polar) - 1):
                tick(four_polar[j] == four_polar[j + 1], f"(4) φ_polar(r_C) の鎖 第 {j+2} 行 = 第 {j+3} 行")
            tick(AA(1) / r != AA(0), "(4) φ_polar(r_C) の鎖 第 6 行 否定の対照: 0/r を 1/r に取り違えると 0 にならない")
            tick(r > 0 and sqrt_aa(r**2) == r, "(4) φ_polar(r_C) の鎖 第 7 行: r ≥ 0、r^2 = r^2 なので √(r^2) = r")
            tick(sqrt_aa(r**2 + 0**2) == r and phi_polar_equals((r, AA(0)), (r, Ang(0))), "(4) φ_polar(r_C) = [(r, 0)]")
            four_lines = [
                phi_cartesian((sqrt_aa(r), Ang(0) / 2 - 0 * pi_)),
                phi_cartesian((absg, Ang(0) / 2 - 0 * pi_)),
                phi_cartesian((absg, Ang(0) - 0 * pi_)),     # 0/x = 0 (x → 2)
                phi_cartesian((absg, Ang(0) - Ang(0))),      # 0·x = 0 (x → π)
                phi_cartesian((absg, Ang(0))),               # a - 0 = a (a → 0)
                (absg * cos_sin(Ang(0))[0], absg * cos_sin(Ang(0))[1]),
                (absg * 1, absg * cos_sin(Ang(0))[1]),
                (absg * 1, absg * 0),
                (absg, absg * 0),                            # x·1 = x (x → |γ|)
                (absg, AA(0)),                               # x·0 = 0 (x → |γ|)
                iota(absg, AA),
            ]
            tick(sqrt_aa(r) == absg, "(4)(5) √r = |γ|（|γ| ≥ 0、|γ|^2 = r）")
            for j in range(len(four_lines) - 1):
                tick(four_lines[j] == four_lines[j + 1], f"(4) の鎖 第 {j+2} 行 = 第 {j+3} 行")
            tick(Ang(0) / 2 - 0 * pi_ == Ang(0) - 0 * pi_ and Ang(0) - 0 * pi_ == Ang(0) - Ang(0) and Ang(0) - Ang(0) == Ang(0), "(4) の鎖 角度の 3 行（0/2 - 0·π = 0 - 0·π = 0 - 0 = 0）")
            tick(Ang(0) - 1 * pi_ != Ang(0), "(4) の鎖 角度 否定の対照: 0·π を 1·π に取り違えると 0 - π ≠ 0")
            tick(sqrt_cc_by_definition((r, AA(0)), (r, Ang(0))) == four_lines[0], "(4) 第 2 行: sqrt_expansion_via_polar の値が def_sqrt_cc の値と一致")
            tick(to_pair(QQbar(r).sqrt()) == (absg, AA(0)), "(4) 対照: Sage の QQbar の平方根とも一致")
            # (5)
            five_lines = [
                phi_cartesian((sqrt_aa(r), pi_ / 2 - 0 * pi_)),
                phi_cartesian((absg, pi_ / 2 - 0 * pi_)),
                phi_cartesian((absg, pi_ / 2)),
                (absg * cos_sin(pi_ / 2)[0], absg * cos_sin(pi_ / 2)[1]),
                (absg * 0, absg * cos_sin(pi_ / 2)[1]),
                (absg * 0, absg * 1),
                (AA(0), absg),
                cc_mul((AA(0), AA(1)), (absg, AA(0))),
                cc_mul(to_pair(I_), (absg, AA(0))),
                cc_mul(to_pair(I_), iota(absg, AA)),
            ]
            for j in range(len(five_lines) - 1):
                tick(five_lines[j] == five_lines[j + 1], f"(5) の鎖 第 {j+2} 行 = 第 {j+3} 行")
            tick(sqrt_cc_by_definition((-r, AA(0)), (r, pi_)) == five_lines[0], "(5) 第 2 行: sqrt_expansion_via_polar の値が def_sqrt_cc の値と一致")
            tick(to_pair(QQbar(-r).sqrt()) == (AA(0), absg), "(5) 対照: Sage の QQbar の平方根（主値）とも一致")

rep.check(n_cases > 0, f"具体の組の数: 結合定数 {len(COUPLINGS)} 組 × M_col = {M_RANGE[0]}..{M_RANGE[-1]} の全 μ = {n_cases} 組")
rep.check(not fail_lines, "全ての組で全ての行が一致")
for key, cnt in sorted(fail_lines.items()):
    print(f"  不一致: {key}: {cnt} 組")
rep.finish()
