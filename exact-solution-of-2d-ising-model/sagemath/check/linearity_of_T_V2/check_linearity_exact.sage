# 対象ラベル: linearity_of_T_V2
# g := V_2 を def_transfer_matrix の成分 exp(K_2 n) で作る。K_2 := log x（x ∈ QQ, x > 1）と選ぶと成分は x^n で QQ に入る
# （row_configurations.sage の V2_by_components）。g^{-1} は Sage の inverse で QQ に作り、本文の成分の式の積で左右の逆元であることを確かめる
# （逆元は一意なので、V2_invertible の主張の (a^{-1})_C exp(-Y) と同じ行列である。その一致は T_actions_on_check_Z_Y の検算が確かめる）。
# ℝ への脱出は K_2 の選び方と、Ž_μ・Y̌_μ の位相を 1 の冪根で表すこと（half_integer_check_operators.sage の冒頭）で、検算の等号は全て L[a, b] の中で厳密に判定する。
import sys
load("../../_shared/linearity_of_conjugation_on_check_Z_Y.sage")

Ms = [int(m) for m in sys.argv[1:]] or [2, 3, 4]
for M in Ms:
    for x in [QQ(2), QQ(3)]:
        V2 = V2_by_components(M, lambda m: x**m, QQ)
        V2_inv = V2.inverse()
        check_linearity_for(M, V2, V2_inv, f"M={M} x={x}", "V_2")
print("RESULT: PASS")
