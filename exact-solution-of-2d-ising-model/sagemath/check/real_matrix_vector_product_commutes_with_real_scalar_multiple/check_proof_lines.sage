# real_matrix_vector_product_commutes_with_real_scalar_multiple
# P ∈ Mat(m,n,ℝ)、c ∈ ℝ、u, w ∈ ℝ^n、w_k = c u_k について (Pw)_i = c (Pu)_i の 7 行の鎖を、
# P・u・c を不定元に置き、m, n = 1,…,4 の各 i で QQ 上の多項式として厳密に確かめる。
# (Px)_i は def_real_matrix_vector_product のとおり Σ_j P_ij x_j を左から順に足して組む。
# 両端は Sage の matrix * vector（本文の式とは別の経路）と比べる。
# 帰属: QQ 上の多項式環。不定元で成り立つ等号は、任意の実数を代入しても成り立つ。


def lsum(terms):
    """def_finite_sum_of_real_numbers: 左から順に足す。"""
    terms = list(terms)
    s = terms[0]
    for q in terms[1:]:
        s = s + q
    return s


def mv(P, x, i):
    """def_real_matrix_vector_product の (Px)_i。"""
    return lsum(P[i][j] * x[j] for j in range(len(x)))


count = 0
for m in [1, 2, 3, 4]:
    for n in [1, 2, 3, 4]:
        M, N = range(m), range(n)
        names = [f"P_{i}_{j}" for i in M for j in N] + [f"u_{j}" for j in N] + ["c"]
        R = PolynomialRing(QQ, names)
        g = dict(zip(names, R.gens()))
        P = [[g[f"P_{i}_{j}"] for j in N] for i in M]
        u = [g[f"u_{j}"] for j in N]
        c = g["c"]
        w = [c * u[k] for k in N]                                       # 仮定 w_k = c u_k
        Pm, uv, wv = matrix(R, P), vector(R, u), vector(R, w)
        for i in M:
            lines = [
                mv(P, w, i),                                            # (Pw)_i
                lsum(P[i][j] * w[j] for j in N),                        # def_real_matrix_vector_product
                lsum(P[i][j] * (c * u[j]) for j in N),                  # 仮定を n 個の項へ
                lsum((P[i][j] * c) * u[j] for j in N),                  # 結合則
                lsum((c * P[i][j]) * u[j] for j in N),                  # 交換則
                lsum(c * (P[i][j] * u[j]) for j in N),                  # 結合則
                c * lsum(P[i][j] * u[j] for j in N),                    # finite_sum_of_real_scalar_multiples
                c * mv(P, u, i),                                        # def_real_matrix_vector_product を右辺から左辺へ
            ]
            for t in range(len(lines) - 1):
                assert lines[t] == lines[t + 1], (m, n, i, t)
                count += 1
            assert lines[0] == (Pm * wv)[i]
            assert lines[-1] == c * (Pm * uv)[i]
        # 否定コントロール（行の書き間違い）: i = 1 の 5 行目と、u の添字を 1 つずらした誤った 6 行目は、n ≥ 2 で一致しない
        if n >= 2:
            bad6 = c * lsum(P[0][j] * u[(j + 1) % n] for j in N)    # 添字をずらした誤った 6 行目
            assert lsum(c * (P[0][j] * u[j]) for j in N) != bad6
        # 否定コントロール（仮定）: w_k = c u_k を崩した w' (w'_0 = 2 c u_0) では主張が成り立たない
        wbad = [2 * c * u[0]] + w[1:]
        assert mv(P, wbad, 0) != c * mv(P, u, 0)
print(f"7 行の鎖の隣り合う行を m, n = 1,…,4 の各 i で確かめた（{count} 段）。仮定を崩した w と、添字をずらした誤った行が崩れることも確かめた")
print("RESULT: PASS")
