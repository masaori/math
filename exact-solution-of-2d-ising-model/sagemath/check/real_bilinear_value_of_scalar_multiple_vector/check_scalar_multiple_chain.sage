# real_bilinear_value_of_scalar_multiple_vector
# P ∈ Mat(n,ℝ)、u, w ∈ ℝ^n、c ∈ ℝ、w_k = c u_k について w^T P w = (c c)(u^T P u) の 13 行の鎖を、
# P・u・c の成分を不定元に置き、n = 1,…,5 で QQ 上の多項式として厳密に確かめる。
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
    N = range(n)
    names = [f"P_{k}_{l}" for k in N for l in N] + [f"u_{k}" for k in N] + ["c"]
    R = PolynomialRing(QQ, names)
    g = dict(zip(names, R.gens()))
    P = [[g[f"P_{k}_{l}"] for l in N] for k in N]
    u = [g[f"u_{k}"] for k in N]
    c = g["c"]
    w = [c * u[k] for k in N]                                                       # 仮定 w_k = c u_k
    s = lambda k, l: u[k] * P[k][l]
    lines = [
        bilin(w, P, w),                                                             # w^T P w
        lsum(lsum((w[k] * P[k][l]) * w[l] for l in N) for k in N),                  # def_real_bilinear_value
        lsum(lsum(((c * u[k]) * P[k][l]) * (c * u[l]) for l in N) for k in N),      # 仮定を w_k と w_l へ
        lsum(lsum((c * s(k, l)) * (c * u[l]) for l in N) for k in N),               # 結合則
        lsum(lsum(c * (s(k, l) * (c * u[l])) for l in N) for k in N),               # 結合則
        lsum(lsum(c * ((s(k, l) * c) * u[l]) for l in N) for k in N),               # 結合則
        lsum(lsum(c * ((c * s(k, l)) * u[l]) for l in N) for k in N),               # 可換則
        lsum(lsum(c * (c * (s(k, l) * u[l])) for l in N) for k in N),               # 結合則
        lsum(c * lsum(c * (s(k, l) * u[l]) for l in N) for k in N),                 # finite_sum_of_real_scalar_multiples を各 k へ
        lsum(c * (c * lsum(s(k, l) * u[l] for l in N)) for k in N),                 # 同上
        c * lsum(c * lsum(s(k, l) * u[l] for l in N) for k in N),                   # finite_sum_of_real_scalar_multiples
        c * (c * lsum(lsum(s(k, l) * u[l] for l in N) for k in N)),                 # 同上
        c * (c * bilin(u, P, u)),                                                   # def_real_bilinear_value を右辺から左辺へ
        (c * c) * bilin(u, P, u),                                                   # 結合則
    ]
    for i in range(len(lines) - 1):
        assert lines[i] == lines[i + 1], (n, i)
        count += 1
    uv, Pm = vector(R, u), matrix(R, P)
    assert lines[0] == (c * uv) * Pm * (c * uv)
    assert lines[-1] == c ** 2 * (uv * Pm * uv)
    # 否定コントロール: w_k = c u_k を崩した w' (w'_0 = 2 c u_0) では主張が成り立たない
    wbad = [2 * c * u[0]] + w[1:]
    assert bilin(wbad, P, wbad) != (c * c) * bilin(u, P, u)
print(f"13 行の鎖の隣り合う行を n = 1,…,5 で確かめた（{count} 段）。仮定を崩した w では主張が崩れることも確かめた")
print("RESULT: PASS")
