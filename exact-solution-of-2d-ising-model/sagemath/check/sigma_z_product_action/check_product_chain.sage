# 対象ラベル: sigma_z_product_action
# 証明の六行:
#   σ_m^z σ_{m'}^z f = σ_m^z(σ_{m'}^z f)        (mat_mult_associative)
#   = σ_m^z(μ(m') f)                            (sigma_z_diagonal_action)
#   = μ(m')(σ_m^z f)                            (scalar_multiple_factors_out_of_right_factor)
#   = μ(m')(μ(m) f)                             (sigma_z_diagonal_action)
#   = (μ(m')μ(m)) f                             (scalar_multiple_is_associative)
#   = μ(m)μ(m') f                               (乗法の交換律)
# 各行を別々の式で作り、ZZ で厳密に比べる。M = 1,…,4、すべての μ と m, m'（m = m' を含む）。
load("../../_shared/site_sigma_z_kronecker.sage")

count = 0
for M in M_RANGE[:4]:
    S = {m: sigma_z_site(M, m) for m in range(1, M + 1)}
    for mu in spin_configurations(M):
        f = f_basis(iota(mu))
        for m in range(1, M + 1):
            for mp in range(1, M + 1):
                a, b = mu[m - 1], mu[mp - 1]
                line1 = (S[m] * S[mp]) * f
                line2 = S[m] * (S[mp] * f)
                line3 = S[m] * (b * f)
                line4 = b * (S[m] * f)
                line5 = b * (a * f)
                line6 = (b * a) * f
                line7 = (a * b) * f
                assert line1 == line2 == line3 == line4 == line5 == line6 == line7
                count += 1
print(f"checked {count} (M, mu, m, m') cases")
print("RESULT: PASS")
