# 対象ラベル: transpose_of_pauli_y
# 人手の 6 行の鎖 (σ^y)^⊤ = ((σ^y)_{11} (σ^y)_{21}; (σ^y)_{12} (σ^y)_{22}) = (0 i; -i 0) = (-0 i; -i -0)
#   = (-0 -(-i); -i -0) = -(0 -i; i 0) = -σ^y を 1 行ずつ確かめる。
# 転置は def_matrix_transpose の成分の式（body_transpose）、符号反転は def_matrix_negation と multiply_by_minus_one の
# -z := (-1)·z（body_negation・body_neg_scalar）で組み、それぞれ Sage の transpose()・単項の `-` と一致することを見てから使う。
# 対照: 符号反転を落とした (σ^y)^⊤ = σ^y は偽。
load("../../_shared/pauli_sites_exact.sage")

T = body_transpose(SY)
assert T == SY.transpose()
neg = body_neg_scalar
z0 = KG(0)
lines = [
    T,
    matrix(KG, [[SY[0, 0], SY[1, 0]], [SY[0, 1], SY[1, 1]]]),       # def_matrix_transpose（m = n = 2）
    matrix(KG, [[0, i_K], [-i_K, 0]]),                             # σ^y の成分
    matrix(KG, [[neg(z0), i_K], [-i_K, neg(z0)]]),                 # ℂ で 0 = -0
    matrix(KG, [[neg(z0), neg(-i_K)], [-i_K, neg(z0)]]),           # ℂ で i = -(-i)
    body_negation(matrix(KG, [[0, -i_K], [i_K, 0]])),              # def_matrix_negation
    body_negation(SY),                                             # σ^y
]
check_chain(lines, "transpose_of_pauli_y")
assert body_negation(SY) == -SY
assert T != SY
print(f"  {len(lines) - 1} 段が成り立つ（QQ(i) の厳密計算）")
print("  対照 1 件: 符号反転を落とした (σ^y)^⊤ = σ^y は偽")
print("RESULT: PASS")
