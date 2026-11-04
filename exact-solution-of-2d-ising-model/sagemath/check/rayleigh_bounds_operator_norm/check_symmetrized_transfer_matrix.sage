# 対象ラベル: rayleigh_bounds_operator_norm
# 本文の W = (BV_2)B（def_symmetrized_transfer_matrix）で証明の行を一行ずつ確かめる。
# K_1 := 2 log y、K_2 := log x（x, y ∈ {2, 3}）と選ぶと、B = Σ_λ y^λ P_λ(D) と V_2（成分 x^n）は QQ に乗り、W も QQ の行列になる。
# ℝ への脱出は K_1・K_2 の選び方と、c(M_col)（上限。AA の代数的数）・ノルム（AA の平方根）の値だけで、等号・不等号は AA の厳密計算である。
load("_prelude.sage")
load("_lines.sage")

set_random_seed(20261104)
for M in [2, 3]:
    n = 2**M
    for xx in [QQ(2), QQ(3)]:
        for yy in [QQ(2), QQ(3)]:
            W = W_exact(M, xx, yy)
            # 因子の順に組み込みの積で作った W と比べる（W_exact は mat_mult の成分の式）
            n_ = W.nrows(); D_ = bond_sum(M); DQ_ = matrix(QQ, n_, n_, [QQ(z) for z in D_.list()])
            B_ = exp_by_spectral_projectors(DQ_, lambda lam: yy**lam, QQ)
            V2_ = V2_by_components(M, lambda m: xx**m, QQ).change_ring(QQ)
            eq(W, B_ * V2_ * B_, f"M_col={M}: W の成分の式と組み込みの積")
            assert is_real_symmetric(W)                       # W_is_real_symmetric_positive_definite
            assert real_rooted_with_signs(W, strict=True)      # 正定値（とくに半正定値）
            c = rayleigh_sup_exact(W)
            assert c > 0
            xs = [random_vector(QQ, n, num_bound=4, den_bound=3) for _ in range(2)]
            xs += [vector(QQ, [1] + [0] * (n - 1))]
            for x in xs:
                check_proof_lines(W, c, x, 3 if M == 2 else 2, f"M_col={M}, K_2=log {xx}, K_1=2log {yy}, x={x}")
    print(f"M_col = {M}: 等号 {n_steps} 個、不等号 {n_ineq} 個（累計）")
print(f"等号 {n_steps} 個、不等号 {n_ineq} 個")
print("RESULT: PASS")
