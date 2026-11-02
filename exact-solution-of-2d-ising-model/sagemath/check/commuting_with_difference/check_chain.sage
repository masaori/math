# 対象ラベル: commuting_with_difference
# 8 等号の鎖。G は不定元の行列、X = a0 I + a1 G、W = b0 I + b1 G で GX = XG・GW = WG を実現する。
# 対照: X を独立にすると第 3→4 だけが、W を独立にすると第 5→6 だけが崩れる。
load("_prelude.sage")

for n in [2, 3]:
    names = ['a0', 'a1', 'b0', 'b1'] + [f"{x}_{r}_{s}" for x in "GUV" for r in range(n) for s in range(n)]
    R = PolynomialRing(QQ, names)
    g = R.gens()
    G, U, V = [matrix(R, n, n, g[4 + k*n*n:4 + (k+1)*n*n]) for k in range(3)]
    I = body_identity(R, n)
    X = body_sum(body_scalar(g[0], I), body_scalar(g[1], G))
    W = body_sum(body_scalar(g[2], I), body_scalar(g[3], G))
    P, S, N, D = body_product, body_sum, body_negation, body_difference
    def lines(X, W):
        return [P(G, D(X, W)), P(G, S(X, N(W))), S(P(G, X), P(G, N(W))), S(P(X, G), P(G, N(W))),
                S(P(X, G), N(P(G, W))), S(P(X, G), N(P(W, G))), S(P(X, G), P(N(W), G)), P(S(X, N(W)), G), P(D(X, W), G)]
    check_chain(lines(X, W), f"n={n}")
    ln = lines(U, W); assert [k for k in range(1, 9) if ln[k - 1] != ln[k]] == [3]
    ln = lines(X, V); assert [k for k in range(1, 9) if ln[k - 1] != ln[k]] == [5]
    print(f"  n={n}: 8 等号が成り立ち、対照では仮定 GX = XG の第 3→4、GW = WG の第 5→6 だけが崩れる")
print("RESULT: PASS")
