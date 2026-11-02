# 対象ラベル: site_sigma_z_is_diagonal
# 主張そのもの: σ_m^z は対角行列（def_diagonal_matrix: k ≠ l ⇒ 成分 0）。
# 行列は本文の定め方の経路（def_kronecker の成分の式）で組み、非対角成分を一つずつ見る。
# 対照として、σ_m^x は対角行列でないことも確かめる。帰属: ZZ。M = 1,…,5。
load("../../_shared/site_sigma_z_kronecker.sage")

SIGMA_X = matrix(ZZ, [[0, 1], [1, 0]])

def is_diagonal_by_definition(D):
    n = D.nrows()
    return all(D[k, l] == 0 for k in range(n) for l in range(n) if k != l)

count = 0
for M in M_RANGE:
    for m in range(1, M + 1):
        S = kron_matrix_by_definition(site_factors(M, m, SIGMA_Z))
        assert is_diagonal_by_definition(S)
        assert S.is_diagonal()
        assert not is_diagonal_by_definition(kron_matrix_by_definition(site_factors(M, m, SIGMA_X)))
        count += 1
print(f"checked {count} matrices")
print("RESULT: PASS")
