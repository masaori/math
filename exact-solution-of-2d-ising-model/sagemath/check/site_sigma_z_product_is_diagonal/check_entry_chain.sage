# 対象ラベル: site_sigma_z_product_is_diagonal
# 証明の準備と三行（k ≠ l）:
#   準備: q ≠ k なら (σ_m^z)_{kq} = 0 なので項 (σ_m^z)_{kq}(σ_{m'}^z)_{ql} = 0·(…) = 0、
#         q = k なら (σ_{m'}^z)_{kl} = 0 なので項 = (…)·0 = 0
#   (σ_m^z σ_{m'}^z)_{kl} = Σ_q (σ_m^z)_{kq}(σ_{m'}^z)_{ql}   (mat_mult)
#                         = Σ_q 0                              (各項が 0)
#                         = 0                                  (finite_sum_of_complex_zeros)
# 第一行の左辺は Sage の行列の積の成分、右辺は成分の和を一項ずつ足したもの。準備の二つの場合を
# 項ごとに確かめる。帰属: ZZ。M = 1,…,4、すべての m, m'（m = m' を含む）、k ≠ l。
load("../../_shared/site_sigma_z_kronecker.sage")

count = 0
for M in M_RANGE[:4]:
    N = 2**M
    S = {m: sigma_z_site(M, m) for m in range(1, M + 1)}
    for m in range(1, M + 1):
        for mp in range(1, M + 1):
            P = S[m] * S[mp]
            for k in range(N):
                for l in range(N):
                    if k == l:
                        continue
                    terms = []
                    for q in range(N):
                        if q != k:
                            assert S[m][k, q] == 0
                            assert S[m][k, q] * S[mp][q, l] == 0 * S[mp][q, l] == 0
                        else:
                            assert S[mp][k, l] == 0
                            assert S[m][k, q] * S[mp][q, l] == S[m][k, q] * 0 == 0
                        terms.append(S[m][k, q] * S[mp][q, l])
                    line1 = P[k, l]
                    line1_rhs = sum(terms)
                    line2 = sum(0 for q in range(N))
                    line3 = 0
                    assert line1 == line1_rhs == line2 == line3
                    count += 1
print(f"checked {count} off-diagonal entries of products")
print("RESULT: PASS")
