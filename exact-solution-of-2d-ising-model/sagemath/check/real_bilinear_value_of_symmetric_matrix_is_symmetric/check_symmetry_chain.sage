# 対象ラベル: real_bilinear_value_of_symmetric_matrix_is_symmetric
# 対称な P ∈ Mat(n,ℝ) と u, v ∈ ℝ^n について u^T P v = v^T P u の 7 行の鎖を、P を対称な不定元の表（P_lk := P_kl）、
# u, v を不定元に置き、n = 1,…,5 で QQ 上の多項式として厳密に確かめる。
# x^T P y は def_real_bilinear_value のとおり Σ_k Σ_l (x_k P_kl) y_l を左から順に足して組む。
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


count = 0
for n in [1, 2, 3, 4, 5]:
    names = [f"P_{k}_{l}" for k in range(n) for l in range(k, n)]
    names += [f"{s}_{k}" for s in "uv" for k in range(n)]
    R = PolynomialRing(QQ, names)
    g = dict(zip(names, R.gens()))
    P = [[g[f"P_{min(k, l)}_{max(k, l)}"] for l in range(n)] for k in range(n)]
    u = [g[f"u_{k}"] for k in range(n)]
    v = [g[f"v_{k}"] for k in range(n)]
    N = range(n)
    lines = [
        bilin(u, P, v),                                                       # u^T P v
        lsum(lsum((u[k] * P[k][l]) * v[l] for l in N) for k in N),             # def_real_bilinear_value
        lsum(lsum((u[k] * P[l][k]) * v[l] for l in N) for k in N),             # def_real_symmetric_matrix を各項へ
        lsum(lsum(v[l] * (u[k] * P[l][k]) for l in N) for k in N),             # 乗法の可換則
        lsum(lsum(v[l] * (P[l][k] * u[k]) for l in N) for k in N),             # 乗法の可換則
        lsum(lsum((v[l] * P[l][k]) * u[k] for l in N) for k in N),             # 乗法の結合則
        lsum(lsum((v[l] * P[l][k]) * u[k] for k in N) for l in N),             # finite_double_sum_of_real_numbers_interchange
        bilin(v, P, u),                                                       # def_real_bilinear_value を右辺から左辺へ
    ]
    for i in range(len(lines) - 1):
        assert lines[i] == lines[i + 1], (n, i)
        count += 1
    assert lines[0] == vector(R, u) * matrix(R, P) * vector(R, v)
    assert lines[-1] == vector(R, v) * matrix(R, P) * vector(R, u)
    # 否定コントロール: 対称でない不定元の表 Q では、対称性を使う 1 行目 → 2 行目と、主張そのものが成り立たない
    if n >= 2:
        Rn = PolynomialRing(QQ, [f"Q_{k}_{l}" for k in N for l in N] + [f"{s}_{k}" for s in "uv" for k in N])
        gn = Rn.gens()
        Q = [[gn[k * n + l] for l in N] for k in N]
        un, vn = list(gn[n * n:n * n + n]), list(gn[n * n + n:])
        assert lsum(lsum((un[k] * Q[k][l]) * vn[l] for l in N) for k in N) != \
            lsum(lsum((un[k] * Q[l][k]) * vn[l] for l in N) for k in N)
        assert bilin(un, Q, vn) != bilin(vn, Q, un)
print(f"7 行の鎖の隣り合う行を n = 1,…,5 で確かめた（{count} 段）。対称でない表では主張が崩れることも確かめた")
print("RESULT: PASS")
