# 対象ラベル: moment_log_convexity
# 本文の W = (BV_2)B（def_symmetrized_transfer_matrix）で証明の行を一行ずつ確かめる。
# K_1 := 2 log y、K_2 := log x（x, y ∈ {2, 3}）と選ぶと W は QQ の行列になる。‖x‖ = 1 の x は e_1 と逆立体射影の有理点（QQ）。
# ℝ への脱出は K_1・K_2 の選び方だけで、等号・不等号は QQ の厳密計算である。
load("_prelude.sage")
load("_lines.sage")

set_random_seed(20261105)
for M in [2, 3]:
    d = 2**M
    for xx in [QQ(2), QQ(3)]:
        for yy in [QQ(2), QQ(3)]:
            W = W_exact(M, xx, yy)
            assert W.nrows() == d                                 # d := 2^{M_col}
            assert is_real_symmetric(W)                           # W_is_real_symmetric_positive_definite（実対称）
            assert real_rooted_with_signs(W, strict=True)          # 正定値
            xs = [vector(QQ, [1 if i == 0 else 0 for i in range(d)]),
                  rational_unit_vector([QQ.random_element(num_bound=4, den_bound=3) for _ in range(d - 1)])]
            for x in xs:
                check_proof_lines(W, x, 5 if M == 2 else 3, f"M_col={M}, K_2=log {xx}, K_1=2log {yy}, x={list(x)}")
    print(f"M_col = {M}: 等号 {n_eq} 個、不等号 {n_le} 個（累計）")
print(f"等号 {n_eq} 個、不等号 {n_le} 個")
print("RESULT: PASS")
