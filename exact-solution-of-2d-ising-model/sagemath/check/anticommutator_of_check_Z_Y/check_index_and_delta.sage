# 対象ラベル: anticommutator_of_check_Z_Y
# 準備 1（j, k ∈ {1,…,N} で δ^{(M)}_{(j,k)} は j = k のとき 1、j ≠ k のとき 0）と、その帰結の 2 等号の鎖
# (e_{j,λ}e_{k,λ'})δ^{(M)}_{(j,k)} = (e_{j,λ}e_{k,λ'})0_C = 0_C（j ≠ k）、
# 主鎖の def_delta_M の行 δ^{(M)}_{(κ,0)} = δ^{(M)}_{(μ+ν,1)}（κ = -(μ+ν-1)）と def_check_index_set (5) の行
# δ^{(M)}_{(μ+ν,1)} = δ_{ν,M+1-μ} を、M = 2..12、μ, ν ∈ M̌ = {1,…,M} で厳密に（ZZ・QQ 上の多項式環）確かめる。
# δ^{(M)} は def_delta_M の合同式の場合分け、δ_{ν,M+1-μ} は def_kronecker_delta の等号の場合分けで別々に組む。

def deltaM(M, a, b):
    """def_delta_M: a ≡ b (mod M) なら 1、そうでなければ 0。"""
    return 1 if (a - b) % M == 0 else 0


def kron_delta(n, a, b):
    """def_kronecker_delta: a, b ∈ {1,…,n} について a = b なら 1、そうでなければ 0。"""
    assert 1 <= a <= n and 1 <= b <= n
    return 1 if a == b else 0


Pe = PolynomialRing(QQ, ['ej', 'ek'])
ej, ek = Pe.gens()
n_pairs = 0
for M in range(2, 13):
    for j in range(1, M + 1):
        for k in range(1, M + 1):
            # 準備 1
            assert deltaM(M, j, k) == (1 if j == k else 0)
            if j != k:
                assert 0 < abs(j - k) <= M - 1
                lines = [(ej * ek) * deltaM(M, j, k), (ej * ek) * 0, Pe(0)]
                assert lines[0] == lines[1] == lines[2]
    for mu in range(1, M + 1):
        for nu in range(1, M + 1):
            kappa = -(mu + nu - 1)
            assert kappa - 0 == -((mu + nu) - 1)
            assert deltaM(M, kappa, 0) == deltaM(M, mu + nu, 1)          # def_delta_M の行
            assert M + 1 - mu in range(1, M + 1)                         # def_check_index_set (2)
            assert deltaM(M, mu + nu, 1) == kron_delta(M, nu, M + 1 - mu)  # def_check_index_set (5) の行
            n_pairs += 1
    # 対照: M̌ の外の添字（ν = M+1-μ+M）では δ^{(M)}_{(μ+ν,1)} = 1 なのに ν ≠ M+1-μ
    assert deltaM(M, 1 + (2 * M), 1) == 1 and (2 * M) != M + 1 - 1
print(f"checked the diagonal of delta^(M) on {{1..M}}^2 and the two delta rows for M = 2..12 ({n_pairs} pairs (mu, nu))")
print("RESULT: PASS")
