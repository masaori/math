# 対象ラベル: product_of_anticommuting_matrices_commutes
# 8 等号の鎖 G(XY) = (GX)Y = (-(XG))Y = -((XG)Y) = -(X(GY)) = -(X(-(YG))) = -(-(X(YG))) = X(YG) = (XY)G。
# 具体の反可換な組（G = ε、X, Y ∈ {σ_k^z, σ_k^y, Z_m, Y_m}、M_col = 1,2,3）で全行を厳密に。
# 対照: G, X, Y を独立な不定元の行列にすると、仮定を使う第 2→3 と第 5→6 の行だけが崩れる。
load("_prelude.sage")

def lines(G, X, Y):
    neg = body_negation
    P = body_product
    return [P(G, P(X, Y)), P(P(G, X), Y), P(neg(P(X, G)), Y), neg(P(P(X, G), Y)), neg(P(X, P(G, Y))),
            neg(P(X, neg(P(Y, G)))), neg(neg(P(X, P(Y, G)))), P(X, P(Y, G)), P(P(X, Y), G)]

count = 0
for M in [1, 2, 3]:
    G = epsilon(M)
    pool = [site(M, k, 'z') for k in range(1, M + 1)] + [site(M, k, 'y') for k in range(1, M + 1)] \
         + [jw(M, m, 'z') for m in range(1, M + 1)] + [jw(M, m, 'y') for m in range(1, M + 1)]
    for X in pool:
        assert G * X == -(X * G)
        for Y in pool:
            ln = lines(G, X, Y)
            check_chain(ln, f"M={M}")
            count += 1
for n in [2, 3]:
    names = [f"{x}_{r}_{s}" for x in "GXY" for r in range(n) for s in range(n)]
    R = PolynomialRing(QQ, names)
    g = R.gens()
    G, X, Y = [matrix(R, n, n, g[k*n*n:(k+1)*n*n]) for k in range(3)]
    ln = lines(G, X, Y)
    bad = [k for k in range(1, 9) if ln[k - 1] != ln[k]]
    assert bad == [2, 5], bad
print(f"  具体の反可換な組 {count} 通りで 8 等号が成り立ち、不定元の行列では第 2→3・第 5→6 だけが崩れる")
print("RESULT: PASS")
