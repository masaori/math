# 対象ラベル: epsilon_real_fixes_sum_of_vector_and_its_image
# v_k := u_k + (ε_ℝu)_k について ε_ℝv = v を示す 10 行の鎖を、M_col ∈ {1, 2, 3}（d = 2, 4, 8）で、
# u の成分を不定元に置いて QQ 上の多項式として厳密に確かめる（隣り合う行の等号を各成分 k で）。
# ε は epsilon_square_and_eigenvalues の証明の表示 σ^x ⊠ ⋯ ⊠ σ^x の成分（0 と 1）で作る。成分は整数なので
# ε_ℝ = ϱ(ε) の成分も同じ整数で、QQ 上に置ける。
# 積は def_real_matrix_vector_product・def_real_matrix_product の成分の和で作る（Sage の * に頼らない）。
# 帰属: QQ 上の多項式環。不定元で成り立つ等号は、任意の実数を代入しても成り立つ。浮動小数点は使わない。


def lsum(terms):
    """def_finite_sum_of_real_numbers: 左から順に足す。"""
    terms = list(terms)
    s = terms[0]
    for q in terms[1:]:
        s = s + q
    return s


def epsilon_real(M):
    """σ^x ⊠ ⋯ ⊠ σ^x（M 個の因子）の成分。整数の行列として返す。"""
    sx = matrix(ZZ, [[0, 1], [1, 0]])
    E = matrix(ZZ, [[1]])
    for _ in range(M):
        E = E.tensor_product(sx)
    return E


def matvec(P, x):
    """def_real_matrix_vector_product: (Px)_i := Σ_j P_ij x_j。"""
    n = len(x)
    return [lsum(P[i][j] * x[j] for j in range(n)) for i in range(len(P))]


def matmul(P, Q):
    """def_real_matrix_product: (PQ)_ik := Σ_j P_ij Q_jk。"""
    n = len(Q)
    return [[lsum(P[i][j] * Q[j][k] for j in range(n)) for k in range(len(Q[0]))] for i in range(len(P))]


count = 0
for M in [1, 2, 3]:
    d = 2**M
    D = range(d)
    R = PolynomialRing(QQ, [f"u_{k}" for k in D])
    u = list(R.gens())
    E = [[R(epsilon_real(M)[k, l]) for l in D] for k in D]           # def_epsilon_real（成分は整数）
    Eu = matvec(E, u)
    v = [u[k] + Eu[k] for k in D]                                    # v_k := u_k + (ε_ℝu)_k
    EEu = matvec(E, Eu)
    EE = matmul(E, E)
    I = [[R(1) if s == t else R(0) for t in D] for s in D]            # def_real_identity_matrix
    assert EE == I                                                   # epsilon_real_square_is_identity（引く主張の確認）
    EE_u = matvec(EE, u)
    I_u = matvec(I, u)
    Ev = matvec(E, v)
    for k in D:
        lines = [
            Ev[k],                                                                   # (ε_ℝv)_k
            lsum(E[k][l] * v[l] for l in D),                                         # def_real_matrix_vector_product
            lsum(E[k][l] * (u[l] + Eu[l]) for l in D),                               # v の定義
            lsum(E[k][l] * u[l] + E[k][l] * Eu[l] for l in D),                       # ℝ の分配則
            lsum(E[k][l] * u[l] for l in D) + lsum(E[k][l] * Eu[l] for l in D),      # finite_sum_of_real_sums
            Eu[k] + EEu[k],                                                          # def_real_matrix_vector_product を右辺から左辺へ 2 か所
            Eu[k] + EE_u[k],                                                         # real_matrix_vector_product_is_associative を右辺から左辺へ
            Eu[k] + I_u[k],                                                          # epsilon_real_square_is_identity
            Eu[k] + u[k],                                                            # real_identity_matrix_is_left_unit_of_real_matrix_vector_product
            u[k] + Eu[k],                                                            # 加法の交換則
            v[k],                                                                    # v の定義を右辺から左辺へ
        ]
        for i in range(len(lines) - 1):
            assert lines[i] == lines[i + 1], (M, k, i)
            count += 1
    # 主張そのものを Sage の行列とベクトルの積（独立な経路）で確かめる
    Em, vv = matrix(R, E), vector(R, v)
    assert Em * vv == vv
    # 否定コントロール: ε_ℝ を自身の 2 乗が単位行列でない行列（1 行目を 2 倍したもの）に替えると、主張が崩れる
    F = [[(2 if k == 0 else 1) * E[k][l] for l in D] for k in D]
    Fu = matvec(F, u)
    w = [u[k] + Fu[k] for k in D]
    assert matvec(F, w) != w
print(f"10 行の鎖の隣り合う行を M_col = 1, 2, 3 の各成分で確かめた（{count} 段）。ε_ℝ を 2 乗が単位行列でない行列に替えると主張が崩れることも確かめた")
print("RESULT: PASS")
