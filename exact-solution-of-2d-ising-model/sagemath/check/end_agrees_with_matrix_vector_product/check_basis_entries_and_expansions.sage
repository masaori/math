# 対象ラベル: end_agrees_with_matrix_vector_product
# 証明の準備の四つの鎖を確かめる。
#   (f_K)_{ν(L)} = (e_{k_1}⊠…⊠e_{k_M})_{ν(L)} = Π_m (e_{k_m})_{l_m} = Π_m δ_{k_m,l_m} = δ_{K,L}
#   (E_{I,J})_{ν(K),ν(L)} = (E_{i_1j_1}⊠…)_{ν(K),ν(L)} = Π_m (E_{i_mj_m})_{k_ml_m} = Π_m δ_{i_m,k_m}δ_{j_m,l_m}
#                         = (Π_m δ_{i_m,k_m})(Π_m δ_{j_m,l_m}) = δ_{I,K} δ_{J,L}
#   (Σ_{I,J} A_{ν(I),ν(J)} E_{I,J})_{ν(K),ν(L)} = Σ A_{ν(I),ν(J)} (E_{I,J})_{ν(K),ν(L)} = Σ A δ_{I,K}δ_{J,L} = A_{ν(K),ν(L)}
#   (Σ_K f_{ν(K)} f_K)_{ν(L)} = Σ_K f_{ν(K)} (f_K)_{ν(L)} = Σ_K f_{ν(K)} δ_{K,L} = f_{ν(L)}
# 帰属: 成分は QQ(i) 上の多項式環の独立な不定元（A の 4^M 個、f の 2^M 個）。M = 1, 2, 3。全て厳密。
load("../../_shared/one_by_one_matrix.sage")
load("../../_shared/end_by_definition.sage")


def delta(a, b):
    return 1 if a == b else 0


for M in [1, 2, 3]:
    n = 2^M
    idx = multi_indices(M)
    # ν が {1,…,2^M} への全単射であること（ν の定義の確認）
    assert sorted(nu(I) for I in idx) == list(range(1, n + 1))
    fb = f_basis(QQ, M)
    Eb = E_basis(QQ, M)
    # 対照: 本文のクロネッカー積が Sage の tensor_product と一致する（ν の並べ方が Sage と同じ）
    for I in idx:
        sage_f = reduce(lambda U, V: U.tensor_product(V), [column_matrix(QQ, std_basis_C2(QQ, i)) for i in I]).column(0)
        assert fb[I] == sage_f
        for J in idx:
            sage_E = reduce(lambda U, V: U.tensor_product(V), [matrix_unit_2(QQ, I[m], J[m]) for m in range(M)])
            assert Eb[(I, J)] == sage_E
    for K in idx:
        for L in idx:
            line1 = fb[K][nu(L) - 1]
            line2 = kron_vectors(QQ, [std_basis_C2(QQ, k) for k in K])[nu(L) - 1]
            line3 = prod(std_basis_C2(QQ, K[m])[L[m] - 1] for m in range(M))
            line4 = prod(delta(K[m], L[m]) for m in range(M))
            line5 = delta(K, L)
            assert line1 == line2 == line3 == line4 == line5, (M, K, L)
    for I in idx:
        for J in idx:
            for K in idx:
                for L in idx:
                    line1 = Eb[(I, J)][nu(K) - 1, nu(L) - 1]
                    line2 = kron_matrices(QQ, [matrix_unit_2(QQ, I[m], J[m]) for m in range(M)])[nu(K) - 1, nu(L) - 1]
                    line3 = prod(matrix_unit_2(QQ, I[m], J[m])[K[m] - 1, L[m] - 1] for m in range(M))
                    line4 = prod(delta(I[m], K[m]) * delta(J[m], L[m]) for m in range(M))
                    line5 = prod(delta(I[m], K[m]) for m in range(M)) * prod(delta(J[m], L[m]) for m in range(M))
                    line6 = delta(I, K) * delta(J, L)
                    assert line1 == line2 == line3 == line4 == line5 == line6, (M, I, J, K, L)
    # 基底による展開
    R = PolynomialRing(GAUSSIAN, [f"a{p}_{q}" for p in range(1, n + 1) for q in range(1, n + 1)] + [f"x{p}" for p in range(1, n + 1)])
    gens = R.gens()
    A = matrix(R, n, n, gens[:n * n])
    f = vector(R, gens[n * n:])
    EbR = E_basis(R, M)
    fbR = f_basis(R, M)
    expansion_A = sum(A[nu(I) - 1, nu(J) - 1] * EbR[(I, J)] for I in idx for J in idx)
    for K in idx:
        for L in idx:
            line1 = expansion_A[nu(K) - 1, nu(L) - 1]
            line2 = sum(A[nu(I) - 1, nu(J) - 1] * EbR[(I, J)][nu(K) - 1, nu(L) - 1] for I in idx for J in idx)
            line3 = sum(A[nu(I) - 1, nu(J) - 1] * delta(I, K) * delta(J, L) for I in idx for J in idx)
            line4 = A[nu(K) - 1, nu(L) - 1]
            assert line1 == line2 == line3 == line4
    assert expansion_A == A
    expansion_f = sum(f[nu(K) - 1] * fbR[K] for K in idx)
    for L in idx:
        line1 = expansion_f[nu(L) - 1]
        line2 = sum(f[nu(K) - 1] * fbR[K][nu(L) - 1] for K in idx)
        line3 = sum(f[nu(K) - 1] * delta(K, L) for K in idx)
        line4 = f[nu(L) - 1]
        assert line1 == line2 == line3 == line4
    assert expansion_f == f
    # 基底による展開は、検算の側の座標（基底を並べた行列の逆行列から求めたもの）とも一致する
    E = EndByDefinition(M)
    cA = E.coords_of_matrix(A)
    assert all(cA[(I, J)] == A[nu(I) - 1, nu(J) - 1] for I in idx for J in idx)
    df = E.coords_of_vector(f)
    assert all(df[K] == f[nu(K) - 1] for K in idx)
print("M = 1, 2, 3 で、(f_K)_{ν(L)} と (E_{I,J})_{ν(K),ν(L)} の鎖の各行（QQ で厳密）と、")
print("A と f の基底による展開の鎖の各行（QQ(i) 上の不定元で厳密）が成り立つ")

# 対照: ν をビットを逆に並べた全単射に替えると、M ≥ 2 では f_K の成分が δ_{K,L} にならない
fb_rev = f_basis(QQ, 2, nu_reversed)
assert any(fb_rev[K][nu(L) - 1] != delta(K, L) for K in multi_indices(2) for L in multi_indices(2))
print("対照: ν を別の並べ方に替えると、M = 2 で (f_K)_{ν(L)} = δ_{K,L} が崩れる")
print("RESULT: PASS")
