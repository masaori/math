# 対象ラベル: commuting_with_finite_sum
# r = 1 の鎖と r → r+1 の鎖（r = 1..3）。G は不定元の行列、X_j = a_j I + b_j G + d_j G^2（GX_j = X_jG）。
# 有限和は def_finite_sum_of_matrices のとおり左から足す。
# 対照: X_{r+1} を独立な不定元の行列にすると仮定を使う第 4→5 だけが、X_1 を独立にすると帰納法の仮定の第 3→4 だけが崩れる。
load("_prelude.sage")

n = 2
rmax = 4
names = [f"{x}{j}" for j in range(1, rmax + 1) for x in "abd"] + [f"G_{r}_{s}" for r in range(n) for s in range(n)] + [f"Z_{r}_{s}" for r in range(n) for s in range(n)]
R = PolynomialRing(QQ, names)
g = R.gens()
G = matrix(R, n, n, g[3*rmax:3*rmax + n*n])
Zg = matrix(R, n, n, g[3*rmax + n*n:])
G2 = body_product(G, G)
Xs = [body_finite_sum([body_scalar(g[3*j], body_identity(R, n)), body_scalar(g[3*j+1], G), body_scalar(g[3*j+2], G2)]) for j in range(rmax)]
P = body_product
F = body_finite_sum
base = [P(G, F(Xs[:1])), P(G, Xs[0]), P(Xs[0], G), P(F(Xs[:1]), G)]
check_chain(base, "r=1")

def lines(X):
    S = F(X[:-1])
    last = X[-1]
    return [P(G, F(X)), P(G, body_sum(S, last)), body_sum(P(G, S), P(G, last)), body_sum(P(S, G), P(G, last)),
            body_sum(P(S, G), P(last, G)), P(body_sum(S, last), G), P(F(X), G)]

for r in range(1, rmax):
    check_chain(lines(Xs[:r + 1]), f"r={r}->r+1")
    ln = lines(Xs[:r] + [Zg])
    assert [k for k in range(1, 7) if ln[k - 1] != ln[k]] == [4]
    ln = lines([Zg] + Xs[1:r + 1])
    assert [k for k in range(1, 7) if ln[k - 1] != ln[k]] == [3]
print("  r=1 の 2 等号と r→r+1（r=1..3）の 6 等号が成り立ち、対照では仮定の行・帰納法の仮定の行だけが崩れる")
print("RESULT: PASS")
