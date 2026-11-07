# 対象ラベル: norm_squared_of_sum_of_unit_vector_and_its_epsilon_real_image_is_at_most_four
# 証明の準備（‖x‖^2 = (√Σ|x_k|^2)^2 = Σ|x_k|^2 の 2 行を x → u, ε_ℝu, v で、|v_k|^2 の 4 行の鎖をすべての k で）と
# 主張の 8 行の鎖
#   ‖v‖^2 = Σ|v_k|^2 ≤ Σ(2|u_k|^2 + 2|(ε_ℝu)_k|^2) = Σ2|u_k|^2 + Σ2|(ε_ℝu)_k|^2 = 2Σ|u_k|^2 + 2Σ|(ε_ℝu)_k|^2
#         = 2‖u‖^2 + 2‖ε_ℝu‖^2 = 2‖u‖^2 + 2‖u‖^2 = 2·1^2 + 2·1^2 = 4
# を、M_col = 1, 2, 3, 4、‖u‖ = 1 の u（各 M_col で 6 本。負の成分を含むもの、ε_ℝu = u で等号になるものを含む）で厳密に（AA）確かめる。
load("../epsilon_entries_in_row_configuration_numbering/_epsilon_exact.sage")


def rho(B):
    """def_real_matrix_of_real_entry_matrix: 成分がすべて実数の複素行列 B から B_ℝ。"""
    assert all(z.imag() == 0 for z in B.list())
    return matrix(AA, B.nrows(), B.ncols(), [AA(z.real()) for z in B.list()])


def rabs(q):
    """def_real_absolute_value。"""
    return q if q >= 0 else -q


def norm(w):
    """def_matrix_norm（K = ℝ）: √(Σ|w_i|²)（AA の平方根。非負の根）。"""
    return AA(sum(rabs(x) ** 2 for x in w)).sqrt()


def check(M, u):
    d = 2 ** M
    assert norm(u) == 1                                          # 仮定 ‖u‖ = 1
    ER = rho(epsilon_site_product(M))                            # def_epsilon_real
    Eu = ER * vector(AA, u)                                      # def_real_matrix_vector_product
    v = [u[k] + Eu[k] for k in range(d)]                         # v の定義
    steps = 0
    for x in [u, list(Eu), v]:                                   # 準備: ‖x‖^2 の 2 行
        S = sum(rabs(xk) ** 2 for xk in x)
        assert S >= 0
        assert norm(x) ** 2 == AA(S).sqrt() ** 2, (M, "準備 1 行目")
        assert AA(S).sqrt() ** 2 == S, (M, "準備 2 行目")
        steps += 2
    for k in range(d):                                           # 準備: |v_k|^2 の 4 行
        a, b = u[k], Eu[k]
        l = [rabs(v[k]) ** 2, v[k] ** 2, (a + b) ** 2, 2*a**2 + 2*b**2, 2*rabs(a)**2 + 2*rabs(b)**2]
        assert l[0] == l[1] and l[1] == l[2], (M, k, "1・2 行目")
        assert l[2] <= l[3], (M, k, "3 行目")
        assert l[3] == l[4], (M, k, "4 行目")
        steps += 4
    l = [norm(v) ** 2,
         sum(rabs(v[k]) ** 2 for k in range(d)),
         sum(2*rabs(u[k])**2 + 2*rabs(Eu[k])**2 for k in range(d)),
         sum(2*rabs(u[k])**2 for k in range(d)) + sum(2*rabs(Eu[k])**2 for k in range(d)),
         2*sum(rabs(u[k])**2 for k in range(d)) + 2*sum(rabs(Eu[k])**2 for k in range(d)),
         2*norm(u)**2 + 2*norm(list(Eu))**2,
         2*norm(u)**2 + 2*norm(u)**2,
         2*1**2 + 2*1**2,
         4]
    ops = ["==", "<=", "==", "==", "==", "==", "==", "=="]
    for i, op in enumerate(ops):
        if op == "==":
            assert l[i] == l[i + 1], (M, f"主張の {i + 1} 行目")
        else:
            assert l[i] <= l[i + 1], (M, f"主張の {i + 1} 行目")
    steps += len(ops)
    assert norm(v) ** 2 <= 4, (M, "主張")
    return steps, norm(v) ** 2 == 4


def normalize(w):
    n = norm(w)
    return [AA(x) / n for x in w]

total = 0
count = 0
equal_cases = 0
set_random_seed(20261107)
for M in [1, 2, 3, 4]:
    d = 2 ** M
    ER = rho(epsilon_site_product(M))
    samples = []
    e1 = [AA(0)] * d; e1[0] = AA(1)
    samples.append(e1)                                           # 単位ベクトル e_1
    fixed = list(ER * vector(AA, e1)); fixed[0] += 1             # e_1 + ε_ℝe_1 は ε_ℝ で動かない
    samples.append(normalize(fixed))                             # ε_ℝu = u のとき ‖v‖^2 = 4（等号）
    while len(samples) < 6:
        w = [AA(QQ.random_element(num_bound=9, den_bound=5)) for _ in range(d)]
        if any(x != 0 for x in w):
            samples.append(normalize(w))
    for u in samples:
        s, eq = check(M, u)
        total += s
        count += 1
        equal_cases += int(eq)
assert equal_cases >= 4
# 否定コントロール: 仮定 ‖u‖ = 1 を外すと ‖v‖^2 ≤ 4 は成り立たない（u = 2e_1、M_col = 1 で ‖v‖^2 = 8）
M = 1
u = [AA(2), AA(0)]
Eu = rho(epsilon_site_product(M)) * vector(AA, u)
assert norm([u[k] + Eu[k] for k in range(2)]) ** 2 == 8, "否定コントロール"
print(f"{count} 本の (M_col, u) で、準備と主張の鎖の {total} 段が成り立った（等号 ‖v‖^2 = 4 は {equal_cases} 本）。否定コントロール 1 件")
print("RESULT: PASS")
