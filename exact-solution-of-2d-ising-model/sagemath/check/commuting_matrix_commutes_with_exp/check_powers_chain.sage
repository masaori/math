# 対象ラベル: commuting_matrix_commutes_with_exp
# Step 1（冪との可換性）の p = 0 の鎖と、p → p+1 の鎖の各行。
# B は QQ 上の不定元の n 次正方行列、A = a0 I + a1 B + a2 B^2（a0,a1,a2 も不定元）で AB = BA を実現する。
# 冪は def_exp (1) の B^0 := I、B^{p+1} := B^p B。積は mat_mult の成分の式（body_product）。
# 対照: A を独立な不定元の行列 A' にすると、仮定 AB = BA を使う行と帰納法の仮定を使う行だけが崩れる。
load("_prelude.sage")

def power(B, p):
    P = body_identity(B.base_ring(), B.nrows())
    for _ in range(p):
        P = body_product(P, B)
    return P

def step_lines(A, B, p):
    Bp = power(B, p)
    Bp1 = power(B, p + 1)
    return [body_product(A, Bp1),
            body_product(A, body_product(Bp, B)),
            body_product(body_product(A, Bp), B),
            body_product(body_product(Bp, A), B),
            body_product(Bp, body_product(A, B)),
            body_product(Bp, body_product(B, A)),
            body_product(body_product(Bp, B), A),
            body_product(Bp1, A)]

for n in [2, 3]:
    names = ['a0', 'a1', 'a2'] + [f"b_{r}_{s}" for r in range(n) for s in range(n)] + [f"c_{r}_{s}" for r in range(n) for s in range(n)]
    R = PolynomialRing(QQ, names)
    g = R.gens()
    B = matrix(R, n, n, g[3:3 + n*n])
    Ap = matrix(R, n, n, g[3 + n*n:])
    I = body_identity(R, n)
    A = body_sum(body_sum(body_scalar(g[0], I), body_scalar(g[1], B)), body_scalar(g[2], body_product(B, B)))
    assert body_product(A, B) == body_product(B, A)
    B0 = power(B, 0)
    base = [body_product(A, B0), body_product(A, I), A, body_product(I, A), body_product(B0, A)]
    check_chain(base, f"n={n} p=0")
    for p in range(0, 4):
        check_chain(step_lines(A, B, p), f"n={n} p={p}->p+1")
        lines = step_lines(Ap, B, p)
        bad = [k for k in range(1, 8) if lines[k - 1] != lines[k]]
        expected = [5] if p == 0 else [3, 5]
        assert bad == expected, (p, bad)
    print(f"  n={n}: p=0 の 4 等号と p→p+1（p=0..3）の 7 等号が成り立つ。対照の A' では第 3→4（帰納法の仮定、p≥1）と第 5→6（仮定 AB=BA）だけが崩れる")
print("RESULT: PASS")
