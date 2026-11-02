# 対象ラベル: sigma_z_diagonal_action
# 証明の「固有ベクトルの等式」の七行:
#   σ_m^z f_{ι(μ)}
#   = (I⊠⋯⊠σ^z⊠⋯⊠I) f_{ι(μ)}                       (def_site_pauli_matrices)
#   = (I⊠⋯⊠σ^z⊠⋯⊠I)(e_{i_1}⊠⋯⊠e_{i_M})              (def_config_basis_iso)
#   = (I e_{i_1})⊠⋯⊠(σ^z e_{i_m})⊠⋯⊠(I e_{i_M})      (kronecker_product_rule (3))
#   = e_{i_1}⊠⋯⊠(σ^z e_{i_m})⊠⋯⊠e_{i_M}             (単位行列は左単位元)
#   = e_{i_1}⊠⋯⊠(μ(m)_C e_{i_m})⊠⋯⊠e_{i_M}            (場合分けの結果)
#   = μ(m)_C(e_{i_1}⊠⋯⊠e_{i_M})                        (kronecker_multilinear)
#   = μ(m)_C f_{ι(μ)}                                   (def_config_basis_iso)
# μ(m)_C = ι_{R→C}(μ(m)) は整数 ±1 を ZZ のまま係数に使う（ZZ → CC の包含は和と積を保つ）。
# 各行を別々の式で作り、隣どうしの一致を ZZ で厳密に確かめる。クロネッカー積の行は、
# Sage の tensor_product と本文の成分の式（def_kronecker (1)）の両方で組んで一致も確かめる。
# M = 1,…,5、すべての μ ∈ 𝔐 と m。
load("../../_shared/site_sigma_z_kronecker.sage")

count = 0
for M in M_RANGE:
    for mu in spin_configurations(M):
        I = iota(mu)
        f = f_basis(I)
        for m in range(1, M + 1):
            factors = site_factors(M, m, SIGMA_Z)
            line1 = sigma_z_site(M, m) * f
            line2 = kron_sage(factors) * f
            line3 = kron_sage(factors) * kron_sage([E[i] for i in I])
            v4 = [factors[p] * E[I[p]] for p in range(M)]
            line4 = kron_sage(v4)
            assert line4 == kron_vector_by_definition(v4)
            v5 = [E[I[p]] if p != m - 1 else SIGMA_Z * E[I[p]] for p in range(M)]
            line5 = kron_sage(v5)
            v6 = [E[I[p]] if p != m - 1 else mu[m - 1] * E[I[p]] for p in range(M)]
            line6 = kron_sage(v6)
            assert line6 == kron_vector_by_definition(v6)
            line7 = mu[m - 1] * kron_sage([E[i] for i in I])
            line8 = mu[m - 1] * f
            assert line1 == line2 == line3 == line4 == line5 == line6 == line7 == line8
            count += 1

# 対照: σ^z の代わりに σ^x を置くと、f_{ι(μ)} は μ(m)_C 倍にならない（検算が自明でない）
SIGMA_X = matrix(ZZ, [[0, 1], [1, 0]])
mu = (1, -1)
f = f_basis(iota(mu))
assert kron_sage(site_factors(2, 1, SIGMA_X)) * f != mu[0] * f
print(f"checked {count} (M, mu, m) triples, M in {M_RANGE}")
print("RESULT: PASS")
