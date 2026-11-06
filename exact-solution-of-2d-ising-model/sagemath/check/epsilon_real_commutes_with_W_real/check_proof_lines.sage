# 対象ラベル: epsilon_real_commutes_with_W_real
# 証明の 3 行の鎖 ε_ℝW_ℝ = ϱ(εW) = ϱ(Wε) = W_ℝε_ℝ を、具体の W（M_col = 2, 3、x, y ∈ {2, 3}）で厳密に（QQbar・AA）確かめる。
# 積は def_real_matrix_product・mat_mult の成分の和で作る（Sage の * に頼らない）。
load("../W_real_is_symmetric/_W_exact.sage")

sigma_x = matrix(QQbar, [[0, 1], [1, 0]])


def epsilon(M):
    """epsilon_square_and_eigenvalues の証明の表示 ε = σ^x ⊠ ⋯ ⊠ σ^x（M 個の因子）。"""
    result = matrix(QQbar, [[1]])
    for _ in range(M):
        result = result.tensor_product(sigma_x)
    return result


def rho(B):
    """def_real_matrix_of_real_entry_matrix: 成分がすべて実数の複素行列 B から B_ℝ。"""
    assert all(z.imag() == 0 for z in B.list())
    return matrix(AA, B.nrows(), B.ncols(), [AA(z.real()) for z in B.list()])


def matprod(A, B, ring):
    """def_real_matrix_product（ring = AA）・mat_mult（ring = QQbar）: (AB)_ik := Σ_j A_ij B_jk（左から足す）。"""
    n = A.nrows()
    out = matrix(ring, n, n)
    for i in range(n):
        for k in range(n):
            s = ring(0)
            for j in range(n):
                s = s + A[i, j] * B[j, k]
            out[i, k] = s
    return out


count = 0
for M in [2, 3]:
    E = epsilon(M)
    ER = rho(E)                                                  # def_epsilon_real
    for x in [QQ(2), QQ(3)]:
        for y in [QQ(2), QQ(3)]:
            WC, WR = W_complex_and_real(M, x, y)                 # def_W_real
            EW = matprod(E, WC, QQbar)
            WE = matprod(WC, E, QQbar)
            assert EW == WE                                      # epsilon_commutes_with_W の εW = Wε
            line1 = matprod(ER, WR, AA)                             # ε_ℝW_ℝ
            line2 = rho(EW)                                      # ϱ(εW)
            line3 = rho(WE)                                      # ϱ(Wε)
            line4 = matprod(WR, ER, AA)                             # W_ℝε_ℝ
            assert line1 == line2 == line3 == line4, (M, x, y)
            count += 1
# 否定コントロール: ε と可換でない実の行列 N（左上の成分だけ 1）は、鎖の 2→3 行（εN = Nε）で外れる
N = matrix(QQbar, 4, 4, lambda s, t: 1 if (s, t) == (0, 0) else 0)
assert matprod(epsilon(2), N, QQbar) != matprod(N, epsilon(2), QQbar)
print(f"{count} 組の (M_col, x, y) で 3 行の鎖の 4 つの値が一致した。否定コントロール 1 件")
print("RESULT: PASS")
