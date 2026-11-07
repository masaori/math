# 対象ラベル: sum_of_nonnegative_vector_and_its_epsilon_real_image_is_nonzero
# 準備（u_{k_0} ≠ 0 なる k_0、u_{k_0} > 0、(ε_ℝu)_{k_0} ≥ 0）と、証明の 4 行の鎖
#   v_{k_0} = u_{k_0} + (ε_ℝu)_{k_0} ≥ u_{k_0} + 0 = u_{k_0} > 0
# を、M_col = 1, 2, 3, 4、成分が非負の有理数で 0 でないベクトル u（各 M_col で 8 本。0 でない成分が 1 個だけのものを含む）の、
# u_{k_0} ≠ 0 を満たすすべての k_0 で厳密に（AA）確かめる。
load("../epsilon_entries_in_row_configuration_numbering/_epsilon_exact.sage")


def rho(B):
    """def_real_matrix_of_real_entry_matrix: 成分がすべて実数の複素行列 B から B_ℝ。"""
    assert all(z.imag() == 0 for z in B.list())
    return matrix(AA, B.nrows(), B.ncols(), [AA(z.real()) for z in B.list()])


def check(M, u):
    d = 2 ** M
    assert all(x >= 0 for x in u)                                # 仮定 u_k ≥ 0
    assert any(x != 0 for x in u)                                # 仮定 u ≠ 0
    ER = rho(epsilon_site_product(M))                            # def_epsilon_real
    Eu = ER * vector(AA, u)                                      # def_real_matrix_vector_product
    v = [u[k] + Eu[k] for k in range(d)]                         # v の定義
    n_lines = 0
    for k0 in range(d):
        if u[k0] == 0:
            continue                                             # u_{k_0} ≠ 0 なる k_0 だけ
        assert u[k0] > 0, (M, k0, "準備: u_{k_0} > 0")
        assert Eu[k0] >= 0, (M, k0, "準備: (ε_ℝu)_{k_0} ≥ 0")
        l1, l2, l3, l4 = v[k0], u[k0] + Eu[k0], u[k0] + 0, u[k0]
        assert l1 == l2, (M, k0, "1 行目")
        assert l2 >= l3, (M, k0, "2 行目")
        assert l3 == l4, (M, k0, "3 行目")
        assert l4 > 0, (M, k0, "4 行目")
        assert v[k0] != 0, (M, k0, "結び v_{k_0} ≠ 0")
        n_lines += 4
    assert any(x != 0 for x in v), (M, "主張 v ≠ 0")
    return n_lines

total = 0
count = 0
set_random_seed(20261107)
for M in [1, 2, 3, 4]:
    d = 2 ** M
    samples = []
    for j in range(d):                                           # 0 でない成分が 1 個だけ（e_j の正の倍）
        if len(samples) >= 4:
            break
        u = [AA(0)] * d
        u[j] = AA(QQ.random_element(num_bound=9, den_bound=5).abs() + 1)
        samples.append(u)
    while len(samples) < 8:
        u = [AA(abs(QQ.random_element(num_bound=9, den_bound=5))) for _ in range(d)]
        if any(x != 0 for x in u):
            samples.append(u)
    for u in samples:
        total += check(M, u)
        count += 1
# 否定コントロール: 仮定 u_k ≥ 0 を外すと v = 0 になる u が在る（u_{ord(s)} = 1, u_{ord(-s)} = -1）
M = 1
u = [AA(1), AA(-1)]
Eu = rho(epsilon_site_product(M)) * vector(AA, u)
assert all(u[k] + Eu[k] == 0 for k in range(2)), "否定コントロール"
print(f"{count} 本の (M_col, u) で、u_(k_0) ≠ 0 のすべての k_0 について鎖の {total} 段と主張が成り立った。否定コントロール 1 件")
print("RESULT: PASS")
