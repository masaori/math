# 対象ラベル: W_real_bilinear_value_at_sum_of_nonnegative_vector_and_its_epsilon_real_image_is_at_least_twice
# 証明の準備の 3 つ（u^⊤W_ℝũ ≥ 0・ũ^⊤W_ℝu ≥ 0 と和の不等式 2 本、ε_ℝ(W_ℝũ) = W_ℝu の 7 行、ũ^⊤W_ℝũ = A の 5 行。ũ := ε_ℝu は変数 ut で持つ）と主張の 11 行の鎖を、
# 具体の W（M_col = 2, 3、x, y ∈ {2, 3}）と成分が非負の有理数のベクトル u（各組で 4 本、種は固定）で厳密に（AA）確かめる。
# 積と双線型値は def_real_matrix_vector_product・def_real_matrix_product・def_real_bilinear_value の成分の和で作る（Sage の * に頼らない）。
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


def mv(P, x):
    """def_real_matrix_vector_product: (Px)_i := Σ_j P_ij x_j（左から足す）。"""
    n = P.nrows()
    out = []
    for i in range(n):
        s = AA(0)
        for j in range(P.ncols()):
            s = s + P[i, j] * x[j]
        out.append(s)
    return out


def mm(A, B):
    """def_real_matrix_product: (AB)_ik := Σ_j A_ij B_jk。"""
    n = A.nrows()
    out = matrix(AA, n, n)
    for i in range(n):
        for k in range(n):
            s = AA(0)
            for j in range(n):
                s = s + A[i, j] * B[j, k]
            out[i, k] = s
    return out


def bil(x, P, y):
    """def_real_bilinear_value: x^⊤Py := Σ_k Σ_l (x_k P_kl) y_l。"""
    n = P.nrows()
    s = AA(0)
    for k in range(n):
        for l in range(n):
            s = s + (x[k] * P[k, l]) * y[l]
    return s


def dot(x, y):
    s = AA(0)
    for k in range(len(x)):
        s = s + x[k] * y[k]
    return s


def check(ER, WR, u):
    d = WR.nrows()
    I = identity_matrix(AA, d)
    assert all(x >= 0 for x in u)                                 # 仮定 u_k ≥ 0
    ut = mv(ER, u)                                                 # ut := ε_ℝu
    v = [u[k] + ut[k] for k in range(d)]                           # v の定義
    n = 0
    # 一つ目の準備
    assert all(x >= 0 for x in ut)                                 # epsilon_real_preserves_nonnegative_vectors
    assert all(z > 0 for z in WR.list())                          # W_real_has_positive_entries
    A = bil(u, WR, u)                                             # A の定義
    c1 = bil(u, WR, ut)
    c2 = bil(ut, WR, u)
    assert c1 >= 0 and c2 >= 0; n += 2
    assert A + c1 >= A + 0 and c2 + A >= 0 + A; n += 2
    # 二つ目の準備（7 行）
    Ww = mv(WR, ut)
    p2 = [mv(ER, Ww), mv(ER, mv(WR, mv(ER, u))), mv(mm(ER, WR), mv(ER, u)), mv(mm(WR, ER), mv(ER, u)),
          mv(WR, mv(ER, mv(ER, u))), mv(WR, mv(mm(ER, ER), u)), mv(WR, mv(I, u)), mv(WR, u)]
    for a, b in zip(p2, p2[1:]):
        assert a == b; n += 1
    # 三つ目の準備（5 行）
    p3 = [bil(ut, WR, ut), dot(ut, Ww), dot(mv(ER, u), Ww), dot(u, mv(ER, Ww)), dot(u, mv(WR, u)), A]
    for a, b in zip(p3, p3[1:]):
        assert a == b; n += 1
    # 主張の 11 行
    c = [bil(v, WR, v),
         bil(u, WR, v) + bil(ut, WR, v),
         (A + c1) + bil(ut, WR, v),
         (A + c1) + (c2 + bil(ut, WR, ut)),
         (A + c1) + (c2 + A),
         (A + 0) + (c2 + A),
         (A + 0) + (0 + A),
         A + (0 + A),
         A + A,
         1 * A + 1 * A,
         (1 + 1) * A,
         2 * A]
    rel = ["=", "=", "=", "=", ">=", ">=", "=", "=", "=", "=", "="]
    for (a, b), r in zip(zip(c, c[1:]), rel):
        assert (a == b) if r == "=" else (a >= b); n += 1
    assert bil(v, WR, v) >= 2 * A                                 # 主張
    return n


total = 0
count = 0
set_random_seed(20261107)
for M in [2, 3]:
    ER = rho(epsilon(M))                                          # def_epsilon_real
    d = 2 ** M
    for x in [QQ(2), QQ(3)]:
        for y in [QQ(2), QQ(3)]:
            WC, WR = W_complex_and_real(M, x, y)                  # def_W_real
            samples = [[AA(1)] + [AA(0)] * (d - 1)]               # e_1
            while len(samples) < 4:
                samples.append([AA(abs(QQ.random_element(num_bound=9, den_bound=5))) for _ in range(d)])
            for u in samples:
                total += check(ER, WR, u)
                count += 1
# 否定コントロール: 仮定 u_k ≥ 0 を外した u = e_1 − e_4（M_col = 2、x = y = 2。ε_ℝu = −u なので v = 0）では v^⊤W_ℝv < 2u^⊤W_ℝu
M = 2
ER = rho(epsilon(M))
WC, WR = W_complex_and_real(M, QQ(2), QQ(2))
u = [AA(1), AA(0), AA(0), AA(-1)]
w = mv(ER, u)
v = [u[k] + w[k] for k in range(4)]
neg = bil(v, WR, v) < 2 * bil(u, WR, u)
assert neg, "否定コントロール"
print(f"{count} 組の (M_col, x, y, u) で準備と鎖の {total} 段が成り立った。否定コントロール 1 件")
print("RESULT: PASS")
