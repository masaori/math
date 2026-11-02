# 対象ラベル: commuting_matrix_commutes_with_exp
# Step 3（左からの積の極限）。
# (a) AS_N - AE = AS_N + (-(AE)) = AS_N + A(-E) = A(S_N + (-E)) = A(S_N - E) の 4 等号を、
#     A, S, E を独立な不定元の行列にして厳密に（どの行も仮定を使わない）。
# (b) 不等号の鎖 ‖AS_N - AE‖ ≤ ‖A‖‖S_N - E‖ ≤ (‖A‖+1)‖S_N - E‖ と、η から N_0 を取る段を、
#     具体の A, B ∈ Mat(n, QQ(i))（AB = BA）で E = exp(B) をボールで囲んで確かめる（ℝ への脱出: ノルムと極限）。
load("_prelude.sage")

for n in [2, 3]:
    names = [f"{x}_{r}_{s}" for x in "ASE" for r in range(n) for s in range(n)]
    R = PolynomialRing(QQ, names)
    g = R.gens()
    A, Sm, E = [matrix(R, n, n, g[k*n*n:(k+1)*n*n]) for k in range(3)]
    lines = [body_difference(body_product(A, Sm), body_product(A, E)),
             body_sum(body_product(A, Sm), body_negation(body_product(A, E))),
             body_sum(body_product(A, Sm), body_product(A, body_negation(E))),
             body_product(A, body_sum(Sm, body_negation(E))),
             body_product(A, body_difference(Sm, E))]
    check_chain(lines, f"n={n}")
    print(f"  n={n}: 差の 4 等号が不定元の行列で成り立つ")

def norm(X):
    return sum(z.abs()**2 for z in X.list()).sqrt()

def power(B, p):
    P = identity_matrix(KG, B.nrows())
    for _ in range(p):
        P = body_product(P, B)
    return P

def S(B, N):
    return body_finite_sum([body_scalar(QQ(1) / factorial(p), power(B, p)) for p in range(N + 1)])

cases = [(matrix(KG, [[1, 2], [0, i_K]]), lambda B: 2 * identity_matrix(KG, 2) + B - body_product(B, B) / 3),
         (matrix(KG, [[0, 1, 0], [0, 0, 1], [1, 0, 0]]) * (1 + i_K) / 2, lambda B: B + body_product(B, B))]
for B, f in cases:
    A = f(B)
    assert A * B == B * A
    E = exp_ball(B)
    nA = norm(to_CB(A)).real()
    for N in [2, 5, 10, 20, 40]:
        D = to_CB(S(B, N)) - E
        lhs = norm(to_CB(A) * to_CB(S(B, N)) - to_CB(A) * E).real()
        mid = nA * norm(D).real()
        rhs = (nA + 1) * norm(D).real()
        assert lhs.lower() <= mid.upper() and mid.upper() <= rhs.upper()
    for eta in [QQ(1)/10, QQ(1)/1000, QQ(1)/10**8]:
        etap = RB(eta) / (nA + 1)
        N0 = 0
        while not (norm(to_CB(S(B, N0)) - E).real() < etap):
            N0 += 1
        for N in range(N0, N0 + 5):
            assert norm(to_CB(A) * to_CB(S(B, N)) - to_CB(A) * E).real() < RB(eta)
        print(f"  n={B.nrows()} η={eta}: N_0={N0} で N ≥ N_0 なら ‖AS_N - AE‖ < η")
print("RESULT: PASS")
