# 対象ラベル: transpose_of_identity_matrix_of_order_two
# 人手の 5 行の鎖 I^⊤ = (I_{11} I_{21}; I_{12} I_{22}) = (δ_{11} δ_{21}; δ_{12} δ_{22}) = (1 0; 0 1)
#   = (δ_{11} δ_{12}; δ_{21} δ_{22}) = I を 1 行ずつ確かめる（I = I_{Mat(2,ℂ)}）。
# 転置は def_matrix_transpose の成分の式（body_transpose）、単位行列は def_identity_matrix・def_kronecker_delta の
# 成分の式（body_identity・body_delta）で組み、Sage の transpose()・identity_matrix と一致することを見てから使う。
# 対照: 行列単位 E_{12} = (0 1; 0 0) は、同じ組み方の転置で変わる。
load("../../_shared/pauli_sites_exact.sage")

Id = body_identity(KG, 2)
assert Id == identity_matrix(KG, 2) == I2
T = body_transpose(Id)
assert T == Id.transpose()
d = lambda a, b: body_delta(KG, a, b)
lines = [
    T,
    matrix(KG, [[Id[0, 0], Id[1, 0]], [Id[0, 1], Id[1, 1]]]),   # def_matrix_transpose（m = n = 2）
    matrix(KG, [[d(1, 1), d(2, 1)], [d(1, 2), d(2, 2)]]),        # def_identity_matrix（n = 2）
    matrix(KG, [[1, 0], [0, 1]]),                               # def_kronecker_delta
    matrix(KG, [[d(1, 1), d(1, 2)], [d(2, 1), d(2, 2)]]),        # def_kronecker_delta
    Id,                                                         # def_identity_matrix（n = 2）
]
check_chain(lines, "transpose_of_identity_matrix_of_order_two")
E12 = matrix(KG, [[0, 1], [0, 0]])
assert body_transpose(E12) != E12
print(f"  {len(lines) - 1} 段が成り立つ（QQ(i) の厳密計算）")
print("  対照 1 件: 行列単位 E_12 は転置で変わる")
print("RESULT: PASS")
