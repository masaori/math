# 対象ラベル: commuting_with_scalar_multiple
# 鎖 G(cX) = c(GX) = c(XG) = (cX)G。G は不定元の行列、X = a0 I + a1 G（GX = XG）、c は不定元。
# 対照: 独立な不定元の X では、仮定を使う第 2→3 だけが崩れる。
load("_prelude.sage")

for n in [1, 2, 3]:
    names = ['c', 'a0', 'a1'] + [f"{x}_{r}_{s}" for x in "GX" for r in range(n) for s in range(n)]
    R = PolynomialRing(QQ, names)
    g = R.gens()
    c = g[0]
    G = matrix(R, n, n, g[3:3 + n*n])
    Xg = matrix(R, n, n, g[3 + n*n:])
    X = body_sum(body_scalar(g[1], body_identity(R, n)), body_scalar(g[2], G))
    def lines(X):
        return [body_product(G, body_scalar(c, X)), body_scalar(c, body_product(G, X)),
                body_scalar(c, body_product(X, G)), body_product(body_scalar(c, X), G)]
    check_chain(lines(X), f"n={n}")
    ln = lines(Xg)
    assert [k for k in range(1, 4) if ln[k - 1] != ln[k]] == ([] if n == 1 else [2])
    print(f"  n={n}: 3 等号が成り立つ" + ("" if n == 1 else "。独立な X では第 2→3 だけが崩れる"))
print("RESULT: PASS")
