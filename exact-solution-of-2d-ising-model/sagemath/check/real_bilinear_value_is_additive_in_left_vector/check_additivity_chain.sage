# 対象ラベル: real_bilinear_value_is_additive_in_left_vector
# P ∈ Mat(n,ℝ)、x, y, z, w ∈ ℝ^n、w_k = y_k + z_k について w^T P x = y^T P x + z^T P x の 7 行の鎖を、
# P・x・y・z の成分を不定元に置き、n = 1,…,5 で QQ 上の多項式として厳密に確かめる。
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
    names = [f"P_{k}_{l}" for k in N for l in N] + [f"{s}_{k}" for s in "xyz" for k in N]
    R = PolynomialRing(QQ, names)
    g = dict(zip(names, R.gens()))
    P = [[g[f"P_{k}_{l}"] for l in N] for k in N]
    x = [g[f"x_{k}"] for k in N]
    y = [g[f"y_{k}"] for k in N]
    z = [g[f"z_{k}"] for k in N]
    w = [y[k] + z[k] for k in N]                                                   # 仮定 w_k = y_k + z_k
    lines = [
        bilin(w, P, x),                                                            # w^T P x
        lsum(lsum((w[k] * P[k][l]) * x[l] for l in N) for k in N),                 # def_real_bilinear_value
        lsum(lsum(((y[k] + z[k]) * P[k][l]) * x[l] for l in N) for k in N),        # 仮定を各項へ
        lsum(lsum((y[k] * P[k][l] + z[k] * P[k][l]) * x[l] for l in N) for k in N),  # 分配則
        lsum(lsum((y[k] * P[k][l]) * x[l] + (z[k] * P[k][l]) * x[l] for l in N) for k in N),  # 分配則
        lsum(lsum((y[k] * P[k][l]) * x[l] for l in N) + lsum((z[k] * P[k][l]) * x[l] for l in N)
             for k in N),                                                          # finite_sum_of_real_sums を各 k へ
        lsum(lsum((y[k] * P[k][l]) * x[l] for l in N) for k in N)
        + lsum(lsum((z[k] * P[k][l]) * x[l] for l in N) for k in N),               # finite_sum_of_real_sums
        bilin(y, P, x) + bilin(z, P, x),                                           # def_real_bilinear_value を右辺から左辺へ
    ]
    for i in range(len(lines) - 1):
        assert lines[i] == lines[i + 1], (n, i)
        count += 1
    xv, Pm = vector(R, x), matrix(R, P)
    assert lines[0] == (vector(R, y) + vector(R, z)) * Pm * xv
    assert lines[-1] == vector(R, y) * Pm * xv + vector(R, z) * Pm * xv
    # 否定コントロール: w_k = y_k + z_k を崩した w' (w'_0 = y_0 + 2 z_0) では主張が成り立たない
    wbad = [y[0] + 2 * z[0]] + w[1:]
    assert bilin(wbad, P, x) != bilin(y, P, x) + bilin(z, P, x)
print(f"7 行の鎖の隣り合う行を n = 1,…,5 で確かめた（{count} 段）。仮定を崩した w では主張が崩れることも確かめた")
print("RESULT: PASS")
