# 対象ラベル: linearity_of_T_on_check_Z_Y
# g := (V_1^(+))^{1/2} = exp(X)（def_V1_plus_square_root。X := ((i/2)(K_1)_C)H_1^(+)）を、K_1 := 2 log y（y ∈ QQ, y > 1）と選んで
# 厳密に作る: X = (log y)(iH_1^(+)) で iH_1^(+) は整数の固有値をもつ整数行列なので、exp(±X) は固有値 λ の射影に y^{±λ} を掛けて
# QQ に入る（transfer_matrix_factor_inverses.sage の exp_V1_half_exact。g^{-1} = exp(-X) は matrix_exp_conjugation (3)）。
# ℝ への脱出は K_1 の選び方と、Ž_μ・Y̌_μ の位相を 1 の冪根で表すこと（half_integer_check_operators.sage の冒頭）で、検算の等号は全て L[a, b] の中で厳密に判定する。
import sys
load("../../_shared/linearity_of_conjugation_on_check_Z_Y.sage")

Ms = [int(m) for m in sys.argv[1:]] or [2, 3, 4]
for M in Ms:
    for y in [QQ(2), QQ(3) / 2]:
        S = exp_V1_half_exact(M, y, 1)
        S_inv = exp_V1_half_exact(M, y, -1)
        check_linearity_for(M, S, S_inv, f"M={M} y={y}", "S")
print("RESULT: PASS")
