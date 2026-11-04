# 対象ラベル: trace_of_epsilon_V_plus_via_check_eigenvalues（Step 6 の不等号の 3 つの鎖と Step 7 の同値の鎖）
# Step 6: γ(θ̃_μ)/2 = γ(θ̃_μ)·1/2 > 0·1/2 = 0、2sinh(γ(θ̃_μ)/2) > 2·0 = 0、
#         Π_μ 2sinh(γ(θ̃_μ)/2) > 0（finite_product_of_positive_reals_is_positive。有限積は左から畳み込み、各段が正）、
#         ϰ = C Π_μ 2sinh(γ(θ̃_μ)/2) > 0（C ∈ ℝ_{>0} と ab > 0）。
# Step 7: η = +1 なら tr(εV) = 1_Cϰ_C = ϰ_C。逆に tr(εV) = r_C（r > 0）なら (r, 0) = r_C = (ȟϰ)_C = (ȟϰ, 0) から r = ȟϰ で、
#         ȟ = −1 なら r = ȟϰ = (−1)ϰ = −ϰ < 0 の鎖となり矛盾、よって ȟ = 1、η = ȟ_C = 1_C。
# 球の部: γ(θ̃_μ)・sinh・C の値は ℝ への脱出なので RealBallField(512) の球で、不等号は球の全体が満たすこと、等号は重なりと半径で確かめる。
#   結合定数は有理数の (K_1, K_2) の 4 組と (2 log y, log x) の 3 組、M_col = 2..6。
# Step 7 の包含は ℂ = QQ(i) の厳密な部でも確かめる（r_C := r + 0i、(r, 0) = (s, 0) ⟺ r = s）。ȟ ∈ {1, −1} の両方で、
#   r := ȟϰ（ϰ は Step 6 の球の中心に近い有理数で、正であることを確かめたもの）が正になるのは ȟ = 1 のときだけであることを見る。
load("_prelude.sage")

PARAMS = [(RB(QQ(2) / 5), RB(QQ(4) / 5)), (RB(QQ(6) / 5), RB(QQ(3) / 10)), (RB(QQ(11) / 25), RB(QQ(11) / 25)), (RB(QQ(1) / 10), RB(2))]
PARAMS += [(2 * RB(QQ(y)).log(), RB(QQ(x)).log()) for (x, y) in COUPLINGS]
half = RB(1) / 2
count = 0
negatives = 0
Ci = QuadraticField(-1, 'i')
for (K1, K2) in PARAMS:
    for M in range(2, 7):
        gam = [gamma_tilde_ball(M, mu, K1, K2) for mu in range(1, M + 1)]
        C = (2 * (2 * K2).sinh()).sqrt() ** M
        assert C > 0                                                     # def_second_transfer_matrix_prefactor の ℝ_{>0}
        for g in gam:
            assert g > 0                                                 # gamma_theta_tilde_mu_positive
            assert (g / 2).overlaps(g * half) and g * half > 0 * half and (0 * half) == 0
            assert 2 * (g / 2).sinh() > 2 * 0 and 2 * 0 == 0
            count += 5
        p = 2 * (gam[0] / 2).sinh()
        assert p > 0
        for g in gam[1:]:
            p = p * (2 * (g / 2).sinh())
            assert p > 0
            count += 1
        # Step 6 の第三の鎖の 1 行（finite_product_of_positive_reals_is_positive）と第四の鎖（ϰ の置き方、ab > 0）
        assert p > 0
        kappa = C * p
        assert kappa.overlaps(C * left_product([2 * (g / 2).sinh() for g in gam])) and kappa > 0
        count += 3
        # Step 7（ℂ を QQ(i) で厳密に。ϰ の代わりに、球の中に入る有理数 ϰ_q > 0 を取る）
        kq = QQ(kappa.mid().exact_rational())
        assert kq > 0 and kappa.contains_exact(kq)
        for h in (1, -1):
            tr_val = Ci(h) * Ci(kq)                                       # (1) の右辺 η ϰ_C（η = ȟ_C）
            assert tr_val == Ci(h * kq)                                   # real_inclusion_preserves_product
            is_pos = tr_val.list()[1] == 0 and tr_val.list()[0] > 0       # z > 0 ⟺ z = r_C、r ∈ ℝ_{>0}
            assert is_pos == (h == 1)
            if h == 1:
                assert Ci(1) * Ci(kq) == Ci(kq)
            else:
                r = tr_val.list()[0]
                lines7 = [r, h * kq, (-1) * kq, -kq]                    # r = ȟϰ = (−1)ϰ = −ϰ
                for x, y in zip(lines7, lines7[1:]):
                    assert x == y
                    count += 1
                assert lines7[-1] < 0                                   # −ϰ < 0（ϰ > 0）
            count += 2
        # 否定コントロール: ϰ の sinh の引数に −γ を入れると M_col が奇数のとき負
        if M % 2 == 1:
            assert C * left_product([2 * (-g / 2).sinh() for g in gam]) < 0
            negatives += 1
print(f"checked {count} lines")
print(f"negative controls: {negatives}")
print("RESULT: PASS")
