# 対象ラベル: transpose_of_pauli_z
# 人手の 3 行の鎖 (σ^z)^⊤ = ((σ^z)_{11} (σ^z)_{21}; (σ^z)_{12} (σ^z)_{22}) = (1 0; 0 -1) = σ^z を 1 行ずつ確かめる。
# 転置は def_matrix_transpose の成分の式（body_transpose）で組み、Sage の transpose() と一致することを見てから使う。
# 対照: 対称でない 2 次の行列 σ^zσ^x = (0 1; -1 0) は、同じ組み方の転置で変わる。
load("../../_shared/pauli_sites_exact.sage")

T = body_transpose(SZ)
assert T == SZ.transpose()
lines = [
    T,
    matrix(KG, [[SZ[0, 0], SZ[1, 0]], [SZ[0, 1], SZ[1, 1]]]),   # def_matrix_transpose（m = n = 2）
    matrix(KG, [[1, 0], [0, -1]]),                             # σ^z の成分
    SZ,                                                        # σ^z
]
check_chain(lines, "transpose_of_pauli_z")
ZX = body_product(SZ, SX)
assert body_transpose(ZX) != ZX
print(f"  {len(lines) - 1} 段が成り立つ（QQ(i) の厳密計算）")
print("  対照 1 件: 対称でない σ^zσ^x は転置で変わる")
print("RESULT: PASS")
