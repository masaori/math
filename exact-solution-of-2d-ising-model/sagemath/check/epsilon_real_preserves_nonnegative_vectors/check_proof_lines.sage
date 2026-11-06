# 対象ラベル: epsilon_real_preserves_nonnegative_vectors
# 証明の 3 行の鎖 (ε_ℝu)_k = (ε_ℝu)_{ord(s)} = u_{ord(-s)} ≥ 0 を、
# M_col = 1, 2, 3, 4 の全ての k と、成分が非負の有理数のベクトル u（各 M_col で 5 本）で厳密に（QQbar・AA）確かめる。
load("../epsilon_entries_in_row_configuration_numbering/_epsilon_exact.sage")


def rho(B):
    """def_real_matrix_of_real_entry_matrix: 成分がすべて実数の複素行列 B から B_ℝ。"""
    assert all(z.imag() == 0 for z in B.list())
    return matrix(AA, B.nrows(), B.ncols(), [AA(z.real()) for z in B.list()])


def check(M, u):
    assert all(x >= 0 for x in u)                                # 仮定 u_k ≥ 0
    ER = rho(epsilon_site_product(M))                            # def_epsilon_real
    d = 2 ** M
    Eu = ER * vector(AA, u)                                      # def_real_matrix_vector_product
    inv = {ord_(s): s for s in configurations(M)}                # ord の逆引き
    assert set(inv) == set(range(1, d + 1)), (M, "全ての k が ord(s) と書ける")   # row_configuration_numbering_bijective
    for k in range(1, d + 1):
        s = inv[k]                                               # k = ord(s)
        km = ord_(neg(s))
        assert 1 <= km <= d, (M, s, "ord(-s) の値域")
        chain = [Eu[k - 1], Eu[ord_(s) - 1], u[km - 1]]          # (ε_ℝu)_k = (ε_ℝu)_{ord(s)} = u_{ord(-s)}
        assert all(c == chain[0] for c in chain), (M, k, "等号の 2 行")
        assert chain[-1] >= 0, (M, k, "最後の不等号")
        assert Eu[k - 1] >= 0, (M, k, "主張")

count = 0
set_random_seed(20261106)
for M in [1, 2, 3, 4]:
    for _ in range(5):
        u = [AA(abs(QQ.random_element(num_bound=9, den_bound=5))) for _ in range(2 ** M)]
        check(M, u)
        count += 1
# 否定コントロール: 仮定を外し、成分に負の数を含む u では (ε_ℝu)_k < 0 の k が在る
M = 2
u = [AA(-1), AA(0), AA(0), AA(0)]
Eu = rho(epsilon_site_product(M)) * vector(AA, u)
assert any(x < 0 for x in Eu)
print(f"{count} 本の (M_col, u) で、全ての k について 3 行の鎖と主張が成り立った。否定コントロール 1 件")
print("RESULT: PASS")
