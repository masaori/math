# real_symmetric_matrix_moves_between_factors_of_sum_of_products
# 対称な Q ∈ Mat(n,ℝ)、u, v ∈ ℝ^n について Σ_k (Qu)_k v_k = Σ_k u_k (Qv)_k の 10 行の鎖を、
# Q の上三角の成分（Q_kl = Q_lk）と u・v の成分を不定元に置き、n = 1,…,5 で QQ 上の多項式として厳密に確かめる。
# (Px)_i は def_real_matrix_vector_product のとおり Σ_j P_ij x_j を、和は左から順に足して組む。
# 両端は Sage の (Q u)·v と u·(Q v)（本文の式とは別の経路）と比べる。
# 帰属: QQ 上の多項式環。不定元で成り立つ等号は、任意の実数を代入しても成り立つ。


def lsum(terms):
    """def_finite_sum_of_real_numbers: 左から順に足す。"""
    terms = list(terms)
    s = terms[0]
    for q in terms[1:]:
        s = s + q
    return s


def matvec(P, x):
    """def_real_matrix_vector_product の Px。"""
    n = len(x)
    return [lsum(P[i][j] * x[j] for j in range(n)) for i in range(len(P))]


count = 0
for n in [1, 2, 3, 4, 5]:
    N = range(n)
    names = [f"Q_{k}_{l}" for k in N for l in N if k <= l] + [f"u_{k}" for k in N] + [f"v_{k}" for k in N]
    R = PolynomialRing(QQ, names)
    g = dict(zip(names, R.gens()))
    Q = [[g[f"Q_{min(k, l)}_{max(k, l)}"] for l in N] for k in N]           # 対称: Q_kl = Q_lk
    u = [g[f"u_{k}"] for k in N]
    v = [g[f"v_{k}"] for k in N]
    Qu, Qv = matvec(Q, u), matvec(Q, v)
    lines = [
        lsum(Qu[k] * v[k] for k in N),                                     # Σ_k (Qu)_k v_k
        lsum(lsum(Q[k][l] * u[l] for l in N) * v[k] for k in N),           # def_real_matrix_vector_product を各 k へ
        lsum(v[k] * lsum(Q[k][l] * u[l] for l in N) for k in N),           # 可換則を各 k へ
        lsum(lsum(v[k] * (Q[k][l] * u[l]) for l in N) for k in N),         # finite_sum_of_real_scalar_multiples を右辺から左辺へ
        lsum(lsum(v[k] * (Q[l][k] * u[l]) for l in N) for k in N),         # Q は対称
        lsum(lsum((Q[l][k] * u[l]) * v[k] for l in N) for k in N),         # 可換則
        lsum(lsum((u[l] * Q[l][k]) * v[k] for l in N) for k in N),         # 可換則
        lsum(lsum(u[l] * (Q[l][k] * v[k]) for l in N) for k in N),         # 結合則
        lsum(lsum(u[l] * (Q[l][k] * v[k]) for k in N) for l in N),         # finite_double_sum_of_real_numbers_interchange
        lsum(u[l] * lsum(Q[l][k] * v[k] for k in N) for l in N),           # finite_sum_of_real_scalar_multiples を各 l へ
        lsum(u[k] * Qv[k] for k in N),                                     # def_real_matrix_vector_product を右辺から左辺へ
    ]
    for i in range(len(lines) - 1):
        assert lines[i] == lines[i + 1], (n, i)
        count += 1
    uv, vv, Qm = vector(R, u), vector(R, v), matrix(R, Q)
    assert lines[0] == (Qm * uv).dot_product(vv)
    assert lines[-1] == uv.dot_product(Qm * vv)
    # 否定コントロール: 成分をすべて独立な不定元に置いた（対称でない）行列 A では、
    # 対称性を当てない 9 段はそのまま成り立ち、対称性を当てる 3 行目 → 4 行目の段だけが崩れる（n ≥ 2）
    if n >= 2:
        names2 = [f"A_{k}_{l}" for k in N for l in N] + [f"a_{k}" for k in N] + [f"b_{k}" for k in N]
        R2 = PolynomialRing(QQ, names2)
        g2 = dict(zip(names2, R2.gens()))
        A = [[g2[f"A_{k}_{l}"] for l in N] for k in N]
        a = [g2[f"a_{k}"] for k in N]
        b = [g2[f"b_{k}"] for k in N]
        Aa, Ab = matvec(A, a), matvec(A, b)
        alines = [
            lsum(Aa[k] * b[k] for k in N),
            lsum(lsum(A[k][l] * a[l] for l in N) * b[k] for k in N),
            lsum(b[k] * lsum(A[k][l] * a[l] for l in N) for k in N),
            lsum(lsum(b[k] * (A[k][l] * a[l]) for l in N) for k in N),
            lsum(lsum(b[k] * (A[l][k] * a[l]) for l in N) for k in N),
            lsum(lsum((A[l][k] * a[l]) * b[k] for l in N) for k in N),
            lsum(lsum((a[l] * A[l][k]) * b[k] for l in N) for k in N),
            lsum(lsum(a[l] * (A[l][k] * b[k]) for l in N) for k in N),
            lsum(lsum(a[l] * (A[l][k] * b[k]) for k in N) for l in N),
            lsum(a[l] * lsum(A[l][k] * b[k] for k in N) for l in N),
            lsum(a[k] * Ab[k] for k in N),
        ]
        for i in range(len(alines) - 1):
            if i == 3:
                assert alines[i] != alines[i + 1], (n, i)
            else:
                assert alines[i] == alines[i + 1], (n, i)
        assert alines[0] != alines[-1]
print(f"10 行の鎖の隣り合う行を n = 1,…,5 で確かめた（{count} 段）。対称でない行列では対称性を当てる段だけが崩れ、主張も崩れることを確かめた")
print("RESULT: PASS")
