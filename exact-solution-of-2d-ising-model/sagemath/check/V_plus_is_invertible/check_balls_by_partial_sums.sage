# 対象ラベル: V_plus_is_invertible
# check_exact_factors.sage の (b) と同じ行を、exp を def_exp の部分和（冪は A^{p+1} := A^p A）に尾の上界を
# 各成分の半径として足した 256 ビットのボール（共有の準備の exp_ball。Sage の ComplexBallField の exp と重なることも確かめる）で
# 作って確かめる（ℝ への脱出: exp の極限）。とくに Step 1 の exp_of_negative_is_left_inverse の行（exp(−A)exp(A) = I）を、
# 射影から作る厳密版とは独立に、def_exp の級数そのもので確かめる。
# K_1 ∈ {1/4, 1/2}、K_2^* ∈ {1/3, 1/2} は有理数に取り、K_2 は def_second_dual_coupling_constant の K_2^* = -(1/2) log tanh K_2 を
# 満たす K_2 := artanh(u)（u := exp(-2K_2^*)）とする（V_plus_is_positive_definite のボール版と同じ置き方）。
# このとき V_2 の成分の exp(K_2 n) = ((1+u)/(1-u))^{n/2}、s_2 = sinh 2K_2 = 2u/(1-u^2)。
# a = (2s_2)^{M/2} はボールの冪で作り、a^{-1} は主張の置き方どおり a の ℝ の逆数（ボールの逆数）とする。判定は許容誤差を置かず、等号はボールが重なることで行う。
load("_prelude.sage")

RBv = RealBallField(256)
n_lines = 0
n_neg = 0


def chain_overlaps(lines, what):
    global n_lines
    for r in range(len(lines) - 1):
        assert balls_overlap(lines[r], lines[r + 1]), (what, r)
        n_lines += 1


for M in range(2, 5):
    n = 2**M
    Id = identity_matrix(CB, n)
    H1 = H1_plus(M)
    H2m = H2(M)
    for K2s in [QQ(1) / 3, QQ(1) / 2]:
        u = RBv(-2 * K2s).exp()
        eK2 = ((1 + u) / (1 - u)).sqrt()
        s2 = 2 * u / (1 - u**2)
        assert s2 > 0
        a = (2 * s2) ** (RBv(M) / 2)
        assert a > 0
        ainv = 1 / a
        assert ainv.overlaps((2 * s2) ** (-RBv(M) / 2))   # 別の経路 (2s_2)^{-M/2} の実数冪と重なる
        aC, ainvC = CB(a), CB(ainv)
        V2 = V2_by_components(M, lambda m: eK2**m, CB)
        S2 = body_scalar(i_K * K2s, H2m)
        Ap = exp_ball(S2)
        Am = exp_ball(body_negation(S2))
        # Step 1: A_+A_- = exp(−(−S_2))exp(−S_2) = I、A_-A_+ = I
        Ap_nn = exp_ball(body_negation(body_negation(S2)))
        chain_overlaps([Ap * Am, Ap_nn * Am, Id], f"M={M}: A_+A_-")
        chain_overlaps([Am * Ap, Id], f"M={M}: A_-A_+")
        assert balls_disjoint_somewhere(Ap * Ap, Id); n_neg += 1
        for K1 in [QQ(1) / 4, QQ(1) / 2]:
            Xs = body_scalar(i_K / 2 * K1, H1)        # (1/2)S_1^(+) = (i/2)K_1H_1^(+)
            Ep = exp_ball(Xs)
            Em = exp_ball(body_negation(Xs))
            Ep_nn = exp_ball(body_negation(body_negation(Xs)))
            chain_overlaps([Ep * Em, Ep_nn * Em, Id], f"M={M}: E_+E_-")
            chain_overlaps([Em * Ep, Id], f"M={M}: E_-E_+")
            assert balls_disjoint_somewhere(Ep * Ep, Id); n_neg += 1
            X = (Ep * Ap) * Ep
            Y = (Em * Am) * Em
            Vp = aC * X
            Rp = ainvC * Y
            # def_V_plus の (V_1^(+))^{1/2}V_2(V_1^(+))^{1/2} は主張の表示 a_C((E_+A_+)E_+) に重なる
            chain_overlaps([(Ep * V2) * Ep, Vp], f"M={M}: def_V_plus")
            step2 = [Vp * Rp, aC * (X * (ainvC * Y)), aC * (ainvC * (X * Y)), (aC * ainvC) * (X * Y), CB(a * ainv) * (X * Y),
                     X * Y, (X * (Em * Am)) * Em, ((Ep * Ap) * (Ep * (Em * Am))) * Em, ((Ep * Ap) * ((Ep * Em) * Am)) * Em,
                     ((Ep * Ap) * (Id * Am)) * Em, ((Ep * Ap) * Am) * Em, (Ep * (Ap * Am)) * Em, (Ep * Id) * Em, Ep * Em, Id]
            chain_overlaps(step2, f"M={M}: Step 2")
            step3 = [Rp * Vp, ainvC * (Y * (aC * X)), ainvC * (aC * (Y * X)), (ainvC * aC) * (Y * X), CB(ainv * a) * (Y * X),
                     Y * X, (Y * (Ep * Ap)) * Ep, ((Em * Am) * (Em * (Ep * Ap))) * Ep, ((Em * Am) * ((Em * Ep) * Ap)) * Ep,
                     ((Em * Am) * (Id * Ap)) * Ep, ((Em * Am) * Ap) * Ep, (Em * (Am * Ap)) * Ep, (Em * Id) * Ep, Em * Ep, Id]
            chain_overlaps(step3, f"M={M}: Step 3")
            # 主張そのもの: def_V_plus から作った V^(+) と R^(+) の積が I に重なる
            Vdef = (Ep * V2) * Ep
            assert balls_overlap(Vdef * Rp, Id) and balls_overlap(Rp * Vdef, Id); n_lines += 2
            # 否定コントロール
            assert balls_disjoint_somewhere(Vdef * (aC * Y), Id); n_neg += 1
            assert balls_disjoint_somewhere(Vdef * (ainvC * ((Em * Ap) * Em)), Id); n_neg += 1
    print(f"  M_col = {M}: K_1 ∈ {{1/4, 1/2}}、K_2^* ∈ {{1/3, 1/2}} で Step 1〜3 の行と主張のボールが重なることを確かめた")
print(f"重なりを確かめた行 {n_lines} 個、否定コントロール {n_neg} 件")
print("RESULT: PASS")
