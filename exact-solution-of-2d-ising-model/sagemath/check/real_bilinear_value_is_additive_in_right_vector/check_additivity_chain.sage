# 対象ラベル: real_bilinear_value_is_additive_in_right_vector
# P ∈ Mat(n,ℝ)、x, y, z, w ∈ ℝ^n、w_l = y_l + z_l について x^T P w = x^T P y + x^T P z の 6 行の鎖を、
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
    w = [y[l] + z[l] for l in N]                                                   # 仮定 w_l = y_l + z_l
    lines = [
        bilin(x, P, w),                                                            # x^T P w
        lsum(lsum((x[k] * P[k][l]) * w[l] for l in N) for k in N),                 # def_real_bilinear_value
        lsum(lsum((x[k] * P[k][l]) * (y[l] + z[l]) for l in N) for k in N),        # 仮定を各項へ
        lsum(lsum((x[k] * P[k][l]) * y[l] + (x[k] * P[k][l]) * z[l] for l in N) for k in N),  # 分配則
        lsum(lsum((x[k] * P[k][l]) * y[l] for l in N) + lsum((x[k] * P[k][l]) * z[l] for l in N)
             for k in N),                                                          # finite_sum_of_real_sums を各 k へ
        lsum(lsum((x[k] * P[k][l]) * y[l] for l in N) for k in N)
        + lsum(lsum((x[k] * P[k][l]) * z[l] for l in N) for k in N),               # finite_sum_of_real_sums
        bilin(x, P, y) + bilin(x, P, z),                                           # def_real_bilinear_value を右辺から左辺へ
    ]
    for i in range(len(lines) - 1):
        assert lines[i] == lines[i + 1], (n, i)
        count += 1
    xv, Pm = vector(R, x), matrix(R, P)
    assert lines[0] == xv * Pm * (vector(R, y) + vector(R, z))
    assert lines[-1] == xv * Pm * vector(R, y) + xv * Pm * vector(R, z)
    # 否定コントロール: w_l = y_l + z_l を崩した w' (w'_0 = y_0 + 2 z_0) では主張が成り立たない
    wbad = [y[0] + 2 * z[0]] + w[1:]
    assert bilin(x, P, wbad) != bilin(x, P, y) + bilin(x, P, z)
print(f"6 行の鎖の隣り合う行を n = 1,…,5 で確かめた（{count} 段）。仮定を崩した w では主張が崩れることも確かめた")
print("RESULT: PASS")
