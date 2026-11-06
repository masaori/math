# 対象ラベル: epsilon_real_square_is_identity
# 証明の 5 行の鎖 ε_ℝε_ℝ = ϱ(εε) = ϱ(I_{Mat(d,ℂ)}) = ϱ(ε^0) = (ε_ℝ)^0 = I_{Mat(d,ℝ)} を、M_col ∈ {1, 2, 3, 4} で厳密に確かめる。
# 積は def_real_matrix_product・mat_mult の成分の和で作り、冪 A^0 は def_exp (1) の A^0 := I で作る（Sage の * と ^ に頼らない）。
# 帰属: ℝ の元は AA、ℂ の元は QQbar。浮動小数点は使わない。

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


def prod(A, B, ring):
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


def power(A, q, ring):
    """def_exp (1): A^0 := I、A^{q+1} := A^q A。"""
    P = identity_matrix(ring, A.nrows())
    for _ in range(q):
        P = prod(P, A, ring)
    return P


for M in [1, 2, 3, 4]:
    d = 2**M
    E = epsilon(M)
    ER = rho(E)                                               # def_epsilon_real
    line1 = prod(ER, ER, AA)                                  # ε_ℝε_ℝ
    line2 = rho(prod(E, E, QQbar))                            # ϱ(εε)（preserves_product）
    line3 = rho(identity_matrix(QQbar, d))                    # ϱ(I_{Mat(d,ℂ)})（εε = I）
    assert prod(E, E, QQbar) == identity_matrix(QQbar, d)     # epsilon_square_and_eigenvalues
    line4 = rho(power(E, 0, QQbar))                           # ϱ(ε^0)（def_exp (1), K = ℂ）
    line5 = power(ER, 0, AA)                                  # (ε_ℝ)^0（preserves_power, q → 0）
    line6 = matrix(AA, d, d, lambda s, t: 1 if s == t else 0) # def_real_identity_matrix
    assert line1 == line2 == line3 == line4 == line5 == line6, M
# 否定コントロール: 3 元の巡回置換行列 C は CC ≠ I で、鎖の 2→3 行に当たる段が外れる
C = matrix(QQbar, 3, 3, [0, 1, 0, 0, 0, 1, 1, 0, 0])
assert prod(C, C, QQbar) != identity_matrix(QQbar, 3)
print("M_col = 1, 2, 3, 4 で 5 行の鎖の 6 つの値が一致した。否定コントロール 1 件")
print("RESULT: PASS")
