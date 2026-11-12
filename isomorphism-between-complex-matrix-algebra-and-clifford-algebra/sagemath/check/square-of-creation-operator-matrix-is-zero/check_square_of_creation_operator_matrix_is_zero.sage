# 対象ラベル: claim_square_of_creation_operator_matrix_is_zero
# c_i を定義どおりに作り、M=1,2,3 のすべての i, S, U で、i∈U の場合の成分 0、i∉U の場合の (c_i)_{S,U∪{i}}=0 と
# 成分の式 (c_i)_{S,U∪{i}}·ς(N_i(U))、主張 c_i c_i = 0 を ZZ の厳密計算で確かめる。
# 否定の対照として、c_i が零行列でないこと、c_i c_i^T・c_i^T c_i・(c_i + c_i^T) の平方が零行列でないこと、
# i≠j の c_i c_j が零行列でないこと（M≥2）、c_i の非零成分の個数が 2^{M-1} であることを確かめる。
from itertools import combinations

def power_set(M):
    base = list(range(1, M + 1))
    return [frozenset(c) for r in range(M + 1) for c in combinations(base, r)]

def N(i, T):                       # def_count_of_subset_elements_below_index
    if i == 1:
        return 0
    return N(i - 1, T) + 1 if (i - 1) in T else N(i - 1, T)

def sign(n):                       # def_sign_of_nonnegative_integer
    return ZZ(1) if n == 0 else ZZ(-1) * sign(n - 1)

def creation_matrices(M, P, R=ZZ):  # def_creation_operator_matrix
    return {i: matrix(R, len(P), len(P), lambda s, t: sign(N(i, P[t])) if (i not in P[t] and P[s] == P[t] | {i}) else 0)
            for i in range(1, M + 1)}

cases = 0
for M in range(1, 4):
    P = power_set(M)
    idx = {T: n for n, T in enumerate(P)}
    c = creation_matrices(M, P)
    for i in range(1, M + 1):
        sq = c[i] * c[i]
        for S in P:
            for U in P:
                e = sq[idx[S], idx[U]]
                if i in U:
                    assert e == 0
                else:
                    assert c[i][idx[S], idx[U | {i}]] == 0                      # 条件が成り立たない
                    assert e == c[i][idx[S], idx[U | {i}]] * sign(N(i, U))      # 成分の式
                    assert e == 0
        assert sq == 0                                                          # 主張
        ct = c[i].transpose()                                                   # def_annihilation_operator_matrix
        nz = sum(1 for s in range(len(P)) for t in range(len(P)) if c[i][s, t] != 0)
        assert c[i] != 0 and nz == 2 ** (M - 1)                                 # 否定の対照: c_i 自身は零でない
        assert c[i] * ct != 0 and ct * c[i] != 0                                # 否定の対照: c_i c_i^T、c_i^T c_i は零でない
        assert (c[i] + ct) * (c[i] + ct) != 0                                   # 否定の対照: (c_i + c_i^T)^2 は零でない
        assert (c[i] * ct) * (c[i] * ct) != 0                                   # 否定の対照: (c_i c_i^T)^2 は零でない
        for j in range(1, M + 1):
            if j != i:
                assert c[i] * c[j] != 0                                         # 否定の対照: 番号の違う積は零でない
        cases += 1
    print("M=%d: PASS" % M)
print("ALL PASS（M, i の組 %d 件）" % cases)
