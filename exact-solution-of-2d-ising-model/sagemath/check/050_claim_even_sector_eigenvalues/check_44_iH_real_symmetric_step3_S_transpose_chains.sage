# 対象ラベル: iH_is_real_symmetric
# Step 3 の S_2・S_1^{(+)} の転置の 2 本の鎖を、M_col = 2..7 について、係数 K_1・K_2^* を QQ[i] 上の不定元とした
# 多項式環の行列の厳密計算で一行ずつ確かめる。浮動小数点は使わない。
#   (S_2)^T = (K_2^* Σσ_m^x)^T = K_2^*(Σσ_m^x)^T = K_2^*Σ(σ_m^x)^T = K_2^*Σσ_m^x = S_2
#   (S_1)^T = (K_1Σσ^zσ^z - K_1G)^T = (K_1Σσ^zσ^z)^T - (K_1G)^T = K_1(Σσ^zσ^z)^T - K_1G^T
#           = K_1Σ(σ^zσ^z)^T - K_1G^T = K_1Σσ^zσ^z - K_1G^T = K_1Σσ^zσ^z - K_1G = S_1
# 1 行目の S_2・S_1 は iK_2^*H_2・iK_1H_1^{(+)} から組み、Step 1・Step 2 の表示と一致することも確かめる。
K.<i> = QuadraticField(-1)
R.<K1, K2s> = PolynomialRing(K)
M2 = MatrixSpace(K, 2, 2)
I2 = M2(1)
SX = M2([[0, 1], [1, 0]]); SY = M2([[0, -i], [i, 0]]); SZ = M2([[1, 0], [0, -1]])
def kron(factors):
    out = matrix(K, 1, 1, [1])
    for A in factors:
        out = out.tensor_product(A)
    return out
def site(Mc, k, A):
    return kron([A if j == k else I2 for j in range(1, Mc + 1)])
def lsum(Xs):                                   # def_finite_sum_of_matrices（左から足す）
    out = Xs[0]
    for X in Xs[1:]:
        out = out + X
    return out
T = lambda X: X.transpose()
count = 0
broken = 0
for Mc in range(2, 8):
    sx = [site(Mc, m, SX).change_ring(R) for m in range(1, Mc + 1)]
    zz = [(site(Mc, m, SZ) * site(Mc, m + 1, SZ)).change_ring(R) for m in range(1, Mc)]
    G = kron([SY] + [SX] * (Mc - 2) + [SY]).change_ring(R)
    # Jordan–Wigner の Z_m, Y_m から H_2, H_1^{(+)} を組む（def_H2・def_H1_plus）
    def Zm(m):
        out = site(Mc, m, SZ)
        for j in range(m - 1, 0, -1):
            out = site(Mc, j, SX) * out
        return out
    def Ym(m):
        out = site(Mc, m, SY)
        for j in range(m - 1, 0, -1):
            out = site(Mc, j, SX) * out
        return out
    H2 = lsum([Zm(m) * Ym(m) for m in range(1, Mc + 1)]).change_ring(R)
    H1p = (lsum([Ym(m) * Zm(m + 1) for m in range(1, Mc)]) - Ym(Mc) * Zm(1)).change_ring(R)
    S2 = (i * K2s) * H2
    S1 = (i * K1) * H1p
    assert S2 == K2s * lsum(sx), Mc                        # Step 1 の S_2 の表示
    assert S1 == K1 * lsum(zz) - K1 * G, Mc                # Step 2 の S_1^{(+)} の表示
    lines2 = [
        T(S2),
        T(K2s * lsum(sx)),
        K2s * T(lsum(sx)),                                 # transpose_of_matrix_scalar_multiple
        K2s * lsum([T(X) for X in sx]),                    # transpose_of_finite_sum_of_matrices
        K2s * lsum(sx),                                    # (σ_m^x)^T = σ_m^x を各項へ
        S2,                                                # Step 1 の表示
    ]
    lines1 = [
        T(S1),
        T(K1 * lsum(zz) - K1 * G),
        T(K1 * lsum(zz)) - T(K1 * G),                      # transpose_of_matrix_difference
        K1 * T(lsum(zz)) - K1 * T(G),                      # transpose_of_matrix_scalar_multiple を 2 箇所
        K1 * lsum([T(X) for X in zz]) - K1 * T(G),         # transpose_of_finite_sum_of_matrices
        K1 * lsum(zz) - K1 * T(G),                         # (σ_m^zσ_{m+1}^z)^T を各項へ
        K1 * lsum(zz) - K1 * G,                            # G^T = G
        S1,                                                # Step 2 の表示
    ]
    for name, lines in (("S_2", lines2), ("S_1", lines1)):
        for k, (a, b) in enumerate(zip(lines, lines[1:]), start=1):
            assert a == b, f"M_col = {Mc}, {name}: 第 {k} 行と第 {k+1} 行が一致しない"
            count += 1
    # 否定コントロール（鎖の行を壊す）: G^T = G の行の -K_1G を +K_1G に替えると前の行と一致しない
    assert K1 * lsum(zz) - K1 * T(G) != K1 * lsum(zz) + K1 * G, Mc
    broken += 1
# 否定コントロール: H_1^{(+)} そのもの（係数 i を掛けない）は転置で対称でない（M_col = 3）
Mc = 3
Y1Z2 = site(Mc, 1, SY) * site(Mc, 2, SZ)
assert T(Y1Z2) != Y1Z2
print(f"  {count} 段（M_col = 2..7 の S_2 の 5 行と S_1^(+) の 7 行の鎖。係数は不定元、QQ[i] の厳密計算）")
print(f"  否定コントロール {broken + 1} 件: G^T = G の行の符号を壊すと一致しない（M_col ごと）、Y_1Z_2 は転置で対称でない")
print("RESULT: PASS")
