# 対象ラベル: trace_V_plus_is_positive
# check_exact.sage と同じ二行と主張を、結合定数を K_1 ∈ {1/4, 1/2}、K_2^* ∈ {1/3, 1/2}（有理数）に取って確かめる。
# exp は def_exp の部分和に尾の上界を各成分の半径として足した 256 ビットのボール（共有の準備の exp_ball）で作る
# （ℝ への脱出: exp の極限）。K_2 := artanh(u)（u := exp(−2K_2^*)）として V_2 の成分 exp(K_2 n) = ((1+u)/(1−u))^{n/2} をボールで作る。
# 許容誤差は置かない。等号はボールの重なり、不等号はボールの全体が満たすことで判定する。
# エルミート性がちょうど成り立つことはボールでは言えないので、その点は check_exact.sage が受け持つ。
load("_prelude.sage")

n_lines = 0
n_neg = 0


def ball_pos_real(z, what):
    """z ∈ ℝ_{>0}：虚部のボールが 0 を含み、実部のボール全体が正。"""
    global n_lines
    assert z.imag().contains_zero() and z.real() > 0, what
    n_lines += 1


for M in range(2, 5):
    n = 2**M
    H1 = H1_plus(M)
    H2m = H2(M)
    for K2s in [QQ(1) / 3, QQ(1) / 2]:
        u = RealBallField(256)(-2 * K2s).exp()
        eK2 = ((1 + u) / (1 - u)).sqrt()
        V2 = V2_by_components(M, lambda m: eK2**m, CB)
        for K1 in [QQ(1) / 4, QQ(1) / 2]:
            B = exp_ball(body_scalar(i_K / 2 * K1, H1))     # (V_1^(+))^{1/2} = exp((i/2)K_1H_1^(+))
            Vp = (B * V2) * B                                # def_V_plus
            assert Vp.nrows() == n and Vp.ncols() == n
            # 1 行目: V^(+) は正定値（エルミート性はボールの重なり、首座小行列式の実部が正）
            assert balls_overlap(Vp.conjugate_transpose(), Vp); n_lines += 1
            for k in range(1, n + 1):
                ball_pos_real(Vp.submatrix(0, 0, k, k).det(), f"M={M}: 首座小行列式 {k}")
            # 2 行目の中身: b^{(k)*}V^(+)b^{(k)} = V^(+)_kk ∈ ℝ_{>0}、tr = Σ V^(+)_kk
            for k in range(n):
                b = standard_vector(n, k, CB)
                val = (b.conjugate() * Vp) * b
                assert (val - Vp[k, k]).real().contains_zero() and (val - Vp[k, k]).imag().contains_zero(); n_lines += 1
                ball_pos_real(val, f"M={M}, k={k}: r_k > 0")
            # r_k は V^(+)_kk の実部のボール。Σ_k V^(+)_kk と Σ_k r_k の重なり、Σ r_k ≥ r_1 > 0
            r = [Vp[k, k].real() for k in range(n)]
            tr_def = trace_by_definition(Vp)
            assert (tr_def.real() - sum(r)).contains_zero() and tr_def.imag().contains_zero(); n_lines += 1
            assert sum(r) - r[0] >= 0 and r[0] > 0; n_lines += 1
            assert (tr_def - Vp.trace()).real().contains_zero(); n_lines += 1
            # 主張: tr(V^(+)) ∈ ℝ_{>0}
            ball_pos_real(tr_def, f"M={M}, K_1={K1}, K_2^*={K2s}: tr(V^(+)) > 0")
            # 否定コントロール: −V^(+) のトレースは実部のボール全体が負
            assert trace_by_definition(-Vp).real() < 0; n_neg += 1
    print(f"M_col = {M}: K_1 ∈ {{1/4, 1/2}}, K_2^* ∈ {{1/3, 1/2}} で二行と主張をボールで確かめた")

print(f"ボールで確かめた行 {n_lines} 個、否定コントロール {n_neg} 件")
print("RESULT: PASS")
