# psd_cauchy_schwarz の検算で共有する準備。本文の定め方どおりに成分から組む:
#   x^T P y := Σ_k Σ_l (x_k P_kl) y_l（def_real_bilinear_value。有限和は左から順に足す）。
# 比べる側は Sage の vector と matrix の積 vector(x) * matrix(P) * vector(y)（本文の式とは別の経路）。


def lsum(terms):
    s = terms[0]
    for q in terms[1:]:
        s = s + q
    return s


def bilin(x, P, y):
    """def_real_bilinear_value の x^T P y。P はリストのリスト、x, y はリスト。"""
    n = len(x)
    return lsum([lsum([(x[k] * P[k][l]) * y[l] for l in range(n)]) for k in range(n)])


def sage_bilin(x, P, y, R):
    return vector(R, x) * matrix(R, P) * vector(R, y)


def generic_symmetric_ring(n, extra=()):
    """P の成分を k ≤ l の不定元 P_k_l に置き P_lk := P_kl とした対称な表と、
    x, y, u, v の成分の不定元、追加の不定元 extra を持つ QQ 上の多項式環。"""
    names = [f"P_{k}_{l}" for k in range(n) for l in range(k, n)]
    names += [f"{s}_{k}" for s in "xyuv" for k in range(n)]
    names += list(extra)
    R = PolynomialRing(QQ, names)
    g = dict(zip(names, R.gens()))
    P = [[g[f"P_{min(k, l)}_{max(k, l)}"] for l in range(n)] for k in range(n)]
    vec = {s: [g[f"{s}_{k}"] for k in range(n)] for s in "xyuv"}
    ex = [g[e] for e in extra]
    return R, P, vec, ex
