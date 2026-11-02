# 対象ラベル: nesting_of_commutator_of_H_and_check_Z
# 証明が引く前提: (A)〜(D)（commutator_of_H_and_check_Z_Y）を、この検算で作った H_1^(+)・H_2・Ž_μ・Y̌_μ について厳密に確かめ、
# 準備の exp(-iθ̃)exp(iθ̃) = 1_C の鎖（scalar_exp_product・scalar_exp_zero）を位相の値で厳密に、本文の exp のボールで補助に確かめる。
load("_prelude.sage")

for M in range(2, 6):
    S = Setting(M)
    for mu in range(1, M + 1):
        Zc, Yc = S.checkZ(mu), S.checkY(mu)
        # 位相の表し方の照合（円分体の値 = QQbar の 1 の冪根の値）
        for s in (-1, 1):
            report(phase_qqbar_crosscheck(S.L, S.zeta, M, mu, s), f"M={M} mu={mu}: exp({s}iθ̃) の円分体の値が E と一致")
        # (A)〜(D)
        A_l, A_r = comm_body(S.H1, Zc), body_scalar(2 * S.ph(mu, -1), Yc)
        B_l, B_r = comm_body(S.H1, Yc), body_scalar(-2 * S.ph(mu, 1), Zc)
        C_l, C_r = comm_body(S.H2, Zc), body_scalar(-2, Yc)
        D_l, D_r = comm_body(S.H2, Yc), body_scalar(2, Zc)
        report(A_l == A_r == comm_sage(S.H1, Zc), f"M={M} mu={mu}: (A) [H_1, Ž] = 2exp(-iθ̃)Y̌")
        report(B_l == B_r == comm_sage(S.H1, Yc), f"M={M} mu={mu}: (B) [H_1, Y̌] = -2exp(iθ̃)Ž")
        report(C_l == C_r == comm_sage(S.H2, Zc), f"M={M} mu={mu}: (C) [H_2, Ž] = -2Y̌")
        report(D_l == D_r == comm_sage(S.H2, Yc), f"M={M} mu={mu}: (D) [H_2, Y̌] = 2Ž")
        # 対照: (A) の位相の符号を逆にすると、θ̃ ≠ π の μ では一致しない
        if 2 * mu - 1 != M:
            report(A_l != body_scalar(2 * S.ph(mu, 1), Yc), f"M={M} mu={mu}: 対照 [H_1, Ž] ≠ 2exp(+iθ̃)Y̌")
        # 準備 exp(-iθ̃)exp(iθ̃) = exp(-iθ̃ + iθ̃) = exp(0) = 1_C
        th = theta_tilde_formula(mu, M)
        report((-th) + th == 0, f"M={M} mu={mu}: 指数 -iθ̃ + iθ̃ = 0（π を不定元にした有理関数体）")
        report(S.ph(mu, -1) * S.ph(mu, 1) == 1, f"M={M} mu={mu}: exp(-iθ̃)exp(iθ̃) = 1_C（円分体で厳密）")
        thb = 2 * PI * RB(theta_over_2pi(M, mu))
        em, ep, e0 = body_exp_i_ball(-thb), body_exp_i_ball(thb), body_exp_i_ball(RB(0))
        report((em * ep).contains_exact(1) and e0.contains_exact(1), f"M={M} mu={mu}: 本文の exp のボールで exp(-iθ̃)exp(iθ̃) ∋ 1、exp(0) ∋ 1")
        report(em.overlaps(qqbar_ball(E(-theta_over_2pi(M, mu)))), f"M={M} mu={mu}: 本文の exp(-iθ̃) のボールが 1 の冪根の値と重なる")

print("RESULT: PASS")
