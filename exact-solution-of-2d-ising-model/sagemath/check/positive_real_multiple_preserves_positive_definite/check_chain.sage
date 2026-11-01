# 対象ラベル: positive_real_multiple_preserves_positive_definite
# 正値性の鎖のうち、仮定 x^*Ax = r_C を使わない 8 行を、α を実の不定元、A・x を不定元の対に置いて厳密に確かめる。
# r の取り方以降の 5 行と主張は、具体の正定値な A（C^*C + I）と α ∈ QQ_{>0} で厳密に確かめる。
load("../../_shared/hermitian_forms_by_definition.sage")

for n in [1, 2, 3]:
    P, (al,), _, (A,), (x,) = generic_ring(n, mats=["A"], vecs=["x"], real_scalars=["alpha"])
    R = range(n)
    a = iota(al, P)
    aA = body_scalar(a, A)
    lines = [
        body_cbv(x, aA, x),                                                                     # x^*(α_C A)x
        fsum([fsum([cc_mul(cc_mul(cc_conj(x[k]), aA[k][l]), x[l]) for l in R]) for k in R]),     # (def_conjugate_bilinear_value)
        fsum([fsum([cc_mul(cc_mul(cc_conj(x[k]), cc_mul(a, A[k][l])), x[l]) for l in R]) for k in R]),   # (def_matrix_scalar_multiple)
        fsum([fsum([cc_mul(cc_mul(cc_mul(cc_conj(x[k]), a), A[k][l]), x[l]) for l in R]) for k in R]),   # 結合律
        fsum([fsum([cc_mul(cc_mul(cc_mul(a, cc_conj(x[k])), A[k][l]), x[l]) for l in R]) for k in R]),   # 可換律
        fsum([fsum([cc_mul(cc_mul(a, cc_mul(cc_conj(x[k]), A[k][l])), x[l]) for l in R]) for k in R]),   # 結合律
        fsum([fsum([cc_mul(a, cc_mul(cc_mul(cc_conj(x[k]), A[k][l]), x[l])) for l in R]) for k in R]),   # 結合律
        cc_mul(a, fsum([fsum([cc_mul(cc_mul(cc_conj(x[k]), A[k][l]), x[l]) for l in R]) for k in R])),   # 分配律
        cc_mul(a, body_cbv(x, A, x)),                                                           # (def_conjugate_bilinear_value)
    ]
    for t in range(len(lines) - 1):
        assert lines[t] == lines[t + 1], (n, t)
    PK = gauss_ring(P)
    gx, gA = to_g_vec(x, PK), to_g_mat(A, PK)
    assert to_g(lines[0], PK) == gx.apply_map(g_conj) * (PK(al) * gA) * gx
    print(f"n = {n}: 仮定を使わない 8 行を不定元で確かめた")

PR = PolynomialRing(QQ, ["alpha", "r"])
alg, rg = PR.gens()
lines = [cc_mul(iota(alg, PR), iota(rg, PR)), cc_mul((alg, PR(0)), (rg, PR(0))), (alg * rg - 0 * 0, alg * 0 + 0 * rg), (alg * rg, PR(0)), iota(alg * rg, PR)]
for t in range(len(lines) - 1):
    assert lines[t] == lines[t + 1], ("alpha r", t)
print("α_C r_C = (αr)_C の 4 行を不定元で確かめた")

set_random_seed(7)
for n in [1, 2, 3, 4]:
    for _ in range(4):
        gA = rand_posdef(n)
        assert sage_is_positive_definite(gA)
        A = from_g_mat(gA)
        alpha = QQ(ZZ.random_element(1, 20)) / ZZ.random_element(1, 7)
        aA = body_scalar(iota(alpha, QQ), A)
        assert body_star(aA) == aA                                   # エルミート性
        for _ in range(6):
            x = from_g_vec(rand_nonzero_vector(n))
            v = body_cbv(x, A, x)
            assert is_positive_real_inclusion(v)                     # r の取り方
            r = v[0]
            w = body_cbv(x, aA, x)
            assert w == cc_mul(iota(alpha, QQ), v) == iota(alpha * r, QQ) and alpha * r > 0
        assert sage_is_positive_definite(alpha * gA)
    print(f"n = {n}: 具体の 4 組の (A, α)、各 6 本の x で、r の取り方以降と主張を確かめた")

# α > 0 が要ることの確認
gA = rand_posdef(2)
assert not sage_is_positive_definite(-1 * gA) and not sage_is_positive_definite(0 * gA)
print("α = -1, 0 では正定値でないことを確かめた")
print("RESULT: PASS")
