# real_bilinear_value_is_sum_with_real_matrix_vector_product
# P ∈ Mat(n,ℝ)、u, v ∈ ℝ^n について u^T P v = Σ_k u_k (Pv)_k の 4 行の鎖を、
# P・u・v の成分を不定元に置き、n = 1,…,5 で QQ 上の多項式として厳密に確かめる。
# x^T P y は def_real_bilinear_value のとおり Σ_k Σ_l (x_k P_kl) y_l を、
# (Px)_i は def_real_matrix_vector_product のとおり Σ_j P_ij x_j を、左から順に足して組む。
# 両端は Sage の vector * matrix * vector（本文の式とは別の経路）と比べる。
# 帰属: QQ 上の多項式環。不定元で成り立つ等号は、任意の実数を代入しても成り立つ。


def lsum(terms):
    """def_finite_sum_of_real_numbers: 左から順に足す。"""
    terms = list(terms)
    s = terms[0]
    for q in terms[1:]:
        s = s + q
    return s


def bilin(x, P, y):
    """def_real_bilinear_value の x^T P y。"""
    n = len(x)
    return lsum(lsum((x[k] * P[k][l]) * y[l] for l in range(n)) for k in range(n))


def matvec(P, x):
    """def_real_matrix_vector_product の Px。"""
    n = len(x)
    return [lsum(P[i][j] * x[j] for j in range(n)) for i in range(len(P))]


count = 0
for n in [1, 2, 3, 4, 5]:
    N = range(n)
    names = [f"P_{k}_{l}" for k in N for l in N] + [f"u_{k}" for k in N] + [f"v_{k}" for k in N]
    R = PolynomialRing(QQ, names)
    g = dict(zip(names, R.gens()))
    P = [[g[f"P_{k}_{l}"] for l in N] for k in N]
    u = [g[f"u_{k}"] for k in N]
    v = [g[f"v_{k}"] for k in N]
    Pv = matvec(P, v)
    lines = [
        bilin(u, P, v),                                                    # u^T P v
        lsum(lsum((u[k] * P[k][l]) * v[l] for l in N) for k in N),         # def_real_bilinear_value
        lsum(lsum(u[k] * (P[k][l] * v[l]) for l in N) for k in N),         # 結合則
        lsum(u[k] * lsum(P[k][l] * v[l] for l in N) for k in N),           # finite_sum_of_real_scalar_multiples を各 k へ
        lsum(u[k] * Pv[k] for k in N),                                     # def_real_matrix_vector_product を右辺から左辺へ
    ]
    for i in range(len(lines) - 1):
        assert lines[i] == lines[i + 1], (n, i)
        count += 1
    uv, vv, Pm = vector(R, u), vector(R, v), matrix(R, P)
    assert lines[0] == uv * Pm * vv
    assert lines[-1] == uv.dot_product(Pm * vv)
    # 否定コントロール: (Pv)_k を転置の側 (P^T v)_k に取り違えると、n ≥ 2 で主張が成り立たない
    if n >= 2:
        PTv = matvec([[P[l][k] for l in N] for k in N], v)
        assert bilin(u, P, v) != lsum(u[k] * PTv[k] for k in N)
print(f"4 行の鎖の隣り合う行を n = 1,…,5 で確かめた（{count} 段）。(Pv)_k を (P^T v)_k に取り違えると主張が崩れることも確かめた")
print("RESULT: PASS")
