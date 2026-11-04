# 対象ラベル: V_plus_is_positive_definite
# check_exact_chain_and_positivity.sage と同じ行を、exp を def_exp の部分和（冪は A^{p+1} := A^p A）に尾の上界を
# 各成分の半径として足した 256 ビットのボール（共有の準備の exp_ball。Sage の ComplexBallField の exp と重なることも確かめる）で
# 作って確かめる（ℝ への脱出: exp の極限）。K_1 ∈ {1/4, 1/2}、K_2^* ∈ {1/3, 1/2} は有理数に取り、K_2 は
# def_second_dual_coupling_constant の K_2^* = -(1/2) log tanh K_2 を満たす K_2 := artanh(u)（u := exp(-2K_2^*)）とする。
# このとき V_2 の成分の exp(K_2 n) = ((1+u)/(1-u))^{n/2}、s_2 = sinh 2K_2 = 2u/(1-u^2) をボールで作る。
# 判定は許容誤差を置かず、等号はボールが重なること、不等号はボールの全体が満たすことで行う。
# 正定値性は、エルミート性（B^* と B のボールが重なる）と首座小行列式のボールの実部が正・虚部が 0 を含むことで見る
# （エルミート性がちょうど成り立つことはボールでは言えず、厳密版が受け持つ）。
load("_prelude.sage")

RBv = RealBallField(256)


def ball_conj_transpose(A):
    return A.conjugate_transpose()


def ball_positive_definite(A):
    n = A.nrows()
    if not balls_overlap(ball_conj_transpose(A), A):
        return False
    for k in range(1, n + 1):
        d = A.submatrix(0, 0, k, k).det()
        if not (d.imag().contains_zero() and d.real() > 0):
            return False
    return True


def ball_not_positive_definite(A):
    """首座小行列式のどれかのボールの実部が全体として負（正定値でないことの証明になる）。"""
    n = A.nrows()
    return any(A.submatrix(0, 0, k, k).det().real() < 0 for k in range(1, n + 1))


n_lines = 0
n_neg = 0
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
        c = (2 * s2) ** (RBv(M) / 2)
        assert c > 0
        V2 = V2_by_components(M, lambda m: eK2**m, CB)
        S2 = body_scalar(i_K * K2s, H2m)
        A = exp_ball(S2)
        # Step 1 の V_2 の鎖（V2_exponential_representation）
        assert balls_overlap(V2, CB(c) * A); n_lines += 1
        # 否定コントロール: 肩の K_2^* を K_2 に替えた exp(iK_2H_2) では外れる（K_2 はボールなので Sage の exp で作る）
        K2b = eK2.log()
        A_wrong = (CB(0, 1) * CB(K2b) * H2m.change_ring(CB)).exp()
        assert balls_disjoint_somewhere(V2, CB(c) * A_wrong); n_neg += 1
        assert ball_positive_definite(A)
        for K1 in [QQ(1) / 4, QQ(1) / 2]:
            X = body_scalar(i_K / 2 * K1, H1)        # (i/2)K_1H_1^(+) = (1/2)S_1^(+)
            B = exp_ball(X)
            Bp = exp_ball(body_negation(X))
            assert balls_overlap(ball_conj_transpose(B), B); n_lines += 1
            assert ball_positive_definite(B)
            assert balls_overlap(Bp * B, Id); n_lines += 1
            Vp = (B * V2) * B                          # def_V_plus
            rows = [Vp, (B * (CB(c) * A)) * B, (CB(c) * (B * A)) * B, CB(c) * ((B * A) * B),
                    CB(c) * (B * (A * B)), CB(c) * (ball_conj_transpose(B) * (A * B))]   # Step 3 の鎖: 結合、B^* = B
            for q in range(len(rows) - 1):
                assert balls_overlap(rows[q], rows[q + 1]), (M, K1, K2s, q)
                n_lines += 1
            BsAB = ball_conj_transpose(B) * (A * B)
            assert ball_positive_definite(BsAB)
            assert ball_positive_definite(Vp)
            for xv in [vector(CB, [CB(k + 1, k % 3 - 1) for k in range(n)]), vector(CB, [CB((-1)**k) for k in range(n)])]:
                v = (xv.conjugate() * Vp) * xv
                assert v.imag().contains_zero() and v.real() > 0
            # 否定コントロール
            assert balls_disjoint_somewhere(Vp, CB(c**2) * ((B * A) * B)); n_neg += 1
            assert balls_disjoint_somewhere(Vp, CB(c) * ((B * B) * A)); n_neg += 1
            assert ball_not_positive_definite(ball_conj_transpose(B) * ((-A) * B)); n_neg += 1
    print(f"  M_col = {M}: K_1 ∈ {{1/4, 1/2}}、K_2^* ∈ {{1/3, 1/2}} で Step 1〜3 の行のボールが重なり、B・A・B^*AB・V^(+) の正定値性をボールで確かめた")
print(f"重なりを確かめた行 {n_lines} 個、否定コントロール {n_neg} 件")
print("RESULT: PASS")
