# 対象ラベル: epsilon_real_is_symmetric
# def_epsilon_real の ε_ℝ := ϱ(ε) を ε の成分から作り、証明の 4 行の鎖
# ((ε_ℝ)_kl)_ℂ = ε_kl = (ε^⊤)_kl = ε_lk = ((ε_ℝ)_lk)_ℂ と、単射性による (ε_ℝ)_kl = (ε_ℝ)_lk を、
# M_col ∈ {1, 2, 3, 4} の全ての k, l で厳密に確かめる。
# 帰属: ℝ の元は AA、ℂ の元は QQbar。r_ℂ := (r, 0) は QQbar(r)。浮動小数点は使わない。

sigma_x = matrix(QQbar, [[0, 1], [1, 0]])


def incl(r):
    """inclusion_rr_to_cc: r ↦ r_ℂ = (r, 0)。"""
    z = QQbar(r)
    assert z.real() == r and z.imag() == 0
    return z


def epsilon(M):
    """epsilon_square_and_eigenvalues の証明の表示 ε = σ^x ⊠ ⋯ ⊠ σ^x（M 個の因子）。"""
    result = matrix(QQbar, [[1]])
    for _ in range(M):
        result = result.tensor_product(sigma_x)
    return result


def rho(B):
    """def_real_matrix_of_real_entry_matrix: 成分がすべて実数の複素行列 B から B_ℝ。"""
    assert all(z.imag() == 0 for z in B.list())               # epsilon_is_real_symmetric の成分の実性
    return matrix(AA, B.nrows(), B.ncols(), [AA(z.real()) for z in B.list()])


count = 0
for M in [1, 2, 3, 4]:
    E = epsilon(M)
    ER = rho(E)                                               # def_epsilon_real
    n = E.nrows()
    Et = matrix(QQbar, n, n, lambda k, l: E[l, k])            # def_matrix_transpose
    assert Et == E                                            # ε^⊤ = ε（epsilon_is_real_symmetric）
    for k in range(n):
        for l in range(n):
            line1 = incl(ER[k, l])
            line2 = E[k, l]                                   # def_epsilon_real
            line3 = Et[k, l]                                  # ε^⊤ = ε
            line4 = E[l, k]                                   # def_matrix_transpose
            line5 = incl(ER[l, k])                            # def_epsilon_real
            assert line1 == line2 == line3 == line4 == line5, (M, k, l)
            assert ER[k, l] == ER[l, k]                       # inclusion_rr_to_cc_is_injective の結論
            count += 1
    assert ER.transpose() == ER                               # def_real_symmetric_matrix の意味で対称
# 否定コントロール: 対称でない置換行列（3 元の巡回置換）は鎖の 2→3 行（ε^⊤ = ε）で外れる
C = matrix(QQbar, 3, 3, [0, 1, 0, 0, 0, 1, 1, 0, 0])
assert C.transpose() != C
print(f"{count} 組の (M_col, k, l) で 4 行の鎖と (ε_ℝ)_kl = (ε_ℝ)_lk を確かめた。否定コントロール 1 件")
print("RESULT: PASS")
