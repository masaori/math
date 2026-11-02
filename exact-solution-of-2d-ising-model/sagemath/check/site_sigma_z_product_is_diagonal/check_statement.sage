# 対象ラベル: site_sigma_z_product_is_diagonal
# 主張そのもの: σ_m^z σ_{m'}^z は対角行列（def_diagonal_matrix）。
# 行列は本文の定め方の経路（def_kronecker の成分の式）で組み、積は Sage の行列の積で取る。
# 対照として、σ_m^z σ_{m'}^x（m ≠ m' でも m = m' でも）は対角行列でないことも確かめる。帰属: ZZ。M = 1,…,5。
load("../../_shared/site_sigma_z_kronecker.sage")

SIGMA_X = matrix(ZZ, [[0, 1], [1, 0]])

def is_diagonal_by_definition(D):
    n = D.nrows()
    return all(D[k, l] == 0 for k in range(n) for l in range(n) if k != l)

count = 0
for M in M_RANGE:
    S = {m: kron_matrix_by_definition(site_factors(M, m, SIGMA_Z)) for m in range(1, M + 1)}
    X = {m: kron_matrix_by_definition(site_factors(M, m, SIGMA_X)) for m in range(1, M + 1)}
    for m in range(1, M + 1):
        for mp in range(1, M + 1):
            assert is_diagonal_by_definition(S[m] * S[mp])
            assert not is_diagonal_by_definition(S[m] * X[mp])
            count += 1
print(f"checked {count} products")
print("RESULT: PASS")
