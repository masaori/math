# 対象ラベル: sigma_z_product_action
# 主張そのもの: すべての μ ∈ 𝔐、m, m' について σ_m^z σ_{m'}^z f_{ι(μ)} = μ(m)_C μ(m')_C f_{ι(μ)}。
# 行列は本文の定め方の経路（def_kronecker の成分の式）で組む。対照として、積の符号を反転した値
# -μ(m)μ(m') では成り立たないことも確かめる。帰属: ZZ。M = 1,…,5。
load("../../_shared/site_sigma_z_kronecker.sage")

count = 0
for M in M_RANGE:
    S = {m: kron_matrix_by_definition(site_factors(M, m, SIGMA_Z)) for m in range(1, M + 1)}
    for mu in spin_configurations(M):
        f = kron_vector_by_definition([E[i] for i in iota(mu)])
        for m in range(1, M + 1):
            for mp in range(1, M + 1):
                assert S[m] * S[mp] * f == mu[m - 1] * mu[mp - 1] * f
                assert S[m] * S[mp] * f != -mu[m - 1] * mu[mp - 1] * f
                count += 1
print(f"checked {count} cases of the statement")
print("RESULT: PASS")
