# 対象ラベル: site_sigma_z_product_diagonal_entry
# 証明の準備と八行（k = ν(ι(μ))、P := σ_m^z σ_{m'}^z、f := f_{ι(μ)}）:
#   準備: l ≠ k なら P_{kl} = 0 で P_{kl} f_l = 0
#   P_{kk} = P_{kk}·1 = P_{kk} f_k = Σ_l P_{kl} f_l = (P f)_k = (μ(m)μ(m') f)_k
#          = μ(m)μ(m') f_k = μ(m)μ(m')·1 = μ(m)μ(m')
# P は Sage の行列の積、f は Sage の tensor_product で組む。和の行は成分を一項ずつ足し、
# (P f)_k は Sage の行列とベクトルの積の成分で取る。帰属: ZZ。M = 1,…,4、すべての μ、m、m'。
load("../../_shared/site_sigma_z_kronecker.sage")

count = 0
for M in M_RANGE[:4]:
    N = 2**M
    S = {m: sigma_z_site(M, m) for m in range(1, M + 1)}
    for mu in spin_configurations(M):
        f = f_basis(iota(mu))
        k = nu(iota(mu)) - 1
        for m in range(1, M + 1):
            for mp in range(1, M + 1):
                P = S[m] * S[mp]
                c = mu[m - 1] * mu[mp - 1]
                for l in range(N):
                    if l != k:
                        assert P[k, l] == 0 and P[k, l] * f[l, 0] == 0
                chain = [P[k, k],
                         P[k, k] * 1,
                         P[k, k] * f[k, 0],
                         sum(P[k, l] * f[l, 0] for l in range(N)),
                         (P * f)[k, 0],
                         (c * f)[k, 0],
                         c * f[k, 0],
                         c * 1,
                         c]
                assert all(x == chain[0] for x in chain)
                count += 1
print(f"checked {count} (M, mu, m, m') cases")
print("RESULT: PASS")
