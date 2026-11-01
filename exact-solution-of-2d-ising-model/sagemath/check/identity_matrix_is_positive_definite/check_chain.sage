# 対象ラベル: identity_matrix_is_positive_definite
# エルミート性の 5 行と、正値性の 7 行を不定元で厳密に確かめ、最後の和が正であることを具体の x で確かめる。
load("../../_shared/hermitian_forms_by_definition.sage")

for n in [1, 2, 3, 4]:
    P, _, _, _, (x,) = generic_ring(n, vecs=["x"])
    I = body_identity(n, P)
    Is = body_star(I)
    for k in range(n):
        for l in range(n):
            lines = [Is[k][l], cc_conj(I[l][k]), cc_conj(body_delta(l, k, P)), body_delta(l, k, P), body_delta(k, l, P), I[k][l]]
            for t in range(len(lines) - 1):
                assert lines[t] == lines[t + 1], ("herm", n, k, l, t)
    R = range(n)
    Ix = body_matvec(I, x)
    abs_sq = [x[k][0]^2 + x[k][1]^2 for k in R]                 # abs_basic_properties (2)
    lines = [
        body_cbv(x, I, x),                                                        # x^*Ix
        fsum([fsum([cc_mul(cc_mul(cc_conj(x[k]), I[k][l]), x[l]) for l in R]) for k in R]),   # (def_conjugate_bilinear_value)
        fsum([fsum([cc_mul(cc_conj(x[k]), cc_mul(I[k][l], x[l])) for l in R]) for k in R]),   # 積の結合律
        fsum([cc_mul(cc_conj(x[k]), fsum([cc_mul(I[k][l], x[l]) for l in R])) for k in R]),   # 分配律
        fsum([cc_mul(cc_conj(x[k]), Ix[k]) for k in R]),                          # (mat_mult)
        fsum([cc_mul(cc_conj(x[k]), x[k]) for k in R]),                           # (identity_matrix_is_left_unit_of_mat_mult)
        fsum([iota(abs_sq[k], P) for k in R]),                                    # (complex_conjugate_times_self)
        iota(sum(abs_sq), P),                                                     # (real_inclusion_preserves_finite_sum)
    ]
    for t in range(len(lines) - 1):
        assert lines[t] == lines[t + 1], ("pos", n, t)
    assert Ix == x
    PK = gauss_ring(P)
    gx = to_g_vec(x, PK)
    assert to_g(lines[0], PK) == gx.apply_map(g_conj) * gx                      # 比べる側
    print(f"n = {n}: エルミート性の 5 行と正値性の 7 行を不定元で確かめた")

set_random_seed(2)
for n in [1, 2, 3, 4]:
    I = body_identity(n, QQ)
    for _ in range(20):
        gx = rand_nonzero_vector(n)
        x = from_g_vec(gx)
        v = body_cbv(x, I, x)
        k0 = next(k for k in range(n) if x[k] != (0, 0))
        r = sum(cc_abs_aa(z)^2 for z in x)
        assert cc_abs_aa(x[k0]) != 0 and r >= cc_abs_aa(x[k0])^2 > 0     # 最後の不等式の鎖
        assert v == iota(r, AA) and is_positive_real_inclusion(v)
    assert sage_is_positive_definite(identity_matrix(KG, n))
print("具体の x（n = 1,…,4、各 20 本）で x^*Ix が正の実数の包含であることと、Sage で I が正定値であることを確かめた")
print("RESULT: PASS")
