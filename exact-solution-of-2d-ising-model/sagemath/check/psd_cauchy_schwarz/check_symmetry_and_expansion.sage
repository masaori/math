# 対象ラベル: psd_cauchy_schwarz
# q(t) の展開（7 行）を、P を対称な不定元の表、x, y, t を不定元に置いて QQ 上の多項式として厳密に確かめる。
# 左端は Sage の vector * matrix * vector と比べる。展開の 6 行目が引く u^T P v = v^T P u は主張
# real_bilinear_value_of_symmetric_matrix_is_symmetric の鎖として sagemath/check/real_bilinear_value_of_symmetric_matrix_is_symmetric/ で確かめる。
load("real_bilinear_value_by_definition.sage")

for n in [1, 2, 3, 4]:
    R, P, V, (t,) = generic_symmetric_ring(n, extra=["t"])
    x, y = V["x"], V["y"]
    N = range(n)
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
    print(f"n = {n}: 展開の 7 行を、対称な不定元の P で厳密に確かめた")
print("RESULT: PASS")
