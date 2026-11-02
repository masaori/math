# 対象ラベル: site_sigma_z_is_diagonal
# 証明の準備と三行:
#   準備: s ≠ t ⇒ (I_{Mat(2,C)})_{st} = δ_{st} = 0、(σ^z)_{st} = 0、したがって各因子 A_p で (A_p)_{st} = 0
#   ν は全単射（k = ν(K), l = ν(L)）、k ≠ l ⇒ K ≠ L ⇒ k_n ≠ l_n となる n がある
#   (σ_m^z)_{kl} = (A_1⊠⋯⊠A_M)_{ν(K),ν(L)}      (def_site_pauli_matrices)
#                = ∏_{p=1}^{M} (A_p)_{k_p l_p}    (def_kronecker (2))
#                = 0                               (finite_product_with_zero_factor_is_zero、(A_n)_{k_n l_n} = 0)
# 第一行は Sage の tensor_product の成分、第二行は因子の成分を左から順に掛けた積
# （def_finite_product_of_complex_numbers の帰納法の順）。第三行へ進む前に第 n 因子の成分が 0 であることを確かめる。
# 帰属: ZZ。M = 1,…,5、すべての m、k ≠ l。
load("../../_shared/site_sigma_z_kronecker.sage")

def left_to_right_product(zs):
    """def_finite_product_of_complex_numbers: ∏_{j=1}^{1} := z_1、∏_{j=1}^{m+1} := (∏_{j=1}^{m}) z_{m+1}。"""
    acc = zs[0]
    for z in zs[1:]:
        acc = acc * z
    return acc

# 準備
for s_ in (1, 2):
    for t_ in (1, 2):
        if s_ != t_:
            assert ID2[s_ - 1, t_ - 1] == (1 if s_ == t_ else 0) == 0   # def_identity_matrix・def_kronecker_delta
            assert SIGMA_Z[s_ - 1, t_ - 1] == 0                           # pauli_matrix_products

count = 0
for M in M_RANGE:
    idx = index_set(M)
    assert sorted(nu(I) for I in idx) == list(range(1, 2**M + 1))   # ν は全単射
    inv = {nu(I): I for I in idx}
    for m in range(1, M + 1):
        A = site_factors(M, m, SIGMA_Z)
        S = kron_sage(A)
        assert S == sigma_z_site(M, m)
        for k in range(1, 2**M + 1):
            for l in range(1, 2**M + 1):
                if k == l:
                    continue
                K, L = inv[k], inv[l]
                assert K != L
                n = next(p for p in range(M) if K[p] != L[p])
                line1 = S[k - 1, l - 1]
                line2 = left_to_right_product([A[p][K[p] - 1, L[p] - 1] for p in range(M)])
                assert A[n][K[n] - 1, L[n] - 1] == 0
                line3 = 0
                assert line1 == line2 == line3
                count += 1
print(f"checked {count} off-diagonal entries")
print("RESULT: PASS")
