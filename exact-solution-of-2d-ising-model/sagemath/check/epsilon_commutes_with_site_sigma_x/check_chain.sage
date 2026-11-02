# 対象ラベル: epsilon_commutes_with_site_sigma_x
# 因子の条件の鎖 y_ix_i = Iσ^x = σ^x = σ^xI = x_iy_i（i ≠ k）と y_kx_k = σ^xσ^x = x_ky_k、
# 主の鎖 εσ_k^x = (⊠σ^x)(σ_k^x のクロネッカー積) = (σ_k^x のクロネッカー積)(⊠σ^x) = σ_k^xε を M_col = 1..5、全ての k で厳密に。
# 対照: σ_k^x を σ_k^z に替えると可換でない（因子の条件の k 番目が崩れる）。
load("_prelude.sage")
P = body_product
check_chain([P(I2, SX), SX, P(SX, I2)], "因子の条件")
for M in range(1, 6):
    E = epsilon(M)
    Ek = kron([SX] * M)
    for k in range(1, M + 1):
        S = site(M, k, 'x')
        Sk = kron(site_factors(M, k, SX))
        check_chain([P(E, S), P(Ek, Sk), P(Sk, Ek), P(S, E)], f"M={M} k={k}")
        Zk = site(M, k, 'z')
        assert P(E, Zk) != P(Zk, E)
    print(f"  M_col={M}: 全ての k で εσ_k^x = σ_k^xε")
print("RESULT: PASS")
