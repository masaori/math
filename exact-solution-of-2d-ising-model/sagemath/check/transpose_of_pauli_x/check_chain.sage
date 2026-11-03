# 対象ラベル: transpose_of_pauli_x
# 人手の 3 行の鎖 (σ^x)^⊤ = ((σ^x)_{11} (σ^x)_{21}; (σ^x)_{12} (σ^x)_{22}) = (0 1; 1 0) = σ^x を 1 行ずつ確かめる。
# 転置は def_matrix_transpose の成分の式（body_transpose）で組み、Sage の transpose() と一致することを見てから使う。
# 対照: 対称でない 2 次の行列 σ^xσ^z = (0 -1; 1 0) は、同じ組み方の転置で変わる。
load("../../_shared/pauli_sites_exact.sage")

T = body_transpose(SX)
assert T == SX.transpose()
lines = [
    T,
    matrix(KG, [[SX[0, 0], SX[1, 0]], [SX[0, 1], SX[1, 1]]]),   # def_matrix_transpose（m = n = 2）
    matrix(KG, [[0, 1], [1, 0]]),                              # σ^x の成分
    SX,                                                        # σ^x
]
check_chain(lines, "transpose_of_pauli_x")
XZ = body_product(SX, SZ)
assert body_transpose(XZ) != XZ
print(f"  {len(lines) - 1} 段が成り立つ（QQ(i) の厳密計算）")
print("  対照 1 件: 対称でない σ^xσ^z は転置で変わる")
print("RESULT: PASS")
