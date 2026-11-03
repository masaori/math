# 対象ラベル: action_of_T_check_Vprime_on_check_psi
# ℝ への脱出を含む行を確かめる: Step 5 の極限の等式 exp(X̌)W = W exp(X̌ + cI)、Step 6 の T(W) の鎖の各行、結論の二つの鎖と主張。
# γ(θ~_λ) = arccosh(γ_1(θ~_λ))（実対数）、r_λ = |γ_2(θ~_λ)|（ℝ_{≥0} の平方根）、exp の値（def_exp・def_scalar_exp の極限）を
# RealBallField(512)・ComplexBallField(512) のボールで囲む。行列の exp は def_exp の部分和（積は mat_mult の成分の式）に
# 尾の上界 s^{N+1}/(N+1)!/(1 - s/(N+2))（s は成分の 2 乗和の平方根の上界で、def_matrix_norm のノルム以上）を各成分の半径として足し、
# Sage の ComplexBallField の行列の exp（独立な経路）と重なることも見る。V̌'・exp(-X̌) の冪の積は本文の成分の式（body_product）で、
# μ ごとに作る exp(X̌ + cI)・exp(cI)・exp((X̌ + cI) + (-X̌)) の冪の積は計算量のため Sage の行列積で組む（部分和と尾の上界は同じ）。等号の行はボールが重なることで判定する。
# (V̌')^{-1} は Sage の逆行列（独立な経路）で作り、def_check_Vprime (2) の (V̌')^{-1} = exp(-X̌) を経て鎖に入れる。
# Step 6 の鎖の lines[0] は T(W) を Sage の行列演算（独立な経路）で作ったもので、ログの「第 t 行」は証明の第 t 等号に当たる。
# W・c は二通り: (ψ̌^†_μ, (γ(θ~_μ))_C)、(ψ̌_μ, -(γ(θ~_μ))_C)。
# 範囲: 結合定数 4 組（臨界点 (2,3)・(3,2) を含む）× M_col = 2..5 × 全ての μ。
# 対照: 主張の指数の符号を逆にした exp(∓γ) と重ならない。c = 0 の exp(X̌)W と W exp(X̌) は重ならない（W は X̌ と可換でない）。
load("_prelude.sage")

rep = Report("action_of_T_check_Vprime_on_check_psi: Step 5 の極限・Step 6・結論（ボール）")


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
    return matrix(CB, n, n, lambda r_, c_: CB(E[r_, c_].real().add_error(rad), E[r_, c_].imag().add_error(rad)))


def exp_ball_fast(A):
    """body_exp_ball_cb と同じ部分和と尾の上界で、冪の積だけ Sage の行列積で組む（計算量のため）。"""
    n = A.nrows()
    s = sum((z.real()**2 + z.imag()**2) for z in A.list()).sqrt()
    s = RB(s.upper())
    N = 20
    while not (s < N + 2 and (s**(N + 1) / factorial(N + 1)) < RB(2)**(-300)):
        N += 10
    E = matrix(CB, n, n, 0); Pw = identity_matrix(CB, n)
    for p in range(N + 1):
        E = E + (CB(1) / factorial(p)) * Pw
        if p < N:
            Pw = Pw * A
    rad = (s**(N + 1) / factorial(N + 1) / (1 - s / (N + 2))).upper()
    return matrix(CB, n, n, lambda r_, c_: CB(E[r_, c_].real().add_error(rad), E[r_, c_].imag().add_error(rad)))


def main():
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
            gamR = {}
            for l in J:
                g1 = RB(AA(S.emb(S.gamma1(l, k))))
                gamR[l] = (g1 + (g1**2 - 1).sqrt()).log()          # def_arccosh
            gC = {l: CB(gamR[l]) for l in J}                         # g_λ = (γ(θ~_λ))_C
            dag = {l: body_sum(body_scalar(-r[l] / (2 * sig * b[l]), Zcb[l]), body_scalar(1 / (2 * sig), Ycb[l])) for l in J}
            psi = {l: body_sum(body_scalar(r[l] / (2 * sig * b[l]), Zcb[l]), body_scalar(1 / (2 * sig), Ycb[l])) for l in J}
            U = body_scalar(CB(1) / 2, Icb)
            X = body_finite_sum([body_scalar(gC[l], body_difference(body_product(dag[l], psi[M + 1 - l]), U)) for l in J])
            negX = body_negation(X)
            Vp = body_exp_ball_cb(X)                       # V̌' := exp(X̌)
            Em = body_exp_ball_cb(negX)                    # exp(-X̌)
            Vinv = Vp.inverse()                            # (V̌')^{-1}（独立な経路）
            tag = f"M={M} {kk}"
            rep.check(balls_overlap(Vp, X.exp()) and balls_overlap(Em, negX.exp()), f"exp の部分和のボールと Sage の exp が重なる {tag}", quiet=True)
            rep.check(balls_overlap(Vinv, Em), f"def_check_Vprime (2) の (V̌')^{{-1}} = exp(-X̌) {tag}", quiet=True)
            for mu in J:
                for W, c, sgn, wn in [(dag[mu], gC[mu], +1, "ψ̌^†"), (psi[mu], -gC[mu], -1, "ψ̌")]:
                    cI = body_scalar(c, Icb)
                    Xc = body_sum(X, cI)
                    Ec = exp_ball_fast(Xc)              # exp(X̌ + cI)
                    EcI = exp_ball_fast(cI)             # exp(cI)
                    ec = c.exp()                           # def_scalar_exp の exp(c)
                    t2 = f"W={wn}_{mu} {tag}"
                    # Step 5 の極限の等式
                    rep.check(balls_overlap(body_product(Vp, W), body_product(W, Ec)), f"Step 5 exp(X̌)W = W exp(X̌ + cI) {t2}", quiet=True)
                    # Step 6 の鎖
                    TW = X.exp() * W * X.exp().inverse()                         # T(W) = V̌'W(V̌')^{-1}（Sage の行列演算、独立な経路）
                    lines = [
                        TW,                                                      # T(W)
                        body_product(body_product(Vp, W), Vinv),                 # (V̌'W)(V̌')^{-1}
                        body_product(body_product(Vp, W), Vinv),                 # (exp(X̌)W)(V̌')^{-1}（V̌' := exp(X̌)）
                        body_product(body_product(Vp, W), Em),                   # (exp(X̌)W)exp(-X̌)
                        body_product(body_product(W, Ec), Em),                   # (W exp(X̌ + cI))exp(-X̌)
                        body_product(W, body_product(Ec, Em)),                   # W(exp(X̌ + cI)exp(-X̌))
                        body_product(W, exp_ball_fast(body_sum(Xc, negX))),   # W exp((X̌ + cI) + (-X̌))
                        body_product(W, EcI),                                    # W exp(cI)
                        body_product(W, body_scalar(ec, Icb)),                   # W(exp(c)I)
                        body_scalar(ec, body_product(W, Icb)),                   # exp(c)(WI)
                        body_scalar(ec, W),                                      # exp(c)W
                    ]
                    for t in range(1, len(lines)):
                        rep.check(balls_overlap(lines[t - 1], lines[t]), f"Step 6 の鎖 第 {t} 行 {t2}", quiet=True)
                    # 結論の鎖: exp(±g_μ) = exp((±γ)_C) = (exp(±γ))_C
                    e_real = CB((sgn * gamR[mu]).exp())
                    rep.check(ec.overlaps(CB(sgn * gamR[mu]).exp()) and CB(sgn * gamR[mu]).exp().overlaps(e_real),
                              f"結論 exp(±g_μ) = exp((±γ)_C) = (exp(±γ))_C {t2}", quiet=True)
                    rep.check(balls_overlap(lines[0], body_scalar(e_real, W)), f"主張 T(W) = (exp(±γ(θ~_μ)))_C W {t2}", quiet=True)
                    # 対照
                    rep.check(not balls_overlap(lines[0], body_scalar(CB((-sgn * gamR[mu]).exp()), W)), f"対照 指数の符号を逆にすると重ならない {t2}", quiet=True)
                    rep.check(not balls_overlap(body_product(Vp, W), body_product(W, Vp)), f"対照 c = 0 の exp(X̌)W = W exp(X̌) は成り立たない {t2}", quiet=True)
                    rep.check(gamR[mu] > RB(10)**(-3), f"γ(θ~_μ) は 0 から離れている（対照が効く） {t2}", quiet=True)
        print(f"M={M}: 結合定数 4 組で済み")


main()
rep.finish()
