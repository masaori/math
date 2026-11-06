# 対象ラベル: epsilon_real_preserves_norm
# 証明の準備（χ(k) := ord(-ord^{-1}(k)) の χ(χ(k)) = k の 5 行、χ の全単射性、(ε_ℝu)_k = u_{χ(k)} の 3 行）と
# 主張の 4 行の鎖 ‖ε_ℝu‖ = √Σ|(ε_ℝu)_k|² = √Σ|u_{χ(k)}|² = √Σ|u_k|² = ‖u‖ を、
# M_col = 1, 2, 3, 4 で有理数のベクトル u（各 M_col で 5 本、負の成分を含む）について厳密に（QQbar・AA）確かめる。
load("../epsilon_entries_in_row_configuration_numbering/_epsilon_exact.sage")


def rho(B):
    """def_real_matrix_of_real_entry_matrix: 成分がすべて実数の複素行列 B から B_ℝ。"""
    assert all(z.imag() == 0 for z in B.list())
    return matrix(AA, B.nrows(), B.ncols(), [AA(z.real()) for z in B.list()])


def norm(w):
    """def_matrix_norm（K = ℝ）: √(Σ|w_i|²)。"""
    return sqrt(sum(abs(x) ** 2 for x in w))


def check(M, u):
    ER = rho(epsilon_site_product(M))                            # def_epsilon_real
    d = 2 ** M
    Eu = ER * vector(AA, u)                                      # def_real_matrix_vector_product
    inv = {ord_(s): s for s in configurations(M)}                # ord^{-1}
    assert set(inv) == set(range(1, d + 1))                      # row_configuration_numbering_bijective
    chi = {k: ord_(neg(inv[k])) for k in range(1, d + 1)}         # χ(k) := ord(-ord^{-1}(k))
    for k in range(1, d + 1):
        chain = [chi[chi[k]], ord_(neg(inv[chi[k]])), ord_(neg(inv[ord_(neg(inv[k]))])),
                 ord_(neg(neg(inv[k]))), ord_(inv[k]), k]        # χ(χ(k)) の 5 行
        assert all(c == chain[0] for c in chain), (M, k, "χ(χ(k)) = k")
        chain = [Eu[k - 1], Eu[ord_(inv[k]) - 1], u[ord_(neg(inv[k])) - 1], u[chi[k] - 1]]
        assert all(c == chain[0] for c in chain), (M, k, "(ε_ℝu)_k = u_{χ(k)}")
    assert sorted(chi.values()) == list(range(1, d + 1)), (M, "χ は全単射")
    chain = [norm(Eu), sqrt(sum(abs(Eu[k - 1]) ** 2 for k in range(1, d + 1))),
             sqrt(sum(abs(u[chi[k] - 1]) ** 2 for k in range(1, d + 1))),
             sqrt(sum(abs(u[k - 1]) ** 2 for k in range(1, d + 1))), norm(u)]
    assert all(c == chain[0] for c in chain), (M, "4 行の鎖")

count = 0
set_random_seed(20261106)
for M in [1, 2, 3, 4]:
    for _ in range(5):
        u = [AA(QQ.random_element(num_bound=9, den_bound=5)) for _ in range(2 ** M)]
        check(M, u)
        count += 1
# 否定コントロール: ε_ℝ を成分が 2 倍の行列に替えるとノルムは保たれない
M = 2
u = [AA(1), AA(2), AA(-3), AA(0)]
assert norm(2 * rho(epsilon_site_product(M)) * vector(AA, u)) != norm(u)
print(f"{count} 本の (M_col, u) で、準備の鎖・χ の全単射性・4 行の鎖が成り立った。否定コントロール 1 件")
print("RESULT: PASS")
