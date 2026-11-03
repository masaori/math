# 対象ラベル: iH_is_real_symmetric
# Step 3 の最後の文（S_1^{(+)}・S_2 は成分が実で転置について対称なので実対称（def_real_symmetric_complex_matrix）であり、
# real_symmetric_matrix_is_hermitian（n → 2^{M_col}, A → S_1^{(+)} と A → S_2）よりエルミート）を、M_col = 2..7 について、
# 係数 K_1・K_2^* を QQ 上の不定元（実数の代表）として QQ(i) 係数の多項式環に入れた行列の厳密計算で確かめる。浮動小数点は使わない。
# 共役は係数の QQ(i) の共役で取る（不定元は実数の代表なので動かさない）。
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
def conj_entry(e):                              # def_complex_conjugate を係数に（不定元は実数の代表）
    return R(e).map_coefficients(lambda c: c.conjugate())
def conj_transpose(X):                          # def_hermitian_positive_definite の (A^*)_{kl} := conj(A_{lk})
    Xt = X.transpose()
    return matrix(R, Xt.nrows(), Xt.ncols(), {kl: conj_entry(e) for kl, e in Xt.dict().items()})
count = 0
neg = 0
for Mc in range(2, 8):
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
    for name, S in (("S_2", (i * K2s) * H2), ("S_1^(+)", (i * K1) * H1p)):
        assert is_real_matrix(S), (Mc, name)                 # 上で示した成分の実性
        assert S.transpose() == S, (Mc, name)                # 上で示した転置での対称性（def_real_symmetric_complex_matrix の 2 条件）
        assert conj_transpose(S) == S, (Mc, name)            # real_symmetric_matrix_is_hermitian の結論 A^* = A
        count += 3
    # 否定コントロール: i を掛けない H_2 は転置で対称でも成分が実でなく、エルミートでない（H_2^* = -H_2）
    assert H2.transpose() == H2 and not is_real_matrix(H2) and conj_transpose(H2) != H2, Mc
    neg += 1
print(f"  {count} 項（M_col = 2..7 で S_2・S_1^(+) の成分の実性・転置での対称性・A^* = A。係数は不定元、QQ[i] の厳密計算）")
print(f"  否定コントロール {neg} 件: i を掛けない H_2 は転置で対称だが成分が実でなく、エルミートでない（M_col ごと）")
print("RESULT: PASS")
