# 対象ラベル: star_preserves_norm_and_limits
# (3) の準備 A_N^* - A^* = (A_N - A)^* の成分の鎖を一行ずつ（A_N, A の成分を QQ 上の不定元の対に置く）と、
# 各 N での ‖A_N^* - A^*‖ = ‖(A_N - A)^*‖ = ‖A_N - A‖ を、具体の列 A_N := A + (1/(N+1)) C（成分は QQ(i)）で AA により厳密に確かめる。
# N → ∞ の極限そのものは有限の計算では確かめられない（overview.md）。
load("_prelude.sage")

for n in SIZES:
    P, _, (AN, A) = generic_pairs(n, ["AN", "A"])
    lhs = body_diff(body_star(AN), body_star(A), P)
    D = body_diff(AN, A, P)
    rhs = body_star(D)
    for k in range(n):
        for l in range(n):
            lines = [
                lhs[k][l],                                             # (A_N^* - A^*)_kl
                cc_sub(body_star(AN)[k][l], body_star(A)[k][l], P),    # (A_N^*)_kl - (A^*)_kl    (def_matrix_difference)
                cc_sub(cc_conj(AN[l][k]), cc_conj(A[l][k]), P),        # conj(A_N)_lk - conj A_lk (def_hermitian_positive_definite)
                cc_conj(cc_sub(AN[l][k], A[l][k], P)),                 # conj((A_N)_lk - A_lk)    (complex_conjugate_of_difference)
                cc_conj(D[l][k]),                                      # conj((A_N - A)_lk)       (def_matrix_difference)
                rhs[k][l],                                             # ((A_N - A)^*)_kl         (def_hermitian_positive_definite)
            ]
            for t in range(len(lines) - 1):
                assert lines[t] == lines[t + 1], (n, k, l, t)
    PK = gauss_ring(P)
    gAN, gA = to_gauss(AN, PK), to_gauss(A, PK)
    assert to_gauss(lhs, PK) == sage_star(gAN) - sage_star(gA) == sage_star(gAN - gA)
    print(f"n = {n}: 準備の鎖の 5 個の等号と、両端の Sage の共役転置・差との一致を不定元で確かめた")


def norm_aa(M):
    """def_matrix_norm の ‖M‖ を、成分の |·|^2 = x^2 + y^2（abs_basic_properties (2)）の和の非負の平方根として AA で。"""
    n = len(M)
    return AA(sum(M[k][l][0]^2 + M[k][l][1]^2 for k in range(n) for l in range(n))).sqrt()


set_random_seed(31)
for n in SIZES:
    rnd = lambda: K(ZZ.random_element(-5, 6)) + i_K * K(ZZ.random_element(-5, 6))
    gA = matrix(K, n, n, lambda r, s: rnd())
    gC = matrix(K, n, n, lambda r, s: rnd())
    to_p = lambda M: [[(QQ(M[r, s].real()), QQ(M[r, s].imag())) for s in range(n)] for r in range(n)]
    A = to_p(gA)
    prev = None
    for N in range(0, 30):
        gAN = gA + (QQ(1) / (N + 1)) * gC
        AN = to_p(gAN)
        v = [
            norm_aa(body_diff(body_star(AN), body_star(A), QQ)),   # ‖A_N^* - A^*‖
            norm_aa(body_star(body_diff(AN, A, QQ))),              # ‖(A_N - A)^*‖   (準備)
            norm_aa(body_diff(AN, A, QQ)),                         # ‖A_N - A‖       ((2))
        ]
        assert v[0] == v[1] == v[2], (n, N)
        assert v[2] == norm_aa(to_p(gC)) / (N + 1)
        if prev is not None:
            assert v[0] <= prev
        prev = v[0]
print("具体の列 A_N = A + C/(N+1)（n = 1,…,4、N = 0,…,29）で、各 N の 2 個の等号を AA で厳密に確かめた")
print("RESULT: PASS")
