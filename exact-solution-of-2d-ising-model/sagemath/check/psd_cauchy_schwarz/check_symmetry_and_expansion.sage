# 対象ラベル: psd_cauchy_schwarz
# 準備の u^T P v = v^T P u（5 行）と、q(t) の展開（7 行）を、P を対称な不定元の表、x, y, u, v, t を不定元に置いて
# QQ 上の多項式として厳密に確かめる。両端は Sage の vector * matrix * vector と比べる。
load("real_bilinear_value_by_definition.sage")

for n in [1, 2, 3, 4]:
    R, P, V, (t,) = generic_symmetric_ring(n, extra=["t"])
    x, y, u, v = V["x"], V["y"], V["u"], V["v"]
    N = range(n)
    # 準備の鎖
    prep = [
        bilin(u, P, v),                                                                   # u^T P v
        lsum([lsum([(u[k] * P[k][l]) * v[l] for l in N]) for k in N]),                    # 定義
        lsum([lsum([(u[k] * P[l][k]) * v[l] for l in N]) for k in N]),                    # P_kl = P_lk
        lsum([lsum([(v[l] * P[l][k]) * u[k] for l in N]) for k in N]),                    # 乗法の結合・可換
        lsum([lsum([(v[l] * P[l][k]) * u[k] for k in N]) for l in N]),                    # 和の順序の入れ替え
        bilin(v, P, u),                                                                   # v^T P u
    ]
    for i in range(len(prep) - 1):
        assert prep[i] == prep[i + 1], ("prep", n, i)
    assert prep[0] == sage_bilin(u, P, v, R) and prep[-1] == sage_bilin(v, P, u, R)
    # 対称でない P では準備の第 2 行が成り立たないこと（仮定が効いている行の確認）
    if n >= 2:
        Rn = PolynomialRing(QQ, [f"Q_{k}_{l}" for k in N for l in N] + [f"{s}_{k}" for s in "uv" for k in N])
        gn = Rn.gens()
        Q = [[gn[k * n + l] for l in N] for k in N]
        un, vn = list(gn[n * n:n * n + n]), list(gn[n * n + n:])
        line1 = lsum([lsum([(un[k] * Q[k][l]) * vn[l] for l in N]) for k in N])       # 第 1 行
        line2 = lsum([lsum([(un[k] * Q[l][k]) * vn[l] for l in N]) for k in N])       # 第 2 行（対称性を使った行）
        assert line1 != line2
        assert bilin(un, Q, vn) != bilin(vn, Q, un)
    # 展開の鎖
    w = [y[k] + t * x[k] for k in N]
    a, b, c = bilin(x, P, x), bilin(y, P, x), bilin(y, P, y)
    expa = [
        bilin(w, P, w),                                                                   # q(t)
        lsum([lsum([(y[k] + t * x[k]) * P[k][l] * (y[l] + t * x[l]) for l in N]) for k in N]),
        lsum([lsum([y[k] * P[k][l] * y[l] + t * (y[k] * P[k][l] * x[l]) + t * (x[k] * P[k][l] * y[l])
                    + t ** 2 * (x[k] * P[k][l] * x[l]) for l in N]) for k in N]),
        lsum([lsum([y[k] * P[k][l] * y[l] for l in N]) for k in N])                   # 項の並べ替え
        + lsum([lsum([t * (y[k] * P[k][l] * x[l]) for l in N]) for k in N])
        + lsum([lsum([t * (x[k] * P[k][l] * y[l]) for l in N]) for k in N])
        + lsum([lsum([t ** 2 * (x[k] * P[k][l] * x[l]) for l in N]) for k in N]),
        lsum([lsum([y[k] * P[k][l] * y[l] for l in N]) for k in N])                   # t, t^2 を外へ
        + t * lsum([lsum([y[k] * P[k][l] * x[l] for l in N]) for k in N])
        + t * lsum([lsum([x[k] * P[k][l] * y[l] for l in N]) for k in N])
        + t ** 2 * lsum([lsum([x[k] * P[k][l] * x[l] for l in N]) for k in N]),
        bilin(y, P, y) + t * bilin(y, P, x) + t * bilin(x, P, y) + t ** 2 * bilin(x, P, x),
        bilin(y, P, y) + t * bilin(y, P, x) + t * bilin(y, P, x) + t ** 2 * bilin(x, P, x),
        a * t ** 2 + 2 * b * t + c,
    ]
    for i in range(len(expa) - 1):
        assert expa[i] == expa[i + 1], ("expand", n, i)
    assert expa[0] == sage_bilin(w, P, w, R)
    print(f"n = {n}: 準備の 5 行と展開の 7 行を、対称な不定元の P で厳密に確かめた")
print("RESULT: PASS")
