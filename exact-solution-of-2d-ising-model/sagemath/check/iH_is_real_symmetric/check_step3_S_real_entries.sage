# 対象ラベル: iH_is_real_symmetric
# Step 3 の最後の 2 段落（S_2・S_1^{(+)} の成分が実数であること）を、M_col = 2..7 について、係数 K_1・K_2^* を
# QQ 上の不定元（実数の代表）として QQ(i) 係数の多項式環に入れた行列の厳密計算で確かめる。浮動小数点は使わない。
#   σ_m^x の成分が実 → Σσ_m^x の成分が実（finite_sum_of_real_entry_matrices_has_real_entries, r → M_col）
#   → S_2 = (K_2^*)_C Σσ_m^x の成分が実（real_scalar_multiple_of_real_entry_matrix_has_real_entries, c → K_2^*）
#   σ_m^zσ_{m+1}^z の成分が実 → Σσ^zσ^z の成分が実（r → M_col - 1）→ (K_1)_C Σσ^zσ^z と (K_1)_C G の成分が実
#   → S_1^{(+)} = (K_1)_C Σσ^zσ^z - (K_1)_C G の成分が実（difference_of_real_entry_matrices_has_real_entries）
# S_2・S_1^{(+)} は iK_2^*H_2・iK_1H_1^{(+)} から組み、Step 1・Step 2 の表示と一致することも確かめる。
K.<i> = QuadraticField(-1)
P.<K1, K2s> = PolynomialRing(QQ)
R = P.change_ring(K)
K1, K2s = R(K1), R(K2s)
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
def is_real_matrix(X):                          # def_matrix_with_real_entries（係数がすべて虚部 0）
    return all(K(c).imag() == 0 for e in X.list() for c in R(e).coefficients())
count = 0
neg = 0
for Mc in range(2, 8):
    sx = [site(Mc, m, SX).change_ring(R) for m in range(1, Mc + 1)]
    zz = [(site(Mc, m, SZ) * site(Mc, m + 1, SZ)).change_ring(R) for m in range(1, Mc)]
    G = kron([SY] + [SX] * (Mc - 2) + [SY]).change_ring(R)
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
    checks = [
        all(is_real_matrix(X) for X in sx),                # σ_m^x の成分が実（上で見たこと）
        is_real_matrix(lsum(sx)),                          # finite_sum_of_real_entry_matrices_has_real_entries（r → M_col）
        is_real_matrix(K2s * lsum(sx)),                    # real_scalar_multiple_...（c → K_2^*）
        is_real_matrix(S2),                                # Step 1 の表示より S_2
        all(is_real_matrix(X) for X in zz),                # σ_m^zσ_{m+1}^z の成分が実
        is_real_matrix(lsum(zz)),                          # finite_sum_...（r → M_col - 1）
        is_real_matrix(G),                                 # G の成分が実（上で見たこと）
        is_real_matrix(K1 * lsum(zz)),                     # real_scalar_multiple_...（c → K_1, B → Σσ^zσ^z）
        is_real_matrix(K1 * G),                            # real_scalar_multiple_...（c → K_1, B → G）
        is_real_matrix(K1 * lsum(zz) - K1 * G),            # difference_of_real_entry_matrices_has_real_entries
        is_real_matrix(S1),                                # Step 2 の表示より S_1^{(+)}
    ]
    for k, ok in enumerate(checks, start=1):
        assert ok, f"M_col = {Mc}: 第 {k} 項が実でない"
        count += 1
    # 否定コントロール: 係数 i を掛けない H_2・H_1^{(+)} は成分が実でない（純虚数の成分を持つ）
    assert not is_real_matrix(H2) and not is_real_matrix(H1p), Mc
    neg += 1
print(f"  {count} 項（M_col = 2..7 で σ^x・Σσ^x・K_2^*Σσ^x・S_2・σ^zσ^z・Σσ^zσ^z・G・K_1Σσ^zσ^z・K_1G・差・S_1^(+) の成分の実性。係数は不定元、QQ[i] の厳密計算）")
print(f"  否定コントロール {neg} 件: i を掛けない H_2・H_1^(+) は成分が実でない（M_col ごと）")
print("RESULT: PASS")
