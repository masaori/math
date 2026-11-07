# 対象ラベル: trace_power_upper_bound
# 本文の W = (BV_2)B（def_symmetrized_transfer_matrix）で証明の行を一行ずつ確かめる。
# K_1 := 2 log y、K_2 := log x（x, y ∈ {2, 3}）と選ぶと、B = Σ_λ y^λ P_λ(D) と V_2（成分 x^n）は QQ に乗り、W も QQ の行列になる。
# ℝ への脱出は K_1・K_2 の選び方と、c(M_col)（上限。AA の代数的数）・ノルム（AA の平方根）の値だけで、等号・不等号は AA の厳密計算である。
load("_prelude.sage")
load("_lines.sage")

for M in [2, 3]:
    for xx in [QQ(2), QQ(3)]:
        for yy in [QQ(2), QQ(3)]:
            W = W_exact(M, xx, yy)
            assert W.nrows() == 2**M                          # d := 2^{M_col}（トレースの鎖の最後の行）
            assert is_real_symmetric(W)                       # W_is_real_symmetric_positive_definite
            assert real_rooted_with_signs(W, strict=True)      # 正定値（とくに半正定値）
            c = rayleigh_sup_exact(W)
            assert c > 0
            check_proof_lines(W, c, 5, f"M_col={M}, K_2=log {xx}, K_1=2log {yy}")
            check_power_of_two_lines(W.nrows(), M, c, 5, f"M_col={M}, K_2=log {xx}, K_1=2log {yy}")
            check_varrho_lines(W, 5, f"M_col={M}, K_2=log {xx}, K_1=2log {yy}")
    print(f"M_col = {M}: 等号 {n_eq} 個、不等号 {n_le} 個（累計）")
print(f"等号 {n_eq} 個、不等号 {n_le} 個")
print("RESULT: PASS")
