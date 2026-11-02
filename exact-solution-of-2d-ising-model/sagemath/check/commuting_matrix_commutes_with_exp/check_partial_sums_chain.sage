# 対象ラベル: commuting_matrix_commutes_with_exp
# Step 2（部分和との可換性）の N = 0 の鎖と N → N+1 の鎖の各行。
# S_N := Σ_{p=0}^{N} c_p B^p、c_p = (1/p!)_C（QQ に属する）。有限和は def_finite_sum_of_matrices のとおり左から足す。
# 対照: 独立な不定元の A' では、Step 1 を使う行と帰納法の仮定を使う行だけが崩れる。
load("_prelude.sage")

def power(B, p):
    P = body_identity(B.base_ring(), B.nrows())
    for _ in range(p):
        P = body_product(P, B)
    return P

def c(p):
    return QQ(1) / factorial(p)

def S(B, N):
    return body_finite_sum([body_scalar(c(p), power(B, p)) for p in range(N + 1)])

for n in [2, 3]:
    names = ['a0', 'a1'] + [f"b_{r}_{s}" for r in range(n) for s in range(n)] + [f"c_{r}_{s}" for r in range(n) for s in range(n)]
    R = PolynomialRing(QQ, names)
    g = R.gens()
    B = matrix(R, n, n, g[2:2 + n*n])
    Ap = matrix(R, n, n, g[2 + n*n:])
    A = body_sum(body_scalar(g[0], body_identity(R, n)), body_scalar(g[1], B))
    B0 = power(B, 0)
    base = [body_product(A, S(B, 0)), body_product(A, body_scalar(c(0), B0)), body_scalar(c(0), body_product(A, B0)),
            body_scalar(c(0), body_product(B0, A)), body_product(body_scalar(c(0), B0), A), body_product(S(B, 0), A)]
    check_chain(base, f"n={n} N=0")
    for N in range(0, 5):
        def lines(A):
            SN, T = S(B, N), body_scalar(c(N + 1), power(B, N + 1))
            return [body_product(A, S(B, N + 1)),
                    body_product(A, body_sum(SN, T)),
                    body_sum(body_product(A, SN), body_product(A, T)),
                    body_sum(body_product(SN, A), body_product(A, T)),
                    body_sum(body_product(SN, A), body_scalar(c(N + 1), body_product(A, power(B, N + 1)))),
                    body_sum(body_product(SN, A), body_scalar(c(N + 1), body_product(power(B, N + 1), A))),
                    body_sum(body_product(SN, A), body_product(T, A)),
                    body_product(body_sum(SN, T), A),
                    body_product(S(B, N + 1), A)]
        check_chain(lines(A), f"n={n} N={N}")
        ln = lines(Ap)
        bad = [k for k in range(1, 9) if ln[k - 1] != ln[k]]
        assert bad == ([5] if N == 0 else [3, 5]), (N, bad)
    print(f"  n={n}: N=0 の 5 等号と N→N+1（N=0..4）の 8 等号が成り立つ。対照の A' では第 3→4（帰納法の仮定、N≥1。S_0 = I なので N = 0 では崩れない）と第 5→6（Step 1）だけが崩れる")
print("RESULT: PASS")
